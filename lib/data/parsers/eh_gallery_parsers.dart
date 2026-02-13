import 'package:ehentter/data/models/eh_gallery_id_model.dart';
import 'package:ehentter/data/models/eh_gallery_summary_model.dart';
import 'package:ehentter/data/models/eh_gallery_tag_model.dart';
import 'package:ehentter/data/parsers/eh_base_parser.dart';
import 'package:ehentter/data/parsers/eh_dom_parser.dart';
import 'package:ehentter/domain/entities/eh_gallery_category.dart';
import 'package:ehentter/domain/entities/eh_gallery_page_info.dart';
import 'package:ehentter/domain/entities/eh_gallery_tag_namespace.dart';
import 'package:html/dom.dart';

/// 画廊 URL 转 [EhGalleryIdModel]
class EhGalleryUrlParser extends EhBaseParser<String, EhGalleryIdModel> {
  @override
  EhGalleryIdModel parser(String input) {
    final m = RegExp(r'/g/(\d+)/([a-z0-9]+)').firstMatch(input);
    return EhGalleryIdModel(gid: int.parse(m!.group(1)!), token: m.group(2)!);
  }
}

/// 评分星星样式转具体数值
class EhRatingStyleParser extends EhBaseParser<String, double> {
  @override
  double parser(String input) {
    final m = RegExp(r':(-?\d+)px\s+(-?\d+)px').firstMatch(input);

    return 5.0 +
        (int.parse(m!.group(1)!) / 16.0) -
        (m.group(2) == '-21' ? 0.5 : 0);
  }
}

/// 下一页按钮的地址转 [int] gid
class EhNextUrlParser extends EhBaseParser<String, int?> {
  @override
  int? parser(String input) {
    if (input.isEmpty) return null;

    final m = RegExp(r'[?&]next=(\d+)').firstMatch(input);

    final nextGid = m?.group(1);
    if (nextGid == null) return null;

    return int.tryParse(nextGid);
  }
}

/// 下一页按钮的地址转 [int] gid
class EhPrevUrlParser extends EhBaseParser<String, int?> {
  @override
  int? parser(String input) {
    if (input.isEmpty) return null;

    final m = RegExp(r'[?&]prev=(\d+)').firstMatch(input);

    final prevGid = m?.group(1);
    if (prevGid == null) return null;

    return int.tryParse(prevGid);
  }
}

/// 画廊列表页转 [EhGalleryPageInfo]
class EhGalleryPageParser extends EhDomParser<Document, EhGalleryPageInfo> {
  final EhGalleryUrlParser _ehGalleryUrlParser;
  final EhRatingStyleParser _ehRatingStyleParser;
  final EhNextUrlParser _ehNextUrlParser;
  final EhPrevUrlParser _ehPrevUrlParser;

  EhGalleryPageParser(
    this._ehGalleryUrlParser,
    this._ehRatingStyleParser,
    this._ehNextUrlParser,
    this._ehPrevUrlParser,
  );

  @override
  EhGalleryPageInfo parser(Document input) {
    final rows = input
        .querySelectorAll('.itg tr')
        .where((tr) => tr.querySelector('.glink') != null);

    final galleries = rows.map((tr) {
      return EhGallerySummaryModel(
        id: guardElement(
          tr,
          '.glname > a',
          (el) => _ehGalleryUrlParser(getAttributes(el, 'href')),
        ),

        title: guardElement(tr, '.glink', (el) => el.text),

        category: guardElement(
          tr,
          '.gl1c.glcat div',
          (el) => EhGalleryCategory.fromString(el.text),
        ),

        thumb: guardElement(
          tr,
          'img',
          (el) => el.attributes['data-src'] ?? getAttributes(el, 'src'),
        ),

        uploader: guardElement(tr, '.gl4c a', (el) => el.text),

        posted: guardElement(
          tr,
          '[id^=posted_]',
          (el) => DateTime.parse(el.text),
        ),

        rating: guardElement(
          tr,
          '.ir',
          (el) => _ehRatingStyleParser(getAttributes(el, 'style')),
        ),

        filecount: guardElement(tr, '.gl4c > div', (el) {
          final divs = tr.querySelectorAll('.gl4c > div');
          return divs.last.text.split(' ').first;
        }),

        tags: guardElement(tr, '.glname', (el) {
          return tr.querySelectorAll('.gt').map((tagEl) {
            final titleAttr = getAttributes(tagEl, 'title');
            final parts = titleAttr.split(':');
            return EhGalleryTagGroupModel(
              namespace: EhGalleryTagNamespaces.fromString(parts[0]),
              name: {parts[1]},
            );
          }).toList();
        }),
      );
    }).toList();

    int? nextGid;
    if (input.querySelector('#dnext')?.localName == 'a') {
      nextGid = guardElement(
        input.body!,
        '#dnext',
        (el) => _ehNextUrlParser(getAttributes(el, 'href')),
      );
    }
    int? prevGid;
    if (input.querySelector('#dprev')?.localName == 'a') {
      prevGid = guardElement(
        input.body!,
        '#dprev',
        (el) => _ehPrevUrlParser(getAttributes(el, 'href')),
      );
    }

    return EhGalleryPageInfo(
      galleries: galleries,
      resultCount: galleries.length,
      nextGid: nextGid,
      prevGid: prevGid,
    );
  }
}
