import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routes/routes_name.dart';
import 'broker_form_footer.dart';

class BrokerBusinessContactFooter extends StatelessWidget {
  const BrokerBusinessContactFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return BrokerFormFooter(
      isEnabled: true,
      onContinue: () => context.pushNamed(RouteNames.brokerDocuments),
    );
  }
}
