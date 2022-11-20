import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_bakarbatu/db/models/contribution_article_model.dart';
import 'package:new_bakarbatu/features/contribution/presentation/bloc/article/article_bloc.dart';
import 'package:new_bakarbatu/features/contribution/presentation/bloc/bottom_nav/bottom_nav_bloc.dart';
import 'package:new_bakarbatu/features/contribution/presentation/pages/widget/article_basic.dart';
import 'package:new_bakarbatu/features/contribution/presentation/pages/widget/article_foto.dart';
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
    // BlocProvider.of<ArticleBloc>(context).add(GetArticle(statusArticle: 0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBloc, BottomNavState>(
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
    );
  }

  _buildTabPage() {
    return TabBarView(
      children: <Widget>[
        _pageOne(),
        Container(
          color: const Color(0xFF800000),
          child: const Center(
            child: Text("It's rainy here"),
          ),
        ),
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
                  children: const [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Nama Lengkap'),
                    ),
                    SizedBox(height: 6),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Jl. Kawi Raya No.18, RT.6/RW.2, Guntur, Kecamatan Setiabudi, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12980',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey
                        ),
                      ),
                    ),
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

  Widget _pageOne() {
    return BlocBuilder<ArticleBloc, ArticleState>(
      bloc: BlocProvider.of<ArticleBloc>(context)..add(GetArticle(statusArticle: 0)),
      builder: (context, state){
        if(state.status.isLoading){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }else{
          if(state.article != null && state.article!.isNotEmpty){
            return ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: state.article!.length,
              itemBuilder: (context, index){
                debugPrint('${state.article![index].filename}');
                return Container(
                  color: const Color(0xFF800000),
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                          child: Image.file(File('${state.article![index].filename}'))
                      ),
                      const SizedBox(height: 15,),
                      Text('${state.article![index].judulIndonesia}', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                      Text(state.article![index].hideAuthor! ? 'Publish Author' : 'Private Author', style: TextStyle(color: Colors.white),),
                      Row(
                        children: [
                          Text('${state.article![index].timeSchedule}', style: TextStyle(color: Color(0xFFC7C7C7)),),
                          const SizedBox(width: 8,),
                          Text('${state.article![index].captionIndonesia}', style: TextStyle(color: Color(0xFFC7C7C7)),),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text('${state.article![index].tagDistrik} - ${state.article![index].tagKampung} - ${state.article![index].tagKabupaten}', style: TextStyle(color: Color(0xFFC7C7C7)),),
                          )
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Text('${state.article![index].deskripsiIndonesia}', style: const TextStyle(color: Colors.white),),
                      SizedBox(height: 8,),
                      Container(
                        height: 0.5,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                      SizedBox(height: 20,)
                    ],
                  ),
                );
              },
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
