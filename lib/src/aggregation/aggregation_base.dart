import 'package:meta/meta.dart';
import 'package:mongo_db_query/src/base/operator_expression.dart';

import '../base/expression_content.dart';
import '../base/field_expression.dart';
import 'ae_list.dart';

/// Aggregation expression
/* abstract class ExpressionContent implements Builder {
  const ExpressionContent();
} */

/// Basic aggregation operator
abstract class Operator extends ExpressionContent {
  final dynamic _args;
  final String _name;
  Operator(this._name, this._args);
  @override
  Map<String, dynamic> get rawContent =>
      {'\$$_name': _args is ExpressionContent ? _args.rawContent : _args};
}

/// Basic accumulation operator
abstract class Accumulator extends OperatorExpression {
  Accumulator(super.name, super.expr);
}

/// Aggregation expression's object
///
/// The object is used in aggregation expressions and is aggregation expression as well
class AEObject extends Iterable<MapEntry<String, dynamic>>
    implements ExpressionContent {
  final Iterable<MapEntry<String, dynamic>> _iterable;

  factory AEObject(Map<String, dynamic> map) {
    //if (map == null) return null;
    return AEObject.internal(map);
  }
  @protected
  AEObject.internal(Map<String, dynamic> map)
      : _iterable = map.entries.where(_valueIsNotNull).map((entry) {
          if (entry.value is List) {
            return MapEntry(entry.key, AEList(entry.value as List));
          }
          if (entry.value is Map<String, dynamic>) {
            return MapEntry(
                entry.key, AEObject(entry.value as Map<String, dynamic>));
          }
          return entry;
        });
  @override
  AEIterator<MapEntry<String, dynamic>> get iterator =>
      AEIterator<MapEntry<String, dynamic>>(_iterable);
  @override
  Map<String, dynamic> get rawContent =>
      Map.fromEntries(_iterable).map((argName, argValue) => MapEntry(argName,
          argValue is ExpressionContent ? argValue.rawContent : argValue));
}

/// Returns `true` if value is not null
///
/// The function is used  to filter not null elements in [AEObject] and [AEList]
/// constuctors
bool _valueIsNotNull(value) =>
    value is MapEntry ? value.value != null : value != null;

/// Field path expression
///
class Field extends ExpressionContent {
  final String _fieldPath;

  /// Creates a field path expression
  ///
  /// [fieldPath] - [String] describing a field path. To traverse an
  /// hierarchical document use dot notation. For example: `user.name`
  ///
  /// After build [Field] will look like `$fieldPath`
  const Field(String fieldPath) : _fieldPath = fieldPath;
  @override
  String get rawContent => '\$$_fieldPath';
}

/// Constant expression
class Const extends ExpressionContent {
  final dynamic _value;
  const Const(this._value);
  @override
  dynamic get rawContent => _value;
}

/// Literal expression
///
/// Literals can be of any type. However, MongoDB parses string literals that
/// start with a dollar sign $ as a path to a field and numeric/boolean literals
/// in expression objects as projection flags. To avoid parsing literals, use
/// the [Literal] expression
class Literal extends ExpressionContent {
  final dynamic _expr;

  /// Creates a literal expression
  const Literal(this._expr);
  @override
  Map<String, dynamic> get rawContent => {r'$literal': _expr};
}

/// Aggregation expression's variable
///
/// [Var] can be used to insert user defined an system variables in aggregation
/// expressions
class Var extends ExpressionContent {
  /// Current datetime value.
  ///
  /// [now] has the same value for all members of the deployment and remains the
  /// same throughout all stages of the aggregation pipeline.
  static const now = Var('NOW');

  /// Current timestamp value.
  ///
  /// [clusterTime] is only available on replica sets and sharded clusters.
  /// [clusterTime] has the same value for all members of the deployment and
  /// remains the same throughout all stages of the pipeline.
  static const clusterTime = Var('CLUSTER_TIME');

  /// The root document.
  ///
  /// The top-level document, currently being processed in the aggregation
  /// pipeline stage.
  static const root = Var('ROOT');

  /// The start of the field path being processed in the aggregation pipeline stage.
  ///
  /// Unless documented otherwise, all stages start with curren the same as root.
  /// Current is modifiable. However, since $<field> is equivalent to $$CURRENT.<field>,
  /// rebinding CURRENT changes the meaning of $ accesses.
  static const current = Var('CURRENT');

  /// A variable which evaluates to the missing value.
  ///
  /// Allows for the conditional exclusion of fields. In a $projection, a field
  /// set to the variable REMOVE is excluded from the output.
  /// For an example of its usage, see
  /// [Conditionally Exclude Fields](https://docs.mongodb.com/manual/reference/operator/aggregation/project/#remove-example).
  static const remove = Var('REMOVE');

  /// One of the allowed results of a
  /// [$redact](https://docs.mongodb.com/manual/reference/operator/aggregation/redact/#pipe._S_redact) expression.
  static const discend = Var('DISCEND');

  /// One of the allowed results of a
  /// [$redact](https://docs.mongodb.com/manual/reference/operator/aggregation/redact/#pipe._S_redact) expression.
  static const prune = Var('PRUNE');

  /// One of the allowed results of a
  /// [$redact](https://docs.mongodb.com/manual/reference/operator/aggregation/redact/#pipe._S_redact) expression.
  static const keep = Var('KEEP');

  final String _name;

  /// Creates a variable expression
  ///
  /// After build variable will look like `$$name`
  const Var(String name) : _name = name;

  @override
  String get rawContent => '\$\$$_name';
}

/// Aggregation stage base
abstract class AggregationStage extends FieldExpression {
  AggregationStage(super.fieldName, super.value);
  String get stageName => entry.key;
}
