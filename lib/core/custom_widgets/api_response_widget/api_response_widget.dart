import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../custom_widgets/offline_widget/offline_widget.dart';
import '../../network/connectivity/connectivity_cubit.dart';
import '../../enum/cubit_state/cubit_status.dart';
import '../custom_loading/custom_loading.dart';
import '../exception_widget/exception_widget.dart';
import '../no_data_widget/no_data_widget.dart';

class ApiResponseWidget extends StatelessWidget {
  final CubitStatus cubitState;
  final Widget child;
  final double loadingSize;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final Widget? emptyWidget;
  final Widget? unauthorizedWidget;
  final Widget? offlineWidget;
  final bool isEmpty;
  final bool initialChild;
  final void Function()? onReload;
  final Axis axis;
  final String? noDataMessage;
  final String? exceptionMessage;
  final Color? loadingColor;
  const ApiResponseWidget({
    super.key,
    required this.cubitState,
    required this.child,
    required this.onReload,
    required this.isEmpty,
    this.loadingSize = 35,
    this.loadingWidget,
    this.axis = Axis.vertical,
    this.noDataMessage,
    this.exceptionMessage,
    this.errorWidget,
    this.emptyWidget,
    this.offlineWidget,
    this.loadingColor,
    this.unauthorizedWidget,
    this.initialChild = false,
  });

  @override
  Widget build(BuildContext context) {
    switch (cubitState) {
      case CubitStatus.initial:
        if (initialChild) {
          return child;
        } else {
          return const SizedBox();
        }
      case CubitStatus.loading:
        return loadingWidget ??
            Center(
              child: CustomLoading(size: loadingSize, color: loadingColor),
            );
      case CubitStatus.success:
        if (isEmpty) {
          return emptyWidget ??
              Center(child: NoDataWidget(message: noDataMessage, axis: axis));
        } else {
          return child;
        }
      case CubitStatus.failure:
        final isOffline =
            context.read<ConnectivityCubit>().state == ConnectivityStatus.disconnected;
        if (isOffline) {
          return Center(
            child: offlineWidget ?? OfflineWidget(onReload: onReload, axis: axis),
          );
        }
        return errorWidget ??
            Center(
              child: ExceptionWidget(
                message: exceptionMessage,
                axis: axis,
                onReload: onReload,
              ),
            );
    }
  }
}
