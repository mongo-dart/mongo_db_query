import '../../query_expression/query_expression.dart';
import 'atlas_option.dart';

/// Option for Atlas Score Dcoument
abstract class AtlasExpression extends AtlasOption {
  AtlasExpression(String name, expr) : super(name, valueToContent(expr));
}
