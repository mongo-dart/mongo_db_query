import '../query_expression/filter_expression.dart';
import 'abstract/expression_content.dart';
import 'common/document_types.dart';
import 'common/operators_def.dart';
import 'expression.dart';
import 'list_expression.dart';
import 'logical_expression.dart';
import 'map_expression.dart';

class AndExpression extends LogicalExpression {
  AndExpression([List<ExpressionContent>? values])
      : super(op$and, ListExpression(values ?? <ExpressionContent>[]));

  void add(ExpressionContent operatorExp) {
    var keyList = content.keysList;
    if (keyList == null) {
      content.add(operatorExp);
      return;
    }
    if (operatorExp is Expression) {
      if (keyList.contains(operatorExp.key)) {
        var index = keyList.indexOf(operatorExp.key);
        content.mergeAtElement(operatorExp, index);
      } else {
        content.add(operatorExp);
      }
      return;
    } else if (operatorExp is FilterExpression) {
      content.add(operatorExp);
      return;
    } else if (operatorExp is MapExpression) {
      content.add(operatorExp);
      return;
    } else if (operatorExp is ListExpression) {
      for (var entry in operatorExp.content2map.entries) {
        if (keyList.contains(entry.key)) {
          var index = keyList.indexOf(entry.key);
          content.mergeAtElement(MapExpression(entry.value), index);
        } else {
          content.add(MapExpression({entry.key: entry.value}));
        }
      }
      return;
    }
    content.add(operatorExp);
  }

  @override
  MongoDocument build() => {
        if (content.canBeSimplified)
          ...content.content2map
        else
          ...super.build()
      };
}
