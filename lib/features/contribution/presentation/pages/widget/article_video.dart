import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class ArticleVideo extends StatefulWidget {
  const ArticleVideo({super.key});

  @override
  State<ArticleVideo> createState() => _ArticleVideoState();
}

class _ArticleVideoState extends State<ArticleVideo> {

  final _picker = ImagePicker();

  /// VIDEO NF2F
  Future _getVideoFromCamera(String title) async {
    final pickedVideoFile = await _picker.pickVideo(
      source: ImageSource.camera,
    );

    if (pickedVideoFile != null) {
      if (File(pickedVideoFile.path).lengthSync().toInt() > 100000000) {
        debugPrint('Ukuran video NF2F tidak boleh lebih dari 100MB');
        // CustomSnackBar.showErrorNew(_scaffoldGlobalKey,
        //     'Ukuran video NF2F tidak boleh lebih dari 100MB');
      } else {
        if (Platform.isIOS) {
          debugPrint('Original path: ${File(pickedVideoFile.path).path}');
          var dir = path.dirname(File(pickedVideoFile.path).path);
          var newPath = path.join(dir, 'Video_Artikel.mp4');
          debugPrint('NewPath: $newPath');
          var videoFromRename = File(pickedVideoFile.path).renameSync(newPath);
          debugPrint('VIDEO FILE : ${videoFromRename.path}');
          // BlocProvider.of<CompressVideoBloc>(context).add(
          //     StartCompressVideoEvent(
          //         videoFromIOS: videoFromRename,
          //         status: true,
          //         message: 'Compressing video, please wait...'));
          // context.read<CompressVideoBloc>().add(StartCompressVideoEvent(videoFromIOS: videoFromRename, status: true, message: 'Compressing video, please wait...'));
        } else {
          debugPrint('Compressing video, please wait...');
          // BlocProvider.of<CompressVideoBloc>(context).add(
          //     StartCompressVideoEvent(
          //         videoNF2f: pickedVideoFile,
          //         status: true,
          //         message: 'Compressing video, please wait...'));
          // context.read<CompressVideoBloc>().add(StartCompressVideoEvent(videoNF2f: pickedVideoFile, status: true, message: 'Compressing video, please wait...'));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))
      ),
      height: MediaQuery.of(context).size.height - 50,
      child: ListView(
        children: [
          const SizedBox(height: 50.0,),
          MaterialButton(
            onPressed: (){
              _getVideoFromCamera('First Pick');
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0.5,
                  color: const Color.fromARGB(255, 154, 0, 0)
                ),
                color: const Color.fromARGB(255, 250, 250, 250),
                borderRadius: BorderRadius.circular(20)
              ),
              padding: const EdgeInsets.only(top: 40, bottom: 40),
              width: double.infinity,
              child: Column(
                children: [
                  Image.asset('assets/icons/ic_pick_video.png', width: 50,),
                  const Text('Take a video', style: TextStyle(color: Color.fromARGB(255, 154, 0, 0), fontSize: 10),)
                ],
              ),
            ),
          ),
          const SizedBox(height: 16,),
        ],
      ),
    );
  }
}