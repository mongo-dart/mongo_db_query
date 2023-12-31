library test_lib;

import 'package:mongo_db_query/src/aggregation/support_classes/geo/geo_json_type.dart';
import 'package:mongo_db_query/src/aggregation/support_classes/geo/geo_position.dart';
import 'package:test/test.dart';
import 'package:mongo_db_query/mongo_db_query.dart';

void main() {
  group('Geo Test', () {
    test('Geometry', () {
      var geometry =
          Geometry(type: GeoJsonType.point, coordinates: [40.0, 5.0]);
      expect(geometry.rawContent, {
        'type': "Point",
        'coordinates': [40, 5]
      });
    });
    test('Geometry.point', () {
      var geometry = Geometry.point([40.0, 5.0]);
      expect(geometry.rawContent, {
        'type': "Point",
        'coordinates': [40, 5]
      });
      expect(geometry.runtimeType, GeoPoint);
    });
    test('Geometry.lineString', () {
      var geometry = Geometry.lineString([
        [40, 5],
        [41, 6]
      ]);
      expect(geometry.rawContent, {
        'type': "LineString",
        'coordinates': [
          [40, 5],
          [41, 6]
        ]
      });
      expect(geometry.runtimeType, GeoLineString);
    });
    test('Geometry.multiPoint', () {
      var geometry = Geometry.multiPoint([
        [-73.9580, 40.8003],
        [-73.9498, 40.7968],
        [-73.9737, 40.7648],
        [-73.9814, 40.7681]
      ]);
      expect(geometry.rawContent, {
        'type': "MultiPoint",
        'coordinates': [
          [-73.9580, 40.8003],
          [-73.9498, 40.7968],
          [-73.9737, 40.7648],
          [-73.9814, 40.7681]
        ]
      });
      expect(geometry.runtimeType, GeoMultiPoint);
    });
    test('GeoPoint', () {
      var point = GeoPoint(GeoPosition(40, 5));
      expect(point.rawContent, {
        'type': "Point",
        'coordinates': [40, 5]
      });
    });
    test('GeoPoint.coordinates', () {
      var point = GeoPoint.coordinates([40.0, 5.0]);
      expect(point.rawContent, {
        'type': "Point",
        'coordinates': [40, 5]
      });
    });
    test('GeoLineString', () {
      var point = GeoLineString([
        GeoPoint(GeoPosition(40, 5)),
        GeoPoint(GeoPosition(41, 6)),
      ]);
      expect(point.rawContent, {
        'type': "LineString",
        'coordinates': [
          [40, 5],
          [41, 6]
        ]
      });
    });
    test('GeoLineString.positions', () {
      var point = GeoLineString.positions([
        GeoPosition(40, 5),
        GeoPosition(41, 6),
      ]);
      expect(point.rawContent, {
        'type': "LineString",
        'coordinates': [
          [40, 5],
          [41, 6]
        ]
      });
    });
    test('GeoLineString.coordinates', () {
      var point = GeoLineString.coordinates([
        [40, 5],
        [41, 6]
      ]);
      expect(point.rawContent, {
        'type': "LineString",
        'coordinates': [
          [40, 5],
          [41, 6]
        ]
      });
    });
    test('GeoMultiPoint', () {
      var point = GeoMultiPoint([
        GeoPoint(GeoPosition(-73.9580, 40.8003)),
        GeoPoint(GeoPosition(-73.9498, 40.7968)),
        GeoPoint(GeoPosition(-73.9737, 40.7648)),
        GeoPoint(GeoPosition(-73.9814, 40.7681))
      ]);
      expect(point.rawContent, {
        'type': "MultiPoint",
        'coordinates': [
          [-73.9580, 40.8003],
          [-73.9498, 40.7968],
          [-73.9737, 40.7648],
          [-73.9814, 40.7681]
        ]
      });
    });
    test('GeoMultiPoint.positions', () {
      var point = GeoMultiPoint.positions([
        GeoPosition(-73.9580, 40.8003),
        GeoPosition(-73.9498, 40.7968),
        GeoPosition(-73.9737, 40.7648),
        GeoPosition(-73.9814, 40.7681)
      ]);
      expect(point.rawContent, {
        'type': "MultiPoint",
        'coordinates': [
          [-73.9580, 40.8003],
          [-73.9498, 40.7968],
          [-73.9737, 40.7648],
          [-73.9814, 40.7681]
        ]
      });
    });
    test('GeoMultiPoint.coordinates', () {
      var point = GeoMultiPoint.coordinates([
        [-73.9580, 40.8003],
        [-73.9498, 40.7968],
        [-73.9737, 40.7648],
        [-73.9814, 40.7681]
      ]);
      expect(point.rawContent, {
        'type': "MultiPoint",
        'coordinates': [
          [-73.9580, 40.8003],
          [-73.9498, 40.7968],
          [-73.9737, 40.7648],
          [-73.9814, 40.7681]
        ]
      });
    });
  });
}
