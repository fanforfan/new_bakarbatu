import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_bakarbatu/core/util/routes.dart';
import 'package:new_bakarbatu/features/authentication/presentation/bloc/bloc/authentication_bloc.dart';
import 'package:new_bakarbatu/features/contribution/presentation/bloc/bottom_nav/bottom_nav_bloc.dart';
import 'package:new_bakarbatu/features/contribution/presentation/pages/widget/article_basic.dart';
import 'package:new_bakarbatu/features/contribution/presentation/pages/widget/article_foto.dart';
import 'package:new_bakarbatu/features/contribution/presentation/pages/widget/article_local.dart';
import 'package:new_bakarbatu/features/contribution/presentation/pages/widget/article_online.dart';
import 'package:new_bakarbatu/features/contribution/presentation/pages/widget/article_video.dart';
import 'package:new_bakarbatu/features/contribution/presentation/pages/widget/article_voicerec.dart';
import 'package:new_bakarbatu/features/contribution/presentation/pages/widget/bottom_navbar.dart';
import 'package:new_bakarbatu/features/contribution/presentation/pages/widget/card_profile.dart';

class ContributionPage extends StatefulWidget {
  const ContributionPage({super.key});

  @override
  State<ContributionPage> createState() => _ContributionPageState();
}

class HeaderTab {
  final String title;
  final String image;

  HeaderTab(this.title, this.image);
}

class _ContributionPageState extends State<ContributionPage>
    with SingleTickerProviderStateMixin {

  List<HeaderTab> headTabs = [
    HeaderTab('', 'assets/icons/ic_home.png'),
    HeaderTab('', 'assets/icons/ic_folder.png'),
  ];

  var isiList;

  @override
  void initState() {
    BlocProvider.of<BottomNavBloc>(context).add(ChangeBottomNav(
      statusMenu: true,
      idMenu: 2
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if(state.logoutSuccess != null){
                  if(state.logoutSuccess!){
                    Navigator.pushNamedAndRemoveUntil(context, Routes.initialPage, (route) => false);
                  }else{
                    debugPrint('Logout gagal');
                  }
                }
              })
        ],
        child: BlocBuilder<BottomNavBloc, BottomNavState>(
          builder: (context, state){
            return Scaffold(
              backgroundColor: const Color.fromARGB(255, 142, 0, 0),
              body: DefaultTabController(
                initialIndex: 0,
                length: 2,
                child: Stack(
                  children: [
                    Column(children: [
                      Container(
                        color: Colors.black,
                        height: MediaQuery.of(context).viewPadding.top,
                      ),
                      const SizedBox(height: 35,),
                      const CardProfile(),
                      const SizedBox(height: 35,),
                      state.idMenu == 2 ? Container(
                        padding: const EdgeInsets.only(left: 50),
                        alignment: Alignment.centerLeft,
                        child: const Text('Your Contribution', style: TextStyle(fontWeight: FontWeight.bold, color: Color(
                            0xFFC6C6C6)),),
                      ) : const SizedBox(),
                      state.idMenu == 2 ? const SizedBox(height: 16,) : const SizedBox(),
                      state.idMenu == 2 ? _createTabBar() : const SizedBox(),
                      Expanded(
                        child: state.idMenu == 0 ? const ArticleBasic()
                            : state.idMenu == 1 ? const ArticleVoiceRec()
                            : state.idMenu == 2 ? _buildTabPage()
                            : state.idMenu == 3 ? const ArticleFoto()
                            : const ArticleVideo(),
                      ),
                    ]),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: BottomNavbar(state: state),
                    )
                  ],
                ),
              ),
              // bottomNavigationBar: BottomNavbar(state: state),
            );
          },
        )
    );
  }

  Widget _buildTabPage() {
    return const TabBarView(
      children: <Widget>[
        ArticleLocal(),
        ArticleOnline()
      ],
    );
  }

  Widget _createTabBar() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: Color(0xFF800000),
      ),
      child: TabBar(
          indicatorColor: const Color.fromARGB(255, 255, 255, 255),
          labelColor: const Color.fromARGB(255, 255, 255, 255),
          tabs: headTabs.map((e) => Tab(
            icon: Image.asset(e.image, width: 30, color: const Color.fromARGB(
                255, 255, 255, 255),),
          )).toList()
      ),
    );
  }

}
