// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:hareef/core/enum/cubit_state/cubit_status.dart';
// import 'package:hareef/core/extension/context_extension.dart';
// import 'package:hareef/core/theme/app_colors.dart';


// class CustomDropdownOverlay extends StatefulWidget {
//   final List<CustomSelectDropdownItem> items;
//   final String? title;
//   final String? hintText;
//   final Function(dynamic) onItemSelected;
//   final double? width;
//   final double? height;
//   final Widget? prefixIcon;
//   final CubitStatus? cubitState;
//   final String? Function(String?)? validator;
//   final String? selectedItem;
//   final Widget customWidget;
//   final String? icon;
//   final bool? inCenter;

//   const CustomDropdownOverlay({
//     super.key,
//     required this.items,
//     this.title,
//     this.hintText,
//     required this.onItemSelected,
//     this.width,
//     this.height,
//     this.prefixIcon,
//     this.cubitState,
//     this.validator,
//     this.selectedItem,
//     required this.customWidget,
//     this.icon,
//     this.inCenter = false,
//   });

//   @override
//   State<CustomDropdownOverlay> createState() => _CustomDropdownOverlayState();
// }

// class _CustomDropdownOverlayState extends State<CustomDropdownOverlay> {
//   OverlayEntry? _overlayEntry;
//   final LayerLink _layerLink = LayerLink();
//   final TextEditingController _selectedItemEc = TextEditingController();
//   int? value;
//   final ValueNotifier<bool> _isDropdownVisible = ValueNotifier<bool>(false);

//   void _showOverlay(BuildContext context) {
//     _overlayEntry = OverlayEntry(
//       builder: (context) {
//         return GestureDetector(
//           onTap: () {
//             //! Close overlay when tapping outside
//             _isDropdownVisible.value = false;
//             _removeOverlay();
//           },
//           behavior: HitTestBehavior.opaque, 
//           //! Ensures taps outside are detected
//           child: Stack(
//             children: [
//               //! Transparent background to capture taps anywheremain
//               Positioned.fill(child: Container(color: Colors.transparent)),
//               Positioned(
//                 width: widget.width ?? MediaQuery.of(context).size.width - 70.w,
//                 child: CompositedTransformFollower(
//                   link: _layerLink,
//                   showWhenUnlinked: false,
//                   offset: Offset(0, widget.height ?? 70.h),
//                   targetAnchor:
//                       widget.inCenter!
//                           ? Alignment.center
//                           : context.isRTL()
//                           ? Alignment.bottomRight
//                           : Alignment.bottomLeft,
//                   followerAnchor:
//                       widget.inCenter!
//                           ? Alignment.center
//                           : context.isRTL()
//                           ? Alignment.topRight
//                           : Alignment.topLeft,
//                   child: Material(
//                     elevation: 1,
//                     borderRadius: BorderRadius.circular(8.r),
//                     color: context.customColors.surface,
//                     child: ConstrainedBox(
//                       constraints: BoxConstraints(maxHeight: 250.h, minHeight: 50.h),
//                       child:
//                           widget.items.isEmpty
//                               ? const Center(
//                                 child: Padding(padding: EdgeInsets.all(10.0), child: Text("لا يوجد بيانات")),
//                               )
//                               : Scrollbar(
//                                 interactive: true,
//                                 child: ListView.builder(
//                                   shrinkWrap: true,
//                                   padding: EdgeInsets.zero,
//                                   itemCount: widget.items.length,
//                                   itemBuilder: (context, index) {
//                                     return InkWell(
//                                       onTap: () {
//                                         setState(() {
//                                           _selectedItemEc.text = widget.items[index].name;
//                                           value = widget.items[index].value;
//                                         });
//                                         widget.onItemSelected(widget.items[index].value);
//                                         _isDropdownVisible.value = false;
//                                         _removeOverlay();
//                                       },
//                                       child: Container(
//                                         color:
//                                             value == widget.items[index].value
//                                                 ? AppColors.blue.withOpacity(0.1)
//                                                 : Colors.transparent,
//                                         child: Padding(
//                                           padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
//                                           child: Row(
//                                             children: [
//                                               widget.icon != null
//                                                   ? SvgPicture.asset(widget.icon!)
//                                                   : const SizedBox.shrink(),
//                                               8.horizontalSpace,
//                                               Text(widget.items[index].name, style: AppTextStyle.text14MDark(context)),
//                                               const Spacer(),
//                                               value == widget.items[index].value
//                                                   ? SvgPicture.asset(AppImages.assetsSvgCheckFill)
//                                                   : const SizedBox.shrink(),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//     Overlay.of(context).insert(_overlayEntry!);
//   }

//   void _removeOverlay() {
//     _overlayEntry?.remove();
//     _overlayEntry = null;
//   }

//   @override
//   void dispose() {
//     _removeOverlay();
//     _selectedItemEc.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CompositedTransformTarget(
//       link: _layerLink,
//       child:
//           widget.cubitState == CubitStatus.loading
//               ? CustomShimmer(height: 20.h, width: widget.width ?? double.infinity, radius: 8.r)
//               : GestureDetector(
//                 onTap: () {
//                   if (_overlayEntry == null) {
//                     if (widget.cubitState != CubitStatus.loading) {
//                       _showOverlay(context);
//                       _isDropdownVisible.value = true;
//                     }
//                   } else {
//                     _isDropdownVisible.value = false;
//                     _removeOverlay();
//                   }
//                 },
//                 child: widget.customWidget,
//               ),
//     );
//   }
// }

// class CustomSelectDropdownItem {
//   final dynamic value;
//   final String name;

//   CustomSelectDropdownItem({required this.value, required this.name});
// }
