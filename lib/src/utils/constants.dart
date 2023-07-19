import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:muda_facil/src/utils/general.dart';

const Color kPrimaryColor = FlexColor.bahamaBlueDarkPrimaryContainer;
const Color kWarningColor = FlexColor.goldDarkPrimary;
const Color kSuccessColor = Colors.green;
const double kDefaultPadding = 16.0;
const int kDefaultMaxLines = 4;
const String kDefaultErrorMessage = 'Algum erro inesperado aconteceu';
const String pixCodeMOCK =
    '00020126580014BR.GOV.BCB.PIX01366c1c64c0-98e2-46fd-b1de-2c026962984552040000530398654040.015802BR5925IGOR MING DE MESQUITA 3356009SAO PAULO61080540900062250521nzDbULEzx970KKA10iutk630431D2';

enum OrderStatus {
  pending,
  declined,
  helpNeeded,
  waitingDriver,
  waitingApproval,
  waitingPayment,
  approved,
}

enum Role {
  user,
  admin,
  driver,
}

String getMessageToDriver(String from, String to, DateTime date) {
  return 'Bom dia! Temos um novo frete disponível. Será saindo do endereço: $from. Indo para o endereço: $to. A data prevista é: ${GeneralUtils.formatDateFromTimestamp(date.microsecondsSinceEpoch)}. Você teria interesse de fazer este frete? Ou sabe de alguém que possa fazê-lo? Obrigado!';
}

String getOrderStatusLabelByEnumName(String label) {
  switch (label) {
    case 'declined':
      return 'Orçamento recusado';
    case 'waitingDriver':
      return 'Aguardando frete';
    case 'helpNeeded':
      return 'Aguardando ajuda';
    case 'waitingApproval':
      return 'Aguardando aprovação';
    case 'waitingPayment':
      return 'Aguardando pagamento';
    case 'approved':
      return 'Aprovado';
    case 'pending':
    default:
      return 'Pendente';
  }
}
