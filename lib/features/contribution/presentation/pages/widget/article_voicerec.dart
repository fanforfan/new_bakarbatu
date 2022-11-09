import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_bakarbatu/shared/widgets/reguler_button.dart';
import 'package:new_bakarbatu/shared/widgets/reguler_text_area.dart';
import 'package:new_bakarbatu/shared/widgets/reguler_text_form_field.dart';

class ArticleVoiceRec extends StatefulWidget {
  const ArticleVoiceRec({super.key});

  @override
  State<ArticleVoiceRec> createState() => _ArticleVoiceRecState();
}

class _ArticleVoiceRecState extends State<ArticleVoiceRec> {
  String statusText = 'Click to record audio.';
  bool isComplete = false;
  var recordFilePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))
      ),
      height: MediaQuery.of(context).size.height - 150,
      child: ListView(
        children: [
          const SizedBox(
            height: 50.0,
          ),
          _createAudioPlaceHolder(),
          const SizedBox(
            height: 16,
          ),
          _createTitleField(label: 'Judul laporan Audio'),
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

  Widget _createAudioPlaceHolder() {
    return MaterialButton(
      onPressed: () {
        // statusText == 'Click to record audio.'
        // ? _startRecord()
        // : _stopRecord();
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
            statusText == 'Click to record audio.' 
            ? Image.asset(
              'assets/icons/ic_pick_audio.png',
              width: 50,
            ) 
            : const Icon(Icons.stop_circle_outlined),
            Text(
              statusText,
              style: const TextStyle(
                  color: Color.fromARGB(255, 154, 0, 0), fontSize: 11),
            ),
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
              labelStyle: const TextStyle(color: Colors.grey, fontSize: 12)),
          obsecure: false,
          onChanged: (value) {
            debugPrint('$value');
          }),
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
              labelStyle: const TextStyle(color: Colors.grey, fontSize: 12)),
          obsecure: false,
          onChanged: (value) {
            debugPrint('$value');
          }),
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
        )));
  }

  Widget _createShowHideAuthor() {
    return Row(
      children: [
        const SizedBox(
          width: 30,
        ),
        Switch(
          value: true,
          onChanged: (value) {},
          activeTrackColor: const Color.fromARGB(255, 188, 0, 0),
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
  
  // void _startRecord() async {
  //   setState(() {
  //     statusText = "Recording...";
  //   });
  //   recordFilePath = await getFilePath();
  //   isComplete = false;
  //   RecordMp3.instance.start(
  //     recordFilePath,
  //     (type) {
  //       statusText = "Record error--->$type";
  //     }
  //   );
  //   setState(() {});
  // }

  // void _stopRecord() {
  //   bool s = RecordMp3.instance.stop();
  //
  //   if (s) {
  //     setState(() {
  //       isComplete = true;
  //       statusText = 'Click to record audio.';
  //     });
  //     // AssetsAudioPlayer.newPlayer().open(
  //     //   Audio(recordFilePath),
  //     //   autoStart: true,
  //     //   showNotification: true,
  //     // );
  //   }
  // }

  // int i = 0;
  // Future<String> getFilePath() async {
  //   Directory storageDirectory = await getApplicationSupportDirectory();
  //   String sdPath = '${storageDirectory.path}/record';
  //   var d = Directory(sdPath);
  //   if (!d.existsSync()) {
  //     d.createSync(recursive: true);
  //   }
  //   return sdPath + '/test_${i++}.mp3';
  // }

}