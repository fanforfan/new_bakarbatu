import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_bakarbatu/features/contribution/presentation/bloc/submit_article_video/submit_artikel_video_bloc.dart';
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
      BlocProvider.of<SubmitArtikelVideoBloc>(context)
          .add(PickVideoFile(videoFile: File(pickedVideoFile.path)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubmitArtikelVideoBloc, SubmitArticleVideoState>(
      builder: (context, state){
        return Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16))),
          height: MediaQuery.of(context).size.height - 150,
          child: ListView(
            children: [
              _createVideoPlaceHolder(state),
              const SizedBox(
                height: 16,
              ),
              _createDateField(state),
              const SizedBox(
                height: 16,
              ),
              _createTitleFieldJudul(
                  label: 'Judul Indonesia',
                  stateValidator: state
              ),
              const SizedBox(
                height: 16,
              ),
              _createDescriptionFieldCaption(
                  label: 'Caption Indonesia',
                  maxLines: 3,
                  stateValidator: state
              ),
              const SizedBox(
                height: 16,
              ),
              _createDescriptionFieldDeskripsi(
                  label: 'Deskripsi/Detail Indonesia',
                  maxLines: 7,
                  stateValidator: state
              ),
              const SizedBox(
                height: 16,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 30),
                child: Text('Tag Lokasi', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),),
              ),
              const SizedBox(
                height: 16,
              ),
              _createTitleFieldKabupaten(
                  label: 'Kabupaten',
                  stateValidator: state
              ),
              const SizedBox(
                height: 10,
              ),
              _createTitleFieldKampung(
                  label: 'Kampung',
                  stateValidator: state
              ),
              const SizedBox(
                height: 10,
              ),
              _createTitleFieldDistik(
                  label: 'Distrik',
                  stateValidator: state
              ),
              _createShowHideAuthor(state),
              const SizedBox(
                height: 16,
              ),
              state.status.isError ? Text('${state.warningMessageVid}') : const SizedBox(),
              state.status.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _createButtonSubmit(state),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _createVideoPlaceHolder(SubmitArticleVideoState state) {
    return MaterialButton(
      onPressed: () {
        _getVideoFromCamera('First Pick');
      },
      child: state.videoFile != null
          ? GestureDetector(
        onTap: (){
          _showDialogVideoPlay(context, state.chewieController, state.videoController);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.file(File(state.thumbnailVideo!.path)),
        )
      )
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
              'assets/icons/ic_video_rec.png',
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

  Widget _createDateField(SubmitArticleVideoState state) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: const Border(
              left: BorderSide(width: 1, color: Color(0xFFC4C4C4)),
              right: BorderSide(width: 1, color: Color(0xFFC4C4C4)),
              top: BorderSide(width: 1, color: Color(0xFFC4C4C4)),
              bottom: BorderSide(width: 1, color: Color(0xFFC4C4C4)),
            ),
          ),
          padding: const EdgeInsets.only(left: 10, right: 20),
          child: DateTimePicker(
            decoration: const InputDecoration(
              border: InputBorder.none,
              label: Text('Time Schedule'),
            ),
            style: const TextStyle(fontSize: 15),
            initialValue: state.timeScheduleVid ?? '',
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            onChanged: (val){
              BlocProvider.of<SubmitArtikelVideoBloc>(context).add(ChangeTimeScheduleVid(value: val));
            },
            validator: (val){
              return null;
            },
            onSaved: (val){
              BlocProvider.of<SubmitArtikelVideoBloc>(context).add(ChangeTimeScheduleVid(value: val));
            },
          )
      ),
    );
  }

  Widget _createTitleFieldJudul({required String label, required SubmitArticleVideoState stateValidator}) {
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
          value: stateValidator.judulIndonesiaVid,
          onChanged: (value) {
            BlocProvider.of<SubmitArtikelVideoBloc>(context).add(ChangeJudulIndonesiaVid(value: value));
          }),
    );
  }

  Widget _createDescriptionFieldCaption({required String label, required int maxLines, required SubmitArticleVideoState stateValidator}) {
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
        value: stateValidator.captionIndonesiaVid,
        onChanged: (value) {
          BlocProvider.of<SubmitArtikelVideoBloc>(context).add(ChangeCaptionIndonesiaVid(value: value));
        },
        maxLines: maxLines,
      ),
    );
  }

  Widget _createDescriptionFieldDeskripsi({required String label, required int maxLines, required SubmitArticleVideoState stateValidator}) {
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
        value: stateValidator.deskripsiIndonesiaVid,
        onChanged: (value) {
          BlocProvider.of<SubmitArtikelVideoBloc>(context).add(ChangeDeskripsiIndonesiaVid(value: value));
        },
        maxLines: maxLines,
      ),
    );
  }

  Widget _createTitleFieldKabupaten({required String label, required SubmitArticleVideoState stateValidator}) {
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
          value: stateValidator.tagKabupatenVid,
          onChanged: (value) {
            BlocProvider.of<SubmitArtikelVideoBloc>(context).add(ChangeKabutapenVid(value: value));
          }),
    );
  }

  Widget _createTitleFieldKampung({required String label, required SubmitArticleVideoState stateValidator}) {
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
          value: stateValidator.tagKampungVid,
          onChanged: (value) {
            BlocProvider.of<SubmitArtikelVideoBloc>(context).add(ChangeKampungVid(value: value));
          }),
    );
  }

  Widget _createTitleFieldDistik({required String label, required SubmitArticleVideoState stateValidator}) {
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
          value: stateValidator.tagDistrikVid,
          onChanged: (value) {
            BlocProvider.of<SubmitArtikelVideoBloc>(context).add(ChangeDistrikVid(value: value));
          }),
    );
  }

  Widget _createShowHideAuthor(SubmitArticleVideoState state) {
    return Row(
      children: [
        const SizedBox(
          width: 30,
        ),
        Switch(
          value: state.hideAuthor ?? false,
          onChanged: (value) {
            BlocProvider.of<SubmitArtikelVideoBloc>(context).add(ChangeHideAuthorVid(value: value));
          },
          activeTrackColor: const Color.fromARGB(255, 188, 0, 0),
          activeColor: const Color.fromARGB(255, 133, 0, 0),
        ),
        const Text(
          'Sembuyikan Kepemilikan',
          style: TextStyle(
            color: Color.fromARGB(255, 133, 0, 0),
          ),
        )
      ],
    );
  }

  Widget _createButtonSubmit(SubmitArticleVideoState state) {
    return Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: state.status.isLoading
            ? const CircularProgressIndicator()
            : RegulerButton(
            childWidget: MaterialButton(
              onPressed: () => validateToSubmit(state),
              child: const Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
            ))
    );
  }

  validateToSubmit(SubmitArticleVideoState state) {
    BlocProvider.of<SubmitArtikelVideoBloc>(context).add(ValidateToSubmitArticleVid());
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
