import '../../../base/list_expression.dart';

class GeoPosition extends ListExpression {
  GeoPosition(double longitude, double latitude, {double? altitude})
      : super([longitude, latitude, if (altitude != null) altitude]);
}
