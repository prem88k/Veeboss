// import 'package:flutter/material.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// class RazorpayCart extends StatefulWidget {
//   const RazorpayCart({Key? key}) : super(key: key);
//
//   @override
//   State<RazorpayCart> createState() => _RazorpayCartState();
// }
//
// class _RazorpayCartState extends State<RazorpayCart> {
//
//   late RazorpayCart _razorpay;
//
//
//   @override
//   void initState() {
//     super.initState();
//     _razorpay = RazorpayCart();
//        _razorpay.on(RazorpayCart.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//        _razorpay.on(RazorpayCart.EVENT_PAYMENT_ERROR, _handlePaymentError);
//        _razorpay.on(RazorpayCart.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//    // _razorpay.clear();
//   }
//
//
//   void openCheckout() async {
//     var options = {
//       'key': 'rzp_test_guRZN0mT20gHq9',
//       'amount': 28200,
//       'name': 'Shaiq',
//       'description': 'Payment',
//       'prefill': {'contact': '8866482755', 'email': 'falak209@gmail.com'},
//       'external': {
//         'wallets': ['paytm']
//       }
//     };
//
//     try {
//      _razorpay.open(options);
//     } catch (e) {
//      debugPrint(e);
//     }
//   }
//
//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     Fluttertoast.showToast(
//         msg: "SUCCESS: " + response.paymentId!, timeInSecForIosWeb: 4);
//   }
//
//   void _handlePaymentError(PaymentFailureResponse response) {
//     Fluttertoast.showToast(
//         msg: "ERROR: " + response.code.toString() + " - " + response.message!,
//         timeInSecForIosWeb: 4);
//   }
//
//   void _handleExternalWallet(ExternalWalletResponse response) {
//     Fluttertoast.showToast(
//         msg: "EXTERNAL_WALLET: " + response.walletName!, timeInSecForIosWeb: 4);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//     );
//   }
// }
