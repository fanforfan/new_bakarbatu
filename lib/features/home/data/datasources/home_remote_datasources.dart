import 'package:http/http.dart' as http;
abstract class HomeRemoteDatasources {
  Future goToWebView();
}

class HomeRemoteDatasourcesImpl implements HomeRemoteDatasources {
  final http.Client client;

  HomeRemoteDatasourcesImpl({required this.client});
  
  @override
  Future<Uri?> goToWebView() async {
    // TODO: implement goToWebView
    var response = {
      'base_url_webview' : 'https://bakarbatu.id/',
    };

    var urlWebview = Uri.parse("${response['base_url_webview']}");

    return urlWebview;
  }

}