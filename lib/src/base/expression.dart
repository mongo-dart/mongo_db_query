import 'common/document_types.dart';
import 'expression_content.dart';

class Expression<T extends ExpressionContent> extends ExpressionContent {
  Expression(String key, T value) : entry = MapEntry<String, T>(key, value);
  Expression.fromMapEntry(this.entry);
  MapEntry<String, T> entry;

  String get key => entry.key;
  T get content => entry.value;

  MongoDocument get raw => {
        entry.key: content is Expression
            ? (content as Expression).raw
            : content.rawContent
      };
  @override
  dynamic get rawContent =>
      content is Expression ? (content as Expression).raw : content.rawContent;
}
