import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:new_bakarbatu/core/util/routes.dart';
import 'package:new_bakarbatu/features/home/presentation/bloc/home_bloc.dart';
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

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(HomeGotoWebview());
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
              // ButtonBar(
              //   alignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     ElevatedButton(
              //       child: Icon(Icons.arrow_back),
              //       onPressed: () {
              //         webViewController?.goBack();
              //       },
              //     ),
              //     ElevatedButton(
              //       child: Icon(Icons.arrow_forward),
              //       onPressed: () {
              //         webViewController?.goForward();
              //       },
              //     ),
              //     ElevatedButton(
              //       child: Icon(Icons.refresh),
              //       onPressed: () {
              //         webViewController?.reload();
              //       },
              //     ),
              //   ],
              // ),
            ])),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.pushNamed(context, Routes.loginRoute);
          },
          backgroundColor: const Color.fromARGB(255, 203, 0, 0),
          child: const Icon(Icons.camera_alt),
        ),
    );
  }
}