import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_bakarbatu/core/util/routes.dart';
import 'package:new_bakarbatu/features/authentication/presentation/bloc/bloc/authentication_bloc.dart';
import 'package:new_bakarbatu/features/authentication/presentation/bloc/cubit_email/email_cubit.dart';
import 'package:new_bakarbatu/features/authentication/presentation/bloc/cubit_password/obsecure_password_cubit.dart';
import 'package:new_bakarbatu/features/contribution/presentation/pages/contribution_page.dart';
import 'package:new_bakarbatu/shared/widgets/reguler_button.dart';
import 'package:new_bakarbatu/shared/widgets/reguler_text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<AuthenticationBloc>(context).stream.listen((state) {
      if (state.status.isSuccess) {
        Navigator.pushReplacementNamed(context, Routes.contributionRoute);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: buildBoddy(context)
    );
  }

  buildBoddy(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  Image.asset(
                    'assets/images/login_illustration.png',
                    width: 300,
                  ),
                  // _createStatementError(),
                  const SizedBox(height: 16),
                  _createUsernameField(),
                  const SizedBox(height: 10),
                  _createErrorMessageEmail(),
                  const SizedBox(height: 16),
                  _ctreatePasswordField(),
                  _createForgotPasswordAction(),
                  const SizedBox(height: 18),
                  _createErrorMessage(state),
                  const SizedBox(height: 8),
                  _createButtonLogin(state),
                  const SizedBox(height: 18),
                  // _createRegisterTextButton()
                ],
              ),
            ),
          );
        }
    );
  }

  Widget _createUsernameField() {
    return RegulerTextFormField(
        controller: usernameController,
        obsecure: false,
        inputDecoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          labelText: 'Username',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onChanged: (value) {
          BlocProvider.of<EmailCubit>(context).validateEmail(val: '$value');
        },
    );
  }

  Widget _ctreatePasswordField() {
    return BlocBuilder<ObsecurePasswordCubit, ObsecurePasswordState>(
        bloc: BlocProvider.of<ObsecurePasswordCubit>(context)..changeObsecurePassword(val: false),
        builder: (context, state){
          if(state is ChangeObsecureStatus){
            return RegulerTextFormField(
                controller: passwordController,
                obsecure: state.isObsecure,
                inputDecoration: InputDecoration(
                    prefixIcon: const Icon(Icons.key),
                    labelText: 'Password',
                    suffixIcon: GestureDetector(
                      onTap: (){
                        BlocProvider.of<ObsecurePasswordCubit>(context).changeObsecurePassword(val: state.isObsecure);
                      },
                      child: Icon(state.isObsecure ? Icons.visibility_off : Icons.visibility),
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
                onChanged: (value) {});
          }
          return SizedBox();
        }
    );
  }

  Widget _createForgotPasswordAction() {
    return Align(
      alignment: Alignment.centerRight,
      child: MaterialButton(
        onPressed: () {},
        child: const Text(
          'Forgot password?',
          style: TextStyle(fontSize: 10, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _createButtonLogin(AuthenticationState state) {
    if (state.status.isLoading) {
      return const CircularProgressIndicator(
          color: Color.fromARGB(255, 254, 3, 3));
    }
    return RegulerButton(
        childWidget: MaterialButton(
      child: const Text(
        'Login',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () => BlocProvider.of<AuthenticationBloc>(context).add(AuthLoginEvent(username: usernameController.text ?? '', password: passwordController.text ?? '')),
    ));
  }

  Widget _createRegisterTextButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Don\'t have an account?  ',
          style: TextStyle(fontSize: 10, color: Colors.blueGrey),
        ),
        GestureDetector(
          onTap: () {},
          child: const Text(
            'Register',
            style: TextStyle(fontSize: 10, color: Colors.blue),
          ),
        )
      ],
    );
  }

  Widget _createErrorMessage(AuthenticationState state) {
    return state.message != null ? Text('${state.message}', style: const TextStyle(color: Colors.red),) : SizedBox();
  }

  Widget _createErrorMessageEmail() {
    
    return BlocBuilder<EmailCubit, EmailState>(
        builder: (context, state){
          if(state is ValidateEmail){
            return (state.message != '')
                ?
            Container(
              padding: const EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              child:  Text(state.message, style: const TextStyle(color: Colors.red, fontSize: 12),),
            )
                : const SizedBox();
          }
          return const SizedBox();
        });
  }

  // Widget _createStatementError() {
  //   return BlocBuilder<AuthenticationBloc, AuthenticationState>(
  //     builder: (context, state) {
  //       if (state.status.isError) {
  //         print('SINI 1');
  //         return Text(
  //           '${state.message}',
  //           style: const TextStyle(color: Colors.red, fontSize: 10),
  //         );
  //       }
  //       return const SizedBox();
  //     },
  //   );
  // }
}
