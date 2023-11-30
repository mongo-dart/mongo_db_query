import 'builder.dart';
import 'common/document_types.dart';
import 'expression_content.dart';

class Expression<T extends ExpressionContent> extends ExpressionContent
    implements Builder {
  Expression(String key, T value) : entry = MapEntry<String, T>(key, value);
  Expression.fromMapEntry(this.entry);
  MapEntry<String, T> entry;

  String get key => entry.key;
  // TODO check if the name is appropriate
  T get content => entry.value;

  @override
  MongoDocument build() => {key: _rawContent};

  dynamic get _rawContent => content is Expression
      ? (content as Expression).build()
      : content.rawContent;

  @override
  @Deprecated('Do not call rawContent for an expression, call build()')
  dynamic get rawContent => _rawContent;
}
