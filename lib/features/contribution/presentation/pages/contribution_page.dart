import 'package:flutter/material.dart';
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

class PopUpFloating {
  final Color floatColor;
  final String image;
  final double icSize;
  final Function() onPress;

  PopUpFloating(this.floatColor, this.image, this.icSize, this.onPress);
}

class _ContributionPageState extends State<ContributionPage>
    with SingleTickerProviderStateMixin {

  List<HeaderTab> headTabs = [
    HeaderTab('', 'assets/icons/ic_home.png'),
    HeaderTab('', 'assets/icons/ic_folder.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Container(
            padding: const EdgeInsets.only(left: 50),
            alignment: Alignment.centerLeft,
            child: const Text('Contribution', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),),
          ),
          const SizedBox(height: 16,),
          _createMainMenu(),
          const SizedBox(height: 35,),
          Container(
            padding: const EdgeInsets.only(left: 50),
            alignment: Alignment.centerLeft,
            child: const Text('Your Contribution', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),),
          ),
          const SizedBox(height: 16,),
          TabBar(
              indicatorColor: const Color.fromARGB(255, 179, 1, 1),
              labelColor: const Color.fromARGB(255, 179, 1, 1),
              tabs: headTabs.map((e) => Tab(
                icon: Image.asset(e.image, width: 30, color: const Color.fromARGB(
                    255, 121, 121, 121),),
              )).toList()
          ),
          Expanded(
            child: _buildTabPage(),
          )
        ]),
      ),
    );

    // return CustomFloatingActionButton(
    //   body: Scaffold(
    //     body: Column(
    //       children: [
    //         DefaultTabController(
    //           initialIndex: 0,
    //           length: 2,
    //           child: Column(children: [
    //             Container(
    //               color: Colors.black,
    //               height: MediaQuery.of(context).viewPadding.top,
    //             ),
    //             TabBar(
    //                 indicatorColor: const Color.fromARGB(255, 179, 1, 1),
    //                 labelColor: const Color.fromARGB(255, 179, 1, 1),
    //                 tabs: headTabs.map((e) => Tab(
    //                   icon: Image.asset(e.image, width: 30,),
    //                 )).toList()
    //             ),
    //             Expanded(
    //               child: _buildTabPage(),
    //             )
    //           ]),
    //         ),
    //       ],
    //     ),
    //   ),
    //   options: subFloating.map((e) => GestureDetector(
    //     onTap: e.onPress,
    //     child: CircleAvatar(
    //       backgroundColor: e.floatColor,
    //       child: Image.asset(e.image, width: e.icSize,),
    //     ),
    //   )).toList(),
    //   backgroundColor: Colors.transparent,
    //   spaceFromBottom: 20,
    //   type: CustomFloatingActionButtonType.horizontal,
    //   openFloatingActionButton: const Icon(Icons.edit, color: Colors.white),
    //   closeFloatingActionButton: const Icon(Icons.close, color: Colors.white),
    //   floatinButtonColor: Colors.black,
    // );
  }

  Widget _buildTabPage() {
    return const TabBarView(
      children: <Widget>[
        Center(
          child: Text("It's cloudy here"),
        ),
        Center(
          child: Text("It's rainy here"),
        ),
      ],
    );
  }

  Widget _createMainMenu() {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _itemMenus(
            colors: Colors.blueGrey,
            image: 'assets/icons/ic_article.png',
            size: 19.0,
            pressed: () => showModalBottomSheet<void>(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (BuildContext context) {
                return const ArticleBasic();
              },
            )
          ),
          const SizedBox(width: 16,),
          _itemMenus(
            colors: Colors.pink,
            image: 'assets/icons/ic_mic.png',
            size: 20.0,
            pressed: () => showModalBottomSheet<void>(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (BuildContext context) {
                return const ArticleVoiceRec();
              },
            )
          ),
          const SizedBox(width: 16,),
          _itemMenus(
              colors: Colors.orange,
              image: 'assets/icons/ic_fotoimage.png',
              size: 20.0,
            pressed: () => showModalBottomSheet<void>(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (BuildContext context) {
                return const ArticleFoto();
              },
            )
          ),
          const SizedBox(width: 16,),
          _itemMenus(
              colors: Colors.deepPurple,
              image: 'assets/icons/ic_video.png',
              size: 20.0,
            pressed: () => showModalBottomSheet<void>(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (BuildContext context) {
                return const ArticleVideo();
              },
            )
          ),
        ],
      ),
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
          child: Image.asset(image, width: size,),
        ),
      ),
    );
  }
}
