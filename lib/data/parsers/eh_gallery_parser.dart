import 'package:ehentter/core/exceptions/eh_exceptions.dart';
import 'package:ehentter/data/models/eh_gallery_id_model.dart';
import 'package:ehentter/data/models/eh_gallery_summary_model.dart';
import 'package:ehentter/data/models/eh_gallery_tag_model.dart';
import 'package:ehentter/domain/entities/eh_gallery_category.dart';
import 'package:ehentter/domain/entities/eh_gallery_page_info.dart';
import 'package:ehentter/domain/entities/eh_gallery_tag_namespace.dart';
import 'package:html/dom.dart';

class EhGalleryParser {
  EhGalleryParser._();

  static T _guardElement<T>(
    Element parent,
    String selector,
    T Function(Element el) parser,
  ) {
    final el = parent.querySelector(selector);
    try {
      return parser(el!);
    } catch (e) {
      throw EhParseException(
        '$e\nSelector: "$selector"\nElement: ${el?.outerHtml ?? "NOT FOUND"}',
      );
    }
  }

  static EhGalleryIdModel _fromGalleryUrl(String url) {
    final m = RegExp(r'/g/(\d+)/([a-z0-9]+)').firstMatch(url)!;
    return EhGalleryIdModel(gid: int.parse(m.group(1)!), token: m.group(2)!);
  }

  static double _fromRatingCssStyle(String style) {
    final m = RegExp(r':(-?\d+)px\s+(-?\d+)px').firstMatch(style)!;
    return 5.0 +
        (int.parse(m.group(1)!) / 16.0) -
        (m.group(2) == '-21' ? 0.5 : 0);
  }

  static EhGalleryPageInfo fromSearchPage(Document doc) {
    final rows = doc
        .querySelectorAll('.itg tr')
        .where((tr) => tr.querySelector('.glink') != null);

    final galleries = rows.map((tr) {
      return EhGallerySummaryModel(
        id: _guardElement(
          tr,
          '.glname > a',
          (el) => _fromGalleryUrl(el.attributes['href']!),
        ),
        title: _guardElement(tr, '.glink', (el) => el.text),
        category: _guardElement(
          tr,
          '.gl1c.glcat div',
          (el) => EhGalleryCategory.fromString(el.text),
        ),
        thumb: _guardElement(
          tr,
          'img',
          (el) => el.attributes['data-src'] ?? el.attributes['src']!,
        ),
        uploader: _guardElement(tr, '.gl4c a', (el) => el.text),
        posted: _guardElement(
          tr,
          '[id^=posted_]',
          (el) => DateTime.parse(el.text),
        ),
        rating: _guardElement(
          tr,
          '.ir',
          (el) => _fromRatingCssStyle(el.attributes['style']!),
        ),

        filecount: _guardElement(tr, '.gl4c > div', (el) {
          final divs = tr.querySelectorAll('.gl4c > div');
          return divs.last.text.split(' ').first;
        }),

        tags: _guardElement(tr, '.glname', (el) {
          return tr.querySelectorAll('.gt').map((tagEl) {
            final p = tagEl.attributes['title']!.split(':');
            return EhGalleryTagGroupModel(
              namespace: EhGalleryTagNamespaces.fromString(p[0]),
              name: {p[1]},
            );
          }).toList();
        }),
      );
    }).toList();

    return EhGalleryPageInfo(
      galleries: galleries,
      resultCount: galleries.length,
    );
  }
}
