#!/usr/bin/python2
import argparse
import fnmatch
import logging
import re
import sys

from enum import Enum
from pprint import pprint

import MySQLdb

vmddb_username = 'vspheredb'
vmddb_password = '7aHwF1uozJmuAT2PVpnWONH17RqizQOa'

class NagiosMetricStatus(Enum):
    """
    Enumeration that defines all the supported states and their return values.
    Refers to enum documentation for its correct use.
    """
    ok       = 0
    warning  = 1
    critical = 2
    unknown  = 3

class ArgumentValueError(ValueError):
    """
    Used for reporting more detailed error regarding input parameters
    """
    def __init__(self, argument_name, argument_value, argument_error):
        self.argument_name = argument_name
        self.argument_value = argument_value
        self.argument_error = argument_error
        self.message = "Invalid value for argument '" + argument_name + "': " + argument_error + "\nActual argument value: '" + str(argument_value) + "'"

        ValueError(self, self.message)

    def __unicode__(self):
        return unicode(self.message)

    def __str__(self):
        return unicode(self).encode('utf-8')

class Threshold:
    """
    Abstraction for a generig Icinga/Nagios Threshold. Should be used only as a base class.
    It provides default methods for operating:
     - Check if a value inside the Threshold range
     - Convert the current Threshold value to a string (unicode and str)

     Both these methods should be overwritten and never called, otherwise an exception will be raised.
    """
    def ValueInRange(self, value, minimum_value = None, maximum_value = None):
        """
        Abstract function for checking if a value is inside the Threshold range.
        For some kind of Threshold, knowing the range of values the metric support can be useful.
        Actually, this function must be overwritten and never called.
        If called, a NotImplementedError exception will be raised.
        """
        raise NotImplementedError('Mot implemented on a generic (abstract) threshold definition')

    def GetThresholdString(self):
        """
        Abstract function for converting Threshold definition to string.
        Actually, this function must be overwritten and never called.
        If called, a NotImplementedError exception will be raised.
        """
        raise NotImplementedError('Mot implemented on a generic (abstract) threshold definition')

    def GetThresholdStringAdapted(self, minimum_value = None, maximum_value = None):
        """
        Abstract function for converting Threshold definition to string.
        If the threshold uses relative data, this function adapts the relative values using
        the maximum and minimum values provided.
        Actually, this function must be overwritten and never called.
        If called, a NotImplementedError exception will be raised.
        """
        raise NotImplementedError('Mot implemented on a generic (abstract) threshold definition')

    def __unicode__(self):
        """
        This function return a string representation of a Threshold.
        It is based on the return value of the GetThresholdString function.
        """
        return self.GetThresholdString()

    def __str__(self):
        """
        This function return a string representation of a Threshold.
        It is based on the return value of the __unicode__ function.
        """
        return unicode(self).encode('utf-8')

class AbsoluteRangeThreshold(Threshold):
    """
    Numeric absolute range threshold. This should be the default Threshold type.
    """
    def __init__(self, range, default_lower_bound=0, default_upper_bound=None):
        """
        Initialize a AbsoluteRangeThreshold object basing on a range value.
        """
        logging.debug("Initializing new Absolute Range Threshold. Range: '" + str(range) + "'.")

        # range must have a value
        if range is None:
            logging.error('No range provided. Unable to create Threshold.')
            raise ArgumentValueError('range', range, 'Value is None.')

        # Empty strings are not allowed.
        # Also, ranges composed only by whitespaces are not allowed.
        range_string = range.strip()
        if len(range_string) == 0:
            logging.error('No range provided. Unable to create Threshold.')
            raise ArgumentValueError('range', range, 'Empty value.')

        # Try parsing the range with regex and extract values from it
        logging.debug('Parsing range string...')
        match = self._pattern.match(range_string)
        if match is None:
            logging.error('Unable to understand range pattern: range format is invalid or not supported.')
            raise ArgumentValueError('range', range, 'Invalid format. Format should be [@]start:end.')

        is_inclusive = match.group('is_inclusive')
        lower_bound  = match.group('lower_bound')
        upper_bound  = match.group('upper_bound')

        logging.debug('Range parsed. Extracted values:')
        logging.debug(" - Is inclusive: '" + str(is_inclusive) + "'")
        logging.debug(" - Lower bound : '" + str(lower_bound) + "'")
        logging.debug(" - Upper bound : '" + str(upper_bound) + "'")

        # Set the Range Object as inclusive or exclusive
        if is_inclusive:
            self.__use_inclusive_range = (is_inclusive == '@')
        else:
            self.__use_inclusive_range = False

        if (self.__use_inclusive_range):
            logging.debug('Inclusive range specified.')
        else:
            logging.debug('Exclusive range specified.')

        # Try to convert lower bound value to the expected number.
        # If lower bound is missing, value from an argument is used.
        # Default value for the argument is 0.
        self.__lower_bound = default_lower_bound
        if lower_bound is not None:
            if lower_bound == '~':
                logging.debug('Lower bound set to -INFINITE.')
                self.__lower_bound = None
            else:
                try:
                    self.__lower_bound = float(lower_bound)
                    logging.debug('Lower bound set to ' + str(self.__lower_bound) + '.')
                except:
                    logging.error('Unable to understand lower bound value.')
                    raise ArgumentValueError('range', range, 'Lower bound is not "~" or a number.')
        
        # Try to convert upper bound value to the expected number.
        # If upper bound is missing, value from an argument is used.
        # Default value for the argument is None (+INFINITE).
        self.__upper_bound = default_upper_bound
        if upper_bound is not None:
            if upper_bound == '~':
                logging.debug('Upper bound set to +INFINITE.')
                self.__upper_bound = None
            else:
                try:
                    self.__upper_bound = float(upper_bound)
                    logging.debug('Upper bound set to ' + str(self.__upper_bound) + '.')
                except:
                    logging.error('Unable to understand upper bound value.')
                    raise ArgumentValueError('range', range, 'Upper bound is not "~" or a number.')

        if (self.__lower_bound is not None) and (self.__upper_bound is not None):
            if (self.__lower_bound > self.__upper_bound):
                logging.error('Lower bound value is greatrer than uppe boudn value. Range is invalid.')
                raise ArgumentValueError('range', range, 'Lower bound value is greater than upper bound value.')

    def GetThresholdString(self):
        """
        Return a string representation of the current range.
        The string representation is expanded (default values are not omitted)
        """
        range_string = u''

        if self.__use_inclusive_range:
            range_string = u'@'

        if self.__lower_bound is None:
            range_string += u'~:'
        else:
            range_string += unicode(self.__lower_bound) + u':'
        
        if self.__upper_bound is None:
            range_string += u'~'
        else:
            range_string += unicode(self.__upper_bound)

        return range_string

    def GetThresholdStringAdapted(self, minimum_value, maximum_value):
        return self.GetThresholdString()

    def __ValueInExternalRange(self, value):
        # Maybe both bounds of the range are None...
        if (self.__lower_bound is None) and (self.__upper_bound is None):
            # Is impossible for a value to be less than than -infinite or great than +infinite
            return False

        # At this point, at least one bound is not None. But: which is the one that is None?
        if (self.__lower_bound is None):
            # In case lower bound is -infinite, value is in range only if it is great than the upper bound
            return value > self.__upper_bound
        if (self.__upper_bound is None):
            # In case upper bound is +infinite, value is in range only if it is less than the lower bound
            return value < self.__lower_bound

        # Both of the bounds have a value. Use the standard formula
        return (value < self.__lower_bound) or (value > self.__upper_bound)

    def ValueInRange(self, value, minimum_value = None, maximum_value = None):
        """
        Check if the provided value is inside or outside the current Threshold Range.
        Parameters minimum_value and maximum_value are not used.
        """
        # Argument check: value must be a number (or can converted into it)
        if value is None:
            raise ArgumentValueError('value', value, 'Value must not be None.')

        try:
            parsed_value = float(value)
        except:
            raise ArgumentValueError('value', value, 'Value is not a number.')

        # Check if value is in range
        # It consider the range as Excluseve
        value_in_range = self.__ValueInExternalRange(parsed_value)

        # An Inclusive range is complementary to the Esclusive range.
        # Therefore, if in case of exclusive range is True, in case of inclusice range is false, and viceversa.
        if self.__use_inclusive_range:
            value_in_range = not(value_in_range)

        return value_in_range

    def IsInclusive(self):
        """
        Returns True if the current Threshold Range in Inclusive.
        """
        return self.__use_inclusive_range
    
    def IsExclusive(self):
        """
        Returns True if the current Threshold Range in Exclusive.
        """
        return not (self.IsInclusive())

    def GetLowerBound(self):
        """
        Returns the value of the current range's lower bound.
        If the value is -infinite, it returns None.
        """
        return self.__lower_bound

    def GetUpperBound(self):
        """
        Returns the value of the current range's upper bound.
        If the value is +infinite, it returns None.
        """
        return self.__upper_bound

    _pattern = re.compile(r"""^    # Only one match is allowed for this pattern on a line => Starts at the beginning on the line
    (?P<is_inclusive>               # OPTIONAL ELEMENT: '@' means the inteval must be intended as INCLUSIVE; if @ is absent the interval must be intended as EXCLUSIVE
        @?                          #   Only '@' is allowed for this group
    )
    (?:                             # OPTIONAL ELEMENT: This is intended to be the lower bound of the interval. If it is specified, it MUST BE FOLLOWED BY ':'
        (?P<lower_bound>            #   The inner part of this element is the lower bound of the interval, and it is optional. It can be:
             (?:\d+)                #       A positive integer number (e.g.: xxx)
            |(?:\d+\.\d*)           #       A positive real number with float part as optional (e.g.: x., or x.xxx)
            |(?:\.\d+)              #       A positive real number without real part (means 0.xxx)
            |(?:-\d+)               #       A negative integer number (e.g.: -xxx)
            |(?:-\d+\.\d*)          #       A negative real number with float part as optional (e.g.: -x., or -x.xxx)
            |(?:-\.\d+)             #       A negative real number without real part (means -0.xxx)
            |(?:~)                  #       Nagios notation: ~ means the lower bound is -INFINITE
        ):
    )?
    (?P<upper_bound>                # MANDATORY ELEMENT: This is intended to be the upper bound of the interval. What is said for the lower_bound group apply here
         (?:\d+)
        |(?:\d+\.\d*)
        |(?:\.\d+)
        |(?:-\d+)
        |(?:-\d+\.\d*)
        |(?:-\.\d+)
        |(?:~)                      #   Nagios notation: ~means the lower bound is +INFINITE
    )?
    $                               # Only one match is allowed for this pattern on a line => Ends and the end of the line
    """, re.VERBOSE)

class RelativeRangeThreshold(Threshold):
    """
   Relative range threshold. It is used to calculate percentage-based ranges.
    """
    def __init__(self, range, default_lower_bound=0, default_upper_bound=None):
        """
        Initialize a RelativeRangeThreshold object basing on a range value.
        """
        logging.debug("Initializing new Relative Range Threshold. Range: '" + str(range) + "'.")

        # range must have a value
        if range is None:
            logging.error('No range provided. Unable to create Threshold.')
            raise ArgumentValueError('range', range, 'Value is None.')

        # Empty strings are not allowed.
        # Also, ranges composed only by whitespaces are not allowed.
        range_string = range.strip()
        if len(range_string) == 0:
            logging.error('No range provided. Unable to create Threshold.')
            raise ArgumentValueError('range', range, 'Empty value.')

        # Try parsing the range with regex and extract values from it
        logging.debug('Parsing range string...')
        match = self._pattern.match(range_string)
        if match is None:
            logging.error('Unable to understand range pattern: range format is invalid or not supported.')
            raise ArgumentValueError('range', range, 'Invalid format. Format should be [@]start:end%.')

        is_inclusive = match.group('is_inclusive')
        lower_bound  = match.group('lower_bound')
        upper_bound  = match.group('upper_bound')

        logging.debug('Range parsed. Extracted values:')
        logging.debug(" - Is inclusive: '" + str(is_inclusive) + "'")
        logging.debug(" - Lower bound : '" + str(lower_bound) + "'")
        logging.debug(" - Upper bound : '" + str(upper_bound) + "'")

        # Set the Range Object as inclusive or exclusive
        if is_inclusive:
            self.__use_inclusive_range = (is_inclusive == '@')
        else:
            self.__use_inclusive_range = False

        if (self.__use_inclusive_range):
            logging.debug('Inclusive range specified.')
        else:
            logging.debug('Exclusive range specified.')

        # Try to convert lower bound value to the expected number.
        # If lower bound is missing, value from an argument is used.
        # Default value for the argument is 0.
        self.__lower_bound = default_lower_bound
        if lower_bound is not None:
            if lower_bound == '~':
                logging.debug('Lower bound set to -INFINITE.')
                self.__lower_bound = None
            else:
                try:
                    self.__lower_bound = float(lower_bound)
                    logging.debug('Lower bound set to ' + str(self.__lower_bound) + '.')
                except:
                    logging.error('Unable to understand lower bound value.')
                    raise ArgumentValueError('range', range, 'Lower bound is not "~" or a number.')
        
        # Try to convert upper bound value to the expected number.
        # If upper bound is missing, value from an argument is used.
        # Default value for the argument is None (+INFINITE).
        self.__upper_bound = default_upper_bound
        if upper_bound is not None:
            if upper_bound == '~':
                logging.debug('Upper bound set to +INFINITE.')
                self.__upper_bound = None
            else:
                try:
                    self.__upper_bound = float(upper_bound)
                    logging.debug('Upper bound set to ' + str(self.__upper_bound) + '.')
                except:
                    logging.error('Unable to understand upper bound value.')
                    raise ArgumentValueError('range', range, 'Upper bound is not "~" or a number.')

        if (self.__lower_bound is not None) and (self.__upper_bound is not None):
            if (self.__lower_bound > self.__upper_bound):
                logging.error('Lower bound value is greatrer than uppe boudn value. Range is invalid.')
                raise ArgumentValueError('range', range, 'Lower bound value is greater than upper bound value.')

    def GetThresholdString(self):
        """
        Return a string representation of the current range.
        The string representation is expanded (default values are not omitted)
        """
        range_string = u''

        if self.__use_inclusive_range:
            range_string = u'@'

        if self.__lower_bound is None:
            range_string += u'~:'
        else:
            range_string += unicode(self.__lower_bound) + u':'
        
        if self.__upper_bound is None:
            range_string += u'~'
        else:
            range_string += unicode(self.__upper_bound)

        range_string += u'%'

        return range_string

    def GetThresholdStringAdapted(self, minimum_value, maximum_value):
        """
        Return a string representation of the current range.
        The string representation is expanded (default values are not omitted).
        Percentage values are replaced with adapted (absolute) values.
        """
        range_string = u''

        if self.__use_inclusive_range:
            range_string = u'@'

        if self.__lower_bound is None:
            range_string += u'~:'
        else:
            value = minimum_value + ((maximum_value - minimum_value) * (self.__lower_bound / 100.0))
            range_string += unicode(value) + u':'
        
        if self.__upper_bound is None:
            range_string += u'~'
        else:
            value = minimum_value + ((maximum_value - minimum_value) * (self.__upper_bound / 100.0))
            range_string += unicode(value)

        return range_string

    def __ValueInExternalRange(self, value, minimum_value, maximum_value):
        # Maybe both bounds of the range are None...
        if (self.__lower_bound is None) and (self.__upper_bound is None):
            # Is impossible for a value to be less than than -infinite or great than +infinite
            return False

        # Now, we can make come math and convert value to a percentage
        value_percentage = 100.0 * (value - minimum_value) / (maximum_value - minimum_value)

        # At this point, at least one bound is not None. But: which is the one that is None?
        if (self.__lower_bound is None):
            # In case lower bound is -infinite, value is in range only if it is great than the upper bound
            return value_percentage > self.__upper_bound
        if (self.__upper_bound is None):
            # In case upper bound is +infinite, value is in range only if it is less than the lower bound
            return value_percentage < self.__lower_bound

        # Both of the bounds have a value. Use the standard formula
        return (value_percentage < self.__lower_bound) or (value_percentage > self.__upper_bound)

    def ValueInRange(self, value, minimum_value = None, maximum_value = None):
        """
        Check if the provided value is inside or outside the current Threshold Range.
        Parameters minimum_value and maximum_value are necessary to understand what 0% and 100% actually means.
        """
        # Argument check: all values must be a number (or can converted into it)
        if value is None:
            raise ArgumentValueError('value', value, 'Value must not be None.')
        if minimum_value is None:
            raise ArgumentValueError('minimum_value', minimum_value, 'Value must not be None.')
        if maximum_value is None:
            raise ArgumentValueError('maximum_value', maximum_value, 'Value must not be None.')

        try:
            parsed_value = float(value)
        except:
            raise ArgumentValueError('value', value, 'Value is not a number.')
        try:
            parsed_min = float(minimum_value)
        except:
            raise ArgumentValueError('minimum_value', minimum_value, 'Minimum value is not a number.')
        try:
            parsed_max = float(maximum_value)
        except:
            raise ArgumentValueError('maximum_value', maximum_value, 'Maximum value is not a number.')

        # Argument consistency checks
        # Check if the value range is proper (range is greater than 0 and maximum value is actually greater than minimum value)
        if (minimum_value >= maximum_value):
            raise ArgumentValueError('minimum_value', minimum_value, 'Minimum value is greater then Maximum value.')

        # Check if value is in range
        # It consider the range as Excluseve
        value_in_range = self.__ValueInExternalRange(parsed_value, parsed_min, parsed_max)

        # An Inclusive range is complementary to the Esclusive range.
        # Therefore, if in case of exclusive range is True, in case of inclusice range is false, and viceversa.
        if self.__use_inclusive_range:
            value_in_range = not(value_in_range)

        return value_in_range

    def IsInclusive(self):
        """
        Returns True if the current Threshold Range in Inclusive.
        """
        return self.__use_inclusive_range
    
    def IsExclusive(self):
        """
        Returns True if the current Threshold Range in Exclusive.
        """
        return not (self.IsInclusive())

    def GetLowerBound(self):
        """
        Returns the value of the current range's lower bound.
        If the value is -infinite, it returns None.
        """
        return self.__lower_bound

    def GetUpperBound(self):
        """
        Returns the value of the current range's upper bound.
        If the value is +infinite, it returns None.
        """
        return self.__upper_bound

    _pattern = re.compile(r"""^    # Only one match is allowed for this pattern on a line => Starts at the beginning on the line
    (?P<is_inclusive>               # OPTIONAL ELEMENT: '@' means the inteval must be intended as INCLUSIVE; if @ is absent the interval must be intended as EXCLUSIVE
        @?                          #   Only '@' is allowed for this group
    )
    (?:                             # OPTIONAL ELEMENT: This is intended to be the lower bound of the interval. If it is specified, it MUST BE FOLLOWED BY ':'
        (?P<lower_bound>            #   The inner part of this element is the lower bound of the interval, and it is optional. It can be:
             (?:\d+)                #       A positive integer number (e.g.: xxx)
            |(?:\d+\.\d*)           #       A positive real number with float part as optional (e.g.: x., or x.xxx)
            |(?:\.\d+)              #       A positive real number without real part (means 0.xxx)
            |(?:-\d+)               #       A negative integer number (e.g.: -xxx)
            |(?:-\d+\.\d*)          #       A negative real number with float part as optional (e.g.: -x., or -x.xxx)
            |(?:-\.\d+)             #       A negative real number without real part (means -0.xxx)
            |(?:~)                  #       Nagios notation: ~ means the lower bound is -INFINITE
        ):
    )?
    (?P<upper_bound>                # MANDATORY ELEMENT: This is intended to be the upper bound of the interval. What is said for the lower_bound group apply here
         (?:\d+)
        |(?:\d+\.\d*)
        |(?:\.\d+)
        |(?:-\d+)
        |(?:-\d+\.\d*)
        |(?:-\.\d+)
        |(?:~)                      #   Nagios notation: ~means the lower bound is +INFINITE
    )?
    %                               # MANDATORY ELEMENT: This identifies a Relative Threshold (a threshold expressed using percentages)
    $                               # Only one match is allowed for this pattern on a line => Ends and the end of the line
    """, re.VERBOSE)

class Metric:
    """
    Represent a standard (non-typed) metric with its thresholds
    """
    def __init__(self, name, value, unit = None, minimum_value = None, maximum_value = None):
        """
        Initialize a generic metric without value type check. You should provide a metric unit for the value it will represents.
        """ 
        logging.debug("Creating metric named '" + name + "'.")
        logging.debug("Metric value  : '" + str(value) + "'.")
        logging.debug("Metric unit   : '" + str(unit) + "'.")
        logging.debug("Metric minimum: '" + str(minimum_value) + "'.")
        logging.debug("Metric maximum: '" + str(maximum_value) + "'.")
        
        # Parameter checking: Name must not be None and not an empty string
        if name is None:
            logging.error('No name provided for current metric.')
            raise ArgumentValueError('name', name, 'Metric must have a name.')
        
        self.__name = name.strip()
        if len(self.__name) < 1:
            logging.error('Empty string provided as name for current metric.')
            raise ArgumentValueError('name', name, 'Metric must have a name.')

        self.__value = value

        # If a metric unit is not provided, no metric will be used.
        if unit is not None:
            self.__unit = unit.strip()
        else:
            self.__unit = u''

        self.__warning_threshold  = None
        self.__critical_threshold = None

        self.__minimum_value = None
        self.__maximum_value = None
        if minimum_value is not None:
            self.__minimum_value = float(minimum_value)
        if maximum_value is not None:
            self.__maximum_value = float(maximum_value)

    def __unicode__(self):
        output = unicode(self.__name) + u' ' + unicode(str(self.__value))
        if (self.__unit is not None) and (len(self.__unit) > 0):
            output += u'' + unicode(self.__unit)

        return output

    def __str__(self):
        return unicode(self).encode('utf-8')

    def GetName(self):
        """
        Returns the name of the metric
        """
        return self.__name

    def GetValue(self):
        """
        Returns the value of the metric
        """
        return self.__value

    def GetUnit(self):
        """
        Returns the metric unit of the metric
        """
        return self.__unit

    def GetState(self):
        """
        Check the value against the actual thresholds and returns the resulting state accordingly.
        If no thresholds have been provided, the actual state is always OK.
        """
        #First check if the current value is inside the critical range
        if (self.__critical_threshold is not None) and (self.__critical_threshold.ValueInRange(self.__value, self.__minimum_value, self.__maximum_value)):
            return NagiosMetricStatus.critical

        #If the value is not inside the critical range, maybe it is inside the warning range
        if (self.__warning_threshold is not None) and (self.__warning_threshold.ValueInRange(self.__value, self.__minimum_value, self.__maximum_value)):
            return NagiosMetricStatus.warning

        # The value is outside both warning and critical range, so it must be OK
        return NagiosMetricStatus.ok

    def GetMinimumValue(self):
        return self.__minimum_value

    def GetMaximumValue(self):
        return self.__maximum_value

    def SetWarningThreshold(self, threshold):
        """
        Sets the range for the warning threshold of this metric
        """
        logging.debug("Setting warning threshold for metric " + self.__name + "': " + str(threshold) + ".")
        if threshold is None:
            logging.error('No warning threshold specified.')
            raise ArgumentValueError('threshold', threshold, 'No warning threshold specified.')

        self.__warning_threshold = threshold

    def SetCriticalThreshold(self, threshold):
        """
        Sets the range for the critical threshold of this metric
        """
        logging.debug("Setting critical threshold for metric " + self.__name + "': " + str(threshold) + ".")
        if threshold is None:
            logging.error('No critical threshold specified.')
            raise ArgumentValueError('threshold', threshold, 'No critical threshold specified.')

        self.__critical_threshold = threshold

    def GetWarningThreshold(self):
        """
        Returns the range for the warning threshold of this metric
        """
        return self.__warning_threshold

    def GetCriticalThreshold(self):
        """
        Returns the range for the critical threshold of this metric
        """
        return self.__critical_threshold
    
    def GetPerformanceData(self):
        """
        Returns the current metric's performance data in a Nagios-compatible format
        """
        # Performance data format: 'label'=value[UOM];[warn];[crit];[min];[max]
        # 1: metric name
        perfdata = u"'" + unicode(self.__name) + u"'="
        
        # 2: metric current value and its metric unit
        perfdata += unicode(str(self.__value)) + unicode(self.__unit) + u';'
        
        # 3: thresholds
        if self.__warning_threshold is not None:
            perfdata += str(self.__warning_threshold.GetThresholdStringAdapted(self.__minimum_value, self.__maximum_value))
        perfdata += u';'
        if self.__critical_threshold is not None:
            perfdata += str(self.__critical_threshold.GetThresholdStringAdapted(self.__minimum_value, self.__maximum_value))
        perfdata += u';'

        # 4: minimum and maximum values
        if self.__minimum_value is not None:
            perfdata += str(self.__minimum_value)
        perfdata += u';'
        if self.__maximum_value is not None:
            perfdata += str(self.__maximum_value)

        return perfdata

    def GetServiceOutput(self):
        return self.__unicode__()

class MetricFactory:
    """
    Support Factory class for creating metrics. It supports:
     - Single metric creation, via a dedicated static Factory method
     - Multiple metrics creation, via an instance method

     The instance method is able to use a wide set of parameters to determine which metrics must be loaded, which ones must be skipped, and link each metric with its own threshold.
     All metrics created by MetricFactory are collected inside a static collection during the whole lifetime of the program.
    """

    def __init__(self, metrics_to_include, metrics_to_exclude, warning_thresholds, critical_thresholds, max_values_override, min_values_override):
        """
        Creates a instance of MetricFactory. This is mandatory only if you need to use the CreateMetrics method.
        You can set a list of wanted (to be included) metrics and a list of unwanted (to be excluded) metrics.
        You can provide a dictionary of warning and critical thresholds.
        These lists and dictionaries will be used by the CreateMetrics method.
        """
        logging.debug('Creating new Metric Factory')
        self.__metrics_to_include  = metrics_to_include
        self.__metrics_to_exclude  = metrics_to_exclude
        self.__warning_thresholds  = warning_thresholds
        self.__critical_thresholds = critical_thresholds
        self.__max_values_override = max_values_override
        self.__min_values_override = min_values_override

        if max_values_override:
            logging.info('Metrics Maximum values Override list provided. Specified metrics will have the maximum value provided by this list.')
        else:
            logging.info('Metrics Maximum values Override list not provided. Default maximum value will be used.')
        if min_values_override:
            logging.info('Metrics Minimum values Override list provided. Specified metrics will have the minimum value provided by this list.')
        else:
            logging.info('Metrics Minimum values Override list not provided. Default minimum value will be used.')
        if metrics_to_exclude:
            logging.info('Metrics exclusion list provided. Selected metrics will not be loaded.')
        else:
            logging.info('Metrics exclusion list not provided. No metric will be explicitly excluded while loading (if present).')
        if metrics_to_include:
            logging.info('Metrics inclusion list provided. Only requested metrics will be loaded (if available).')
        else:
            logging.info('Metrics inclusion list not provided. All available metrics will be loaded.')

    def CreateThresholdWithProperType(self, threshold, metric_min, metric_max):
        if (threshold[-1] == '%'):
            return RelativeRangeThreshold(threshold, metric_min, metric_max)
        else:
            return AbsoluteRangeThreshold(threshold, metric_min, metric_max)

    def CreateMetrics(self, metrics_list):
        """
        It builds a list of metrics based on a list provided as an argument.
        Every object of the list must be a dictionary, with these properties:
         - name
         - value
         - unit
         - max
         - min
        Name and value are mandatory. Other properties might be None.
        The list will be checked against the two lists provided with the construction method (metrics_to_include, metrics_to_exclude).
        """
        logging.info('Parsing metric values')
        metrics_created = {}

        for entry in metrics_list:
            metric_name  = entry['name']
            metric_value = entry['value']
            metric_unit  = entry['unit']
            metric_max   = entry['max']
            metric_min   = entry['min']

            if (self.__max_values_override is not None) and (metric_name in self.__max_values_override):
                metric_max = self.__max_values_override[metric_name]
            if (self.__min_values_override is not None) and (metric_name in self.__min_values_override):
                metric_min = self.__min_values_override[metric_name]
            
            warning_threshold  = None
            critical_threshold = None

            #Uses fnmatch to allow wildcards for metric names
            if (self.__warning_thresholds is not None):
                for threshold in self.__warning_thresholds:
                    if fnmatch.fnmatch(metric_name, threshold):
                        warning_threshold = self.CreateThresholdWithProperType(self.__warning_thresholds[threshold], metric_min, metric_max)
            if (self.__critical_thresholds is not None):
                for threshold in self.__critical_thresholds:
                    if fnmatch.fnmatch(metric_name, threshold):
                        critical_threshold = self.CreateThresholdWithProperType(self.__critical_thresholds[threshold], metric_min, metric_max)

            logging.debug('Processing metric ' + metric_name)
            if (self.__metrics_to_exclude is not None):
                for metric in self.__metrics_to_exclude:
                    if fnmatch.fnmatch(metric_name, metric):
                        logging.info('Metric ' + metric_name + ' has been marked for exclusion. Skipping.')
                        continue

            metric_must_be_included = True
            if (self.__metrics_to_include is not None):
                metric_must_be_included = False
                for metric in self.__metrics_to_include:
                    if fnmatch.fnmatch(metric_name, metric):
                        metric_must_be_included = True

            if metric_must_be_included:
                logging.debug('Metric value      : ' + str(metric_value))
                logging.debug('Metric unit       : ' + str(metric_unit))
                logging.debug('Metric max value  : ' + str(metric_max))
                logging.debug('Metric min value  : ' + str(metric_min))
                logging.debug('Warning threshold:  ' + str(warning_threshold))
                logging.debug('Critical threshold: ' + str(critical_threshold))

                metric = MetricFactory.CreateMetric(metric_name, metric_value, metric_unit, metric_max, metric_min, warning_threshold, critical_threshold)
                metrics_created[metric_name] = metric
            else:
                logging.info('Metric ' + metric_name + ' has not been marked for inclusion. Skipping.')
                continue

        return metrics_created

    metrics = []
    metrics_per_state = {}

    @staticmethod
    def CreateMetric(metric_name, metric_value, metric_unit = None, maximum_value = None, minimum_value = None, warning_threshold = None, critical_threshold = None):
        """
        Creates and register a new metric object.
        """

        logging.info("Preparing for building a new Metric object with '" + metric_name + "'")
        logging.debug("Metric value             : '" + str(metric_value) + "'")
        logging.debug("Metric unit              : '" + str(metric_unit) + "'")
        logging.debug("Metric warning threshold : '" + str(warning_threshold) + "'")
        logging.debug("Metric critical threshold: '" + str(critical_threshold) + "'")

        name  = metric_name
        value = metric_value
        unit  = metric_unit
        max   = maximum_value
        min   = minimum_value

        logging.debug('Creating Metric object.')
        metric = Metric(name, value, unit, min, max)
        logging.debug('Setting Metric object thresholds.')
        if warning_threshold is not None:
            metric.SetWarningThreshold(warning_threshold)
        if critical_threshold is not None:
            metric.SetCriticalThreshold(critical_threshold)

        logging.debug('Registering Metric object.')
        MetricFactory.metrics.append(metric)

        return metric

    @staticmethod
    def GetMetricsStatus():
        """
        Check all the available metrics and returns the worst state it can be found.
        """

        MetricFactory.metrics_per_state[NagiosMetricStatus.ok.value]       = []
        MetricFactory.metrics_per_state[NagiosMetricStatus.warning.value]  = []
        MetricFactory.metrics_per_state[NagiosMetricStatus.critical.value] = []
        MetricFactory.metrics_per_state[NagiosMetricStatus.unknown.value]  = []

        for metric in MetricFactory.metrics:
            state = metric.GetState()
            MetricFactory.metrics_per_state[state.value].append(metric)

        if len(MetricFactory.metrics_per_state[NagiosMetricStatus.critical.value]) > 0:
            return NagiosMetricStatus.critical
        if len(MetricFactory.metrics_per_state[NagiosMetricStatus.warning.value]) > 0:
            return NagiosMetricStatus.warning
        
        return NagiosMetricStatus.ok

    @staticmethod
    def GetMetricsOutput(output_all_metrics):
        """
        Produces a string containing all the metrics built until now in the Nagios Performance Output format.
        Remember: this is only the Performance Output. It does not contains Performance Data nor Service State.
        """

        output = u''

        if len(MetricFactory.metrics_per_state[NagiosMetricStatus.unknown.value]):
            output += "UNKNOWN "
            for metric in MetricFactory.metrics_per_state[NagiosMetricStatus.unknown.value]:
                output += str(metric) + u' '
        if len(MetricFactory.metrics_per_state[NagiosMetricStatus.critical.value]):
            output += "CRITICAL "
            for metric in MetricFactory.metrics_per_state[NagiosMetricStatus.critical.value]:
                output += str(metric) + u' '
        if len(MetricFactory.metrics_per_state[NagiosMetricStatus.warning.value]):
            output += "WARNING "
            for metric in MetricFactory.metrics_per_state[NagiosMetricStatus.warning.value]:
                output += str(metric) + u' '

        if(output_all_metrics):
                if len(MetricFactory.metrics_per_state[NagiosMetricStatus.warning.value]):
                    output += "OK "
                    for metric in MetricFactory.metrics_per_state[NagiosMetricStatus.ok.value]:
                        output += str(metric) + u' '

        return output

    @staticmethod
    def GetMetricsPerformance():
        """
        Produces a string containing all the metrics built until now in the Nagios Performance Data format.
        Remember: this is only the Performance Data. It does not contains Performance Output nor Service State.
        """
        perfdata = u''
        for metric in MetricFactory.metrics:
            perfdata += metric.GetPerformanceData() + u' '

        return perfdata



class VMDConnector:
    """
    Helper class fro managing a connection with VMD Database.
    """
    def __init__(self, username, password):
        """
        Initializes a new connection to VMD Database.
        """
        logging.info('Initializing VMD Database connector.')

        self.__servername =  'mariadb.neteyelocal'
        self.__serverport = '3306'
        self.__databasename = 'vspheredb'
        self.__username = username
        self.__password = password

        logging.debug('VMD Server name   : ' + self.__servername + '.')
        logging.debug('VMD Server port   : ' + self.__serverport + '.')
        logging.debug('VMD Database name : ' + self.__databasename + '.')
        logging.debug('Username for login: ' + self.__username + '.')
        logging.debug('Password          : ***')
        
        logging.info('Connecting to VMD Database.')
        self.__vmd_connection = MySQLdb.connect(
            host  =self.__servername,
            db    =self.__databasename,
            user  =self.__username,
            passwd=self.__password)

        logging.info('Connection with VMD Database established.')

    def GetServerName(self):
        return self.__servername

    def GetServerPort(self):
        return self.__serverport

    def GetDatabaseName(self):
        return self.__databasename

    def GetConnection(self):
        return self.__vmd_connection

    def GetUsername(self):
        return self.__username

    def IsConnected(self):
        if self.__vmd_connection is not None:
            return True
        else:
            return False

class VCenterServer:
    """
    Represents one of the VCenter Servers from which the VMD is gathering data.
    It will allow to look for objects managed by the same VCenter Server.
    """
    def __init__(self, vmd_connection, vcenterserver_name):
        logging.info('Loading data for VCenter Server ' + vcenterserver_name + '.')
        logging.debug("VCenter Server Name: '" + vcenterserver_name + "'")

        query = """
            SELECT
            s.id AS id,
            s.vcenter_id AS vcenter_id,
            s.HOST AS hostname,
            HEX(v.instance_uuid) AS uuid
            FROM vcenter_server s INNER JOIN vcenter v ON v.id = s.vcenter_id
            WHERE s.host = '""" + vcenterserver_name + """'
            ;
        """

        if vmd_connection is None:
            raise ArgumentValueError('vmd_connection', vmd_connection, 'No VMD Connection provided.')
        if vcenterserver_name is None:
            raise ArgumentValueError('vcenterserver_name', vcenterserver_name, 'No VCenter Server name provided.')
        if len(vcenterserver_name) < 1:
            raise ArgumentValueError('vcenterserver_name', vcenterserver_name, 'VCenter Server name must not be an empty string.')

        cursor = vmd_connection.cursor()
        cursor.execute(query)
        data = cursor.fetchall()

        if len(data) < 1:
            logging.error('No VCenter Server data found.')
            raise ValueError('No VCenter Server with name ' + vcenterserver_name + ' has been found. The name is invalid, wrong, with different upper or lower cases?')
        if len(data) > 1:
            logging.error('Found 2 or more VCenter Server with the same name. Unable to understand which one should use.')
            raise ValueError('Found more than one VCenter Server with the same name ' + vcenterserver_name + '.')

        self.__name = vcenterserver_name
        for row in data:
            self.__id       = row[1]
            self.__hostname = row[2]
            self.__uuid     = row[3]

        logging.debug('VCenter data collected from VMD:')
        logging.debug("ID      : '" + str(self.__id) + "'" )
        logging.debug("UUID    : '" + self.__uuid + "'" )
        logging.debug("Hostname: '" + self.__hostname + "'" )

    def GetId(self):
        return self.__id

    def GetUUId(self):
        return self.__uuid

    def GetName(self):
        return self.__name

    def GetHostname(self):
        return self.__hostname

class VMDObject:
    """
    Represents a generic VMD Object. This object only has name, uuid and the state as it is provided by the VCenter Server that manages it.
    It can be used as a base class for specific VMD Object types, allowing the reading of more detailed configuration data and metrics.
    """
    def __init__(self, vmd_connection, vcenter_server, object_type, object_name):
        logging.info('Loading data for object ' + object_name + ' of type ' + object_type + '.')
        logging.debug('VCenter server name: ' + vcenter_server.GetName() + '.')

        query = """
            SELECT
            HEX(uuid) AS uuid,
            object_name AS name,
            overall_status AS status
            FROM object
            WHERE vcenter_uuid = UNHEX('""" + vcenter_server.GetUUId() + """')
            AND object_type = '""" + object_type + """'
            AND object_name = '""" + object_name + """'
            ;
        """

        if vmd_connection is None:
            raise ArgumentValueError('vmd_connection', vmd_connection, 'No VMD Connection provided.')
        if vcenter_server is None:
            raise ArgumentValueError('vcenter_server', vcenter_server, 'No VCenter Server provided.')
        if len(object_name.strip()) < 1:
            raise ArgumentValueError('object_name', object_name, 'Object name must not be an empty string.')

        cursor = vmd_connection.cursor()
        cursor.execute(query)
        data = cursor.fetchall()

        if len(data) < 1:
            logging.error('No VMD Object data found.')
            raise ValueError('No VMD Object with name ' + object_name + ' and type ' + object_type + ' has been found. The name is invalid, wrong, with different upper or lower cases?')
        if len(data) > 1:
            logging.error('Found 2 or more VMD Objects  with the same name and type. Unable to understand which one should use.')
            raise ValueError('Found more than one VMD Object with the same name ' + object_name + ' and the same type ' + object_type + '.')

        self.__name = object_name
        self.__type = object_type
        for row in data:
            self.__uuid   = row[0]
            self.__status = row[2]

        logging.debug('Object data collected from VMD:')
        logging.debug("UUID  : '" + self.__uuid + "'" )
        logging.debug("Status: '" + self.__status + "'" )

    def GetUUId(self):
        return self.__uuid

    def GetName(self):
        return self.__name

    def GetType(self):
        return self.__type

    def GetStatus(self):
        if (self.__status == 'green'):
            return NagiosMetricStatus.ok
        if (self.__status == 'yellow'):
            return NagiosMetricStatus.warning
        if (self.__status == 'red'):
            return NagiosMetricStatus.critical
        return NagiosMetricStatus.unknown

    def GetRawStatus(self):
        return self.__status

class VirtualMachineObject(VMDObject):
    def __init__(self, vmd_connection, vcenter_server, object_name, metric_factory = None):
        logging.debug('Building Virtual Machine VMD Object.')
        VMDObject.__init__(self, vmd_connection, vcenter_server, 'VirtualMachine', object_name)

        logging.debug('Loading Virtual Machine data from VMD Database.')
        data_query = """
            SELECT
            vm.hardware_memorymb * 1024                                                AS virtualmemory_total,
            vm.hardware_numcpu                                                         AS vcpu_Total,
            vm.hardware_numcorespersocket                                              AS vcore_persocket,
            CAST(vm.hardware_numcpu/vm.hardware_numcorespersocket AS UNSIGNED INTEGER) AS vsocket_Total,
            HEX(vm.runtime_host_uuid)                                                  AS hostsystem_uuid,
            hs.hardware_cpu_mhz * 1000000                                              AS hostsystem_max_core_freq,
            (vm.runtime_power_state LIKE 'poweredOn')                                  AS is_running
            FROM
            virtual_machine vm INNER JOIN
            host_system hs ON vm.runtime_host_uuid = hs.uuid
            WHERE vm.vcenter_uuid = UNHEX('""" + vcenter_server.GetUUId() + """')
            AND vm.uuid = UNHEX('""" + self.GetUUId() + """')
            ;
        """

        cursor = vmd_connection.cursor()
        cursor.execute(data_query)
        data = cursor.fetchall()

        if len(data) < 1:
            logging.error('Unable to get Virtual Machine data from VMD.')
            raise ValueError('No Virtual Machine data for VMD Object with name ' + object_name + '.')
        if len(data) > 1:
            logging.error('Found 2 or more Virtual Machines data sets with the same name and type. Unable to understand which one should use.')
            raise ValueError('Found more than one Virtual Machines data sets for VMD Object with name ' + object_name + '.')
        
        for row in data:
            self.__virtual_memory          = row[0]
            self.__cpu_core_per_socket     = row[2]
            self.__cpu_sockets             = row[3]
            self.__cpu_total               = row[1]
            self.__hostsystem_uuid         = row[4]
	    self.__hostsystem_max_cpu_freq = row[5]
            self.__max_cpu_frequency       = row[1] * row[5]
            self.__is_running              = row[6]

        logging.debug('Virtual memory        : ' + str(self.__virtual_memory))
        logging.debug('Cores per socket      : ' + str(self.__cpu_core_per_socket))
        logging.debug('Sockets               : ' + str(self.__cpu_sockets))
        logging.debug('Total cores           : ' + str(self.__cpu_total))
        logging.debug('Host System UUID      : ' + str(self.__hostsystem_uuid))
        logging.debug('Max CPU Core frequency: ' + str(self.__hostsystem_max_cpu_freq))
        logging.debug('Max CPU Frequency     : ' + str(self.__max_cpu_frequency))
        logging.debug('Is running            : ' + str(self.__is_running))

        # Gathering object metrics
        if metric_factory:
            logging.debug('Loading Virtual Machine metrics from VMD Database.')
            metrics_query = """
                SELECT
                vm.overall_cpu_demand          * 1000000 AS cpu_demanded,
                vm.overall_cpu_usage           * 1000000 AS cpu_used,
                vm.host_memory_usage_mb        * 1024    AS memory_usage,
                vm.consumed_overhead_memory_mb * 1024    AS memory_overhead_consumed,
                vm.uptime                                AS uptime,
                vm.guest_memory_usage_mb       * 1024    AS guest_memory_usage,
                vm.ballooned_memory_mb         * 1024    AS guest_memory_ballooned,
                vm.compressed_memory_kb                  AS guest_memory_compressed,
                vm.private_memory_mb           * 1024    AS guest_memory_private,
                vm.shared_memory_mb            * 1024    AS guest_memory_shared,
                vm.swapped_memory_mb           * 1024    AS guest_memory_swapped
                FROM
                vm_quick_stats vm
                WHERE vcenter_uuid = UNHEX('""" + vcenter_server.GetUUId() + """')
                AND uuid = UNHEX('""" + self.GetUUId() + """')
                ;
            """

            cursor = vmd_connection.cursor()
            cursor.execute(metrics_query)
            data = cursor.fetchall()

            if len(data) < 1:
                logging.error('Unable to get Virtual Machine statistics from VMD.')
                raise ValueError('No Virtual Machine statistics for VMD Object with name ' + object_name + '.')
            if len(data) > 1:
                logging.error('Found 2 or more Virtual Machine statistic sets with the same name and type. Unable to understand which one should use.')
                raise ValueError('Found more than one Virtual Machine statistic sets for VMD Object with name ' + object_name + '.')
            
            raw_metrics = []
            for row in data:
                raw_metrics.append({'name':'cpu_demanded',             'value':row[ 0],           'unit':'hz', 'max':self.__max_cpu_frequency, 'min':0})
                raw_metrics.append({'name':'cpu_used',                 'value':row[ 1],           'unit':'hz', 'max':self.__max_cpu_frequency, 'min':0})
                raw_metrics.append({'name':'cpu_starvation',           'value':row[ 0] - row[1],  'unit':'hz', 'max':self.__max_cpu_frequency, 'min':0})
                raw_metrics.append({'name':'memory_usage',             'value':row[ 2],           'unit':'KB', 'max':self.__virtual_memory,    'min':0})
                raw_metrics.append({'name':'memory_overhead_consumed', 'value':row[ 3],           'unit':'KB', 'max':self.__virtual_memory,    'min':0})
                raw_metrics.append({'name':'uptime',                   'value':row[ 4],           'unit':'s',  'max':None,                     'min':0})
                raw_metrics.append({'name':'guest_memory_usage',       'value':row[ 5],           'unit':'KB', 'max':self.__virtual_memory,    'min':0})
                raw_metrics.append({'name':'guest_memory_ballooned',   'value':row[ 6],           'unit':'KB', 'max':self.__virtual_memory,    'min':0})
                raw_metrics.append({'name':'guest_memory_compressed',  'value':row[ 7],           'unit':'KB', 'max':self.__virtual_memory,    'min':0})
                raw_metrics.append({'name':'guest_memory_private',     'value':row[ 8],           'unit':'KB', 'max':self.__virtual_memory,    'min':0})
                raw_metrics.append({'name':'guest_memory_shared',      'value':row[ 9],           'unit':'KB', 'max':self.__virtual_memory,    'min':0})
                raw_metrics.append({'name':'guest_memory_swapped',     'value':row[10],           'unit':'KB', 'max':self.__virtual_memory,    'min':0})
                raw_metrics.append({'name':'vm_running',               'value':self.__is_running, 'unit':None, 'max':1,                        'min':0})


            snapshots_query = """
                SELECT
                COUNT(*) AS Number_of_snapshots
                FROM vm_snapshot
                WHERE vcenter_uuid = UNHEX('""" + vcenter_server.GetUUId() + """')
                AND vm_uuid = UNHEX('""" + self.GetUUId() + """')
                ;
            """
            cursor = vmd_connection.cursor()
            cursor.execute(snapshots_query)
            data = cursor.fetchall()

            number_of_snapshots = 0
            for row in data:
                number_of_snapshots = row[0]

            raw_metrics.append({'name':'active_snapshots', 'value':number_of_snapshots, 'unit':'',  'max':None, 'min':0})

            logging.debug('Loading Guest Disk metrics from VMD Database.')
            guest_disks_query = """
                SELECT
                disk_path AS disk_name,
                capacity,
                free_space
                FROM
                vm_disk_usage
                WHERE vcenter_uuid = UNHEX('""" + vcenter_server.GetUUId() + """')
                AND vm_uuid = UNHEX('""" + self.GetUUId() + """')
                ;
            """

            cursor = vmd_connection.cursor()
            cursor.execute(guest_disks_query)
            data = cursor.fetchall()

            if len(data) < 1:
                logging.info('No Guest Disks data for this VM. Maybe VMware Tools are not running?')

            for row in data:
                metric_name   = 'disk_' + str(row[0]).replace(' ', '_') + '_used'
                disk_capacity = row[1]
                disk_free     = row[2]
                disk_used     = disk_capacity - disk_free
                metric_name   = 'disk_' + str(row[0]).replace(' ', '_') + '_free'
                raw_metrics.append({'name':metric_name, 'value':disk_free, 'unit':'B', 'max':disk_capacity, 'min':0})
                metric_name   = 'disk_' + str(row[0]).replace(' ', '_') + '_used'
                raw_metrics.append({'name':metric_name, 'value':disk_used, 'unit':'B', 'max':disk_capacity, 'min':0})

            self.__metrics = metric_factory.CreateMetrics(raw_metrics)

    def GetMetricsStatus(self):
        """
        Check all the available metrics and returns the worst state it can be found.
        """
        warning_count  = 0
        critical_count = 0

        for metric in self.__metrics.values():
            state = metric.GetState()
            if state == NagiosMetricStatus.warning:
                warning_count += 1
            elif state == NagiosMetricStatus.critical:
                critical_count += 1

        if critical_count > 0:
            return NagiosMetricStatus.critical
        if warning_count > 0:
            return NagiosMetricStatus.warning
        
        return NagiosMetricStatus.ok

    def GetVirtualMemoty(self):
        return self.__virtual_memory
        
    def GetCoresPerSocketCout(self):
        return self.__cpu_core_per_socket

    def GetSocketsCount(self):
        return self.__cpu_sockets

    def GetTotalCoresCount(self):
        return self.__cpu_total

class HostSystemObject(VMDObject):
    def __init__(self, vmd_connection, vcenter_server, object_name, metric_factory = None):
        logging.debug('Building Host System VMD Object.')
        VMDObject.__init__(self, vmd_connection, vcenter_server, 'HostSystem', object_name)

        logging.debug('Loading Host System data from VMD Database.')
        data_query = """
            SELECT
            hardware_cpu_mhz      * 1000000                 AS cpu_core_frequency,
            hardware_cpu_packages                           AS cpu_sockets_total,
            hardware_cpu_cores                              AS cpu_core_total,
            hardware_cpu_threads                            AS cpu_thread_total,
            hardware_cpu_mhz * hardware_cpu_cores * 1000000 AS cpu_capacity_total,
            hardware_memory_size_mb * 1024                  AS memory_total
            FROM host_system
            WHERE vcenter_uuid = UNHEX('""" + vcenter_server.GetUUId() + """')
            AND uuid = UNHEX('""" + self.GetUUId() + """')
            ;
        """

        cursor = vmd_connection.cursor()
        cursor.execute(data_query)
        data = cursor.fetchall()

        if len(data) < 1:
            logging.error('Unable to get Host System data from VMD.')
            raise ValueError('No Host System data for VMD Object with name ' + object_name + '.')
        if len(data) > 1:
            logging.error('Found 2 or more Host Systems data sets with the same name and type. Unable to understand which one should use.')
            raise ValueError('Found more than one Host Systems data sets for VMD Object with name ' + object_name + '.')
        
        for row in data:
            self.__core_frequency = row[0]
            self.__core_total     = row[2]
            self.__cpu_sockets    = row[1]
            self.__cpu_threads    = row[3]
            self.__cpu_capacity   = row[4]
            self.__memory_total   = row[5]

        logging.debug('Core frequency     : ' + str(self.__core_frequency))
        logging.debug('Total cores        : ' + str(self.__core_total))
        logging.debug('Sockets            : ' + str(self.__cpu_sockets))
        logging.debug('Total threads      : ' + str(self.__cpu_threads))
        logging.debug('Total CPU Capacity : ' + str(self.__cpu_capacity))
        logging.debug('System memory      : ' + str(self.__memory_total))

        # Gathering object metrics
        if metric_factory:
            logging.debug('Loading Host System metrics from VMD Database.')
            metrics_query = """
                SELECT
                overall_cpu_usage    * 1000000 AS cpu_usage,
                overall_memory_usage_mb * 1024 AS memory_usage,
                uptime
                FROM
                host_quick_stats
                WHERE vcenter_uuid = UNHEX('""" + vcenter_server.GetUUId() + """')
                AND uuid = UNHEX('""" + self.GetUUId() + """')
                ;
            """

            cursor = vmd_connection.cursor()
            cursor.execute(metrics_query)
            data = cursor.fetchall()

            if len(data) < 1:
                logging.error('Unable to get Host System statistics from VMD.')
                raise ValueError('No Virtual Host Systems for VMD Object with name ' + object_name + '.')
            if len(data) > 1:
                logging.error('Found 2 or more Host System statistic sets with the same name and type. Unable to understand which one should use.')
                raise ValueError('Found more than one Host System statistic sets for VMD Object with name ' + object_name + '.')
            
            raw_metrics = []
            for row in data:
                raw_metrics.append({'name':'cpu_usage',    'value':row[ 0], 'unit':'hz',  'max':self.__cpu_capacity, 'min':0})
                raw_metrics.append({'name':'memory_usage', 'value':row[ 1], 'unit':'KB',  'max':self.__memory_total, 'min':0})
                raw_metrics.append({'name':'uptime',       'value':row[ 2], 'unit':'s',   'max':None,                'min':0})

            sensors_query = """
                SELECT
                health_state AS state,
                COUNT(*) AS sensors_count
                FROM host_sensor
                WHERE vcenter_uuid = UNHEX('""" + vcenter_server.GetUUId() + """')
                AND host_uuid = UNHEX('""" + self.GetUUId() + """')
                GROUP BY health_state
                ;
            """

            cursor = vmd_connection.cursor()
            cursor.execute(sensors_query)
            data = cursor.fetchall()
            
            sensors_green   = 0
            sensors_yellow  = 0
            sensors_red     = 0
            sensors_unknown = 0
            for row in data:
                state = row[0]
                count = int(row[1])

                if state == 'green':
                    sensors_green += count
                elif state == 'yellow':
                    sensors_yellow += count
                elif state == 'red':
                    sensors_red += count
                elif state == 'unknown':
                    sensors_unknown += count
                else:
                    logging.warning('While reading sensors status for Host System ' + self.GetName() + ' the unrecognized state ' + str(state) + ' has been found for ' + str(count) + ' sensor(s). Sensor with this state will be considered UNKNOWN.')
                    sensors_unknown += count

            sensors_total    = sensors_green + sensors_yellow + sensors_red + sensors_unknown

            raw_metrics.append({'name':'sensors_green',   'value':sensors_green,   'unit':'', 'max':sensors_total, 'min':0})
            raw_metrics.append({'name':'sensors_yellow',  'value':sensors_yellow,  'unit':'', 'max':sensors_total, 'min':0})
            raw_metrics.append({'name':'sensors_red',     'value':sensors_red,     'unit':'', 'max':sensors_total, 'min':0})
            raw_metrics.append({'name':'sensors_unknown', 'value':sensors_unknown, 'unit':'', 'max':sensors_total, 'min':0})

            self.__metrics = metric_factory.CreateMetrics(raw_metrics)

    def GetMetricsStatus(self):
        """
        Check all the available metrics and returns the worst state it can be found.
        """
        warning_count  = 0
        critical_count = 0

        for metric in self.__metrics.values():
            state = metric.GetState()
            if state == NagiosMetricStatus.warning:
                warning_count += 1
            elif state == NagiosMetricStatus.critical:
                critical_count += 1

        if critical_count > 0:
            return NagiosMetricStatus.critical
        if warning_count > 0:
            return NagiosMetricStatus.warning
        
        return NagiosMetricStatus.ok

    def GetCoreFrequency(self):
        return self.__core_frequency

    def GetTotalCores(self):
        return self.__core_total

    def GetTotalSockets(self):
        return self.__cpu_sockets

    def GetTotalThreads(self):
        return self.__cpu_threads

    def GetTotalCpuCapacity(self):
        return self.__cpu_capacity

    def GetTotalMemory(self):
        return self.__memory_total

class DatastoreObject(VMDObject):
    def __init__(self, vmd_connection, vcenter_server, object_name, metric_factory = None):
        logging.debug('Building Datastore VMD Object.')
        VMDObject.__init__(self, vmd_connection, vcenter_server, 'Datastore', object_name)

        logging.debug('Loading Datastore data from VMD Database.')
        data_query = """
            SELECT
            capacity AS diskspace_total,
            (IFNULL(multiple_host_access, 'n') = 'n') AS local_access
            FROM datastore
            WHERE vcenter_uuid = UNHEX('""" + vcenter_server.GetUUId() + """')
            AND uuid = UNHEX('""" + self.GetUUId() + """')
            ;
        """

        cursor = vmd_connection.cursor()
        cursor.execute(data_query)
        data = cursor.fetchall()

        if len(data) < 1:
            logging.error('Unable to get Datastore data from VMD.')
            raise ValueError('No Datastore data for VMD Object with name ' + object_name + '.')
        if len(data) > 1:
            logging.error('Found 2 or more Datastores data sets with the same name and type. Unable to understand which one should use.')
            raise ValueError('Found more than one Datastore data sets for VMD Object with name ' + object_name + '.')
        
        for row in data:
            self.__diskspace_total       = row[0]
            self.__is_local              = row[1]

        logging.debug('Total Disk space       : ' + str(self.__diskspace_total))
        logging.debug('Local Access only      : ' + str(self.__is_local))

        # Gathering object metrics
        if metric_factory:
            logging.debug('Loading Datastore metrics from VMD Database.')
            metrics_query = """
                SELECT
                free_space  AS diskspace_available,
                uncommitted AS diskspace_uncommitted
                FROM datastore
                WHERE vcenter_uuid = UNHEX('""" + vcenter_server.GetUUId() + """')
                AND uuid = UNHEX('""" + self.GetUUId() + """')
                ;
            """

            cursor = vmd_connection.cursor()
            cursor.execute(metrics_query)
            data = cursor.fetchall()

            if len(data) < 1:
                logging.error('Unable to get Datastore statistics from VMD.')
                raise ValueError('No Datastore for VMD Object with name ' + object_name + '.')
            if len(data) > 1:
                logging.error('Found 2 or more Datastore statistic sets with the same name and type. Unable to understand which one should use.')
                raise ValueError('Found more than one Datastore statistic sets for VMD Object with name ' + object_name + '.')
            
            raw_metrics = []
            for row in data:
                raw_metrics.append({'name':'diskspace_free',        'value':row[ 0], 'unit':'', 'max':self.__diskspace_total, 'min':0})
                raw_metrics.append({'name':'diskspace_uncommitted', 'value':row[ 1], 'unit':'', 'max':self.__diskspace_total, 'min':0})

            self.__metrics = metric_factory.CreateMetrics(raw_metrics)

    def GetMetricsStatus(self):
        """
        Check all the available metrics and returns the worst state it can be found.
        """
        warning_count  = 0
        critical_count = 0

        for metric in self.__metrics.values():
            state = metric.GetState()
            if state == NagiosMetricStatus.warning:
                warning_count += 1
            elif state == NagiosMetricStatus.critical:
                critical_count += 1

        if critical_count > 0:
            return NagiosMetricStatus.critical
        if warning_count > 0:
            return NagiosMetricStatus.warning
        
        return NagiosMetricStatus.ok

    def GetTotalCapacity(self):
        return self.__diskspace_total

    def IsLocalDatastore(self):
        return self.__is_local

class ResourcePoolObject(VMDObject):
    def __init__(self, vmd_connection, vcenter_server, object_name, metric_factory = None):
        logging.debug('Building Resource Pool VMD Object.')
        VMDObject.__init__(self, vmd_connection, vcenter_server, 'ResourcePool', object_name)

        logging.debug('Loading Resource Pool data from VMD Database.')
        data_query = """
            SELECT
            COUNT(*) AS vm_number,
            SUM(hardware_memorymb) * 1024 AS virtual_memory_allocated
            FROM virtual_machine
            WHERE vcenter_uuid = UNHEX('""" + vcenter_server.GetUUId() + """')
            AND uuid = UNHEX('""" + self.GetUUId() + """')
            ;
        """

        cursor = vmd_connection.cursor()
        cursor.execute(data_query)
        data = cursor.fetchall()

        if len(data) < 1:
            logging.error('Unable to get Resource Pool data from VMD.')
            raise ValueError('No Resource Pool data for VMD Object with name ' + object_name + '.')
        if len(data) > 1:
            logging.error('Found 2 or more Resource Pool data sets with the same name and type. Unable to understand which one should use.')
            raise ValueError('Found more than one Resource Pool data sets for VMD Object with name ' + object_name + '.')
        
        for row in data:
            self.__vm_number                = row[0]
            self.__virtual_memory_allocated = row[1]

        logging.debug('VM Inside this Resource Pool: ' + str(self.__vm_number))
        logging.debug('Total memory allocated      : ' + str(self.__virtual_memory_allocated))

        # Gathering object metrics
        if metric_factory:
            logging.debug('Loading Resource Pool metrics from VMD Database.')
            metrics_query = """
                SELECT
                SUM(q.overall_cpu_demand          * 1000000) AS total_cpu_demanded,
                SUM(q.overall_cpu_usage           * 1000000) AS total_cpu_used,
                SUM(q.host_memory_usage_mb        * 1024)    AS total_memory_usage,
                SUM(q.consumed_overhead_memory_mb * 1024)    AS total_memory_overhead_consumed,
                SUM(q.guest_memory_usage_mb       * 1024)    AS total_guest_memory_usage,
                SUM(q.ballooned_memory_mb         * 1024)    AS total_guest_memory_ballooned,
                SUM(q.compressed_memory_kb)                  AS total_guest_memory_compressed,
                SUM(q.private_memory_mb           * 1024)    AS total_guest_memory_private,
                SUM(q.shared_memory_mb            * 1024)    AS total_guest_memory_shared,
                SUM(q.swapped_memory_mb           * 1024)    AS total_guest_memory_swapped,
                SUM(v.hardware_numcpu)                       AS total_vcpu
                FROM vm_quick_stats q
                INNER JOIN virtual_machine v ON q.uuid = v.uuid
                WHERE v.vcenter_uuid = UNHEX('""" + vcenter_server.GetUUId() + """')
                AND v.resource_pool_uuid = UNHEX('""" + self.GetUUId() + """')
                ;
            """

            cursor = vmd_connection.cursor()
            cursor.execute(metrics_query)
            data = cursor.fetchall()

            if len(data) < 1:
                logging.error('Unable to get Resource Pool statistics from VMD.')
                raise ValueError('No Resource Pool for VMD Object with name ' + object_name + '.')
            if len(data) > 1:
                logging.error('Found 2 or more Resource Pool statistic sets with the same name and type. Unable to understand which one should use.')
                raise ValueError('Found more than one Resource Pool statistic sets for VMD Object with name ' + object_name + '.')
            
            raw_metrics = []
            for row in data:
                raw_metrics.append({'name':'total_cpu_demanded',             'value':row[ 0],          'unit':'hz', 'max':None,                            'min':0})
                raw_metrics.append({'name':'total_cpu_used',                 'value':row[ 1],          'unit':'hz', 'max':None,                            'min':0})
                raw_metrics.append({'name':'total_cpu_starvation',           'value':row[ 0] - row[1], 'unit':'hz', 'max':None,                            'min':0})
                raw_metrics.append({'name':'total_memory_usage',             'value':row[ 2],          'unit':'KB', 'max':self.__virtual_memory_allocated, 'min':0})
                raw_metrics.append({'name':'total_memory_overhead_consumed', 'value':row[ 3],          'unit':'KB', 'max':self.__virtual_memory_allocated, 'min':0})
                raw_metrics.append({'name':'total_guest_memory_usage',       'value':row[ 4],          'unit':'KB', 'max':self.__virtual_memory_allocated, 'min':0})
                raw_metrics.append({'name':'total_guest_memory_ballooned',   'value':row[ 5],          'unit':'KB', 'max':self.__virtual_memory_allocated, 'min':0})
                raw_metrics.append({'name':'total_guest_memory_compressed',  'value':row[ 6],          'unit':'KB', 'max':self.__virtual_memory_allocated, 'min':0})
                raw_metrics.append({'name':'total_guest_memory_private',     'value':row[ 7],          'unit':'KB', 'max':self.__virtual_memory_allocated, 'min':0})
                raw_metrics.append({'name':'total_guest_memory_shared',      'value':row[ 8],          'unit':'KB', 'max':self.__virtual_memory_allocated, 'min':0})
                raw_metrics.append({'name':'total_guest_memory_swapped',     'value':row[ 9],          'unit':'KB', 'max':self.__virtual_memory_allocated, 'min':0})
                raw_metrics.append({'name':'total_vcpu',                     'value':row[10],          'unit':'',   'max':None,                            'min':0})

            self.__metrics = metric_factory.CreateMetrics(raw_metrics)

class ClusterComputeResourceObject(VMDObject):
    def __init__(self, vmd_connection, vcenter_server, object_name, metric_factory = None):
        logging.debug('Building Cluster Compute Resource VMD Object.')
        VMDObject.__init__(self, vmd_connection, vcenter_server, 'ClusterComputeResource', object_name)

        logging.debug('Loading Cluster Compute Resource data from VMD Database.')
        data_query = """
            SELECT
            count(*)                                                 AS hostsystems_number,
            SUM(h.hardware_cpu_mhz * h.hardware_cpu_cores) * 1000000 AS cpu_capacity_total,
            SUM(h.hardware_memory_size_mb)                 * 1024    AS hardware_memory_available
            FROM
            object o
            INNER JOIN object p ON (o.parent_uuid = p.uuid)
            INNER JOIN host_system h ON (o.uuid = h.uuid)
            WHERE o.vcenter_uuid = UNHEX('""" + vcenter_server.GetUUId() + """')
            AND p.uuid = UNHEX('""" + self.GetUUId() + """')
            ;
        """

        cursor = vmd_connection.cursor()
        cursor.execute(data_query)
        data = cursor.fetchall()

        if len(data) < 1:
            logging.error('Unable to get Cluster Compute Resource data from VMD.')
            raise ValueError('No Cluster Compute Resource data for VMD Object with name ' + object_name + '.')
        if len(data) > 1:
            logging.error('Found 2 or more Cluster Compute Resource data sets with the same name and type. Unable to understand which one should use.')
            raise ValueError('Found more than one Cluster Compute Resource data sets for VMD Object with name ' + object_name + '.')
        
        for row in data:
            self.__host_number           = row[0]
            self.__host_cpu_capacity     = row[1]
            self.__host_memory_available = row[2]

        logging.debug('Host systems Inside this Cluster Compute Resource: ' + str(self.__host_number))
        logging.debug('Total CPU clock available                        : ' + str(self.__host_cpu_capacity))
        logging.debug('Total memory available                           : ' + str(self.__host_memory_available))

        # Gathering object metrics
        if metric_factory:
            logging.debug('Loading Cluster Compute Resource metrics from VMD Database.')
            metrics_query = """
                SELECT
                SUM(q.overall_cpu_usage       * 1000000) AS total_cpu_used,
                SUM(q.overall_memory_usage_mb * 1024)    AS total_memory_usage
                FROM
                object o
                INNER JOIN object p ON (o.parent_uuid = p.uuid)
                INNER JOIN host_quick_stats q ON (o.uuid = q.uuid)
                WHERE o.vcenter_uuid = UNHEX('""" + vcenter_server.GetUUId() + """')
                AND p.uuid = UNHEX('""" + self.GetUUId() + """')
                ;
            """

            cursor = vmd_connection.cursor()
            cursor.execute(metrics_query)
            data = cursor.fetchall()

            if len(data) < 1:
                logging.error('Unable to get Cluster Compute Resource statistics from VMD.')
                raise ValueError('No Cluster Compute Resource for VMD Object with name ' + object_name + '.')
            if len(data) > 1:
                logging.error('Found 2 or more Cluster Compute Resource statistic sets with the same name and type. Unable to understand which one should use.')
                raise ValueError('Found more than one Cluster Compute Resource statistic sets for VMD Object with name ' + object_name + '.')
            
            raw_metrics = []
            for row in data:
                raw_metrics.append({'name':'total_cpu_used',     'value':row[ 0], 'unit':'hz', 'max':self.__host_cpu_capacity,     'min':0})
                raw_metrics.append({'name':'total_memory_usage', 'value':row[ 1], 'unit':'KB', 'max':self.__host_memory_available, 'min':0})

            self.__metrics = metric_factory.CreateMetrics(raw_metrics)

    def GetMetricsStatus(self):
        """
        Check all the available metrics and returns the worst state it can be found.
        """
        warning_count  = 0
        critical_count = 0

        for metric in self.__metrics.values():
            state = metric.GetState()
            if state == NagiosMetricStatus.warning:
                warning_count += 1
            elif state == NagiosMetricStatus.critical:
                critical_count += 1

        if critical_count > 0:
            return NagiosMetricStatus.critical
        if warning_count > 0:
            return NagiosMetricStatus.warning
        
        return NagiosMetricStatus.ok

    def GetTotalCapacity(self):
        return self.__diskspace_total

    def IsLocalDatastore(self):
        return self.__is_local








def concatenate_array(array, value_on_none = '', separator = ', '):
    """
    Support function: if the array is not None, all the elements will be joined together on a string using the specified separator.
    If the array is None, the value_on_none string is returned.
    """
    output = value_on_none
    if array is not None:
        output = separator.join(array)

    return output

def convert_array_to_dictionary(array, separator='='):
    """
    Support function to convert an array of strings into a dictionary of key-value pairs.
    Each key-value pair is obtained by splitting each string at the first occurrence of the specified separator.
    If the separator is not present, the string will simply be discarded.
    """
    dictionary = None

    if array:
        dictionary = {}
        for element in array:
            splitted = element.split('=', 1)
            if (len(splitted) > 1):
                dictionary[splitted[0]] = splitted[1]

    return dictionary

def parse_command_line(command_line_overwrite = None):
    """
    Support function for parsing command line arguments.
    If you want, you can provide a string that will be used instead of the original command line.
    Uses argparse.
    """
    # Preparing for command line arguments parsing
    parser = argparse.ArgumentParser(description='Reads the state of a VMD Object and its metrics from VSphereDB Database.')

    parser.add_argument('-s', '--vcsa-name',          required=True,  action='store',      dest='vcsa_name',
        metavar='VCSAServerName',       help='Name of the VCSA queried by VSphereDB. If VSphereDB queries directly an ESXi host, its name must be provided.')
    parser.add_argument('-t', '--object-type',        required=True,                       dest='vmd_object_type', choices=vmd_object_types,
        metavar='VMDObjectType',        help='Type of the VMD Object of which its state you want to check. Supported types are: ' + ', '.join(vmd_object_types))
    parser.add_argument('-m',  '--check-method',      required=False,                      dest='check_method', choices=['VCSA', 'Metrics', 'Both'], default='Both',
        metavar='Method',               help='Method used to determine the state of the object. Possible values: VCSA, Metrics, Both. VCSA means the state of the object is the state read directly from the source used by VMD. Metrics uses thresholds to determine the state of each metric, then the worst state will be selected. Both means both VCSA and Metrics methods will be used, and the worst one will be reported. Default: %(default)s')
    parser.add_argument('-n', '--object-name',        required=True,  action='store',      dest='vmd_object_name',
        metavar='VMDObjectName',        help='Name of the VMD Object of which its state you want to check.')
    parser.add_argument('-w', '--warning',            required=False, action='append',     dest='warning_thresholds',
        metavar='MetricName=Threshold', help='NAGIOS-Style interval describing a warning threshold for metric MetricName. This parameter can be specified multiple times, each time for a different metric.')
    parser.add_argument('-c', '--critical',           required=False, action='append',     dest='critical_thresholds',
        metavar='MetricName=Threshold', help='NAGIOS-Style interval describing a critical threshold for metric MetricName. This parameter can be specified multiple times, each time for a different metric.')
    parser.add_argument('-i', '--metric-to-include',  required=False, action='append',     dest='metrics_to_include',
        metavar='MetricName',           help='Name of a metric you want to include . This script will load only the specifiec metric. This parameter can be specified multiple times, each time for a different metric.')
    parser.add_argument('-x', '--metric-to-exclude',  required=False, action='append',     dest='metrics_to_exclude',
        metavar='MetricName',           help='Name of a metric you want to skip. This script will load all the available (or included) metrics, then will discard the specified metric.This parameter can be specified multiple times, each time for a different metric.')
    parser.add_argument(      '--override-max-value', required=False, action='append',     dest='max_values_override',
        metavar='MetricName=MaxValue',  help='Override Maximum Value for a given Metric. The value automatically obtained by the script will be replaced with the one provided by command line.')
    parser.add_argument(      '--override-min-value', required=False, action='append',     dest='min_values_override',
        metavar='MetricName=MinValue',  help='Override Minimum Value for a given Metric. The value automatically obtained by the script will be replaced with the one provided by command line.')
    parser.add_argument(      '--output-all-metrics', required=False, action='store_true', dest='output_all_metrics',
                                        help='By default, only faulted metrics (ordered by fault severity) are displayed as output. If specified, all metrics will be displayed as output. This does not affect performance data.')

    parser.add_argument('-v', '--verbose',           required=False, action='count', default=0)
    parser.add_argument('-V', '--version',                           action='version', version='%(prog)s 0.2')

    if command_line_overwrite:
        arguments = parser.parse_args(command_line_overwrite.split(' '))
    else:
        arguments = parser.parse_args()

    return arguments

vmd_object_types = [
#    'ComputeResource',
    'ClusterComputeResource',
#    'Datacenter',
    'Datastore',
#    'DatastoreHostMount',
#    'DistributedVirtualPortgroup',
#    'DistributedVirtualSwitch',
#    'Folder',
#    'HostMountInfo',
    'HostSystem',
#    'Network',
    'ResourcePool',
#    'StoragePod',
#    'VirtualApp',
    'VirtualMachine',
#    'VmwareDistributedVirtualSwitch'
]

return_value = NagiosMetricStatus.ok

try:
    arguments = parse_command_line()

    vcsa_name           = arguments.vcsa_name
    vmd_object_type     = arguments.vmd_object_type
    vmd_object_name     = arguments.vmd_object_name
    max_values_override = arguments.max_values_override
    min_values_override = arguments.min_values_override
    metrics_to_include  = arguments.metrics_to_include
    metrics_to_exclude  = arguments.metrics_to_exclude
    warning_thresholds  = arguments.warning_thresholds
    critical_thresholds = arguments.critical_thresholds
    output_all_metrics  = arguments.output_all_metrics
    status_check_method = arguments.check_method
    log_level_count     = arguments.verbose

    # Setting log level for this script. Default is WARNING or above.
    # If by command line one or more verbose are specified, log level is updated accordingly
    log_level = logging.WARNING
    if log_level_count == 0:
        log_level = logging.WARNING
    if log_level_count == 1:
        log_level = logging.INFO
    if log_level_count > 1:
        log_level = logging.DEBUG
    
    # Configuring log level (only if this is the main instance)
    if __name__ == '__main__':
        logging.basicConfig(level=log_level, format='[%(asctime)s][%(levelname)-8s] %(message)s')

    # Logging argument values. Useful for debugging.
    metrics_to_include_string  = concatenate_array(metrics_to_include,  'All')
    metrics_to_exclude_string  = concatenate_array(metrics_to_exclude,  'None')
    warning_thresholds_string  = concatenate_array(warning_thresholds,  'None')
    critical_thresholds_string = concatenate_array(critical_thresholds, 'None')
    max_values_override_string = concatenate_array(max_values_override, 'None')
    min_values_override_string = concatenate_array(min_values_override, 'None')

    logging.debug('Arguments from command line:')
    logging.debug("VCSA Server name              : '" + vcsa_name                  + "'")
    logging.debug("VMD Object Type               : '" + vmd_object_type            + "'")
    logging.debug("VMD Object Name               : '" + vmd_object_name            + "'")
    logging.debug("Metrics Maximum value override: '" + max_values_override_string + "'")
    logging.debug("Metrics Minimum value override: '" + min_values_override_string + "'")
    logging.debug("Metrics to include            : '" + metrics_to_include_string  + "'")
    logging.debug("Metrics to exclude            : '" + metrics_to_exclude_string  + "'")
    logging.debug("Warning Thresholds            : '" + warning_thresholds_string  + "'")
    logging.debug("Critical Thresholds           : '" + critical_thresholds_string + "'")
    logging.debug("State calculation method      : '" + status_check_method        + "'")
    logging.debug("Log level                     : '" + str(log_level_count)       + "'")

    #Converting arguments to the right format
    warning_thresholds_dictionary  = convert_array_to_dictionary(warning_thresholds)
    critical_thresholds_dictionary = convert_array_to_dictionary(critical_thresholds)
    max_values_override_dictionary = convert_array_to_dictionary(max_values_override)
    min_values_override_dictionary = convert_array_to_dictionary(min_values_override)

    # Connecting to VMD Database
    logging.info('Connecting to VMD Database.')
    connector = VMDConnector(vmddb_username, vmddb_password)
    connection = connector.GetConnection()

    # Looking for the specified VCSA inside the database.
    # The VCSA is required because objects managed by different VCSA might have the same name, while the name of an object is unique for every VCSA
    logging.info('Loading VCenter Server data.')
    vcenter_server = VCenterServer(connection, vcsa_name)

    # Searching for the requested VMD Object.
    logging.info('Loading data for requested VMD Object.')
    metric_factory = MetricFactory(metrics_to_include, metrics_to_exclude, warning_thresholds_dictionary, critical_thresholds_dictionary, max_values_override_dictionary, min_values_override_dictionary)

    # The object with the right type (corresponding to what expressed as an argument) will be created
    object = None
    if (vmd_object_type == 'ComputeResource'):
        raise 
    elif (vmd_object_type == 'ClusterComputeResource'):
        object = ClusterComputeResourceObject(connection, vcenter_server, vmd_object_name, metric_factory)
    elif (vmd_object_type == 'Datacenter'):
        pass
    elif (vmd_object_type == 'Datastore'):
        object = DatastoreObject(connection, vcenter_server, vmd_object_name, metric_factory)
        pass
    elif (vmd_object_type == 'DatastoreHostMount'):
        pass
    elif (vmd_object_type == 'DistributedVirtualPortgroup'):
        pass
    elif (vmd_object_type == 'DistributedVirtualSwitch'):
        pass
    elif (vmd_object_type == 'Folder'):
        pass
    elif (vmd_object_type == 'HostMountInfo'):
        pass
    elif (vmd_object_type == 'HostSystem'):
        object = HostSystemObject(connection, vcenter_server, vmd_object_name, metric_factory)
    elif (vmd_object_type == 'Network'):
        pass
    elif (vmd_object_type == 'ResourcePool'):
        object = ResourcePoolObject(connection, vcenter_server, vmd_object_name, metric_factory)
    elif (vmd_object_type == 'StoragePod'):
        pass
    elif (vmd_object_type == 'VirtualApp'):
        pass
    elif (vmd_object_type == 'VirtualMachine'):
        object = VirtualMachineObject(connection, vcenter_server, vmd_object_name, metric_factory)
    elif (vmd_object_type == 'VmwareDistributedVirtualSwitch'):
        pass

    # Assertion: at this point, OBJECT MUST EXIST
    assert object is not None

    # Determining the state of the object.
    # The state will be determined by using the algorithm selected by the end user at command line.
    object_status  = NagiosMetricStatus.unknown
    vcsa_status    = object.GetStatus()
    metrics_status = MetricFactory.GetMetricsStatus()

    if status_check_method == 'VCSA':
        object_status = vcsa_status
    elif status_check_method == 'Metrics':
        object_status = metrics_status
    elif status_check_method == 'Both':
        if metrics_status.value > vcsa_status.value:
            object_status = metrics_status
        else:
            object_status = vcsa_status

    return_value = object_status

    # Now that the state has been determined, the right output can be produced.
    perf_output = MetricFactory.GetMetricsOutput(output_all_metrics)
    perf_data   = MetricFactory.GetMetricsPerformance()

    output = vmd_object_type + u' status is ' + return_value.name.upper() + u': '
    
    if len(perf_output) > 0:
        output += perf_output
    else:
        output += u'All metrics are OK'
    
    output += '| ' + perf_data
    
    print(output)

except Exception as e:
    print(NagiosMetricStatus.unknown.name + ' - ' + str(e))
    return_value = NagiosMetricStatus.unknown
except SystemExit:
    pass
except:
    print('Unhandled exception: Unable to catch the raised exception')
    return_value = NagiosMetricStatus.unknown
finally:
    try:
        # Try to estroy DB connection: if it exists, it will be closed.
        # Any kind of error (including undefined connection object) will be ignored.
        if connection:
            connection.close()
    except:
        pass

    sys.exit(return_value.value)

