import 'package:ehentter/core/exceptions/eh_exceptions.dart';
import 'package:ehentter/data/parsers/eh_base_parser.dart';
import 'package:html/dom.dart';
import 'package:meta/meta.dart';

abstract class EhDomParser<I extends Node, T> extends EhBaseParser<I, T> {
  /// [parent] 父元素
  /// [selector] CSS 选择器
  /// [transform] 转换函数，将找到的 [Element] 转换为目标类型 [T]
  @protected
  R guardElement<R>(
    Element parent,
    String selector,
    R Function(Element el) transform,
  ) {
    final element = parent.querySelector(selector);
    if (element == null) {
      throw FormatException('Element not found. Selector: "$selector"');
    }
    try {
      return transform(element);
    } catch (e, stackTrace) {
      throw EhParseException(
        'Element parsing failed. Selector: "$selector", Error: $e',
        stackTrace: stackTrace,
        parser: runtimeType,
        rawData: parent.outerHtml,
      );
    }
  }

  @protected
  String getAttributes(Element el, String name) {
    final attr = el.attributes[name];
    if (attr == null) {
      throw FormatException(
        'Attribute "$name" not found in element <${el.localName}>',
      );
    }
    return attr;
  }
}
