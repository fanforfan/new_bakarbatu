import 'package:http/http.dart' as http;
abstract class HomeRemoteDatasources {
  Future goToWebView(String? urlWebView);
}

class HomeRemoteDatasourcesImpl implements HomeRemoteDatasources {
  final http.Client client;

  HomeRemoteDatasourcesImpl({required this.client});

  // @override
  // Future<AuthenticationDataEntity>? validateLogin(AuthenticationLoginRequest paramLogin) async {

  //   var response = {
  //     'username' : 'fandis',
  //     'password' : 'test',
  //     'full_name' : 'Fandi Sujatmiko'
  //   };

  //   if(response['username'] != paramLogin.username){
  //     return const AuthenticationDataEntity(
  //       message: 'Username salah',
  //       error: true
  //     );
  //   }else if(response['password'] != paramLogin.password){
  //     return const AuthenticationDataEntity(
  //       message: 'Password salah',
  //       error: true
  //     );
  //   }else{
  //     return AuthenticationDataEntity(
  //       username: response['username'],
  //       password: response['password'],
  //       fullname: response['full_name'],
  //       error: false,
  //       message: 'Login success'
  //     );
  //   }

  //   // TODO: implement validateLogin
  //   // final response = await client.post(
  //   //   Uri.parse('http://url_login.com'), 
  //   //   body: paramLogin
  //   // );

  //   // if(response.statusCode == 200){
  //   //   return AuthLoginModel.fromJson(json.decode(response.body));
  //   // }else{
  //   //   throw ServerException();
  //   // }
  // }

  // @override
  // Future<AuthenticationDataEntity>? validateRegister(AuthenticationregisterRequest paramsRegister) async {
  //   // TODO: implement validateRegister
  //   final response = await client.post(
  //     Uri.parse('http://url_register.com'), 
  //     body: paramsRegister
  //   );

  //   if(response.statusCode == 200){
  //     return AuthLoginModel.fromJson(json.decode(response.body));
  //   }else{
  //     throw ServerException();
  //   }
  // }
  
  @override
  Future goToWebView(String? urlWebView) {
    // TODO: implement goToWebView
    throw UnimplementedError();
  }

}