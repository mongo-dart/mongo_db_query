part of 'geometry.dart';

/// Polygons consist of an array of GeoJSON LinearRing coordinate arrays.
/// These LinearRings are closed LineStrings. Closed LineStrings have at least
/// four coordinate pairs and specify the same position as the first and last
/// coordinates.
///
/// The line that joins two points on a curved surface may or may not contain
/// the same set of co-ordinates that joins those two points on a flat surface.
/// The line that joins two points on a curved surface will be a geodesic.
/// Carefully check points to avoid errors with shared edges, as well as
/// overlaps and other types of intersections.
///
/// *Polygons with a Single Ring*
///
/// The following example specifies a GeoJSON Polygon with an exterior ring
/// and no interior rings (or holes). The first and last coordinates must
/// match in order to close the polygon:
/// ```
/// {
///  type: "Polygon",
///  coordinates: [ [ [ 0 , 0 ] , [ 3 , 6 ] , [ 6 , 1 ] , [ 0 , 0  ] ] ]
/// }
/// ```
/// For Polygons with a single ring, the ring cannot self-intersect.
///
/// *Polygons with Multiple Rings*
///
/// For Polygons with multiple rings:
/// The first described ring must be the exterior ring.
/// The exterior ring cannot self-intersect.
/// Any interior ring must be entirely contained by the outer ring.
/// Interior rings cannot intersect or overlap each other. Interior rings
/// cannot share an edge.
/// The following example represents a GeoJSON polygon with an interior ring:
/// ```
/// {
///  type : "Polygon",
///  coordinates : [
///     [ [ 0 , 0 ] , [ 3 , 6 ] , [ 6 , 1 ] , [ 0 , 0 ] ],
///     [ [ 2 , 2 ] , [ 3 , 3 ] , [ 4 , 2 ] , [ 2 , 2 ] ]
///  ]
/// }
/// ```
final class GeoPolygon extends Geometry {
  GeoPolygon(List<GeoLinearRing> rings)
      : super(type: GeoJsonType.polygon, coordinates: [
          for (var ring in rings) ring.rawContent['coordinates']
        ]);

  factory GeoPolygon.coordinates(List<List<List<double>>> coordinates) =>
      GeoPolygon([
        for (var element in coordinates) GeoLinearRing.coordinates(element)
      ]);
}
