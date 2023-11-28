import 'package:mongo_db_query/src/base/expression_content.dart';

class TestExpr implements ExpressionContent {
  @override
  get rawContent => '\$field';
}
