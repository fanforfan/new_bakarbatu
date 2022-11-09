import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_bakarbatu/shared/widgets/reguler_button.dart';
import 'package:new_bakarbatu/shared/widgets/reguler_text_area.dart';
import 'package:new_bakarbatu/shared/widgets/reguler_text_form_field.dart';
import 'package:path/path.dart' as path;

class ArticleVideo extends StatefulWidget {
  const ArticleVideo({super.key});

  @override
  State<ArticleVideo> createState() => _ArticleVideoState();
}

class _ArticleVideoState extends State<ArticleVideo> {
  final _picker = ImagePicker();

  /// TAKE VIDEO
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
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      height: MediaQuery.of(context).size.height - 150,
      child: ListView(
        children: [
          const SizedBox(
            height: 50.0,
          ),
          _createVideoPlaceHolder(),
          const SizedBox(
            height: 16,
          ),
          _createTitleField(label: 'Judul laporan Video'),
          const SizedBox(
            height: 16,
          ),
          _createDescriptionField(label: 'Deskripsi'),
          const SizedBox(
            height: 16,
          ),
          _createShowHideAuthor(),
          const SizedBox(
            height: 16,
          ),
          _createButtonSubmit(),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  Widget _createVideoPlaceHolder() {
    return MaterialButton(
      onPressed: () {
        _getVideoFromCamera('First Pick');
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                width: 0.5, color: const Color.fromARGB(255, 154, 0, 0)),
            color: const Color.fromARGB(255, 250, 250, 250),
            borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.only(top: 40, bottom: 40),
        width: double.infinity,
        child: Column(
          children: [
            Image.asset(
              'assets/icons/ic_pick_video.png',
              width: 50,
            ),
            const Text(
              'Take video',
              style: TextStyle(
                  color: Color.fromARGB(255, 154, 0, 0), fontSize: 11),
            )
          ],
        ),
      ),
    );
  }
  
  Widget _createTitleField({required String label}) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: RegulerTextFormField(
        inputDecoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          labelStyle: const TextStyle(color: Colors.grey, fontSize: 12)
        ), 
        obsecure: false, 
        onChanged: (value){
          debugPrint('$value');
        }
      ),
    );
  }
  
  Widget _createDescriptionField({required String label}) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: RegulerTextArea(
        inputDecoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          labelStyle: const TextStyle(color: Colors.grey, fontSize: 12)
        ), 
        obsecure: false, 
        onChanged: (value){
          debugPrint('$value');
        }
      ),
    );
  }
  
  Widget _createButtonSubmit() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: const RegulerButton(
        childWidget: MaterialButton(
          onPressed: null,
          child: Text(
            'Submit',
            style: TextStyle(color: Colors.white),
          ),
        )
      )
    );
  }
  
  Widget _createShowHideAuthor() {
    return Row(
      children: [
        const SizedBox(width: 30,),
        Switch(
          value: true,
          onChanged: (value) {},
          activeTrackColor: Color.fromARGB(255, 188, 0, 0),
          activeColor: const Color.fromARGB(255, 133, 0, 0),
        ),
        const Text(
          'Hide Author', 
          style: TextStyle(
            color: Color.fromARGB(255, 133, 0, 0),
          ),
        )
      ],
    );
  }
}
