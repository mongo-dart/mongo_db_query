import '../base/common/operators_def.dart';
import '../base/operator_expression.dart';
import '../query_expression/query_expression.dart';

/// `$concat` operator
class $concat extends OperatorExpression {
  /// Creates `$concat` operator expression
  ///
  /// Concatenates strings and returns the concatenated string.
  ///
  /// The [strings] is a [List] of valid expression as long as they resolve to
  /// strings.
  $concat(List strings) : super(op$concat, valueToContent(strings));
}

/// `$indexOfBytes` operator
class $indexOfBytes extends OperatorExpression {
  /// Creates `$indexOfBytes` operator expression
  ///
  /// Searches a [string] for an occurence of a [substring] and returns the
  /// UTF-8 byte index (zero-based) of the first occurence. If the [substring]
  /// is not found, returns -1.
  ///
  /// * [string] - Can be any valid expression as long as it resolves to a string.
  /// If the string expression resolves to a value of `null` or refers to a
  /// field that is missing, $indexOfCP returns `null`. If the string expression
  /// does not resolve to a string or `null` nor refers to a missing field,
  /// `$indexOfBytes` returns an error.
  /// * [substring] - Can be any valid expression as long as it resolves to a
  /// string.
  /// [start] - Optional. An integral number that specifies the starting index
  /// position for the search. Can be any valid expression that resolves to a
  /// non-negative integral number.
  /// [end] - Optional. An integral number that specifies the ending index
  /// position for the search. Can be any valid expression that resolves to a
  /// non-negative integral number. If you specify a [end] index value, you
  /// should also specify a [start] index value; otherwise, `$indexOfBytes` uses
  /// the [end] value as the [start] index value instead of the [end] value.
  $indexOfBytes(string, substring, [start, end])
      : super(op$indexOfBytes, valueToContent([string, substring, start, end]));
}

/// `$indexOfCP` operator
class $indexOfCP extends OperatorExpression {
  /// Creates `$indexOfCP` operator expression
  ///
  /// Searches a [string] for an occurence of a [substring] and returns the
  /// UTF-8 code point index (zero-based) of the first occurence. If the
  /// [substring] is not found, returns -1.
  ///
  /// * [string] - Can be any valid expression as long as it resolves to a string.
  /// If the string expression resolves to a value of `null` or refers to a
  /// field that is missing, $indexOfCP returns `null`. If the string expression
  /// does not resolve to a string or `null` nor refers to a missing field,
  /// `$indexOfCP` returns an error.
  /// * [substring] - Can be any valid expression as long as it resolves to a
  /// string.
  /// [start] - Optional. An integral number that specifies the starting index
  /// position for the search. Can be any valid expression that resolves to a
  /// non-negative integral number.
  /// [end] - Optional. An integral number that specifies the ending index
  /// position for the search. Can be any valid expression that resolves to a
  /// non-negative integral number. If you specify a [end] index value, you
  /// should also specify a [start] index value; otherwise, `$indexOfCP` uses
  /// the [end] value as the [start] index value instead of the [end value.
  $indexOfCP(string, substring, [start, end])
      : super(op$indexOfCP, valueToContent([string, substring, start, end]));
}

/// `$ltrim` operator
class $ltrim extends OperatorExpression {
  /// Creates `$ltrim` operator expression
  ///
  /// Removes whitespace characters, including null, or the specified characters
  /// from the beginning of a string.
  ///
  /// * [input] - The string to trim. The argument can be any valid expression
  /// that resolves to a string.
  /// * [chars] - Optional. The character(s) to trim from the beginning of the input.
  /// The argument can be any valid expression that resolves to a string. The `$ltrim`
  /// operator breaks down the string into individual UTF code point to trim from input.
  /// If unspecified, `$ltrim` removes whitespace characters, including the `null`
  /// character.
  $ltrim({required input, chars})
      : super(op$ltrim, valueToContent({'input': input, 'chars': chars}));
}

// TODO: add options validation

/// `$regexFind` operator
class $regexFind extends OperatorExpression {
  /// Creates `$regexFind` operator expression
  ///
  /// Provides regular expression (regex) pattern matching capability in
  /// aggregation expressions. If a match is found, returns a document that
  /// contains information on the first match. If a match is not found, returns
  /// `null`.
  ///
  /// MongoDB uses Perl compatible regular expressions (i.e. “PCRE” ) version
  /// 8.41 with UTF-8 support.
  ///
  /// * [input] - The string on which you wish to apply the regex pattern. Can
  /// be a string or any valid expression that resolves to a string.
  /// * [regex] - The regex pattern to apply. Can be any valid expression that
  /// resolves to a string.
  /// * [options] - Optional. The following <options> are available for use with
  /// regular expression:
  ///   * `i` - Case insensitivity to match both upper and lower cases. You can
  /// specify the option in the options field or as part of the regex field.
  ///   * `m` - For patterns that include anchors (i.e. ^ for the start, $ for
  /// the end), match at the beginning or end of each line for strings with
  /// multiline values. Without this option, these anchors match at beginning or
  /// end of the string. If the pattern contains no anchors or if the string
  /// value has no newline characters (e.g. \n), the m option has no effect.
  ///   * `x` - “Extended” capability to ignore all white space characters in the
  /// pattern unless escaped or included in a character class. Additionally, it
  /// ignores characters in-between and including an un-escaped hash/pound (#)
  /// character and the next new line, so that you may include comments in
  /// complicated patterns. This only applies to data characters; white space
  /// characters may never appear within special character sequences in a pattern.
  /// The `x` option does not affect the handling of the VT character (i.e. code
  /// 11).
  ///   * `s` - Allows the dot character (i.e. .) to match all characters including
  /// newline characters.
  $regexFind({required input, required regex, options})
      : super(
            op$regexFind,
            valueToContent(
                {'input': input, 'regex': regex, 'options': options}));
}

/// `$regexFindAll` operator
class $regexFindAll extends OperatorExpression {
  /// Creates `$regexFindAll` operator expression
  ///
  /// Provides regular expression (regex) pattern matching capability in
  /// aggregation expressions. The operator returns an array of documents that
  /// contains information on each match. If a match is not found, returns an
  /// empty array.
  ///
  /// MongoDB uses Perl compatible regular expressions (i.e. “PCRE” ) version
  /// 8.41 with UTF-8 support.
  ///
  /// * [input] - The string on which you wish to apply the regex pattern. Can
  /// be a string or any valid expression that resolves to a string.
  /// * [regex] - The regex pattern to apply. Can be any valid expression that
  /// resolves to a string.
  /// * [options] - Optional. The following <options> are available for use with
  /// regular expression:
  ///   * `i` - Case insensitivity to match both upper and lower cases. You can
  /// specify the option in the options field or as part of the regex field.
  ///   * `m` - For patterns that include anchors (i.e. ^ for the start, $ for
  /// the end), match at the beginning or end of each line for strings with
  /// multiline values. Without this option, these anchors match at beginning or
  /// end of the string. If the pattern contains no anchors or if the string
  /// value has no newline characters (e.g. \n), the m option has no effect.
  ///   * `x` - “Extended” capability to ignore all white space characters in the
  /// pattern unless escaped or included in a character class. Additionally, it
  /// ignores characters in-between and including an un-escaped hash/pound (#)
  /// character and the next new line, so that you may include comments in
  /// complicated patterns. This only applies to data characters; white space
  /// characters may never appear within special character sequences in a pattern.
  /// The `x` option does not affect the handling of the VT character (i.e. code
  /// 11).
  ///   * `s` - Allows the dot character (i.e. .) to match all characters including
  /// newline characters.
  $regexFindAll({required input, required regex, options})
      : super(
            op$regexFindAll,
            valueToContent(
                {'input': input, 'regex': regex, 'options': options}));
}

/// `$regexMatch` operator
class $regexMatch extends OperatorExpression {
  /// Creates `$regexMatch` operator expression
  ///
  /// Performs a regular expression (regex) pattern matching and returns:
  ///
  /// * `true` if a match exists.
  /// * `false` if a match doesn’t exist.
  ///
  /// MongoDB uses Perl compatible regular expressions (i.e. “PCRE” ) version
  /// 8.41 with UTF-8 support.
  ///
  /// * [input] - The string on which you wish to apply the regex pattern. Can
  /// be a string or any valid expression that resolves to a string.
  /// * [regex] - The regex pattern to apply. Can be any valid expression that
  /// resolves to a string.
  /// * [options] - Optional. The following <options> are available for use with
  /// regular expression:
  ///   * `i` - Case insensitivity to match both upper and lower cases. You can
  /// specify the option in the options field or as part of the regex field.
  ///   * `m` - For patterns that include anchors (i.e. ^ for the start, $ for
  /// the end), match at the beginning or end of each line for strings with
  /// multiline values. Without this option, these anchors match at beginning or
  /// end of the string. If the pattern contains no anchors or if the string
  /// value has no newline characters (e.g. \n), the m option has no effect.
  ///   * `x` - “Extended” capability to ignore all white space characters in the
  /// pattern unless escaped or included in a character class. Additionally, it
  /// ignores characters in-between and including an un-escaped hash/pound (#)
  /// character and the next new line, so that you may include comments in
  /// complicated patterns. This only applies to data characters; white space
  /// characters may never appear within special character sequences in a pattern.
  /// The `x` option does not affect the handling of the VT character (i.e. code
  /// 11).
  ///   * `s` - Allows the dot character (i.e. .) to match all characters including
  /// newline characters.
  $regexMatch({required input, required regex, options})
      : super(
            op$regexMatch,
            valueToContent(
                {'input': input, 'regex': regex, 'options': options}));
}

/// `$rtrim` operator
class $rtrim extends OperatorExpression {
  /// Creates `$rtrim` operator expression
  ///
  /// Removes whitespace characters, including `null`, or the specified
  /// characters from the end of a string.
  ///
  /// * [input] - The string to trim. The argument can be any valid expression
  /// that resolves to a string.
  /// * [chars] - Optional. The character(s) to trim from the beginning of the input.
  /// The argument can be any valid expression that resolves to a string. The `$ltrim`
  /// operator breaks down the string into individual UTF code point to trim from input.
  /// If unspecified, `$ltrim` removes whitespace characters, including the `null`
  /// character.
  $rtrim({required input, chars})
      : super(op$rtrim, valueToContent({'input': input, 'chars': chars}));
}

/// `$split` operator
class $split extends OperatorExpression {
  /// Creates `$split` operator expression
  ///
  /// Divides a [string] into an array of substrings based on a [delimiter].
  /// `$split` removes the [delimiter] and returns the resulting substrings as
  /// elements of an array. If the [delimiter] is not found in the [string],
  /// `$split` returns the original [string] as the only element of an array.
  ///
  /// * [string] - The string to be split. string expression can be any valid
  /// expression as long as it resolves to a string.
  /// * [delimiter] - The delimiter to use when splitting the string expression.
  /// delimiter can be any valid expression as long as it resolves to a string.
  $split(string, delimiter)
      : super(op$split, valueToContent([string, delimiter]));
}

/// `$strLenBytes` operator
class $strLenBytes extends OperatorExpression {
  /// Creates `$strLenBytes` operator expression
  ///
  /// Returns the number of UTF-8 encoded bytes in the specified string.
  $strLenBytes(expr) : super(op$strLenBytes, valueToContent(expr));
}

/// `$strLenCP` operator
class $strLenCP extends OperatorExpression {
  /// Creates `$xtrLenCp` operator expression
  ///
  /// Returns the number of UTF-8 code points in the specified string.
  $strLenCP(expr) : super(op$strLenCP, valueToContent(expr));
}

/// `$strcasecmp` operator
class $strCaseCmp extends OperatorExpression {
  /// Creates `$strcasecmp` operator expression
  ///
  /// Performs case-insensitive comparison of two strings. Returns
  ///
  /// * 1 if first string is “greater than” the second string.
  /// * 0 if the two strings are equal.
  /// * -1 if the first string is “less than” the second string.
  $strCaseCmp(a, b) : super(op$strcasecmp, valueToContent([a, b]));
}

/// `$substrBytes` operator
class $substrBytes extends OperatorExpression {
  /// Creates `$substrBytes` operator expression
  ///
  /// Returns the substring of a string. The substring starts with the
  /// character at the specified UTF-8 byte index (zero-based) in the string
  /// and continues for the number of bytes specified.
  ///
  /// * [string] - The string from which the substring will be extracted.
  /// [string] expression can be any valid expression as long as it resolves
  /// to a string. If the argument resolves to a value of `null` or refers to a
  /// field that is missing, `$substrBytes` returns an empty string. If the
  /// argument does not resolve to a string or `null` nor refers to a missing
  /// field, `$substrBytes` returns an error.
  /// * [index] - Indicates the starting point of the substring. Byte [index] can
  /// be any valid expression as long as it resolves to a non-negative integer
  /// or number that can be represented as an integer (such as 2.0). Byte index
  /// cannot refer to a starting index located in the middle of a multi-byte
  /// UTF-8 character.
  /// * [count] - Can be any valid expression as long as it resolves to a
  /// non-negative integer or number that can be represented as an integer
  /// (such as 2.0). Byte count can not result in an ending index that is in the
  /// middle of a UTF-8 character.
  $substrBytes(string, index, count)
      : super(op$substrBytes, valueToContent([string, index, count]));
}

/// `$substrCP` operator
class $substrCP extends OperatorExpression {
  /// Creates `$substrCP` operator expression
  ///
  /// Returns the substring of a string. The substring starts with the character
  /// at the specified UTF-8 code point (CP) index (zero-based) in the string for
  /// the number of code points specified.
  ///
  /// * [string] - The string from which the substring will be extracted. [string]
  /// expression can be any valid expression as long as it resolves to a string.
  /// If the argument resolves to a value of `null` or refers to a field that is
  /// missing, `$substrCP` returns an empty string. If the argument does not
  /// resolve to a string or `null` nor refers to a missing field, `$substrCP`
  /// returns an error.
  /// * [index] - Indicates the starting point of the substring. code point index
  /// can be any valid expression as long as it resolves to a non-negative
  /// integer.
  /// * [count] - Can be any valid expression as long as it resolves to a
  /// non-negative integer or number that can be represented as an integer
  /// (such as 2.0).
  $substrCP(string, index, count)
      : super(op$substrCP, valueToContent([string, index, count]));
}

/// `$toLower` operator
class $toLower extends OperatorExpression {
  /// Creates `$toLower` operator expression
  ///
  /// Converts a string to lowercase, returning the result.
  ///
  /// The argument can be any expression as long as it resolves to a string.
  $toLower(expr) : super(op$toLower, valueToContent(expr));
}

/// `$toString` operator
class $toString extends OperatorExpression {
  /// Creates `$toString` operator expression
  ///
  /// Converts a value to a string. If the value cannot be converted to a
  /// string, $toString errors. If the value is null or missing, $toString
  /// returns null.
  ///
  /// The $toString takes any valid expression.
  $toString(expr) : super(op$toString, valueToContent(expr));
}

/// `$trim` operator
class $trim extends OperatorExpression {
  /// Creates `$trim` operator expression
  ///
  /// Removes whitespace characters, including null, or the specified characters
  /// from the beginning and end of a string.
  ///
  /// * [input] - The string to trim. The argument can be any valid expression
  /// that resolves to a string.
  /// * [chars] - Optional. The character(s) to trim from the beginning of the input.
  /// The argument can be any valid expression that resolves to a string. The `$ltrim`
  /// operator breaks down the string into individual UTF code point to trim from input.
  /// If unspecified, `$ltrim` removes whitespace characters, including the `null`
  /// character.
  $trim({required input, chars})
      : super(op$trim, valueToContent({'input': input, 'chars': chars}));
}

/// `$toUpper` operator
class $toUpper extends OperatorExpression {
  /// Creates `$toUpper` operator expression
  ///
  /// Converts a string to uppercase, returning the result.
  ///
  /// The argument can be any expression as long as it resolves to a string.
  $toUpper(expr) : super(op$toUpper, valueToContent(expr));
}
