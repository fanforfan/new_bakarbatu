import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_bakarbatu/core/util/routes.dart';
import 'package:new_bakarbatu/features/authentication/presentation/bloc/bloc/authentication_bloc.dart';
import 'package:new_bakarbatu/features/authentication/presentation/bloc/cubit_password/obsecure_password_cubit.dart';
import 'package:new_bakarbatu/shared/widgets/reguler_button.dart';
import 'package:new_bakarbatu/shared/widgets/reguler_text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBoddy(context),
    );
  }

  buildBoddy(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if(state.message == 'Success'){
          Navigator.pushReplacementNamed(context, Routes.contributionRoute);
        }
      },
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
                _createStatementError(),
                const SizedBox(height: 16),
                _createUsernameField(),
                const SizedBox(height: 16),
                _ctreatePasswordField(),
                _createForgotPasswordAction(),
                const SizedBox(height: 18),
                _createButtonLogin(state),
                const SizedBox(height: 18),
                _createRegisterTextButton()
              ],
            ),
          ),
        );
      },
    );
  }

  validateToLogin(BuildContext context, String? username, String? password) {
    BlocProvider.of<AuthenticationBloc>(context).add(
        AuthLoginEvent(username: username ?? '', password: password ?? ''));
  }

  Widget _createUsernameField() {
    return RegulerTextFormField(
        obsecure: false,
        inputDecoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          labelText: 'Username',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onChanged: (value) {
          BlocProvider.of<AuthenticationBloc>(context)
              .add(TextFieldChanged(keyField: 'Username', value: value));
        });
  }

  Widget _ctreatePasswordField() {
    return BlocBuilder<ObsecurePasswordCubit, ObsecurePasswordState>(
        bloc: BlocProvider.of<ObsecurePasswordCubit>(context)..changeObsecurePassword(val: false),
        builder: (context, state){
          if(state is ChangeObsecureStatus){
            return RegulerTextFormField(
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
                onChanged: (value) {
                  BlocProvider.of<AuthenticationBloc>(context).add(TextFieldChanged(keyField: 'Password', value: value));
                });
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
      onPressed: () => validateToLogin(context, state.username, state.password),
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

  Widget _createStatementError() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state.status.isError) {
          return Text(
            '${state.message}',
            style: const TextStyle(color: Colors.red, fontSize: 10),
          );
        } else if (state.status.isSuccess) {
          return Text('${state.message}',
              style: const TextStyle(color: Colors.red, fontSize: 10));
        }
        return const SizedBox();
      },
    );
  }
}
