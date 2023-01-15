import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_bakarbatu/features/contribution/presentation/bloc/article/article_bloc.dart';

import '../../../../../db/models/contribution_article_model.dart';
import '../../../../../shared/common/key_language.dart';
import '../../../../../shared/widgets/reguler_button.dart';
import '../../../../../shared/widgets/reguler_text_area.dart';
import '../../../../../shared/widgets/reguler_text_form_field.dart';
import '../../bloc/submit_article/submit_article_bloc.dart';
import '../detail_video.dart';

class ItemArticleLocal extends StatelessWidget {
  final int? index;
  final ContributionArticle contributionArticle;

  const ItemArticleLocal({Key? key, required this.contributionArticle, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF800000),
      padding: EdgeInsets.only(left: 20, right: 20, top: (index != null) ? index == 0 ? 85 : 0 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// cek apakan dia video atau image
          contributionArticle.jenisFile == 1
              ?
          ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
              child: Image.file(File('${contributionArticle.filename}'))
          )
              :
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
            ),
            child: MaterialButton(
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailVideo(fileName: contributionArticle.filename,)
                    )
                );
              },
              child: const Icon(Icons.play_circle_outline_outlined, color: Colors.red,),
            ),
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
                  child: Text('${contributionArticle.judulIndonesia}', style: const TextStyle(color: Colors.black54, fontSize: 18, fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: Row(
                    children: [
                      Expanded(child: Text(contributionArticle.hideAuthor! ? 'Publish Author' : 'Private Author', style: const TextStyle(color: Colors.black54),)),
                      _buttonEdit(context),
                      SizedBox(width: 6,),
                      _buttonUpToServer(context),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10, bottom: 10),
                    child: Row(
                      children: [
                        Text('${contributionArticle.timeSchedule}', style: const TextStyle(color: Color(0xFFC7C7C7)),),
                        const SizedBox(width: 8,),
                        Text('${contributionArticle.captionIndonesia}', style: const TextStyle(color: Color(0xFFC7C7C7)),),
                      ],
                    )
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10, bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text('${contributionArticle.tagDistrik} - ${contributionArticle.tagKampung} - ${contributionArticle.tagKabupaten}', style: const TextStyle(color: Color(0xFFC7C7C7)),),
                        )
                      ],
                    )
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10, bottom: 10),
                  child: Text('${contributionArticle.deskripsiIndonesia}', style: const TextStyle(color: Colors.black54)),
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

  void _showDialogEdit(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 16,
          child: BlocConsumer<SubmitArticleBloc, SubmitArticleState>(
            listener: (context, state){
              if(state.status.isSuccess){
                Navigator.of(context).pop();
                BlocProvider.of<ArticleBloc>(context).add(GetArticle(statusArticle: 0));
                BlocProvider.of<SubmitArticleBloc>(context).add(ClearFormIMG());
              }
            },
            builder: (context, state){
              return SizedBox(
                height: MediaQuery.of(context).size.height - 150,
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    _createFotoPlaceHolder(context, state.editPhotoFile?.path),
                    const SizedBox(
                      height: 16,
                    ),
                    _createDateField(context, state.editTimeSchedule),
                    const SizedBox(
                      height: 16,
                    ),
                    _createTitleFieldJudul(
                        context: context,
                        label: KeyLanguage.labelJudul,
                        stateValidator: state.editJudulIndonesia
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    _createDescriptionFieldCaption(
                        context: context,
                        label: KeyLanguage.labelCaptipn,
                        maxLines: 3,
                        stateValidator: state.editDeskripsiIndonesia
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    _createDescriptionFieldDeskripsi(
                        context: context,
                        label: KeyLanguage.labelDeskripsi,
                        maxLines: 7,
                        stateValidator: state.editDeskripsiIndonesia
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Text(KeyLanguage.labelLokasi, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    _createTitleFieldKabupaten(
                        context: context,
                        label: KeyLanguage.labelKabupaten,
                        stateValidator: state.editTagKabupaten
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _createTitleFieldKampung(
                        context: context,
                        label: KeyLanguage.labelKampung,
                        stateValidator: state.editTagKampung
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _createTitleFieldDistik(
                        context: context,
                        label: KeyLanguage.labelDistrik,
                        stateValidator: state.editTagDistrik
                    ),
                    _createShowHideAuthor(context, state.edithideAuthor),
                    const SizedBox(
                      height: 16,
                    ),
                    _createButtonSubmit(context, state.editPhotoFile),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _createFotoPlaceHolder(BuildContext context, String? filename) {
    return MaterialButton(
      onPressed: (){
        _showDialogPickImage(context);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.file(File(filename ?? '')),
      ),
    );
  }

  Widget _createButtonSubmit(BuildContext context, XFile? editPhotoFile) {
    return Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child:
        RegulerButton(
            childWidget: MaterialButton(
              onPressed: () {
                updateArticleLocal(context, contributionArticle.collectionKey, editPhotoFile?.path);
              },
              child: const Text(
                KeyLanguage.labelButtonSubmit,
                style: TextStyle(color: Colors.white),
              ),
            ))
    );
  }

  Widget _createShowHideAuthor(BuildContext context, bool? hideAuthor) {
    return Row(
      children: [
        const SizedBox(
          width: 30,
        ),
        Switch(
          value: hideAuthor ?? false,
          onChanged: (value) {
            BlocProvider.of<SubmitArticleBloc>(context).add(EditChangeHideAuthor(value: value));
          },
          activeTrackColor: const Color.fromARGB(255, 188, 0, 0),
          activeColor: const Color.fromARGB(255, 133, 0, 0),
        ),
        const Text(
          KeyLanguage.labelHideAutor,
          style: TextStyle(
            color: Color.fromARGB(255, 133, 0, 0),
          ),
        )
      ],
    );
  }

  Widget _createDateField(BuildContext context, String? timeSchedule) {
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
              label: Text(KeyLanguage.labelTimeSchedule),
            ),
            style: const TextStyle(fontSize: 15),
            initialValue: timeSchedule ?? '',
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            onChanged: (val){
              BlocProvider.of<SubmitArticleBloc>(context).add(EditChangeTimeSchedule(value: val));
            },
            validator: (val){
              return null;
            },
            onSaved: (val){
              BlocProvider.of<SubmitArticleBloc>(context).add(EditChangeTimeSchedule(value: val));
            },
          )
      ),
    );
  }

  _showDialogPickImage(BuildContext context) {
    showDialog(context: context, builder: (_){
      return Dialog(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: MaterialButton(
                    onPressed: (){
                      _getFotoFromCamera(context, '0');
                      Navigator.pop(context);
                    },
                    child: Column(
                      children: const [
                        Icon(Icons.photo_camera_back, color: Color.fromARGB(255, 154, 0, 0)),
                        Text('Gallery', style: TextStyle(color: Color.fromARGB(255, 154, 0, 0), fontSize: 10, fontWeight: FontWeight.normal))
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: MaterialButton(
                    onPressed: (){
                      _getFotoFromCamera(context, '1');
                      Navigator.pop(context);
                    },
                    child: Column(
                      children: const [
                        Icon(Icons.camera_alt_outlined, color: Color.fromARGB(255, 154, 0, 0)),
                        Text('Camera', style: TextStyle(color: Color.fromARGB(255, 154, 0, 0), fontSize: 10, fontWeight: FontWeight.normal),)
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

  Future _getFotoFromCamera(BuildContext context, String title) async {
    XFile? pickedFotoFile;

    if(title == '0'){
      pickedFotoFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    }else{
      pickedFotoFile = await ImagePicker().pickImage(source: ImageSource.camera);
    }

    if (pickedFotoFile != null) {
      BlocProvider.of<SubmitArticleBloc>(context).add(
          GetImageArticleEdited(
            imageFile: pickedFotoFile,
          )
      );
    }
  }

  Widget _createTitleFieldJudul({required BuildContext context, required String label, String? stateValidator}) {
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
          value: stateValidator,
          onChanged: (value) {
            BlocProvider.of<SubmitArticleBloc>(context).add(EditChangeJudulIndonesia(value: value));
          }),
    );
  }

  Widget _createTitleFieldKabupaten({required BuildContext context, required String label, String? stateValidator}) {
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
          value: stateValidator,
          onChanged: (value) {
            BlocProvider.of<SubmitArticleBloc>(context).add(EditChangeKabutapen(value: value));
          }),
    );
  }

  Widget _createTitleFieldKampung({required BuildContext context, required String label, String? stateValidator}) {
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
          value: stateValidator,
          onChanged: (value) {
            BlocProvider.of<SubmitArticleBloc>(context).add(EditChangeKampung(value: value));
          }),
    );
  }

  Widget _createTitleFieldDistik({required BuildContext context, required String label, String? stateValidator}) {
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
          value: stateValidator,
          onChanged: (value) {
            BlocProvider.of<SubmitArticleBloc>(context).add(EditChangeDistrik(value: value));
          }),
    );
  }

  Widget _createDescriptionFieldCaption({required BuildContext context, required String label, required int maxLines, String? stateValidator}) {
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
        value: stateValidator,
        onChanged: (value) {
          BlocProvider.of<SubmitArticleBloc>(context).add(EditChangeCaptionIndonesia(value: value));
        },
        maxLines: maxLines,
      ),
    );
  }

  Widget _createDescriptionFieldDeskripsi({required BuildContext context, required String label, required int maxLines, String? stateValidator}) {
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
        value: stateValidator,
        onChanged: (value) {
          BlocProvider.of<SubmitArticleBloc>(context).add(EditChangeDeskripsiIndonesia(value: value));
        },
        maxLines: maxLines,
      ),
    );
  }

  void updateArticleLocal(BuildContext context, String? collectionKey, String? filename) {
    BlocProvider.of<SubmitArticleBloc>(context).add(SaveUpdateToLocalArticle(
        collectionKey: collectionKey,
        fileExisting: filename
    ));
  }

  _buttonUpToServer(BuildContext context) {
    return BlocConsumer<SubmitArticleBloc, SubmitArticleState>(
        builder: (context, state){
          return state.statusDelete.isLoading
              ? const CircularProgressIndicator()
              : Container(
            height: 35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.deepOrange
            ),
            child: MaterialButton(
              onPressed: (){
                BlocProvider.of<SubmitArticleBloc>(context).add(LocalToServer(data: contributionArticle));
              },
              child: Row(
                children: const [
                  Text('Upload ke server', style: TextStyle(color: Colors.white),),
                  SizedBox(width: 6,),
                  Icon(Icons.upload, size: 16, color: Colors.white,)
                ],
              ),
            ),
          );
        },
        listener: (context, state){
          if(state.statusDelete.isSuccess){
            BlocProvider.of<ArticleBloc>(context).add(GetArticle(statusArticle: 0));
          }
        }
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
        onPressed: (){
          BlocProvider.of<SubmitArticleBloc>(context).add(SetDetailArticleToEdit(data: contributionArticle));
          _showDialogEdit(context);
        },
        child: Row(
          children: const [
            Text('Edit', style: TextStyle(color: Colors.white),),
            SizedBox(width: 6,),
            Icon(Icons.edit, size: 15, color: Colors.white,)
          ],
        ),
      ),
    );
  }

}
