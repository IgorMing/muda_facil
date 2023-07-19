import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/src/utils/constants.dart';
import 'package:muda_facil/src/utils/ui.dart';

class OrderCard extends ConsumerWidget {
  const OrderCard({
    super.key,
    required this.clickable,
    required this.content,
    this.clipboardMessage,
    this.onTap,
  });

  final bool clickable;
  final Function()? onTap;
  final Widget content;
  final String? clipboardMessage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      shape: _roundedRectangleBorder,
      child: InkWell(
        splashColor: Theme.of(context).colorScheme.primary,
        onLongPress: () {
          if (clipboardMessage == null || clipboardMessage!.isEmpty) return;

          Clipboard.setData(ClipboardData(
            text: clipboardMessage!,
          ));
          UIUtils.of(context).showSnackBar(
              'Texto de oferta copiado com sucesso!',
              success: true);
        },
        onTap: () {
          if (!clickable || onTap == null) return;
          onTap!();
        },
        customBorder: _roundedRectangleBorder,
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: content,
        ),
      ),
    );
  }
}

const _roundedRectangleBorder = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(kDefaultPadding)),
);

Color getColorByStatus(BuildContext context, {required OrderStatus status}) {
  final colorScheme = Theme.of(context).colorScheme;

  switch (status) {
    case OrderStatus.waitingDriver:
    case OrderStatus.waitingPayment:
      return kWarningColor;
    case OrderStatus.helpNeeded:
    case OrderStatus.declined:
      return colorScheme.error;
    case OrderStatus.waitingApproval:
    case OrderStatus.approved:
    case OrderStatus.pending:
      return kSuccessColor;
  }
}
