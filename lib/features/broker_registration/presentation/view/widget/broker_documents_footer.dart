import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routes/routes_name.dart';
import '../../controller/broker_documents_cubit.dart';
import '../../controller/broker_registration_draft_cubit.dart';
import 'broker_form_footer.dart';

class BrokerDocumentsFooter extends StatelessWidget {
  const BrokerDocumentsFooter({super.key});

  void _continue(BuildContext context) {
    context.read<BrokerRegistrationDraftCubit>().saveDocuments(
      context.read<BrokerDocumentsCubit>().state.documents,
    );
    context.pushNamed(RouteNames.brokerReview);
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<BrokerDocumentsCubit, BrokerDocumentsState, bool>(
      selector: (state) => state.canContinue,
      builder: (context, canContinue) => BrokerFormFooter(
        // isEnabled: canContinue,
        isEnabled: true,
        onContinue: () => _continue(context),
        // onContinue: canContinue ? () => _continue(context) : null,
      ),
    );
  }
}
