import 'package:flutter/material.dart';
import 'package:muda_facil/src/utils/constants.dart';
import 'package:muda_facil/src/utils/dialogs.dart';
import 'package:muda_facil/src/utils/general.dart';
import 'package:muda_facil/src/widgets/info_row.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.topText,
    required this.bottomText,
    required this.date,
  });

  final String topText;
  final String bottomText;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: _roundedRectangleBorder,
      child: InkWell(
        splashColor: Theme.of(context).colorScheme.primary,
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => Dialogs.getBugetInfoDialog(
              context,
              onSave: ({
                required budgetValue,
                required driverName,
                required pixCode,
              }) {
                // TODO: call the service here
              },
            ),
          );
        },
        customBorder: _roundedRectangleBorder,
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoRow(
                label: 'De',
                value: topText,
              ),
              const Divider(),
              InfoRow(
                label: 'Para',
                value: bottomText,
              ),
              Center(
                child: InfoRow(
                  label: 'Data',
                  value: GeneralUtils.formatDateFromTimestamp(
                      date.microsecondsSinceEpoch),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

const _roundedRectangleBorder = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(kDefaultPadding)),
);
