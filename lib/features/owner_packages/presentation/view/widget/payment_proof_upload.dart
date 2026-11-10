import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_widgets/document_upload/upload_dropzone.dart';
import '../../../../../core/custom_widgets/document_upload/uploaded_document_tile.dart';
import '../../../../../core/extension/context_ui_extension.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/models/uploaded_document.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../../../core/utils/document_picker_methods.dart';
import '../../controller/package_payment_cubit.dart';

class PaymentProofUpload extends StatelessWidget {
  const PaymentProofUpload({super.key});

  static const _textHeight = 1.5;

  Future<void> _pick(BuildContext context) async {
    final cubit = context.read<PackagePaymentCubit>();
    final file = await DocumentPickerMethods.pickDocument();
    if (file == null) return;
    if (file.sizeInBytes > DocumentPickerMethods.maxSizeInBytes) {
      if (context.mounted) context.showErrorToast(message: AppLocaleKey.documentTooLarge.tr());
      return;
    }
    if (cubit.isClosed) return;
    cubit.attachProof(
      UploadedDocument(name: file.name, sizeInBytes: file.sizeInBytes, path: file.path),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PackagePaymentCubit, PackagePaymentState, UploadedDocument?>(
      selector: (state) => state.proof,
      builder: (context, proof) {
        if (proof != null) {
          return UploadedDocumentTile(
            document: proof,
            onRemove: context.read<PackagePaymentCubit>().removeProof,
          );
        }
        return UploadDropzone(
          showIcon: false,
          title: AppLocaleKey.uploadPaymentProof.tr(),
          hint: AppLocaleKey.paymentProofFormats.tr(),
          hintStyle: AppTextStyles.xxxxxsMedium.copyWith(
            color: context.customColors.oceanAccent,
            fontWeight: FontWeight.w800,
            height: _textHeight,
          ),
          onTap: () => _pick(context),
        );
      },
    );
  }
}
