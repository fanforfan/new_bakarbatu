import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bloc/submit_article/submit_article_bloc.dart';

class DetailArticleOnline extends StatefulWidget {
  final String title;
  const DetailArticleOnline({Key? key, required this.title}) : super(key: key);

  @override
  _DetailArticleOnlineState createState() => _DetailArticleOnlineState();
}

class _DetailArticleOnlineState extends State<DetailArticleOnline> {
  InAppWebViewController? webViewController;
  String url = '';
  double progress = 0;
  final urlController = TextEditingController();

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: true,
        javaScriptCanOpenWindowsAutomatically: true,
        javaScriptEnabled: true,
        supportZoom: true
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: BlocBuilder<SubmitArticleBloc, SubmitArticleState>(
          builder: (context, state){
            return SingleChildScrollView(
              child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      /// WEB VIEW FILE
                      Expanded(
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 300,
                            child: Stack(
                              children: [
                                InAppWebView(
                                  initialOptions: options,
                                  initialUrlRequest: URLRequest(url: Uri.parse('${state.detailPathUrl}')),
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
                            )
                        ),
                      ),
                      /// DETAIL
                      const SizedBox(
                        height: 10,
                      ),
                      /// CATEGORY AND DATE
                      Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Text('${state.detailCaption}', style: GoogleFonts.playfairDisplay(color: Colors.black54),),
                          const SizedBox(
                            width: 8,
                          ),
                          const Icon(Icons.circle, size: 6, color: Colors.black54,),
                          const SizedBox(
                            width: 7,
                          ),
                          Text('${state.detailTimeSchedule}', style: GoogleFonts.playfairDisplay(color: Colors.black54)),
                        ],
                      ),
                      _createTitleFieldJudul(context: context, label: 'Judul', stateValidator: state.detailJudul),
                      const SizedBox(
                        height: 16,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      _createTitleField(context: context, label: 'Deskripsi', stateValidator: state.detailDeskripsi),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  )
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _createTitleField({required BuildContext context, required String label, String? stateValidator}) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Text('$stateValidator', style: GoogleFonts.playfairDisplay(fontSize: 12),),
      ),
    );
  }

  Widget _createTitleFieldJudul({required BuildContext context, required String label, String? stateValidator}) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Text('$stateValidator', style: GoogleFonts.playfairDisplay(fontSize: 50, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
