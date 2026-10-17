import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../enum/cubit_state/cubit_status.dart';
import '../../extension/context_extension.dart';
import '../../locale/app_locale_key.dart';
import '../../utils/common_methods.dart';
import '../../utils/navigator_methods.dart';
import '../api_response_widget/api_response_widget.dart';
import '../buttons/custom_button.dart';
import '../custom_form_field/custom_form_field.dart';
import 'custom_select_item.dart';
import 'package:flutter_hr_erb/core/theme/app_text_styles.dart';
import 'package:flutter_hr_erb/core/theme/extensions/theme_extensions.dart';
import 'package:flutter_hr_erb/core/theme/app_colors.dart';

class CustomSingleSelect extends StatefulWidget {
  final dynamic value;
  final List<CustomSelectItem>? items;
  final void Function(dynamic)? onChanged;
  final String? Function(dynamic)? validator;
  final String? hintText;
  final int? maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double radius;
  final Color? fillColor;
  final Color? focusColor;
  final Color? unFocusColor;
  final String? title;
  final String? otherSideTitle;
  final CubitStatus? cubitState;
  final void Function()? onReload;
  final void Function()? onReInitial;
  final Widget? icon;
  final TextStyle? hintStyle;
  final bool hasRemove;
  final FormFieldBorder formFieldBorder;
  const CustomSingleSelect({
    super.key,
    this.value,
    this.items,
    this.onChanged,
    this.validator,
    this.hintText,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.radius = 4,
    this.fillColor,
    this.focusColor,
    this.unFocusColor,
    this.title,
    this.otherSideTitle,
    this.cubitState,
    this.onReload,
    this.icon,
    this.onReInitial,
    this.formFieldBorder = FormFieldBorder.outLine,
    this.hintStyle,
    this.hasRemove = true,
  });

  @override
  State<CustomSingleSelect> createState() => _CustomSingleSelectState();
}

class _CustomSingleSelectState extends State<CustomSingleSelect> {
  final _selectedEC = TextEditingController();
  dynamic _lastValue;

  @override
  void initState() {
    super.initState();
    _lastValue = widget.value;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateText();
    });
  }

  @override
  void didUpdateWidget(CustomSingleSelect oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value ||
        oldWidget.items != widget.items ||
        _lastValue != widget.value) {
      _lastValue = widget.value;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _updateText();
        }
      });
    }
  }

  void _updateText() {
    if (widget.value != null && widget.items != null && widget.items!.isNotEmpty) {
      try {
        final selectedItem = widget.items!.firstWhere((item) => item.value == widget.value);
        if (_selectedEC.text != selectedItem.name) {
          _selectedEC.text = selectedItem.name;
        }
      } catch (e) {
        if (_selectedEC.text.isNotEmpty) {
          _selectedEC.clear();
        }
      }
    } else {
      if (_selectedEC.text.isNotEmpty) {
        _selectedEC.clear();
      }
    }
  }

  @override
  void dispose() {
    _selectedEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (widget.title != null) ...{
                Expanded(child: Text(widget.title!, style: AppTextStyles.sMedium.copyWith(color: context.customColors.textPrimary))),
              },
              if (widget.otherSideTitle != null) ...{
                Text(widget.otherSideTitle!, style: AppTextStyles.sMedium.copyWith(color: context.customColors.textPrimary)),
              },
            ],
          ),
          if (widget.title != null || widget.otherSideTitle != null) ...{
            const SizedBox(height: 10),
          },
          TextFormField(
            controller: _selectedEC,
            validator: (v) => widget.validator?.call(widget.value),
            onTap: widget.cubitState == CubitStatus.loading
                ? null
                : widget.items != null && widget.items?.isNotEmpty == true
                ? () {
                    NavigatorMethods.showAppBottomSheet(
                      context,
                      CustomSingleSelectBottomSheet(
                        value: widget.value,
                        items: widget.items,
                        hasRemove: widget.hasRemove,
                        onChanged: (v) {
                          widget.onChanged?.call(v);
                        },
                      ),
                      isScrollControlled: true,
                    );
                  }
                : () {
                    CommonMethods.showAlertDialog(
                      message: context.apiTr(ar: "لا توجد بيانات", en: "There is no data"),
                    );
                  },
            readOnly: true,
            style: AppTextStyles.sRegular.copyWith(color: context.customColors.textPrimary),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLines: widget.maxLines,
            cursorColor: widget.focusColor,
            decoration: InputDecoration(
              hintMaxLines: 2,
              hintText: widget.hintText,
              hintStyle: widget.hintStyle ?? AppTextStyles.sRegular.copyWith(color: context.customColors.hint),
              fillColor:
                  widget.fillColor ??
                  (widget.formFieldBorder == FormFieldBorder.underLine
                      ? Colors.transparent
                      : context.customColors.textFormFill),
              filled: true,
              border: _border(color: widget.unFocusColor ?? context.customColors.textFormBorder),
              disabledBorder: _border(
                color: widget.unFocusColor ?? context.customColors.textFormBorder,
              ),
              focusedBorder: _border(color: widget.unFocusColor ?? AppColors.primary),
              enabledBorder: _border(
                color: widget.unFocusColor ?? context.customColors.textFormBorder,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              suffixIconConstraints: BoxConstraints(maxWidth: widget.suffixIcon != null ? 110 : 40),
              prefixIcon: widget.prefixIcon,
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 35,
                    child: widget.cubitState != null
                        ? ApiResponseWidget(
                            cubitState: widget.cubitState!,
                            onReload: widget.onReload,
                            isEmpty: false,
                            errorWidget: IconButton(
                              onPressed: widget.onReload,
                              icon: Icon(
                                Icons.wifi_protected_setup_rounded,
                                color: context.customColors.hint,
                              ),
                            ),
                            offlineWidget: GestureDetector(
                              onTap: widget.onReload,
                              child: Icon(
                                Icons.wifi_protected_setup_rounded,
                                color: context.customColors.hint,
                              ),
                            ),
                            loadingWidget: const CupertinoActivityIndicator(),
                            child:
                                widget.icon ??
                                Icon(
                                  widget.items == null || widget.items!.isEmpty
                                      ? Icons.error_rounded
                                      : Icons.keyboard_arrow_down_rounded,
                                  color: context.customColors.hint,
                                  size: 25,
                                ),
                          )
                        : widget.icon ??
                              Icon(
                                widget.items == null || widget.items!.isEmpty
                                    ? Icons.error_rounded
                                    : Icons.keyboard_arrow_down_rounded,
                                color: context.customColors.hint,
                                size: 25,
                              ),
                  ),
                  if (widget.suffixIcon != null) ...{
                    widget.suffixIcon ?? const SizedBox(),
                    const SizedBox(width: 10),
                  },
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputBorder _border({required Color color}) {
    switch (widget.formFieldBorder) {
      case FormFieldBorder.outLine:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          borderSide: BorderSide(color: color),
        );
      case FormFieldBorder.underLine:
        return UnderlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: color),
        );
      case FormFieldBorder.none:
        return InputBorder.none;
    }
  }
}

class CustomSingleSelectBottomSheet extends StatefulWidget {
  final dynamic value;
  final List<CustomSelectItem>? items;
  final void Function(dynamic)? onChanged;
  final bool hasRemove;
  const CustomSingleSelectBottomSheet({
    super.key,
    this.value,
    this.items,
    this.onChanged,
    this.hasRemove = true,
  });

  @override
  State<CustomSingleSelectBottomSheet> createState() => _CustomSingleSelectBottomSheetState();
}

class _CustomSingleSelectBottomSheetState extends State<CustomSingleSelectBottomSheet> {
  dynamic _initialValue;
  List<CustomSelectItem>? _items;
  @override
  void initState() {
    _initialValue = widget.value;
    _items = widget.items;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: context.customColors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(0)),
      ),
      constraints: BoxConstraints(maxHeight: context.height() * 0.75),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 15),
          Center(
            child: SizedBox(
              width: 30,
              child: Divider(color: context.customColors.lightGrey, thickness: 2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(AppLocaleKey.search.tr(), style: AppTextStyles.mMedium.copyWith(color: context.customColors.textSecondary)),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                CustomButton(
                  text: context.apiTr(ar: 'تطبيق', en: 'Done'),
                  height: 47,
                  width: 90,
                  onPressed: () {
                    widget.onChanged?.call(_initialValue);
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomFormField(
                    fillColor: context.customColors.surfaceVariant,
                    unFocusColor: context.customColors.surfaceVariant,
                    hintText: tr(AppLocaleKey.search),
                    onChanged: (v) {
                      _items = widget.items
                          ?.where((element) => element.name.toLowerCase().contains(v))
                          .toList();
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...List.generate(
                    _items?.length ?? 0,
                    (index) => Column(
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              switch (widget.hasRemove) {
                                case true:
                                  if (_initialValue == _items?[index].value) {
                                    setState(() {
                                      _initialValue = null;
                                    });
                                  } else {
                                    setState(() {
                                      _initialValue = _items?[index].value;
                                    });
                                  }
                                  break;
                                case false:
                                  setState(() {
                                    _initialValue = _items?[index].value;
                                  });
                                  break;
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  _initialValue == _items?[index].value
                                      ? Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: AppColors.primary,
                                            shape: BoxShape.circle,
                                            border: Border.all(color: context.customColors.grey),
                                          ),
                                          child: Center(
                                            child: CircleAvatar(
                                              radius: 3,
                                              backgroundColor: context.customColors.surface,
                                            ),
                                          ),
                                        )
                                      : Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: context.customColors.surface,
                                            shape: BoxShape.circle,
                                            border: Border.all(color: context.customColors.grey),
                                          ),
                                        ),
                                  /*
                                  CircleAvatar(
                                    backgroundColor: _initialValue == _items?[index].value
                                        ? AppColors.primary
                                        : context.customColors.grey,
                                    radius: 11,
                                    child: CircleAvatar(
                                      backgroundColor: context.customColors.surface,
                                      radius: 9,
                                      child: CircleAvatar(
                                        backgroundColor: _initialValue == _items?[index].value
                                            ? AppColors.primary
                                            : context.customColors.surface,
                                        radius: 7,
                                      ),
                                    ),
                                  ),
                                  */
                                  const SizedBox(width: 10),
                                  //Expanded
                                  Text(
                                    _items?[index].name ?? "",
                                    style: TextStyle(
                                      color: context.customColors.textPrimary,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 22),
                          child: Divider(color: context.customColors.divider, thickness: 1),
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.viewInsetsOf(context).bottom),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
