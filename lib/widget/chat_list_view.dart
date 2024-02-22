import 'package:demo02_chat/res/styles.dart';
import 'package:demo02_chat/widget/touch_close_keyboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatListView extends StatefulWidget {
  final ScrollController? controller;
  final ScrollPhysics? physics;
  final int? itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final Future<bool> Function()? onScrollToBottomLoad;

  final Future<bool> Function()? onScrollToTopLoad;
  final Function()? onScrollToBottom;
  final Function()? onScrollToTop;

  final bool enabledScrollTopLoad;
  final Function()? onTouch;

  const ChatListView({
    super.key,
    this.physics,
    this.onTouch,
    this.itemCount,
    this.controller,
    required this.itemBuilder,
    this.enabledScrollTopLoad = false,
    this.onScrollToBottomLoad,
    this.onScrollToTopLoad,
    this.onScrollToBottom,
    this.onScrollToTop,
  });

  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView> {
  bool _scrollToBottomLoadMore = true;
  bool _scrollToTopLoadMore = true;

  bool get _isBottom =>
      widget.controller!.offset >= widget.controller!.position.maxScrollExtent;

  bool get _isTop => widget.controller!.offset <= 0;

  @override
  void dispose() {
    widget.controller?.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  void initState() {
    _onScrollToBottomLoadMore();
    widget.controller?.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (_isBottom) {
      debugPrint('已经滚到底部了');
      _onScrollToBottomLoadMore();
    } else if (_isTop) {
      debugPrint('已经滚到顶部了');
      _onScrollToTopLoadMore();
    }
  }

  void _onScrollToBottomLoadMore() {
    widget.onScrollToBottom?.call();
    widget.onScrollToBottomLoad?.call().then((hasMore) {
      if (!mounted) return;
      setState(() {
        _scrollToBottomLoadMore = hasMore;
      });
    });
  }

  void _onScrollToTopLoadMore() {
    widget.onScrollToTop?.call();
    if (widget.enabledScrollTopLoad) {
      widget.onScrollToTopLoad?.call().then((hasMore) {
        if (!mounted) return;
        setState(() {
          _scrollToTopLoadMore = hasMore;
        });
      });
    }
  }

  Widget get loadMoreView =>
      Container(
        alignment: Alignment.center,
        height: 44,
        child: CupertinoActivityIndicator(color: Styles.c_0089FF),
      );

  @override
  Widget build(BuildContext context) {
    return TouchCloseSoftKeyboard(
      onTouch: widget.onTouch,
      child: Align(
        alignment: Alignment.topCenter,
        child: ListView.builder(
          reverse: true,
          shrinkWrap: true,
          physics: widget.physics ?? const ClampingScrollPhysics(),
          itemCount: widget.itemCount ?? 0,
          padding: EdgeInsets.only(top: 10.h),
          controller: widget.controller,
          itemBuilder: (context, index) => _wrapLoadMoreItem(index),
        ),
      ),
    );
  }

  Widget _wrapLoadMoreItem(int index) {
    final child = widget.itemBuilder(context, index);
    if (index == widget.itemCount! - 1) {
      return _scrollToBottomLoadMore
          ? Column(children: [loadMoreView, child])
          : child;
    }
    if (index == 0 && widget.enabledScrollTopLoad) {
      return _scrollToTopLoadMore
          ? Column(children: [child, loadMoreView])
          : child;
    }
    return child;
  }
}
