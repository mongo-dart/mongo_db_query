import 'expression_content.dart';

abstract class ExpressionContainer extends ExpressionContent {
  const ExpressionContainer();
  bool get isEmpty;
  bool get isNotEmpty;
}
