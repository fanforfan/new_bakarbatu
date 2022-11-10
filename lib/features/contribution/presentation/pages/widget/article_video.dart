import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_bakarbatu/features/contribution/presentation/bloc/submit_article/submit_article_bloc.dart';
import 'package:new_bakarbatu/shared/widgets/reguler_button.dart';
import 'package:new_bakarbatu/shared/widgets/reguler_text_area.dart';
import 'package:new_bakarbatu/shared/widgets/reguler_text_form_field.dart';
import 'package:video_player/video_player.dart';

class ArticleVideo extends StatefulWidget {
  const ArticleVideo({super.key});

  @override
  State<ArticleVideo> createState() => _ArticleVideoState();
}

class _ArticleVideoState extends State<ArticleVideo> {
  final _picker = ImagePicker();
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  /// TAKE VIDEO
  Future _getVideoFromCamera(String title) async {
    final pickedVideoFile = await _picker.pickVideo(
      source: ImageSource.camera,
    );

    if (pickedVideoFile != null) {
      BlocProvider.of<SubmitArticleBloc>(context)
          .add(PickVideo(videoFile: File(pickedVideoFile.path)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubmitArticleBloc, SubmitArticleState>(
      builder: (context, state){
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
              _createVideoPlaceHolder(state),
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
      },
    );
  }

  Widget _createVideoPlaceHolder(SubmitArticleState state) {
    return MaterialButton(
      onPressed: () {
        _getVideoFromCamera('First Pick');
      },
      child: state.videoFile != null
          ? GestureDetector(
        onTap: (){
          _showDialogVideoPlay(context, state.chewieController, state.videoController);
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                  width: 0.5, color: const Color.fromARGB(255, 154, 0, 0)),
              color: const Color.fromARGB(255, 250, 250, 250),
              borderRadius: BorderRadius.circular(20)),
          width: double.infinity,
          child: Image.asset(state.thumbnailVideo!.path),
        ),
      )
      // MaterialButton(
      //   onPressed: (){
      //     _showDialogVideoPlay(context);
      //   },
      //   child: Icon(Icons.play_arrow_outlined),
      // )
          : Container(
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

  late BuildContext _dialogContext;
  void _showDialogVideoPlay(BuildContext context, ChewieController? chewieController, VideoPlayerController? videoController) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          _dialogContext = context;
          return WillPopScope(
            onWillPop: () => _disposeVideo(),
            child: Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(8)),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Stack(
                children: [
                  Chewie(
                    controller: chewieController!,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: 100,
                      child: MaterialButton(
                        color: Colors.blueGrey,
                        onPressed: () {
                          videoController?.pause();
                          chewieController.pause();
                          Navigator.pop(_dialogContext);
                        },
                        child: Row(
                          children: const [
                            Icon(
                              Icons.close_outlined,
                              color: Colors.white,
                              size: 16,
                            ),
                            Text('Close',
                                style: TextStyle(
                                    color:
                                    Colors.white))
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  _disposeVideo() {
    _videoPlayerController?.pause();
    _chewieController?.pause();
    Navigator.pop(_dialogContext);
  }
}
