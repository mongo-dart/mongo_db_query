import '../../base/common/document_types.dart';
import '../../base/common/operators_def.dart';

enum TimeSeriesGranularity {
  seconds('seconds'),
  minutes('minutes'),
  hours('hours');

  const TimeSeriesGranularity(this.name);
  final String name;
}

class Timeseries {
  Timeseries(this.timefield, {this.metaField, this.granularity});

  final String timefield;
  final String? metaField;
  final TimeSeriesGranularity? granularity;

  MongoDocument toMap() => {
        coTimeSeries: {
          coTimeField: timefield,
          if (metaField != null) coMetaField: metaField,
          if (granularity != null) coGranularity: granularity!.name
        }
      };
}
