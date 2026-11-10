import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routes/routes_name.dart';

import '../../../data/model/owner_package.dart';
import '../../controller/owner_packages_cubit.dart';
import 'owner_package_card.dart';

class OwnerPackagesSliverList extends StatelessWidget {
  const OwnerPackagesSliverList({super.key});

  static const _cardsGap = SizedBox(height: 9);

  Future<void> _openDetails(BuildContext context, OwnerPackage package) async {
    final cubit = context.read<OwnerPackagesCubit>();
    final selectedId = await context.pushNamed<String>(
      RouteNames.ownerPackageDetails,
      extra: package,
    );
    if (selectedId == null || cubit.isClosed) return;
    cubit.selectPackage(selectedId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<OwnerPackagesCubit, OwnerPackagesState, List<OwnerPackage>>(
      selector: (state) => state.packages,
      builder: (context, packages) => SliverList.separated(
        itemCount: packages.length,
        separatorBuilder: (_, _) => _cardsGap,
        itemBuilder: (context, index) {
          final package = packages[index];
          return BlocSelector<OwnerPackagesCubit, OwnerPackagesState, bool>(
            key: ValueKey(package.id),
            selector: (state) => state.isSelected(package.id),
            builder: (context, isSelected) => OwnerPackageCard(
              package: package,
              isSelected: isSelected,
              onSelect: () => context.read<OwnerPackagesCubit>().selectPackage(package.id),
              onView: () => _openDetails(context, package),
            ),
          );
        },
      ),
    );
  }
}
