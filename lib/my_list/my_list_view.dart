
import 'package:flutter/material.dart';

class MyListView extends StatelessWidget {
  final Function listOfData;
  final bool isVertical;
  final double horizontalPadding;
  final double verticalPadding;
  final double dividerVerticalPadding;
  final double dividerHorizontalPadding;
  final double dividerThickness;
  final bool reverse;
  final ScrollPhysics physics;
  final bool shrinkWrap;
  final bool primary;
  final Clip clipBehavior;
  final int itemCount;
  final double dividerHeight;
  final Color dividerColor;
  final bool wantDivider;

  const MyListView({
    Key? key,
    required this.listOfData,
    this.isVertical = true,
    this.primary = true,
    this.dividerColor = Colors.black,
    this.horizontalPadding = 2,
    this.dividerHorizontalPadding = 0,
    this.dividerVerticalPadding = 0,
    this.dividerThickness = 0,
    this.reverse = false,
    required this.physics,
    this.shrinkWrap = false,
    this.verticalPadding = 2,
    this.clipBehavior = Clip.hardEdge,
    required this.itemCount,
    this.dividerHeight = 0.0,
    this.wantDivider=false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding, vertical: verticalPadding),
      child: ListView.separated(
        reverse: reverse,
        physics: physics,
        primary: primary,
        shrinkWrap: shrinkWrap,
        clipBehavior: clipBehavior,
        scrollDirection: isVertical ? Axis.vertical : Axis.horizontal,
        separatorBuilder: (c, i) {
          return wantDivider?isVertical
              ? Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: dividerHorizontalPadding,
                      vertical: dividerVerticalPadding),
                  child: Divider(
                    height: dividerHeight,
                    thickness: dividerThickness,
                    color: dividerColor,
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: dividerHorizontalPadding,
                      vertical: dividerVerticalPadding),
                  child: VerticalDivider(
                    width: dividerHeight,
                    thickness: dividerThickness,
                    color: dividerColor,

                  ),
                ):SizedBox();
        },
        itemBuilder: (c, i) {
          return listOfData(i);
        },
        itemCount: itemCount,
      ),
    );
  }
}
