import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photos/src/view/widget%20copy/custom_animated_size_widget.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.boxConstraints,
    this.textEditingController,
    this.hintText = "",
    this.borderRadius,
    this.initialValue,
    this.focusNode,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType = TextInputType.text,
    this.minLines,
    this.maxLines = 1,
    this.maxLength,
    this.textAlign = TextAlign.start,
    this.autofocus = true,
    this.autocorrect = true,
    this.enabled = true,
    this.readOnly = false,
    this.cursorColor,
    this.obscureText = false,
    this.obscuringCharacter = "•",
    this.autofillHints,
    this.style,
    this.onChangeDebouncer = const Duration(milliseconds: 500),
    this.fullTextSelection = false,
    this.label,
    this.labelText,
    this.labelStyle,
    this.prefixIcon,
    this.prefix,
    this.suffixIcon,
    this.suffix,
    this.loadingIcon,
    this.loadingIconColor,
    this.loadingIconsSize = 24,
    this.showPrefixLoadingIcon = false,
    this.showSuffixLoadingIcon = false,
    this.fillColor,
    this.hintStyle,
    this.errorStyle,
    this.contentPadding,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.disabledBorder,
    this.textAlignVertical = TextAlignVertical.center,
    this.isCollapsed = false,
    this.floatingLabelBehavior,
    this.isDense = true,
    this.showDetailError = true,
    this.errorTextStyle,
    this.errorColor,

    //Functions
    this.onFocusChange,
    this.onComplete,
    this.onTapOutside,
    this.validator,
    this.onTap,
    this.onChanged,
    this.onChangedProcessing,
    this.errorCheck,
    this.errorBuilder,
  });

  final BoxConstraints? boxConstraints;
  final TextEditingController? textEditingController;
  final String hintText;
  final BorderRadius? borderRadius;
  final String? initialValue;
  final FocusNode? focusNode;
  final TextCapitalization textCapitalization;
  final TextInputType keyboardType;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final TextAlign textAlign;
  final bool autofocus;
  final bool autocorrect;
  final bool enabled;
  final bool readOnly;
  final Color? cursorColor;
  final bool obscureText;
  final String obscuringCharacter;
  final List<String>? autofillHints;
  final TextStyle? style;
  final Duration onChangeDebouncer;
  final bool fullTextSelection;
  final Widget? label;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? prefix;
  final Widget? suffixIcon;
  final Widget? suffix;
  final Widget? loadingIcon;
  final double? loadingIconsSize;
  final Color? loadingIconColor;
  final bool showPrefixLoadingIcon;
  final bool showSuffixLoadingIcon;
  final Color? fillColor;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final InputBorder? disabledBorder;
  final TextAlignVertical? textAlignVertical;
  final bool isCollapsed;
  final bool isDense;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final bool showDetailError;

  /// Use showDetailError = true
  /// Default: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.error, fontWeight: FontWeight.bold)
  final TextStyle? errorTextStyle;

  /// Use showDetailError = true
  /// Default: Theme.of(context).colorScheme.error
  final Color? errorColor;

  /// Use showDetailError = true
  final Widget Function(String message)? errorBuilder;

  //Functions
  final Function(bool isFocused)? onFocusChange;
  final void Function(String? value)? onComplete;
  final void Function(PointerDownEvent pointerDownEvent)? onTapOutside;
  final String? Function(String? value)? validator;
  final void Function()? onTap;
  final void Function(String value)? onChanged;
  final Future<void>? Function(String value)? onChangedProcessing;
  final void Function(bool error, String message)? errorCheck;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isFocused = false;
  late TextEditingController textEditingController;
  late String hintText;
  late BorderRadius borderRadius;
  bool error = false;
  String? message;
  bool isIdle = true;
  bool firstTimeTap = false;
  List<String> searchProductList = [];
  Timer? debounce;
  late EdgeInsetsGeometry contentPadding;
  late double height;

  @override
  void initState() {
    super.initState();
    textEditingController = widget.textEditingController ?? TextEditingController();
    hintText = widget.hintText;
    borderRadius = widget.borderRadius ?? BorderRadius.circular(8);

    if (widget.initialValue != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        textEditingController.text = widget.initialValue!;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    // textEditingController.dispose();
    debounce?.cancel();
  }

  Widget? showLoadingIcon(bool value) {
    if (value && !isIdle) {
      return widget.loadingIcon ??
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxHeight: widget.loadingIconsSize ?? double.infinity,
                  maxWidth: widget.loadingIconsSize ?? double.infinity,
                ),
                child: FittedBox(child: CircularProgressIndicator(color: widget.loadingIconColor ?? Theme.of(context).colorScheme.primary)),
              ),
            ],
          );
    } else {
      return null;
    }
  }

  Widget? _setIcon(Widget? icon) {
    if (icon == null) return null;

    return SizedBox(
      height: Theme.of(context).buttonTheme.height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon
        ],
      ),
    );
  }

  Widget? widgetReplacement(Widget? wez, EdgeInsetsGeometry padding) {
    // print(contentPadding.horizontal);

    if (wez == null) return SizedBox(width: padding.horizontal);

    // widget.boxConstraints.minWidth ?? BoxConstraints(minWidth: Theme.of(context).buttonTheme.height),

    return Container(
      // const BoxConstraints(minWidth: 16)
      // (widget.boxConstraints?.minWidth ??
      // color: Colors.amber,
      margin: EdgeInsets.symmetric(horizontal: padding.horizontal / 2),
      constraints: BoxConstraints(minWidth: padding.horizontal),
      child: wez,
    );
  }

  Widget errorChild() {
    if (error && widget.showDetailError && message != null) {
      return Text(
        message!,
        textAlign: widget.textAlign,
        style: widget.errorTextStyle ?? Theme.of(context).textTheme.bodySmall?.copyWith(color: widget.errorColor ?? Theme.of(context).colorScheme.error, fontWeight: FontWeight.bold),
      );
    } else {
      return const SizedBox();
    }
  }

  void unfocusKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
    FocusManager.instance.rootScope.unfocus();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    height = widget.boxConstraints?.minHeight ?? Theme.of(context).buttonTheme.height;
    contentPadding = widget.contentPadding ?? EdgeInsets.symmetric(horizontal: 8.sp, vertical: 4.sp);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Focus(
          onFocusChange: (value) {
            firstTimeTap = false;
            if (!value) {
              unfocusKeyboard();
            }

            if (mounted) setState(() => isFocused = value);
            if (widget.onFocusChange != null) widget.onFocusChange!(value);
          },
          child: TextFormField(
            textAlignVertical: widget.textAlignVertical,
            controller: textEditingController,
            focusNode: widget.focusNode,
            textCapitalization: widget.textCapitalization,
            keyboardType: widget.keyboardType,
            minLines: widget.minLines,
            maxLines: widget.obscureText ? 1 : widget.maxLines,
            maxLength: widget.maxLength,
            textAlign: widget.textAlign,
            autofocus: widget.autofocus,
            autocorrect: widget.autocorrect,
            enabled: widget.enabled,
            readOnly: widget.readOnly,
            cursorColor: widget.cursorColor ?? Theme.of(context).colorScheme.primary,
            obscureText: widget.obscureText,
            obscuringCharacter: widget.obscuringCharacter,
            autofillHints: widget.autofillHints,
            style: widget.style ?? Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),

            //! Functions
            onEditingComplete: () {
              unfocusKeyboard();
              if (widget.onComplete != null) widget.onComplete!(textEditingController.text);
            },
            onTapOutside: (PointerDownEvent pointerDownEvent) {
              unfocusKeyboard();
              if (widget.onTapOutside != null) widget.onTapOutside!(pointerDownEvent);
            },
            onChanged: (value) {
              //* On change without processing
              if (widget.onChanged != null) widget.onChanged!(value);

              //* On change with processing
              if (widget.onChangedProcessing != null) {
                if (debounce?.isActive ?? false) debounce?.cancel();
                debounce = Timer(
                  widget.onChangeDebouncer,
                  () async {
                    searchProductList.add(value);
                    if (isIdle && searchProductList.isNotEmpty) {
                      String searchingProduct = searchProductList.last;
                      searchProductList = [];
                      if (mounted) setState(() => isIdle = false);
                      await widget.onChangedProcessing!(searchingProduct);
                      if (mounted) setState(() => isIdle = true);
                    }
                  },
                );
              }
              if (error) {
                hintText = widget.hintText;
                error = false;
                if (widget.errorCheck != null) widget.errorCheck!(error, "");
              }
              if (mounted) setState(() {});
            },
            onTap: () {
              if (widget.fullTextSelection && !firstTimeTap) {
                textEditingController.selection = TextSelection(
                  baseOffset: 0,
                  extentOffset: textEditingController.value.text.length,
                );
                firstTimeTap = true;
              }
              if (widget.onTap != null) widget.onTap!();
              if (error) {
                hintText = widget.hintText;
                error = false;
                if (widget.errorCheck != null) widget.errorCheck!(error, "");
              }
              if (mounted) setState(() {});
            },
            validator: (value) {
              message = null;
              if (mounted) setState(() {});

              if (widget.validator == null) return null;
              message = widget.validator!(value);
              if (message == null) return null;
              error = true;
              if (widget.errorCheck != null) widget.errorCheck!(error, message!);

              if (widget.showDetailError || widget.errorBuilder != null) {
              } else {
                textEditingController.clear();
                hintText = message!;
              }

              if (mounted) setState(() {});
              return "";
            },
            //! ------------------------------------------
            decoration: InputDecoration(
              isDense: widget.isDense,
              isCollapsed: widget.isCollapsed,
              hintText: hintText,
              label: widget.label,
              labelText: widget.labelText,
              labelStyle: widget.labelStyle,
              floatingLabelBehavior: widget.floatingLabelBehavior,
              constraints: widget.boxConstraints ?? BoxConstraints(minHeight: height),
              prefix: widget.prefix,
              suffix: widget.suffix,
              suffixIconConstraints: const BoxConstraints(),
              prefixIconConstraints: const BoxConstraints(),
              prefixIcon: SizedBox(
                height: height,
                child: CustomAnimatedSize(
                  alignment: Alignment.centerLeft,
                  child: widgetReplacement(showLoadingIcon(widget.showPrefixLoadingIcon) ?? _setIcon(widget.prefixIcon), contentPadding),
                ),
              ),
              suffixIcon: CustomAnimatedSize(
                alignment: Alignment.centerLeft,
                child: widgetReplacement(showLoadingIcon(widget.showSuffixLoadingIcon) ?? _setIcon(widget.suffixIcon), contentPadding),
              ),
              filled: widget.fillColor == null ? false : true,
              fillColor: widget.fillColor,
              hintStyle: !error ? widget.hintStyle ?? TextStyle(color: Theme.of(context).colorScheme.primary.withOpacity(0.5)) : widget.errorStyle ?? widget.hintStyle?.copyWith(color: Theme.of(context).colorScheme.error) ?? TextStyle(color: Theme.of(context).colorScheme.error),
              errorStyle: const TextStyle(height: 0),
              contentPadding: contentPadding,
              // contentPadding: EdgeInsets.zero,
              enabledBorder: widget.enabledBorder?.copyWith(borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.primary.withOpacity(0.5))) ??
                  OutlineInputBorder(
                    borderRadius: borderRadius,
                    borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
                  ),
              focusedBorder: widget.focusedBorder?.copyWith(borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.primary)) ??
                  OutlineInputBorder(
                    borderRadius: borderRadius,
                    borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.primary),
                  ),
              errorBorder: widget.errorBorder?.copyWith(borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.error)) ??
                  OutlineInputBorder(
                    borderRadius: borderRadius,
                    borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.error),
                  ),
              focusedErrorBorder: widget.focusedErrorBorder?.copyWith(borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.primary.withOpacity(0.5))) ??
                  OutlineInputBorder(
                    borderRadius: borderRadius,
                    borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
                  ),
              disabledBorder: widget.disabledBorder?.copyWith(borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.primary.withOpacity(0.1))) ??
                  OutlineInputBorder(
                    borderRadius: borderRadius,
                    borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.primary.withOpacity(0.1)),
                  ),
            ),
          ),
        ),
        CustomAnimatedSize(
          alignment: Alignment.topCenter,
          widthFactor: 1,
          child: widget.errorBuilder != null ? widget.errorBuilder!(message ?? "") : errorChild(),
        ),
      ],
    );
  }
}
