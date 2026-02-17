import 'package:ehentter/core/extensions/build_context.dart';
import 'package:flutter/material.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

class EhtWaterfall extends StatefulWidget {
  const EhtWaterfall({
    required this.itemCount,
    required this.itemBuilder,
    required this.gridDelegate,
    this.hasReachedMax = true,
    this.onLoadMore,
    this.onRefresh,
    this.padding,
    super.key,
  });

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final SliverWaterfallFlowDelegate gridDelegate;
  final bool hasReachedMax;
  final RefreshCallback? onRefresh;
  final VoidCallback? onLoadMore;
  final EdgeInsetsGeometry? padding;

  @override
  State<EhtWaterfall> createState() => _EhtWaterfallState();
}

class _EhtWaterfallState extends State<EhtWaterfall> {
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
    Widget content = WaterfallFlow.builder(
      controller: _scrollController,
      padding: widget.padding,
      itemCount: widget.itemCount + 1,
      gridDelegate: widget.gridDelegate,
      itemBuilder: (context, index) {
        if (index == widget.itemCount) return _buildFooter(context);
        return widget.itemBuilder(context, index);
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
