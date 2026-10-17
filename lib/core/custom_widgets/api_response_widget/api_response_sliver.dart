import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../enum/cubit_state/cubit_status.dart';
import '../../network/connectivity/connectivity_cubit.dart';
import '../custom_loading/custom_loading.dart';
import '../exception_widget/exception_widget.dart';
import '../no_data_widget/no_data_widget.dart';
import '../offline_widget/offline_widget.dart';

class ApiResponseSliver extends StatelessWidget {
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

  const ApiResponseSliver({
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
          return SliverToBoxAdapter(child: child);
        } else {
          return const SliverToBoxAdapter(child: SizedBox());
        }

      case CubitStatus.loading:
        return loadingWidget != null
            ? SliverToBoxAdapter(child: loadingWidget)
            : SliverToBoxAdapter(
                child: Center(
                  child: CustomLoading(size: loadingSize, color: loadingColor),
                ),
              );

      case CubitStatus.success:
        if (isEmpty) {
          return emptyWidget != null
              ? SliverToBoxAdapter(child: emptyWidget)
              : SliverToBoxAdapter(
                  child: Center(
                    child: NoDataWidget(message: noDataMessage, axis: axis),
                  ),
                );
        } else {
          return child;
        }

      case CubitStatus.failure:
        final isOffline =
            context.read<ConnectivityCubit>().state == ConnectivityStatus.disconnected;
        if (isOffline) {
          return SliverToBoxAdapter(
            child: Center(
              child: offlineWidget ?? OfflineWidget(onReload: onReload, axis: axis),
            ),
          );
        }
        return errorWidget != null
            ? SliverToBoxAdapter(child: errorWidget)
            : SliverToBoxAdapter(
                child: Center(
                  child: ExceptionWidget(message: exceptionMessage, axis: axis, onReload: onReload),
                ),
              );
    }
  }
}
