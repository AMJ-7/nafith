import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../presentation/payment/payment_states.dart';
import '../presentation/styles/app_theme.dart';
import 'providers.dart';

extension CurrentTheme on WidgetRef {
  ThemeData get theme => watch(themeProvider);

  void toggleTheme() => read(themeProvider) == getApplicationLightTheme()
      ? read(themeProvider.notifier).state = getApplicationDarkTheme()
      : read(themeProvider.notifier).state = getApplicationLightTheme();
}





extension WillTextOverflow on String {
  bool willTextOverflow(TextStyle style,
      {double minWidth = 0,
      double maxWidth = double.infinity,
      int maxLines = 2}) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: this, style: style),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: minWidth, maxWidth: maxWidth);
    return textPainter.didExceedMaxLines;
  }
}


extension PaymentStatesExtension on WidgetRef {
  PaymentStates get paymentState => watch(paymentStateProvider);

  void setPaymentState(PaymentStates paymentStates) =>
      read(paymentStateProvider.notifier).state = paymentStates;

  bool get isPaymentStateLoading => paymentState is LoadingPaymentState;

  bool get isPaymentStateSuccess => paymentState is SuccessPaymentState;

  bool get isPaymentStateError => paymentState is ErrorPaymentState;
}



