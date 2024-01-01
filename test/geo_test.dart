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
      test('.coordinates with altitude', () {
        var point = GeoPoint.coordinates([40.0, 5.0, 150]);
        expect(point.rawContent, {
          'type': 'Point',
          'coordinates': [40, 5, 150]
        });
      });
      test('.coordinates, discards exceeding', () {
        var point = GeoPoint.coordinates([40.0, 5.0, 150, 312, 40]);
        expect(point.rawContent, {
          'type': 'Point',
          'coordinates': [40, 5, 150]
        });
      });
      test('equality', () {
        var point = GeoPoint.coordinates([40.0, 5.0, 0]);
        var point2 = GeoPoint(GeoPosition(40, 5));
        var point3 = GeoPoint.coordinates([40.0, 5.0]);
        var point4 = GeoPoint.coordinates([40.0, 6]);
        var point5 = GeoPoint(GeoPosition(40, 5, altitude: 6));

        expect(point, point2);
        expect(point2, point);
        expect(point3, point2);
        expect(point4 == point2, isFalse);
        expect(point5 == point, isFalse);
      });
      test('.coordinates - error missing longitude', () {
        expect(() => GeoPoint.coordinates([]), throwsArgumentError);
      });
      test('.coordinates - error missing latitude', () {
        expect(() => GeoPoint.coordinates([40]), throwsArgumentError);
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
      test('.coordinates with altitude', () {
        var point = GeoLineString.coordinates([
          [40, 5, 100],
          [41, 6]
        ]);
        expect(point.rawContent, {
          'type': "LineString",
          'coordinates': [
            [40, 5, 100],
            [41, 6]
          ]
        });
      });
      test('.coordinates, discards exceeding', () {
        var point = GeoLineString.coordinates([
          [40, 5, 100, 312, 40],
          [41, 6, 200]
        ]);
        expect(point.rawContent, {
          'type': "LineString",
          'coordinates': [
            [40, 5, 100],
            [41, 6, 200]
          ]
        });
      });
      // TODO Equality test

      test('.coordinates - error missing longitude', () {
        expect(
            () => GeoLineString.coordinates([
                  [],
                  [41, 6, 200]
                ]),
            throwsArgumentError);
      });
      test('.coordinates - error missing latitude', () {
        expect(
            () => GeoLineString.coordinates([
                  [40, 5],
                  [41]
                ]),
            throwsArgumentError);
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
      test('.coordinates with altitude', () {
        var point = GeoMultiPoint.coordinates([
          [-73.9580, 40.8003, 200],
          [-73.9498, 40.7968],
          [-73.9737, 40.7648, 100],
          [-73.9814, 40.7681]
        ]);
        expect(point.rawContent, {
          'type': "MultiPoint",
          'coordinates': [
            [-73.9580, 40.8003, 200],
            [-73.9498, 40.7968],
            [-73.9737, 40.7648, 100],
            [-73.9814, 40.7681]
          ]
        });
      });
      test('.coordinates, discards exceeding', () {
        var point = GeoMultiPoint.coordinates([
          [-73.9580, 40.8003, 200, 50, 29],
          [-73.9498, 40.7968],
          [-73.9737, 40.7648, 100, 40],
          [-73.9814, 40.7681]
        ]);
        expect(point.rawContent, {
          'type': "MultiPoint",
          'coordinates': [
            [-73.9580, 40.8003, 200],
            [-73.9498, 40.7968],
            [-73.9737, 40.7648, 100],
            [-73.9814, 40.7681]
          ]
        });
      });
      // TODO Equality test

      test('.coordinates - error missing longitude', () {
        expect(
            () => GeoMultiPoint.coordinates([
                  [-73.9580, 40.8003, 200],
                  [],
                  [-73.9737, 40.7648, 100],
                  [-73.9814, 40.7681]
                ]),
            throwsArgumentError);
      });
      test('.coordinates - error missing latitude', () {
        expect(
            () => GeoMultiPoint.coordinates([
                  [-73.9580],
                  [-73.9498, 40.7968],
                  [-73.9737, 40.7648, 100],
                  [-73.9814, 40.7681]
                ]),
            throwsArgumentError);
      });
    });
    group('GeoLinearRing', () {
      test('.', () {
        var ring = GeoLinearRing([
          GeoPoint(GeoPosition(0, 0)),
          GeoPoint(GeoPosition(3, 6)),
          GeoPoint(GeoPosition(6, 1)),
          GeoPoint(GeoPosition(0, 0)),
        ]);
        expect(ring.rawContent, {
          'type': "LineString",
          'coordinates': [
            [0, 0],
            [3, 6],
            [6, 1],
            [0, 0]
          ]
        });
      });
      test('.positions', () {
        var ring = GeoLinearRing.positions([
          GeoPosition(0, 0),
          GeoPosition(3, 6),
          GeoPosition(6, 1),
          GeoPosition(0, 0),
        ]);
        expect(ring.rawContent, {
          'type': "LineString",
          'coordinates': [
            [0, 0],
            [3, 6],
            [6, 1],
            [0, 0]
          ]
        });
      });
      test('.coordinates', () {
        var ring = GeoLinearRing.coordinates([
          [0, 0],
          [3, 6],
          [6, 1],
          [0, 0]
        ]);
        expect(ring.rawContent, {
          'type': "LineString",
          'coordinates': [
            [0, 0],
            [3, 6],
            [6, 1],
            [0, 0]
          ]
        });
      });
      test('. - closed ring', () {
        var ring = GeoLinearRing([
          GeoPoint(GeoPosition(0, 0, altitude: 5)),
          GeoPoint(GeoPosition(3, 6)),
          GeoPoint(GeoPosition(6, 1)),
          GeoPoint(GeoPosition(0, 0, altitude: 5)),
        ]);
        expect(ring.rawContent, {
          'type': "LineString",
          'coordinates': [
            [0, 0, 5],
            [3, 6],
            [6, 1],
            [0, 0, 5]
          ]
        });
      });
      test('. - open ring', () {
        expect(
            () => GeoLinearRing([
                  GeoPoint(GeoPosition(0, 0)),
                  GeoPoint(GeoPosition(3, 6)),
                  GeoPoint(GeoPosition(6, 1)),
                  GeoPoint(GeoPosition(0, 0, altitude: 5)),
                ]),
            throwsArgumentError);
      });
      test('. - less then four points', () {
        expect(
            () => GeoLinearRing([
                  GeoPoint(GeoPosition(0, 0)),
                  GeoPoint(GeoPosition(3, 6)),
                  GeoPoint(GeoPosition(0, 0)),
                ]),
            throwsArgumentError);
      });
      test('.positions - closed ring', () {
        var ring = GeoLinearRing.positions([
          GeoPosition(0, 0, altitude: 5),
          GeoPosition(3, 6),
          GeoPosition(6, 1),
          GeoPosition(0, 0, altitude: 5),
        ]);
        expect(ring.rawContent, {
          'type': "LineString",
          'coordinates': [
            [0, 0, 5],
            [3, 6],
            [6, 1],
            [0, 0, 5]
          ]
        });
      });
      test('.positions - open ring', () {
        expect(
            () => GeoLinearRing.positions([
                  GeoPosition(0, 0),
                  GeoPosition(3, 6),
                  GeoPosition(6, 1),
                  GeoPosition(0, 0, altitude: 5),
                ]),
            throwsArgumentError);
      });
      test('.positions - less then four points', () {
        expect(
            () => GeoLinearRing.positions([
                  GeoPosition(0, 0),
                  GeoPosition(3, 6),
                  GeoPosition(0, 0),
                ]),
            throwsArgumentError);
      });
      test('.coordinates closed ring', () {
        var ring = GeoLinearRing.coordinates([
          [0, 0, 5],
          [3, 6],
          [6, 1],
          [0, 0, 5]
        ]);
        expect(ring.rawContent, {
          'type': "LineString",
          'coordinates': [
            [0, 0, 5],
            [3, 6],
            [6, 1],
            [0, 0, 5]
          ]
        });
      });
      test('.coordinates open ring', () {
        expect(
            () => GeoLinearRing.coordinates([
                  [0, 0, 5],
                  [3, 6],
                  [6, 1],
                  [0, 0]
                ]),
            throwsArgumentError);
      });
      test('.coordinates less then four points', () {
        expect(
            () => GeoLinearRing.coordinates([
                  [0, 0],
                  [3, 6],
                  [0, 0]
                ]),
            throwsArgumentError);
      });
    });
    group('GeoPolygon', () {
      test('.', () {
        var polygon = GeoPolygon([
          GeoLinearRing([
            GeoPoint(GeoPosition(0, 0)),
            GeoPoint(GeoPosition(3, 6)),
            GeoPoint(GeoPosition(6, 1)),
            GeoPoint(GeoPosition(0, 0)),
          ])
        ]);
        expect(polygon.rawContent, {
          'type': "Polygon",
          'coordinates': [
            [
              [0, 0],
              [3, 6],
              [6, 1],
              [0, 0]
            ]
          ]
        });
      });

      test('.coordinates', () {
        var polygon = GeoPolygon.coordinates([
          [
            [0, 0],
            [3, 6],
            [6, 1],
            [0, 0]
          ]
        ]);
        expect(polygon.rawContent, {
          'type': "Polygon",
          'coordinates': [
            [
              [0, 0],
              [3, 6],
              [6, 1],
              [0, 0]
            ]
          ]
        });
      });
      test('.coordinates with altitude', () {
        var polygon = GeoPolygon.coordinates([
          [
            [0, 0],
            [3, 6, 100],
            [6, 1],
            [0, 0]
          ]
        ]);
        expect(polygon.rawContent, {
          'type': "Polygon",
          'coordinates': [
            [
              [0, 0],
              [3, 6, 100],
              [6, 1],
              [0, 0]
            ]
          ]
        });
      });
      test('.coordinates with altitude on beginning/last', () {
        var polygon = GeoPolygon.coordinates([
          [
            [0, 0, 200],
            [3, 6, 100],
            [6, 1],
            [0, 0, 200]
          ]
        ]);
        expect(polygon.rawContent, {
          'type': "Polygon",
          'coordinates': [
            [
              [0, 0, 200],
              [3, 6, 100],
              [6, 1],
              [0, 0, 200]
            ]
          ]
        });
      });
      test('.coordinates, discards exceeding', () {
        var polygon = GeoPolygon.coordinates([
          [
            [0, 0, 200, 32],
            [3, 6, 100, 500, 20],
            [6, 1],
            [0, 0, 200]
          ]
        ]);
        expect(polygon.rawContent, {
          'type': "Polygon",
          'coordinates': [
            [
              [0, 0, 200],
              [3, 6, 100],
              [6, 1],
              [0, 0, 200]
            ]
          ]
        });
      });
      // TODO Equality test

      test('.coordinates - error missing longitude', () {
        expect(
            () => GeoPolygon.coordinates([
                  [
                    [0, 0],
                    [3, 6],
                    [],
                    [0, 0]
                  ]
                ]),
            throwsArgumentError);
      });
      test('.coordinates - error missing latitude', () {
        expect(
            () => GeoPolygon.coordinates([
                  [
                    [0, 0],
                    [3],
                    [6, 1],
                    [0, 0]
                  ]
                ]),
            throwsArgumentError);
      });
    });
    group('GeoPolygon with hole', () {
      test('.', () {
        var polygon = GeoPolygon([
          GeoLinearRing([
            GeoPoint(GeoPosition(0, 0)),
            GeoPoint(GeoPosition(3, 6)),
            GeoPoint(GeoPosition(6, 1)),
            GeoPoint(GeoPosition(0, 0)),
          ]),
          GeoLinearRing([
            GeoPoint(GeoPosition(2, 2)),
            GeoPoint(GeoPosition(3, 3)),
            GeoPoint(GeoPosition(4, 2)),
            GeoPoint(GeoPosition(2, 2)),
          ]),
        ]);
        expect(polygon.rawContent, {
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
      });

      test('.coordinates', () {
        var polygon = GeoPolygon.coordinates([
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
        ]);
        expect(polygon.rawContent, {
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
      });
      test('.coordinates with altitude', () {
        var polygon = GeoPolygon.coordinates([
          [
            [0, 0],
            [3, 6],
            [6, 1],
            [0, 0]
          ],
          [
            [2, 2],
            [3, 3],
            [4, 2, 100],
            [2, 2]
          ]
        ]);
        expect(polygon.rawContent, {
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
              [4, 2, 100],
              [2, 2]
            ]
          ]
        });
      });
      test('.coordinates with altitude on beginning/last', () {
        var polygon = GeoPolygon.coordinates([
          [
            [0, 0],
            [3, 6],
            [6, 1],
            [0, 0]
          ],
          [
            [2, 2, 100],
            [3, 3],
            [4, 2],
            [2, 2, 100]
          ]
        ]);
        expect(polygon.rawContent, {
          'type': "Polygon",
          'coordinates': [
            [
              [0, 0],
              [3, 6],
              [6, 1],
              [0, 0]
            ],
            [
              [2, 2, 100],
              [3, 3],
              [4, 2],
              [2, 2, 100]
            ]
          ]
        });
      });
      test('.coordinates, discards exceeding', () {
        var polygon = GeoPolygon.coordinates([
          [
            [0, 0],
            [3, 6, 100, 95, 12],
            [6, 1],
            [0, 0]
          ],
          [
            [2, 2],
            [3, 3],
            [4, 2],
            [2, 2]
          ]
        ]);
        expect(polygon.rawContent, {
          'type': "Polygon",
          'coordinates': [
            [
              [0, 0],
              [3, 6, 100],
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
      });
      // TODO Equality test

      test('.coordinates - error missing longitude', () {
        expect(
            () => GeoPolygon.coordinates([
                  [
                    [0, 0],
                    [3, 6],
                    [6, 1],
                    [0, 0]
                  ],
                  [
                    [2, 2],
                    [],
                    [4, 2],
                    [2, 2]
                  ]
                ]),
            throwsArgumentError);
      });
      test('.coordinates - error missing latitude', () {
        expect(
            () => GeoPolygon.coordinates([
                  [
                    [0, 0],
                    [3, 6],
                    [6, 1],
                    [0, 0]
                  ],
                  [
                    [2, 2],
                    [3],
                    [4, 2],
                    [2, 2]
                  ]
                ]),
            throwsArgumentError);
      });
    });
  });
}
