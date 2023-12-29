import 'package:mongo_db_query/src/base/operator_expression.dart';

import '../../base/expression_content.dart';

/// Basic accumulation operator
abstract class Accumulator extends OperatorExpression {
  Accumulator(super.name, super.expr);
}

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
  static const descend = Var('DESCEND');

  /// One of the allowed results of a
  /// [$redact](https://docs.mongodb.com/manual/reference/operator/aggregation/redact/#pipe._S_redact) expression.
  static const prune = Var('PRUNE');

  /// One of the allowed results of a
  /// [$redact](https://docs.mongodb.com/manual/reference/operator/aggregation/redact/#pipe._S_redact) expression.
  static const keep = Var('KEEP');

  /// A variable that stores the metadata results of an
  /// [Atlas Search](https://www.mongodb.com/docs/atlas/atlas-search/)
  /// query. In all supported aggregation pipeline stages, a field set to the
  /// variable $$SEARCH_META returns the metadata results for the query.
  static const searchMeta = Var('SEARC_META');

  ///Returns the roles assigned to the current user.
  static const userRoles = Var('USER_ROLES');

  final String _name;

  /// Creates a variable expression
  ///
  /// After build variable will look like `$$name`
  const Var(String name) : _name = name;

  @override
  String get rawContent => '\$\$$_name';
}
