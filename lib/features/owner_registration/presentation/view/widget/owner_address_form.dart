import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../controller/owner_address_cubit.dart';
import 'add_address_button.dart';
import 'address_form_section.dart';
import 'registration_form_card.dart';

class OwnerAddressForm extends StatelessWidget {
  const OwnerAddressForm({super.key});

  static const _buttonPadding = EdgeInsets.fromLTRB(19.2, 0, 19.2, 19.2);
  static const _dividerThickness = 1.6;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return BlocBuilder<OwnerAddressCubit, OwnerAddressState>(
      buildWhen: (previous, current) => !listEquals(previous.ids, current.ids),
      builder: (context, state) {
        final ids = state.ids;
        return RegistrationFormCard(
          children: [
            for (var i = 0; i < ids.length; i++) ...[
              if (i > 0)
                Divider(
                  height: _dividerThickness,
                  thickness: _dividerThickness,
                  color: colors.subtleBorder,
                ),
              AddressFormSection(key: ValueKey(ids[i]), id: ids[i], number: i + 1),
            ],
            Padding(
              padding: _buttonPadding,
              child: AddAddressButton(onPressed: context.read<OwnerAddressCubit>().addAddress),
            ),
          ],
        );
      },
    );
  }
}
