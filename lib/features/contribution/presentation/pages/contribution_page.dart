import 'package:custom_floating_action_button/custom_floating_action_button.dart';
import 'package:flutter/material.dart';

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

  var tabs = const <Widget>[
    Tab(
      icon: Icon(Icons.home),
    ),
    Tab(
      icon: Icon(Icons.file_open_outlined),
    ),
  ];

  var subFloatingMenu = const [
    CircleAvatar(
      backgroundColor: Color.fromARGB(255, 179, 1, 1),
      child: Icon(Icons.note_sharp, color: Colors.white, size: 16,),
    ),
    CircleAvatar(
      backgroundColor: Color.fromARGB(255, 179, 1, 1),
      child: Icon(Icons.mic, color: Colors.white, size: 16,),
    ),
    CircleAvatar(
      backgroundColor: Color.fromARGB(255, 179, 1, 1),
      child: Icon(Icons.camera_alt, color: Colors.white, size: 16,),
    ),
    CircleAvatar(
      backgroundColor: Color.fromARGB(255, 179, 1, 1),
      child: Icon(Icons.videocam, color: Colors.white, size: 16,),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: CustomFloatingActionButton(
      body: Scaffold(
        body: DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: Column(children: [
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
      options: subFloatingMenu,
      backgroundColor: Colors.transparent,
      spaceFromBottom: 20,
      type: CustomFloatingActionButtonType.horizontal,
      openFloatingActionButton: const Icon(Icons.edit, color: Colors.white),
      closeFloatingActionButton: const Icon(Icons.close, color: Colors.white),
      floatinButtonColor: const Color.fromARGB(255, 179, 1, 1),
    ));
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
