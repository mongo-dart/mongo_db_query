import 'common/document_types.dart';
import 'expression_content.dart';
import 'list_expression.dart';
import 'map_expression.dart';
import 'set_expression.dart';

dynamic _setValue(value) {
  if (value is List) {
    return ListExpression(value);
  }
  if (value is Set) {
    return SetExpression(value);
  }
  if (value is MongoDocument) {
    return MapExpression(value);
  }
  return value;
}

/// Represents a class that can hold any kind of data (a sort of dynamic)
class ValueExpression extends ExpressionContent {
  ValueExpression._(this._value);

  static ExpressionContent create(value) {
    var tempExpression = _setValue(value);
    if (tempExpression is ExpressionContent) {
      return tempExpression;
    }
    return ValueExpression._(tempExpression);
  }

  final dynamic _value;

  @override
  dynamic get rawContent {
    if (_value is ExpressionContent) {
      return _value.rawContent;
    }

    return _value;
  }
}
