import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_bakarbatu/features/contribution/presentation/bloc/count_cubit/count_cubit.dart';
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
  var gender;

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
      alamat = '${prefs?.getString(KeyPreferenches.nameKomunitas)}';
      gender = prefs?.getString(KeyPreferenches.gender);
      // '${prefs?.getString(KeyPreferenches.kelurahan)}-${prefs?.getString(KeyPreferenches.kecamatan)}-${prefs?.getString(KeyPreferenches.kabupaten)}-${prefs?.getString(KeyPreferenches.provinsi)}';
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
      ),
      child: Column(
        children: [
          _boxIdentityUser(),
          const SizedBox(height: 20,),
          _boxValueSummarySubmit(),
          _boxLabelSummarySubmit()
        ],
      ),
    );
  }

  Widget _boxLabelSummarySubmit() {
    return Row(
      children: const [
        SizedBox(width: 10,),
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Text('Total Konten', style: TextStyle(color: Colors.blue, fontSize: 11, fontWeight: FontWeight.bold),),
          ),
        ),
        SizedBox(width: 10,),
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Text('Approve', style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold),),
          ),
        ),
        SizedBox(width: 10,),
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Text('Waiting Editor', style: TextStyle(color: Colors.red, fontSize: 11, fontWeight: FontWeight.bold),),
          ),
        ),
        SizedBox(width: 10,),
      ],
    );
  }

  Widget _boxValueSummarySubmit() {
    return BlocBuilder<CountCubit, CountState>(
      bloc: BlocProvider.of<CountCubit>(context)..getCount(),
      builder: (context, state){
        return state.status.isLoading ? const CircularProgressIndicator() : Row(
          children: [
            const SizedBox(width: 10,),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text('${state.totalDataSubmit}',style: const TextStyle(color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(width: 10,),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text('${state.approved}', style: const TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(width: 10,),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text('${state.waiting}', style: const TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(width: 10,),
          ],
        );
      },
    );
  }

  Widget _boxIdentityUser() {
    return Row(
      children: [
        const SizedBox(width: 10,),
        Expanded(
          flex: 2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: gender == '1' ? Image.asset(
              'assets/icons/ic_male.png',
            ) : gender == '2' ? Image.asset(
              'assets/icons/ic_female.png',
            ) : Image.asset(
              'assets/icons/ic_transgender.png',
            ),
          ),
        ),
        const SizedBox(width: 20,),
        Expanded(
          flex: 3,
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '$nama',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    // color: Colors.grey
                  ),),
              ),
              const SizedBox(height: 6),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '$alamat',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    // color: Colors.grey
                  ),
                ),
              ),
              const SizedBox(height: 6),
              // MaterialButton(
              //   onPressed: (){
              //     BlocProvider.of<AuthenticationBloc>(context).add(AuthLogout());
              //   },
              //   child: Row(
              //     children: [
              //       Container(
              //         height: 30,
              //         width: 30,
              //         decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(15),
              //             color: Colors.red
              //         ),
              //         child: Icon(Icons.power_off, size: 20, color: Colors.white,),
              //       ),
              //       SizedBox(width: 6,),
              //       Text('Logout', style: TextStyle(color: Colors.deepOrange, fontSize: 10),)
              //     ],
              //   ),
              // )
            ],
          ),
        ),
        const SizedBox(width: 10,),
      ],
    );
  }
}
