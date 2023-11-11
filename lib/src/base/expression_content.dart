abstract class ExpressionContent {
  const ExpressionContent();
  dynamic get rawContent;

  @Deprecated('Use rawContent')
  dynamic build() => rawContent;
}
