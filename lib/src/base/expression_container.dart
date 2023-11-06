import 'expression_content.dart';

abstract class ExpressionContainer extends ExpressionContent {
  bool get isEmpty;
  bool get isNotEmpty;
}
