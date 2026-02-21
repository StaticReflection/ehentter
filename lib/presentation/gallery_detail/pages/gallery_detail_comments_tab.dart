import 'package:ehentter/core/extensions/build_context.dart';
import 'package:ehentter/domain/entities/eh_gallery_comment.dart';
import 'package:ehentter/presentation/common/eht/eht_list_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GalleryDetailCommentsTab extends StatelessWidget {
  const GalleryDetailCommentsTab(this.comments, {super.key});

  final List<EhGalleryComment> comments;

  @override
  Widget build(BuildContext context) {
    return EhtListView(
      shrinkWrap: true,
      itemCount: comments.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final comment = comments[index];
        return Card(
          child: Padding(
            padding: .fromLTRB(8, 4, 8, 8),
            child: Column(
              spacing: 8,
              crossAxisAlignment: .start,
              children: [
                Text(
                  comment.username,
                  style: context.theme.textTheme.titleSmall,
                ),
                SizedBox(
                  width: .infinity,
                  child: Card(
                    color: context.theme.colorScheme.surfaceContainerHighest,
                    child: Padding(
                      padding: .all(4),
                      child: SelectableText(comment.content),
                    ),
                  ),
                ),
                DefaultTextStyle(
                  style:
                      context.theme.textTheme.labelMedium ?? const TextStyle(),
                  child: Row(
                    children: [
                      Card(
                        color: context.theme.colorScheme.surfaceContainerHigh,
                        child: Padding(
                          padding: .all(4),
                          child: Text(
                            DateFormat(
                              'yyyy-MM-dd HH:mm',
                            ).format(comment.postedAt),
                          ),
                        ),
                      ),
                      Spacer(),
                      Card(
                        color: context.theme.colorScheme.surfaceContainerHigh,
                        child: Padding(
                          padding: .all(4),
                          child: Text(comment.score.toString()),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
