import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:new_bakarbatu/core/util/routes.dart';
import 'package:new_bakarbatu/features/home/presentation/bloc/home_bloc.dart';
import 'package:new_bakarbatu/shared/common/key_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  InAppWebViewController? webViewController;
  String url = '';
  double progress = 0;
  final urlController = TextEditingController();
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(HomeGotoWebview());
    setPrefs();
  }

  @override
  void dispose() {
    _HomePageState();
    super.dispose();
  }

  void setPrefs() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    prefs = await SharedPreferences.getInstance();
    NotificationSettings settings = await messaging.requestPermission(
      alert: false,
      announcement: false,
      badge: false,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: false,
    );
    debugPrint('SETTINGNYA : ${settings.authorizationStatus}');
    await messaging.subscribeToTopic('weather');
    var token = await messaging.getToken();

    debugPrint('Bearer : $token');
    // fLh64rhkR5WqEUzyoSnuFx:APA91bEXRUcr7g8Ga6klk1wuxHR9gAkVQNVIg-t-LXjUPePLiz9bsZx7qhF5w1mqZGJnYzT0MkqJPqslrfvi_FbnYv0NxXuBWqUdyBV1EPAWs3y7XB4KEX6olvOzqT1wJY2bIcbxe36M

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: <Widget>[
              Expanded(
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if(state.status.isSuccess){
                      return Stack(
                        children: [
                          InAppWebView(
                            initialUrlRequest: URLRequest(url: state.urlWebview),
                            onWebViewCreated: (controller) {
                              webViewController = controller;
                            },
                            onLoadStart: (controller, url) {
                              setState(() {
                                this.url = url.toString();
                                urlController.text = this.url;
                              });
                            },
                            shouldOverrideUrlLoading:
                                (controller, navigationAction) async {
                              var uri = navigationAction.request.url!;

                              if (![
                                "http",
                                "https",
                                "file",
                                "chrome",
                                "data",
                                "javascript",
                                "about"
                              ].contains(uri.scheme)) {
                                if (await canLaunchUrl(uri)) {
                                  // Launch the App
                                  await launchUrl(
                                    uri,
                                  );
                                  // and cancel the request
                                  return NavigationActionPolicy.CANCEL;
                                }
                              }

                              return NavigationActionPolicy.ALLOW;
                            },
                            onLoadStop: (controller, url) async {
                              setState(() {
                                this.url = url.toString();
                                urlController.text = this.url;
                              });
                            },
                            onProgressChanged: (controller, progress) {
                              setState(() {
                                this.progress = progress / 100;
                                urlController.text = this.url;
                              });
                            },
                            onUpdateVisitedHistory: (controller, url, androidIsReload) {
                              setState(() {
                                this.url = url.toString();
                                urlController.text = this.url;
                              });
                            },
                            onConsoleMessage: (controller, consoleMessage) {
                              print(consoleMessage);
                            },
                          ),
                          progress < 1.0
                              ? LinearProgressIndicator(value: progress)
                              : Container(),
                        ],
                      );
                    }
                    return const Center(
                        child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ])),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            if(prefs?.getBool(KeyPreferenches.isLogin) == true){
              Navigator.pushNamed(context, Routes.contributionRoute);
            }else{
              Navigator.pushNamed(context, Routes.loginRoute);
            }
          },
          backgroundColor: const Color.fromARGB(255, 203, 0, 0),
          child: const Icon(Icons.camera_alt),
        ),
    );
  }
}