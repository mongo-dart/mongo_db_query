library test_lib;

import 'package:mongo_db_query/src/aggregation/support_classes/geo/geo_json_type.dart';
import 'package:mongo_db_query/src/aggregation/support_classes/geo/geo_position.dart';
import 'package:test/test.dart';
import 'package:mongo_db_query/mongo_db_query.dart';

void main() {
  group('Geo Test', () {
    group('Geometry', () {
      test('.', () {
        var geometry =
            Geometry(type: GeoJsonType.point, coordinates: [40.0, 5.0]);
        expect(geometry.rawContent, {
          'type': "Point",
          'coordinates': [40, 5]
        });
      });
      test('point', () {
        var geometry = Geometry.point([40.0, 5.0]);
        expect(geometry.rawContent, {
          'type': "Point",
          'coordinates': [40, 5]
        });
        expect(geometry.runtimeType, GeoPoint);
      });
      test('.lineString', () {
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
      test('.multiPoint', () {
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
      test('.polygon', () {
        var geometry = Geometry.polygon([
          [
            [0.0, 0.0],
            [3.0, 6.0],
            [6.0, 1.0],
            [0.0, 0.0]
          ],
          [
            [2, 2],
            [3, 3],
            [4, 2],
            [2, 2]
          ]
        ]);
        expect(geometry.rawContent, {
          'type': "Polygon",
          'coordinates': [
            [
              [0, 0],
              [3, 6],
              [6, 1],
              [0, 0]
            ],
            [
              [2, 2],
              [3, 3],
              [4, 2],
              [2, 2]
            ]
          ]
        });
        expect(geometry.runtimeType, GeoPolygon);
      });
    });
    group('GeoPosition', () {
      test('.', () {
        var position = GeoPosition(40, 5);
        expect(position.rawContent, [40, 5]);
      });
      test('. with altitude', () {
        var position = GeoPosition(40, 5, altitude: 150);
        expect(position.rawContent, [40, 5, 150]);
      });
      test('.coordinates', () {
        var position = GeoPosition.coordinates([40.0, 5.0]);
        expect(position.rawContent, [40, 5]);
      });
      test('.coordinates with altitude', () {
        var position = GeoPosition.coordinates([40.0, 5.0, 150]);
        expect(position.rawContent, [40, 5, 150]);
      });
      test('.coordinates, discards exceeding', () {
        var position = GeoPosition.coordinates([40.0, 5.0, 150, 312, 40]);
        expect(position.rawContent, [40, 5, 150]);
      });
      test('equality', () {
        var position = GeoPosition.coordinates([40.0, 5.0, 0]);
        var position2 = GeoPosition(40, 5);
        var position3 = GeoPosition.coordinates([40.0, 5.0]);
        var position4 = GeoPosition.coordinates([40.0, 6]);
        var position5 = GeoPosition(40, 5, altitude: 6);

        expect(position, position2);
        expect(position2, position);
        expect(position3, position2);
        expect(position4 == position2, isFalse);
        expect(position5 == position, isFalse);
      });
      test('.coordinates - error missing longitude', () {
        expect(() => GeoPosition.coordinates([]), throwsArgumentError);
      });
      test('.coordinates - error missing latitude', () {
        expect(() => GeoPosition.coordinates([40]), throwsArgumentError);
      });
    });
    group('GeoPoint', () {
      test('.', () {
        var point = GeoPoint(GeoPosition(40, 5));
        expect(point.rawContent, {
          'type': "Point",
          'coordinates': [40, 5]
        });
      });
      test('.coordinates', () {
        var point = GeoPoint.coordinates([40.0, 5.0]);
        expect(point.rawContent, {
          'type': "Point",
          'coordinates': [40, 5]
        });
      });
    });
    group('GeoLineString', () {
      test('.', () {
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
      test('.positions', () {
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
      test('.coordinates', () {
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
    });
    group('GeoMultiPoint', () {
      test('.', () {
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
      test('.positions', () {
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
      test('.coordinates', () {
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
  });
}
