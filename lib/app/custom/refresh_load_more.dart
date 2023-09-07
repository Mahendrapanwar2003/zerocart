import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zerocart/my_responsive_sizer/src/extension.dart';
import 'package:zerocart/my_colors/my_colors.dart';

class RefreshLoadmore extends StatefulWidget {
  /// Callback function on pull down to refresh | 下拉刷新时的回调函数
  final Future<void> Function()? onRefresh;

  /// Callback function on pull up to load more data | 上拉以加载更多数据的回调函数
  final Future<void> Function()? onLoadmore;

  /// Whether it is the last page, if it is true, you can not load more | 是否为最后一页，如果为true，则无法加载更多
  final bool isLastPage;

  /// Child widget | 子组件
  final Widget child;

  /// Prompt text widget when there is no more data at the bottom | 底部没有更多数据时的提示文字组件
  final Widget? noMoreWidget;

  /// You can use your custom scrollController, or not | 你可以使用自定义的 ScrollController，或者不使用
  final ScrollController? scrollController;

  const RefreshLoadmore({
    Key? key,
    required this.child,
    required this.isLastPage,
    this.onRefresh,
    this.onLoadmore,
    this.noMoreWidget,
    this.scrollController,
  }) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _RefreshLoadmoreState createState() => _RefreshLoadmoreState();
}

class _RefreshLoadmoreState extends State<RefreshLoadmore> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  ScrollController? _scrollController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController!.addListener(() async {
      if (_scrollController!.position.pixels >=
          _scrollController!.position.maxScrollExtent) {
        if (_isLoading) {
          return;
        }

        if (mounted) {
          setState(() {
            _isLoading = true;
          });
        }

        if (!widget.isLastPage && widget.onLoadmore != null) {
          await widget.onLoadmore!();
        }

        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    if (widget.scrollController == null) _scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget mainWidget = ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      controller: _scrollController,
      children: <Widget>[
        widget.child,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.px),
              child: _isLoading
                  ? const CupertinoActivityIndicator()
                  : widget.isLastPage
                  ? widget.noMoreWidget ??
                  Text(
                    'No more data, you are at the end',
                    style: Theme.of(Get.context!)
                        .textTheme
                        .headline6
                        ?.copyWith(fontWeight: FontWeight.w200),
                  )
                  : Container(),
            ),
          ],
        )
      ],
    );

    if (widget.onRefresh == null) {
      return Scrollbar(child: mainWidget);
    }

    return RefreshIndicator(
      key: _refreshIndicatorKey,
      color: MyColorsLight().secondary,
      backgroundColor: MyColorsLight().primary,
      onRefresh: () async {
        if (_isLoading) return;
        await widget.onRefresh!();
      },
      child: mainWidget,
    );
  }
}
