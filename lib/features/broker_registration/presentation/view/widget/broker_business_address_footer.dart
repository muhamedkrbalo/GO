import 'package:flutter/material.dart';

import 'broker_form_footer.dart';

class BrokerBusinessAddressFooter extends StatelessWidget {
  const BrokerBusinessAddressFooter({super.key});

  void _continue(BuildContext context) {
   // Form.of(context).validate();
  }

  @override
  Widget build(BuildContext context) {
    return BrokerFormFooter(isEnabled: true, onContinue: () => _continue(context));
  }
}
