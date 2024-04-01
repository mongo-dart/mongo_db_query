import 'abstract/expression_container.dart';
import 'abstract/expression_content.dart';

class SetExpression extends ExpressionContainer {
  SetExpression(this.values);

  Set values;

  void add(value) => values.add(value);

  @override
  Set get rawContent => {
        for (var element in values)
          element is ExpressionContent ? element.rawContent : element
      };

  @override
  bool get isEmpty => values.isEmpty;

  @override
  bool get isNotEmpty => values.isNotEmpty;
}
