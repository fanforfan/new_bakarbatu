import 'package:custom_floating_action_button/custom_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:new_bakarbatu/core/util/routes.dart';
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
    List<PopUpFloating> subFloating = [
        PopUpFloating(Colors.blueGrey, 'assets/icons/ic_article.png', 19.0,
        () => showModalBottomSheet<void>(
          isScrollControlled: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (BuildContext context) {
              return const ArticleBasic();
            },
          )),
        PopUpFloating(Colors.pink, 'assets/icons/ic_mic.png', 20.0,
        () => showModalBottomSheet<void>(
          isScrollControlled: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (BuildContext context) {
              return const ArticleVoiceRec();
            },
          )),
        PopUpFloating(Colors.orange, 'assets/icons/ic_fotoimage.png', 20.0,
        () => showModalBottomSheet<void>(
          isScrollControlled: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (BuildContext context) {
              return const ArticleFoto();
            },
          )),
        PopUpFloating(Colors.deepPurple, 'assets/icons/ic_video.png', 20.0,
        () => showModalBottomSheet<void>(
          isScrollControlled: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (BuildContext context) {
              return const ArticleVideo();
            },
          ))
      ];

    return CustomFloatingActionButton(
      body: Scaffold(
        body: DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: Column(children: [
            Container(
              color: Colors.black,
              height: MediaQuery.of(context).viewPadding.top,
            ),
            TabBar(
                indicatorColor: const Color.fromARGB(255, 179, 1, 1),
                labelColor: const Color.fromARGB(255, 179, 1, 1),
                tabs: headTabs.map((e) => Tab(
                  icon: Image.asset(e.image, width: 30,),
                )).toList()
            ),
            Expanded(
              child: _buildTabPage(),
            )
          ]),
        ),
      ),
      options: subFloating.map((e) => GestureDetector(
        onTap: e.onPress,
        child: CircleAvatar(
          backgroundColor: e.floatColor,
          child: Image.asset(e.image, width: e.icSize,),
        ),
      )).toList(),
      backgroundColor: Colors.transparent,
      spaceFromBottom: 20,
      type: CustomFloatingActionButtonType.horizontal,
      openFloatingActionButton: const Icon(Icons.edit, color: Colors.white),
      closeFloatingActionButton: const Icon(Icons.close, color: Colors.white),
      floatinButtonColor: Colors.black,
    );
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
}
