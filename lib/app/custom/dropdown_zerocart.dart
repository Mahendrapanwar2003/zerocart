import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_library/ui_library.dart';
// ignore: depend_on_referenced_packages
import 'package:zerocart/my_colors/my_colors.dart';

// ignore: must_be_immutable
class DropdownZeroCartButton<T> extends StatefulWidget {
  final List<DropdownMenuItem<T>> items;
  final Function(T) onChanged;
  Widget? icon;

  DropdownZeroCartButton({
    Key? key,
    required this.items,
    required this.onChanged,
    this.icon,
  }) : super(key: key);

  @override
  State<DropdownZeroCartButton<T>> createState() => _DropdownZeroCartButtonState<T>();
}

class _DropdownZeroCartButtonState<T> extends State<DropdownZeroCartButton<T>> {
  T? selectedValue;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: Theme(
        data: Theme.of(context).copyWith(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        child: DropdownButton(
          value: selectedValue,
          onChanged: (T? value) {
            setState(() {
              selectedValue = value;
            });
            widget.onChanged(value!);
          },
          style: Theme
              .of(Get.context!)
              .textTheme
              .headline3
              ?.copyWith(
              color: MyColorsLight().secondary, fontWeight: FontWeight.w300),
          items: widget.items,
          icon: Padding(
            padding: EdgeInsets.only(right: 12.px),
            child: widget.icon,
          ),
          focusColor: Colors.transparent,
        ),
      ),
    );
  }
}


// ignore: must_be_immutable
class DropdownZeroCart<T> extends StatefulWidget {
  final List<DropdownMenuItem<T>> items;
  final Function(T) onChanged;
  Widget? icon;
  Widget? hint;
  T? selected;
  bool wantDivider = true;
  bool? wantDividerError = false;

  DropdownZeroCart({
    Key? key,
    required this.items,
    required this.onChanged,
    this.icon,
    this.hint,
    this.wantDividerError,
    this.selected,
    this.wantDivider = true,
  }) : super(key: key);

  @override
  State<DropdownZeroCart<T>> createState() => _DropdownZeroCartState<T>();
}

class _DropdownZeroCartState<T> extends State<DropdownZeroCart<T>> {
  T? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Theme(
          data: Theme.of(context).copyWith(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,

          ),
          child: Container(
            margin: EdgeInsets.only(bottom: 4.px),
            child: DropdownButton(
              value: selectedValue,
              hint: widget.hint,
              onChanged: (T? value) {
                setState(() {
                  selectedValue = value;
                });
                widget.onChanged(value!);
              },
              isExpanded: true,
              underline: Container(
                color: Colors.transparent,
              ),
              style: Theme.of(Get.context!)
                  .textTheme
                  .subtitle2
                  ?.copyWith(fontSize: 16.px),
              items: widget.items,
              icon: Padding(
                padding: EdgeInsets.only(right: 12.px),
                child: widget.icon,
              ),
              focusColor: Colors.transparent,
            ),
          ),
        ),
        if(widget.wantDivider)
        Divider(
          thickness: 1,
          color: widget.wantDividerError==true? MyColorsLight().error: MyColorsLight().onPrimary,
          height: 4.px,
        ),
      ],
    );
  }
}
