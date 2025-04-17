import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:photos/src/view/widget/custom_text_field_widget.dart';

import '../../../components.dart';

class CustomTextField1 extends StatefulWidget {
  final bool autofocus;
  final String hintText;
  final String svg;
  final Widget? prefixChild;
  final TextEditingController? textEditingController;
  final void Function(String value)? onChanged;
  final Future<void>? Function(String)? onChangedProcessing;
  final String? Function(String? value)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? initialValue;
  final int? maxLine;
  final int? minLine;
  final bool enable;
  final bool readOnly;
  final InputBorder? border;
  final bool isCollapsed;
  final bool isDense;
  final BoxConstraints? boxConstraints;
  final EdgeInsetsGeometry? contentPadding;
  final dynamic Function(bool isFocused)? onFocusChange;
  final bool showDetailError;
  final Widget Function(String message)? errorBuilder;

  const CustomTextField1({
    super.key,
    this.autofocus = false,
    this.hintText = "",
    this.svg = "",
    this.textEditingController,
    this.onChanged,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.initialValue,
    this.onChangedProcessing,
    this.maxLine = 1,
    this.minLine = 1,
    this.prefixChild,
    this.enable = true,
    this.readOnly = false,
    this.border,
    this.isCollapsed = true,
    this.boxConstraints,
    this.isDense = true,
    this.contentPadding,
    this.onFocusChange,
    this.showDetailError = true,
    this.errorBuilder,
  });

  @override
  State<CustomTextField1> createState() => _CustomTextField1State();
}

class _CustomTextField1State extends State<CustomTextField1> {
  final RxString s = "".obs;
  final RxBool errorStatus = false.obs;
  late final RxBool showText = true.obs;

  @override
  initState() {
    super.initState();
    s.value = widget.textEditingController?.text ?? "";
    showText.value = !widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomTextFormField(
        contentPadding: widget.contentPadding,
        isDense: widget.isDense,
        isCollapsed: widget.isCollapsed,
        errorBuilder: widget.errorBuilder,
        // isDense: true,
        // isCollapsed: true,
        showDetailError: widget.showDetailError,
        readOnly: widget.readOnly,
        enabled: widget.enable,
        autofocus: widget.autofocus,
        textEditingController: widget.textEditingController,
        initialValue: widget.initialValue,
        hintText: widget.hintText,
        keyboardType: widget.keyboardType,
        obscureText: !showText.value,
        maxLines: widget.maxLine,
        minLines: widget.minLine,
        boxConstraints: widget.boxConstraints,
        onFocusChange: (isFocused) {
          if (widget.onFocusChange != null) widget.onFocusChange!(isFocused);
          if (widget.obscureText && !isFocused) showText.value = false;
        },
        //! Eye button
        suffixIcon: !widget.obscureText
            ? null
            : s.isEmpty
                ? null
                : GestureDetector(
                    onTap: () => showText.value = !showText.value,
                    child: Padding(
                      padding: EdgeInsets.all(defaultPadding / 5),
                      child: SvgPicture.asset(
                        showText.value ? "assets/icons/eye_closed_icon.svg" : "assets/icons/eye_opened_icon.svg",
                        colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn),
                      ),
                    ),
                  ),
        validator: widget.validator,
        errorCheck: (error, message) {
          s.value = "";
          errorStatus.value = error;
        },
        onChanged: (value) {
          s.value = value;
          if (widget.onChanged != null) widget.onChanged!(value.trim());
        },
        errorBorder: widget.border,
        enabledBorder: widget.border,
        focusedBorder: widget.border,
        disabledBorder: widget.border,
        focusedErrorBorder: widget.border,

        onChangedProcessing: widget.onChangedProcessing,
        showPrefixLoadingIcon: widget.onChangedProcessing != null,
        prefixIcon: widget.svg.isEmpty
            ? null
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    widget.svg,
                    height: defaultPadding / 1.5,
                    colorFilter: ColorFilter.mode(
                      errorStatus.value
                          ? Theme.of(context).colorScheme.error
                          : s.isEmpty
                              ? Theme.of(context).colorScheme.primary.withOpacity(0.5)
                              : Theme.of(context).colorScheme.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                  if (widget.prefixChild != null) SizedBox(width: 8.sp),
                  if (widget.prefixChild != null) widget.prefixChild!,
                ],
              ),
      ),
    );
  }
}
