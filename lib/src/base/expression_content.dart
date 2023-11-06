import 'builder.dart';

abstract class ExpressionContent implements Builder {
  const ExpressionContent();
  dynamic get rawContent;
  @override
  dynamic build() => rawContent;
}
