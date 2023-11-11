import 'package:meta/meta.dart';

import '../base/expression_content.dart';
import 'aggregation_base.dart';

/// Returns `true` if value is not null
///
/// The function is used  to filter not null elements in [AEObject] and [AEList]
/// constuctors
bool _valueIsNotNull(value) =>
    value is MapEntry ? value.value != null : value != null;

/// Aggregation expression's list
///
/// The list is used in aggregation expressions and is aggregation expression as well
class AEList extends Iterable implements ExpressionContent {
  final Iterable _iterable;
  factory AEList(Iterable iterable) {
    //if (iterable == null) return null;
    return AEList.internal(iterable.where(_valueIsNotNull).map((value) {
      if (value is List) return AEList(value);
      if (value is Map<String, dynamic>) return AEObject(value);
      return value;
    }));
  }

  @protected
  AEList.internal(this._iterable);

  @override
  AEIterator get iterator => AEIterator(_iterable);
  @override
  List get rawContent => _iterable
      .map((expr) => expr is ExpressionContent ? expr.build() : expr)
      .toList();

  @override
  dynamic build() => rawContent;
}

/// Iterator for [AEList]
class AEIterator<T> implements Iterator<T> {
  final Iterable<T> _iterable;
  int _currentIndex = -1;
  T? _current;

  AEIterator(this._iterable);

  @override
  bool moveNext() {
    if (_currentIndex + 1 == _iterable.length) {
      _current = null;
      return false;
    }
    _current = _iterable.elementAt(++_currentIndex);
    return true;
  }

  @override
  T get current {
    if (_current == null) {
      throw StateError('The current object is unspecified. '
          'Check NoveNext() return value before calling the "current" getter.');
    }
    return _current!;
  }
}
