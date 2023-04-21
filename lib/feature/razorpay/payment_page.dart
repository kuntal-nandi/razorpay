import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  InputDecoration textInputDecoration = const InputDecoration(
    labelStyle: TextStyle(color: Colors.black),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color:  Color(0xff315bc1),width: 2),
    ),
    enabledBorder:  OutlineInputBorder(
      borderSide: BorderSide(color:  Color(0xff315bc1),width: 2),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color:  Color(0xff315bc1),width: 2),
    ),
    errorBorder:  OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red,width: 2),
    ),
  );
  final TextEditingController _amountController = TextEditingController();
  String amount = '';
  final Razorpay _razorpay = Razorpay();
  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff315bc1),
        title: const Text('Razorpay'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              onChanged: (value){
                setState(() {
                  amount=value;
                });
              },
              keyboardType: TextInputType.number,
              controller: _amountController,
              cursorColor: const Color(0xff315bc1),
              decoration: textInputDecoration.copyWith(
                hintText: 'Enter Amount',
                hintStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                prefixIcon: const Icon(Icons.currency_rupee,size: 30,color:  Color(0xff315be3),)
              )
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: (){
                var options = {
                  'key': 'rzp_test_puPjWuHArCuPCa',
                  'amount': (int.parse(_amountController.text) * 100), // pay amount in in paisa
                  'name': 'test',
                  'description': 'Application demo',
                  'timeout': 300, // in seconds
                  'prefill': {
                    'contact': '8372988806',
                    'email': 'nkuntal555@gmail.com'
                  }
                };
                _razorpay.open(options);
              },
              child: Container(
                color: amount.isEmpty ?  Colors.grey : const Color(0xff315bc1),
                height: 80,
                width: double.infinity,
                alignment: Alignment.center,
                child: Text('Proceed to Pay',style: TextStyle(
                  fontSize: 22,
                  color: amount.isEmpty ?  Colors.white.withOpacity(0.8) : Colors.white,
                  fontWeight: FontWeight.w700
                ),),
              ),
            ),
          )
        ],
      ),
    );
  }
  @override
  void dispose() {
    _razorpay.clear(); // Removes all listeners
    super.dispose();
  }
}

