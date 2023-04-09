import 'package:flutter/material.dart';

const double kDefaultPadding = 16.0;
const int kDefaultMaxLines = 4;
const Color kSuccessColor = Colors.green;
const String kDefaultErrorMessage = 'Algum erro inesperado aconteceu';

enum OrderStatus {
  pending,
  declined,
  helpNeeded,
  waitingDriver,
  waitingApproval,
  waitingPayment,
  approved,
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
