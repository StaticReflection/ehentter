import 'dart:ui';

import 'package:ehentter/data/models/eh_gallery_detail_model.dart';
import 'package:ehentter/data/models/eh_gallery_id_model.dart';
import 'package:ehentter/data/models/eh_gallery_summary_model.dart';
import 'package:ehentter/data/models/eh_gallery_tag_model.dart';
import 'package:ehentter/data/models/eh_thumbnail_sprite_model.dart';
import 'package:ehentter/data/parsers/eh_base_parser.dart';
import 'package:ehentter/data/parsers/eh_dom_mixin.dart';
import 'package:ehentter/domain/entities/eh_gallery_category.dart';
import 'package:ehentter/domain/entities/eh_gallery_comment.dart';
import 'package:ehentter/domain/entities/eh_gallery_page_info.dart';
import 'package:ehentter/domain/entities/eh_gallery_tag_namespace.dart';
import 'package:html/dom.dart';
import 'package:intl/intl.dart';

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

/// 画廊列表页下一页按钮的地址转 [int] gid
class EhNextUrlParser extends EhBaseParser<String, int?> {
  @override
  int? parser(String input) {
    if (input.isEmpty) return null;
    final m = RegExp(r'[?&]next=(\d+)').firstMatch(input);
    final nextGid = m?.group(1);
    return nextGid != null ? int.tryParse(nextGid) : null;
  }
}

/// 画廊列表页上一页按钮的地址转 [int] gid
class EhPrevUrlParser extends EhBaseParser<String, int?> {
  @override
  int? parser(String input) {
    if (input.isEmpty) return null;
    final m = RegExp(r'[?&]prev=(\d+)').firstMatch(input);
    final prevGid = m?.group(1);
    return prevGid != null ? int.tryParse(prevGid) : null;
  }
}

/// 画廊列表页转 [EhGalleryPageInfo]
class EhGalleryPageParser extends EhBaseParser<Document, EhGalleryPageInfo>
    with EhDomMixin {
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
    // 过滤出包含画廊链接的行
    final rows = input
        .querySelectorAll('.itg tr')
        .where((tr) => tr.querySelector('.glink') != null);

    final galleries = rows.map((tr) {
      return EhGallerySummaryModel(
        id: querySelector(
          tr,
          '.glname > a',
          (el) => _ehGalleryUrlParser(getAttribute(el, 'href')!),
        ),
        title: querySelector(tr, '.glink', (el) => el.text),
        category: querySelector(
          tr,
          '.gl1c.glcat div',
          (el) => EhGalleryCategory.fromString(el.text),
        ),
        thumb: querySelector(
          tr,
          'img',
          (el) =>
              getAttribute(el, 'data-src', required: false) ??
              getAttribute(el, 'src')!,
        ),
        uploader: querySelector(tr, '.gl4c a', (el) => el.text),
        posted: querySelector(
          tr,
          '[id^=posted_]',
          (el) => DateTime.parse(el.text),
        ),
        rating: querySelector(
          tr,
          '.ir',
          (el) => _ehRatingStyleParser(getAttribute(el, 'style')!),
        ),
        filecount: querySelector(
          tr,
          '.gl4c > div:last-child',
          (el) => int.parse(el.text.split(' ').first),
        ),
        tags: querySelectorAll(tr, '.gt', (tagEl) {
          final parts = getAttribute(tagEl, 'title')!.split(':');
          return EhGalleryTagGroupModel(
            namespace: EhGalleryTagNamespaces.fromString(parts[0]),
            name: {parts[1]},
          );
        }, required: false),
      );
    }).toList();

    int? nextGid;
    final nextEl = input.querySelector('#dnext');
    if (nextEl?.localName == 'a') {
      nextGid = querySelector(
        input.body!,
        '#dnext',
        (el) => _ehNextUrlParser(getAttribute(el, 'href')!),
      );
    }

    int? prevGid;
    final prevEl = input.querySelector('#dprev');
    if (prevEl?.localName == 'a') {
      prevGid = querySelector(
        input.body!,
        '#dprev',
        (el) => _ehPrevUrlParser(getAttribute(el, 'href')!),
      );
    }

    int resultCount;
    resultCount =
        querySelector<int?>(input.body!, 'div.searchtext', (searchtext) {
          final pattern = RegExp(r'(\d[\d,]*)\s+results');
          final match = pattern.firstMatch(searchtext.text);

          if (match != null) {
            return int.parse(match.group(1)!.replaceAll(',', ''));
          }

          return 0;
        }, required: false) ??
        0;

    return EhGalleryPageInfo(
      galleries: galleries,
      resultCount: resultCount,
      nextGid: nextGid,
      prevGid: prevGid,
    );
  }
}

/// 画廊详情页转 [EhGalleryDetailModel]
class EhGalleryDetailParser extends EhBaseParser<Document, EhGalleryDetailModel>
    with EhDomMixin {
  final EhGalleryUrlParser _ehGalleryUrlParser;

  EhGalleryDetailParser(this._ehGalleryUrlParser);

  @override
  EhGalleryDetailModel parser(Document input) {
    return EhGalleryDetailModel(
      id: querySelector(
        input.head!,
        'link[rel="canonical"]',
        (el) => _ehGalleryUrlParser(getAttribute(el, 'href')!),
      ),
      title: querySelector(input.body!, '#gn', (el) => el.text),
      category: querySelector(
        input.body!,
        '#gdc',
        (el) => EhGalleryCategory.fromString(el.text),
      ),
      thumb: querySelector(input.body!, '#gd1 > div', (el) {
        final style = getAttribute(el, 'style')!;
        return RegExp(r'background.+url\((.*?)\)').firstMatch(style)!.group(1)!;
      }),
      uploader: querySelector(input.body!, '#gdn > a', (el) => el.text),
      posted: querySelector(
        input.body!,
        '#gdd tr:first-child .gdt2',
        (el) => DateTime.parse(el.text),
      ),
      filecount: querySelector(
        input.body!,
        '#gdd tr:nth-child(5) .gdt2',
        (el) => int.parse(el.text.split(' ').first),
      ),
      rating: querySelector(input.body!, '#rating_label', (el) {
        final match = RegExp(r'Average:\s*(.+)').firstMatch(el.text);
        return double.parse(match!.group(1)!);
      }),
      tags:
          querySelector(input.body!, '#taglist', (taglist) {
            return querySelectorAll(taglist, 'tr', (tr) {
              return EhGalleryTagGroupModel(
                namespace: EhGalleryTagNamespaces.fromString(
                  querySelector(
                    tr,
                    'td.tc',
                    (tc) => tc.text.replaceAll(':', ''),
                  ),
                ),
                name: querySelectorAll(
                  tr,
                  'td div[class^="gt"]',
                  (gt) => gt.text,
                  required: false,
                ).toSet(),
              );
            }, required: false);
          }, required: false) ??
          [],
      thumbnailSprites: querySelector(input.body!, '#gdt', (gdt) {
        return querySelectorAll(gdt, 'a', (item) {
          return EhThumbnailSpriteModel(
            url: getAttribute(item, 'href')!,
            thumb: querySelector(item, 'div', (thumb) {
              final style = getAttribute(thumb, 'style')!;
              return RegExp(
                r'background.+url\((.*?)\)',
              ).firstMatch(style)!.group(1)!;
            }),
            size: querySelector(item, 'div', (thumb) {
              final style = getAttribute(thumb, 'style')!;
              final m = RegExp(
                r'width:\s*(\d+)px;\s*height:\s*(\d+)px;',
              ).firstMatch(style);
              return Size(
                double.parse(m!.group(1)!),
                double.parse(m.group(2)!),
              );
            }),
            offset: querySelector(item, 'div', (thumb) {
              final style = getAttribute(thumb, 'style')!;
              final m = RegExp(
                r'background:.*?url\(.*?\)\s*(-?\d+)(?:px)?\s*(-?\d+)(?:px)?',
              ).firstMatch(style);
              return Offset(
                double.parse(m!.group(1)!),
                double.parse(m.group(2)!),
              );
            }),
          );
        });
      }),
      comments: querySelectorAll(input.body!, '#cdiv div.c1', (comment) {
        return EhGalleryComment(
          username: querySelector(
            comment,
            'div.c3 a',
            (username) => username.text,
          ),
          postedAt: querySelector(comment, 'div.c3', (el) {
            final text = el.text;
            final match = RegExp(
              r'(\d{1,2}\s\w+\s\d{4},\s\d{2}:\d{2})',
            ).firstMatch(text);
            if (match == null) throw Exception('Timestamp format mismatch');
            return DateFormat(
              "d MMMM yyyy, HH:mm",
              "en_US",
            ).parse(match.group(0)!, true);
          }),
          content: querySelector(comment, 'div.c6', (el) {
            return el.innerHtml
                .replaceAll('<br>', '\n')
                .replaceAll('<br/>', '\n')
                .replaceAll('<br />', '\n')
                .replaceAll(RegExp(r'<[^>]*>'), '')
                .trim();
          }),
          score:
              querySelector(comment, 'span[id^="comment_score_"]', (el) {
                final cleaned = el.text.replaceAll(RegExp(r'[^-0-9]'), '');
                return int.tryParse(cleaned) ?? 0;
              }, required: false) ??
              0, // 上传者
        );
      }, required: false),
    );
  }
}

/// 画廊页转 [String] 图片地址
class EhGalleryImageParser extends EhBaseParser<Document, String>
    with EhDomMixin {
  @override
  String parser(Document input) {
    return querySelector(
      input.body!,
      '#img',
      (img) => getAttribute(img, 'src')!,
    );
  }
}
