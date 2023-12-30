enum GeoJsonType {
  point('Point'),
  lineString('LineString'),
  polygon('Polygon'),
  multiPoint('MultiPoint'),
  multiLineString('MultiLineString'),
  multiPolygon('MultiPolygon');

  const GeoJsonType(this.name);
  final String name;
}
