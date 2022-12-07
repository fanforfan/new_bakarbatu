import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_bakarbatu/shared/common/key_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../authentication/presentation/bloc/bloc/authentication_bloc.dart';

class CardProfile extends StatefulWidget {
  const CardProfile({Key? key}) : super(key: key);

  @override
  State<CardProfile> createState() => _CardProfileState();
}

class _CardProfileState extends State<CardProfile> {

  SharedPreferences? prefs;
  var nama;
  var alamat;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initPrefs();
  }

  void _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      nama = prefs?.getString(KeyPreferenches.username);
      alamat = '${prefs?.getString(KeyPreferenches.kelurahan)}-${prefs?.getString(KeyPreferenches.kecamatan)}-${prefs?.getString(KeyPreferenches.kabupaten)}-${prefs?.getString(KeyPreferenches.provinsi)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 0.5),
            blurRadius: 0.1,
            spreadRadius: 0.1,
            color: Color(0xFF454544),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 10,),
              Expanded(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('$nama'),
                    ),
                    const SizedBox(height: 6),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '$alamat',
                        style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: (){
                        BlocProvider.of<AuthenticationBloc>(context).add(AuthLogout());
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 6, bottom: 6),
                        margin: EdgeInsets.only(right: 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.deepOrange
                        ),
                        child: Row(
                          children: const [
                            SizedBox(width: 20,),
                            Icon(Icons.exit_to_app, size: 15, color: Colors.white,),
                            SizedBox(width: 6,),
                            Text('Logout', style: TextStyle(color: Colors.white, fontSize: 10),)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 20,),
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  'assets/images/profile.jpeg',
                  height: 100.0,
                  width: 100.0,
                ),
              ),
              const SizedBox(width: 10,),
            ],
          )
        ],
      ),
    );
  }
}
