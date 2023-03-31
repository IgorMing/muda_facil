const double kDefaultPadding = 16.0;
const int kDefaultMaxLines = 4;

enum OrderStatus {
  pending,
  declined,
  helpNeeded,
  waitingDriver,
  waitingApproval,
  waitingPaymentCode,
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
    case 'waitingPaymentCode':
      return 'Aguarde código pix para pagamento';
    case 'waitingPayment':
      return 'Aguardando pagamento';
    case 'approved':
      return 'Aprovado';
    case 'pending':
    default:
      return 'Pendente';
  }
}
