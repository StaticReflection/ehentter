import 'package:ehentter/core/extensions/build_context.dart';
import 'package:flutter/material.dart';

class EhtListView extends StatefulWidget {
  const EhtListView({
    required this.itemCount,
    required this.itemBuilder,
    this.separatorBuilder,
    this.shrinkWrap = false,
    this.hasReachedMax = true,
    this.onLoadMore,
    this.onRefresh,
    this.padding,
    this.physics = const AlwaysScrollableScrollPhysics(),
    super.key,
  });

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;
  final bool shrinkWrap;
  final bool hasReachedMax;
  final RefreshCallback? onRefresh;
  final VoidCallback? onLoadMore;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics physics;

  @override
  State<EhtListView> createState() => _EhtListViewState();
}

class _EhtListViewState extends State<EhtListView> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    if (widget.onLoadMore != null) {
      _scrollController.addListener(_onScroll);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (widget.hasReachedMax) return;
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      widget.onLoadMore?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.separated(
      controller: _scrollController,
      padding: widget.padding,
      shrinkWrap: widget.shrinkWrap,
      physics: widget.physics,
      itemCount: widget.itemCount + 1,
      itemBuilder: (context, index) {
        if (index == widget.itemCount) return _buildFooter(context);
        return widget.itemBuilder(context, index);
      },
      separatorBuilder: (context, index) {
        if (index == widget.itemCount - 1) return const SizedBox.shrink();
        return widget.separatorBuilder?.call(context, index) ??
            const SizedBox(height: 8);
      },
    );

    if (widget.onRefresh != null) {
      return RefreshIndicator(onRefresh: widget.onRefresh!, child: content);
    }
    return content;
  }

  Widget _buildFooter(BuildContext context) {
    if (widget.hasReachedMax) {
      if (widget.itemCount == 0) return const SizedBox.shrink();
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            context.l10n.no_more_data_message,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
        ),
      );
    }
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: CircularProgressIndicator(),
      ),
    );
  }
}
