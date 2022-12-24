import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instameal/views/checkout/constants.dart';
import 'package:instameal/views/checkout/server_stub.dart';
import 'package:instameal/views/subscription/trial_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

void redirectToCheckout(BuildContext context) async {
  final sessionId = await Server().createCheckout();
  Navigator.of(context).push(MaterialPageRoute(
    builder: (_) => CheckoutPage(sessionId: sessionId),
  ));
}

class CheckoutPage extends StatefulWidget {
  final String sessionId;

  const CheckoutPage({Key key, this.sessionId}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WebView(
        initialUrl: initialUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (webViewController) =>
            _webViewController = webViewController,
        onPageFinished: (String url) {
          if (url == initialUrl) {
            _redirectToStripe(widget.sessionId);
          }
        },
        navigationDelegate: (NavigationRequest request) {
          print("moizata url");
          print(request.url);
          if (request.url.contains('success')) {
            print("success");
            Navigator.pushReplacement<void, void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => SuccessPage(),
              ),
            );
          } else if (request.url.contains('cancel')) {
            print("faol;ed");

            Navigator.pushReplacement<void, void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => SuccessPage(),
              ),
            );
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }

  String get initialUrl => 'https://buy.stripe.com/test_aEUdUPg3i2c6fAIdQQ';

  Future<void> _redirectToStripe(String sessionId) async {
    final redirectToCheckoutJs =
        '''
var stripe = Stripe(\'$apiKey\');
    
stripe.redirectToCheckout({
  sessionId: '$sessionId'
}).then(function (result) {
  result.error.message = 'Error'
});
''';

    try {
      await _webViewController
          .runJavascriptReturningResult(redirectToCheckoutJs);
      // evaluateJavascript(redirectToCheckoutJs);
    } on PlatformException catch (e) {
      if (!e.details.contains(
          'JavaScript execution returned a result of an unsupported type')) {
        rethrow;
      }
    }
  }
}
