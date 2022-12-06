import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_bakarbatu/core/util/routes.dart';
import 'package:new_bakarbatu/db/models/contribution_article_model.dart';
import 'package:new_bakarbatu/features/authentication/presentation/bloc/bloc/authentication_bloc.dart';
import 'package:new_bakarbatu/features/contribution/data/models/article_response.dart';
import 'package:new_bakarbatu/features/contribution/presentation/bloc/article/article_bloc.dart';
import 'package:new_bakarbatu/features/contribution/presentation/bloc/bottom_nav/bottom_nav_bloc.dart';
import 'package:new_bakarbatu/features/contribution/presentation/pages/detail_video.dart';
import 'package:new_bakarbatu/features/contribution/presentation/pages/widget/article_basic.dart';
import 'package:new_bakarbatu/features/contribution/presentation/pages/widget/article_foto.dart';
import 'package:new_bakarbatu/features/contribution/presentation/pages/widget/article_local.dart';
import 'package:new_bakarbatu/features/contribution/presentation/pages/widget/article_online.dart';
import 'package:new_bakarbatu/features/contribution/presentation/pages/widget/article_video.dart';
import 'package:new_bakarbatu/features/contribution/presentation/pages/widget/article_voicerec.dart';

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
                child: Column(children: [
                  Container(
                    color: Colors.black,
                    height: MediaQuery.of(context).viewPadding.top,
                  ),
                  const SizedBox(height: 35,),
                  _createCardProfile(),
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
                  )
                ]),
              ),
              bottomNavigationBar: _createBottomNavBar(state),
            );
          },
        )
    );
  }

  _buildTabPage() {
    return const TabBarView(
      children: <Widget>[
        ArticleLocal(),
        ArticleOnline()
      ],
    );
  }

  Widget _createCardProfile() {
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
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Nama Lengkap'),
                    ),
                    const SizedBox(height: 6),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Jl. Kawi Raya No.18, RT.6/RW.2, Guntur, Kecamatan Setiabudi, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12980',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: (){
                        print('PRESSED');
                        BlocProvider.of<AuthenticationBloc>(context).add(AuthLogout());
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.exit_to_app),
                          Text('Logout')
                        ],
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

  Widget _itemMenus({
    required Color colors,
    required String image,
    required double size,
    required Function() pressed
  }) {
    return GestureDetector(
      onTap: pressed,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: colors
        ),
        width: 50,
        child: Center(
          child: Image.asset(image, width: size, color: const Color.fromARGB(255, 142, 0, 0),),
        ),
      ),
    );
  }

  Widget _createBottomNavBar(BottomNavState state) {
    return Container(
      color: state.idMenu == 2 ? const Color(0xFF800000) : Colors.white,
      height: 96,
      child: Stack(
        children: [
          /// UNACTIVE MENU
          Column(
            children: [
              const SizedBox(height: 30,),
              Container(
                height: 66,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                    color: Colors.grey
                ),
                child: Container(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _itemMenus(
                          colors: state.idMenu == 0 ? const Color(0xFFFFFFFF) : const Color(0xFFD0D0D0),
                          image: 'assets/icons/ic_article.png',
                          size: 19.0,
                          pressed: () {
                            BlocProvider.of<BottomNavBloc>(context).add(ChangeBottomNav(
                                statusMenu: true,
                                idMenu: 0
                            ));
                          }
                      ),
                      const SizedBox(width: 16,),
                      _itemMenus(
                          colors: state.idMenu == 1 ? const Color(0xFFFFFFFF) : const Color(0xFFD0D0D0),
                          image: 'assets/icons/ic_mic.png',
                          size: 20.0,
                          pressed: () {
                            BlocProvider.of<BottomNavBloc>(context).add(ChangeBottomNav(
                                statusMenu: true,
                                idMenu: 1
                            ));
                          }
                      ),
                      const SizedBox(width: 16,),
                      const SizedBox(width: 50,),
                      const SizedBox(width: 16,),
                      _itemMenus(
                          colors: state.idMenu == 3 ? const Color(0xFFFFFFFF) : const Color(0xFFD0D0D0),
                          image: 'assets/icons/ic_fotoimage.png',
                          size: 20.0,
                          pressed: () {
                            BlocProvider.of<BottomNavBloc>(context).add(ChangeBottomNav(
                                statusMenu: true,
                                idMenu: 3
                            ));
                          }
                      ),
                      const SizedBox(width: 16,),
                      _itemMenus(
                          colors: state.idMenu == 4 ? const Color(0xFFFFFFFF) : const Color(0xFFD0D0D0),
                          image: 'assets/icons/ic_video.png',
                          size: 20.0,
                          pressed: () {
                            BlocProvider.of<BottomNavBloc>(context).add(ChangeBottomNav(
                                statusMenu: true,
                                idMenu: 4
                            ));
                          }
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          /// ACTIVE MENU
          Container(
              padding: const EdgeInsets.only(bottom: 26),
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: (){
                  BlocProvider.of<BottomNavBloc>(context).add(ChangeBottomNav(
                      statusMenu: true,
                      idMenu: 2
                  ));
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: state.idMenu == 2 ? const Color(0xFFFFFFFF) : const Color(0xFFD0D0D0),
                      border: Border.all(width: 5, color: state.idMenu == 2 ? const Color(0xFF800000) : Colors.white)
                  ),
                  width: 70,
                  child: Center(
                    child: Image.asset(
                      'assets/icons/ic_home.png',
                      width: 40,
                      color: const Color(0xFF800000),
                    ),
                  ),
                ),
              )
          )
        ],
      ),
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

  Widget _boxItemArticleOnline(DataNewsroom dataNewsroom) {
    return Container(
      color: const Color(0xFF800000),
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
              child: Image.network('${dataNewsroom.articleUrl}')
          ),
          const SizedBox(height: 1),
          Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 8),
                  child: Text('${dataNewsroom.title}', style: const TextStyle(color: Colors.black54, fontSize: 18, fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10, bottom: 10),
                  child: Text(dataNewsroom.nameEditor ?? 'Private Author', style: const TextStyle(color: Colors.black54),),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10, bottom: 10),
                    child: Row(
                      children: [
                        Text('${dataNewsroom.saved}', style: const TextStyle(color: Color(0xFFC7C7C7)),),
                        const SizedBox(width: 8,),
                        Text('${dataNewsroom.categoryName}', style: const TextStyle(color: Color(0xFFC7C7C7)),),
                      ],
                    )
                ),
                // Padding(
                //     padding: const EdgeInsets.only(left: 20, right: 10, bottom: 10),
                //     child: Row(
                //       children: [
                //         Expanded(
                //           child: Text('${dataNewsroom.} - ${contributionArticle.tagKampung} - ${contributionArticle.tagKabupaten}', style: const TextStyle(color: Color(0xFFC7C7C7)),),
                //         )
                //       ],
                //     )
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10, bottom: 10),
                  child: Text('${dataNewsroom.description}', style: const TextStyle(color: Colors.black54)),
                ),
                const SizedBox(height: 8,),
              ],
            ),
          ),
          const SizedBox(height: 20,)
        ],
      ),
    );
  }

  Widget _pageTwo() {
    return BlocBuilder<ArticleBloc, ArticleState>(
      bloc: BlocProvider.of<ArticleBloc>(context)..add(GetArticle(statusArticle: 1)),
      builder: (context, state){
        if(state.status.isLoading){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }else{
          if(state.articleOnline != null && state.articleOnline!.isNotEmpty){
            return Container(
              color: const Color(0xFF800000),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: state.articleOnline!.length,
                itemBuilder: (context, index){
                  return _boxItemArticleOnline(state.articleOnline![index]);
                },
              ),
            );
          }else{
            return Container(
              color: const Color(0xFF800000),
              child: const Center(
                child: Text("Empty Data"),
              ),
            );
          }
        }
      },
    );
  }

}
