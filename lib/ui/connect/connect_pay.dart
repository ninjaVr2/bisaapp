import 'package:bisa_app/models/current_user.dart';
import 'package:bisa_app/providers/current_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:paystack_manager/paystack_manager.dart';

class ConnectPay extends StatefulWidget {
  ConnectPay({Key? key}) : super(key: key);

  @override
  _ConnectPayState createState() => _ConnectPayState();
}

class _ConnectPayState extends State<ConnectPay> {
  late CurrentUser currentUser;
  @override
  Widget build(BuildContext context) {
    currentUser = context.read<CurrentUserProvider>().currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: Text("Paystack Payment"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //initiate payment button
            ElevatedButton(
              onPressed: _processPayment,
              child: Text(
                "Pay",
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _processPayment() {
    try {
      // PaystackPayManager(context: context)
      //   // Don't store your secret key on users device.
      //   // Make sure this is retrive from your server at run time
      //   ..setSecretKey("sk_test_4bc1809fcd590182ee672518e204a0a796acd48b")
      //   //accepts widget
      //   ..setCompanyAssetImage(Image(
      //     image: AssetImage("assets/imgs/bisa_icon.png"),
      //   ))
      //   ..setAmount(1000)
      //   // ..setReference("your-unique-transaction-reference")
      //   ..setReference(DateTime.now().millisecondsSinceEpoch.toString())
      //   ..setCurrency("GHS")
      //   ..setEmail(currentUser.email ?? "Unkown")
      //   ..setFirstName(currentUser.fname ?? "Ambrose")
      //   ..setLastName(currentUser.lname ?? "Bako")
      //   ..setMetadata(
      //     {
      //       "custom_fields": [
      //         {
      //           "value": "Bisa Connect",
      //           "display_name": "Payment to",
      //           "variable_name": "payment_to"
      //         }
      //       ]
      //     },
      //   )
      //   ..onSuccesful(_onPaymentSuccessful)
      //   ..onPending(_onPaymentPending)
      //   ..onFailed(_onPaymentFailed)
      //   ..onCancel(_onPaymentCancelled)
      //   ..initialize();
    } catch (error) {
      print("Payment Error ==> $error");
    }
  }

  // void _onPaymentSuccessful(Transaction transaction) {
  //   print("Transaction was successful");
  //   print("Transaction Message ===> ${transaction.message}");
  //   print("Transaction Refrence ===> ${transaction.refrenceNumber}");
  // }

  // void _onPaymentPending(Transaction transaction) {
  //   print("Transaction is pendinng");
  //   print("Transaction Refrence ===> ${transaction.refrenceNumber}");
  // }

  // void _onPaymentFailed(Transaction transaction) {
  //   print("Transaction failed");
  //   print("Transaction Message ===> ${transaction.message}");
  // }

  // void _onPaymentCancelled(Transaction transaction) {
  //   print("Transaction was cancelled");
  // }
}
