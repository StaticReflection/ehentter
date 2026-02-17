import 'package:ehentter/core/exceptions/eh_exceptions.dart';
import 'package:html/dom.dart';
import 'package:meta/meta.dart';

mixin EhDomMixin {
  Type get _parserType => runtimeType;

  @protected
  R querySelector<R>(
    Element parent,
    String selector,
    R Function(Element el) transform, {
    bool required = true,
  }) {
    final element = parent.querySelector(selector);

    if (element == null) {
      if (required) {
        throw EhParseException(
          'Element not found. Selector: "$selector"',
          stackTrace: StackTrace.current,
          parser: _parserType,
          rawData: parent.outerHtml,
        );
      }
      return null as R;
    }

    try {
      return transform(element);
    } catch (e, stackTrace) {
      throw EhParseException(
        'Element parsing failed. Selector: "$selector", Error: $e',
        stackTrace: stackTrace,
        parser: _parserType,
        rawData: parent.outerHtml,
      );
    }
  }

  @protected
  List<R> querySelectorAll<R>(
    Element parent,
    String selector,
    R Function(Element el) transform, {
    bool required = true, // 列表不能为空
  }) {
    final elements = parent.querySelectorAll(selector);

    if (elements.isEmpty && required) {
      throw EhParseException(
        'Elements not found. Selector: "$selector"',
        stackTrace: StackTrace.current,
        parser: _parserType,
        rawData: parent.outerHtml,
      );
    }

    return elements.map(transform).toList();
  }

  @protected
  String? getAttribute(Element el, String name, {bool required = true}) {
    final attr = el.attributes[name];
    if (attr == null && required) {
      throw EhParseException(
        'Attribute "$name" not found in element <${el.localName}>',
        stackTrace: StackTrace.current,
        parser: _parserType,
        rawData: el.outerHtml,
      );
    }
    return attr;
  }
}
