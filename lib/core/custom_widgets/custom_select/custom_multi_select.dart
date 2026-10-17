import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_erb/core/custom_widgets/custom_image/custom_network_image.dart';
import '../../enum/cubit_state/cubit_status.dart';
import '../../extension/context_extension.dart';
import '../../locale/app_locale_key.dart';
import '../../utils/common_methods.dart';
import '../../utils/navigator_methods.dart';
import '../api_response_widget/api_response_widget.dart';
import '../buttons/custom_button.dart';
import '../custom_form_field/custom_form_field.dart';
import 'custom_select_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_hr_erb/core/theme/app_text_styles.dart';
import 'package:flutter_hr_erb/core/theme/extensions/theme_extensions.dart';
import 'package:flutter_hr_erb/core/theme/app_colors.dart';

class CustomMultiSelect extends StatefulWidget {
  final List<dynamic> value;
  final List<CustomSelectItem>? items;
  final void Function(List<dynamic>)? onChanged;
  final String? Function(List<dynamic>)? validator;
  final TextInputType? keyboardType;
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
  final Widget? icon;

  final FormFieldBorder formFieldBorder;
  const CustomMultiSelect({
    super.key,
    this.value = const [],
    this.items,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.hintText,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.radius = 10,
    this.fillColor,
    this.focusColor,
    this.unFocusColor,
    this.title,
    this.otherSideTitle,
    this.cubitState,
    this.onReload,
    this.icon,
    this.formFieldBorder = FormFieldBorder.outLine,
  });

  @override
  State<CustomMultiSelect> createState() => _CustomMultiSelectState();
}

class _CustomMultiSelectState extends State<CustomMultiSelect> {
  final _selectedEC = TextEditingController();

  void _showValue() {
    Future.delayed(Duration.zero, () {
      _selectedEC.text =
          widget.items
              ?.where(
                (element) => List.generate(
                  widget.value.length,
                  (index) => widget.value[index],
                ).contains(element.value),
              )
              .map((e) => e.name)
              .join(' , ') ??
          "";
    });
  }

  @override
  Widget build(BuildContext context) {
    _showValue();
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
                      CustomMultiSelectBottomSheet(
                        value: widget.value,
                        items: widget.items,
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
            keyboardType: widget.keyboardType,
            style: AppTextStyles.sRegular.copyWith(color: context.customColors.textPrimary),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLines: widget.maxLines,
            cursorColor: widget.focusColor,
            decoration: InputDecoration(
              hintMaxLines: 2,
              hintText: widget.hintText,
              hintStyle: AppTextStyles.sRegular.copyWith(color: context.customColors.hint),
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

class CustomMultiSelectBottomSheet extends StatefulWidget {
  final List<dynamic> value;
  final List<CustomSelectItem>? items;
  final void Function(List<dynamic>)? onChanged;
  const CustomMultiSelectBottomSheet({
    super.key,
    this.value = const [],
    this.items,
    this.onChanged,
  });

  @override
  State<CustomMultiSelectBottomSheet> createState() => _CustomMultiSelectBottomSheetState();
}

class _CustomMultiSelectBottomSheetState extends State<CustomMultiSelectBottomSheet> {
  List<dynamic> _initialValue = [];
  List<CustomSelectItem>? _items;
  @override
  void initState() {
    _initialValue = List.generate(widget.value.length, (index) => widget.value[index]);
    _items = widget.items;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: context.customColors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
      ),
      constraints: BoxConstraints(maxHeight: context.height() * 0.75),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              width: 72,
              height: 4,
              decoration: BoxDecoration(
                color: context.customColors.primaryLight,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocaleKey.chooseAgent.tr(), style: AppTextStyles.xlBold.copyWith(color: context.customColors.textSecondary)),
                InkWell(
                  onTap: () {
                    setState(() {
                      _initialValue.clear();
                    });
                    widget.onChanged?.call(_initialValue);
                    Navigator.pop(context);
                  },
                  child: Text(AppLocaleKey.reset, style: AppTextStyles.mBold.copyWith(color: AppColors.primary)),
                ),
              ],
            ),
          ),
          // SizedBox(height: 16),
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
                    hintText: AppLocaleKey.search.tr(),
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
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                              if (_initialValue.contains(_items?[index].value)) {
                                setState(() {
                                  _initialValue.remove(_items?[index].value);
                                });
                              } else {
                                setState(() {
                                  _initialValue.add(_items?[index].value);
                                });
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                children: [
                                  CustomNetworkImage(
                                    imageUrl: _items?[index].imageUrl ?? "",
                                    width: 32,
                                    height: 36,
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      _items?[index].name ?? "",
                                      style: TextStyle(
                                        color: context.customColors.textSecondary,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    width: 22,
                                    height: 22,
                                    decoration: BoxDecoration(
                                      color: _initialValue.contains(_items?[index].value)
                                          ? AppColors.primary
                                          : context.customColors.surface,
                                      border: Border.all(
                                        color: _initialValue.contains(_items?[index].value)
                                            ? AppColors.primary
                                            : context.customColors.grey,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: _initialValue.contains(_items?[index].value)
                                          ? const Icon(
                                              Icons.check_rounded,
                                              color: AppColors.white,
                                              size: 18,
                                            )
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
