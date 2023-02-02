import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:new_bakarbatu/features/contribution/presentation/pages/detail_article_online.dart';
import 'package:new_bakarbatu/shared/widgets/shimmer_loading_image.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/article_response.dart';
import '../../bloc/submit_article/submit_article_bloc.dart';

class ItemArticleOnline extends StatefulWidget {
  final int? index;
  final DataNewsroom dataNewsroom;
  final bool fromCategory;

  const ItemArticleOnline({Key? key, this.index, required this.dataNewsroom, required this.fromCategory}) : super(key: key);

  @override
  State<ItemArticleOnline> createState() => _ItemArticleOnlineState();
}

class _ItemArticleOnlineState extends State<ItemArticleOnline> {

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
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF800000),
      padding: EdgeInsets.only(left: 20, right: 20, top: (widget.index != null) ? widget.index == 0 ? widget.fromCategory ? 70 : 50 : 0 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.dataNewsroom.articleUrl.toString().contains('.mp4')
              ?
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: Stack(
                children: [
                  InAppWebView(
                    initialOptions: options,
                    initialUrlRequest: URLRequest(url: Uri.parse('${widget.dataNewsroom.articleUrl}')),
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
              ),
            )
          )
              :
          ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                child: CachedNetworkImage(
                imageUrl: '${widget.dataNewsroom.articleUrl}',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                height: 150,
                width: MediaQuery.of(context).size.width,
                placeholder: (context, url){
                  return const Center(
                    child: ShimmerLoadingImage()
                  );
                },
              )
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
                  child: Text(widget.dataNewsroom.title ?? '', style: const TextStyle(color: Colors.black54, fontSize: 18, fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10, bottom: 10),
                  child: Text('${widget.dataNewsroom.status}', style: const TextStyle(color: Colors.black54),),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10, bottom: 10),
                    child: Row(
                      children: [
                        Text(widget.dataNewsroom.saved ?? '', style: const TextStyle(color: Color(0xFFC7C7C7)),),
                        const SizedBox(width: 8,),
                        Text(widget.dataNewsroom.categoryName ?? '', style: const TextStyle(color: Color(0xFFC7C7C7)),),
                        const SizedBox(width: 8,),
                        _buttonEdit(context)
                      ],
                    )
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10, bottom: 10),
                  child: Text(widget.dataNewsroom.description ?? '', style: const TextStyle(color: Colors.black54)),
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

  Widget _buttonEdit(BuildContext context) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.green
      ),
      alignment: Alignment.centerRight,
      child: MaterialButton(
        onPressed: () async {
          BlocProvider.of<SubmitArticleBloc>(context).add(SetDetailArticleOnline(data: widget.dataNewsroom));
          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailArticleOnline(title: widget.dataNewsroom.title ?? '')));
        },
        child: Row(
          children: const [
            Text('Detail', style: TextStyle(color: Colors.white),),
            SizedBox(width: 6,),
            Icon(Icons.edit, size: 15, color: Colors.white,)
          ],
        ),
      ),
    );
  }

}
