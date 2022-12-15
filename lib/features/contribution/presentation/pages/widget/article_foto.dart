import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_bakarbatu/features/contribution/presentation/bloc/submit_article/submit_article_bloc.dart';
import 'package:new_bakarbatu/shared/common/key_language.dart';
import 'package:new_bakarbatu/shared/widgets/reguler_button.dart';
import 'package:new_bakarbatu/shared/widgets/reguler_text_area.dart';
import 'package:new_bakarbatu/shared/widgets/reguler_text_form_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bottom_nav/bottom_nav_bloc.dart';

class ArticleFoto extends StatefulWidget {
  const ArticleFoto({super.key});

  @override
  State<ArticleFoto> createState() => _ArticleFotoState();
}

class _ArticleFotoState extends State<ArticleFoto> {
  Future _getFotoFromCamera(String title) async {
    XFile? pickedFotoFile;

    if(title == '0'){
      pickedFotoFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    }else{
      pickedFotoFile = await ImagePicker().pickImage(source: ImageSource.camera);
    }

    if (pickedFotoFile != null) {
      BlocProvider.of<SubmitArticleBloc>(context).add(
          GetImageArticle(
            imageFile: pickedFotoFile,
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubmitArticleBloc, SubmitArticleState>(
        listener: (context, state){
          if(state.status.isSuccess){
            BlocProvider.of<BottomNavBloc>(context).add(ChangeBottomNav(
                statusMenu: true,
                idMenu: 2
            ));
            BlocProvider.of<SubmitArticleBloc>(context).add(ClearFormIMG());
          }
        },
        builder: (context, state){
          return Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16), topRight: Radius.circular(16))),
            height: MediaQuery.of(context).size.height - 150,
            child: ListView(
              children: [
                _createFotoPlaceHolder(state),
                const SizedBox(
                  height: 16,
                ),
                _createDateField(state),
                const SizedBox(
                  height: 16,
                ),
                _createTitleFieldJudul(
                  label: KeyLanguage.labelJudul,
                  stateValidator: state
                ),
                const SizedBox(
                  height: 16,
                ),
                _createDescriptionFieldCaption(
                    label: KeyLanguage.labelCaptipn,
                    maxLines: 3,
                    stateValidator: state
                ),
                const SizedBox(
                  height: 16,
                ),
                _createDescriptionFieldDeskripsi(
                    label: KeyLanguage.labelDeskripsi,
                    maxLines: 7,
                    stateValidator: state
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
                    label: KeyLanguage.labelKabupaten,
                    stateValidator: state
                ),
                const SizedBox(
                  height: 10,
                ),
                _createTitleFieldKampung(
                    label: KeyLanguage.labelKampung,
                    stateValidator: state
                ),
                const SizedBox(
                  height: 10,
                ),
                _createTitleFieldDistik(
                    label: KeyLanguage.labelDistrik,
                    stateValidator: state
                ),
                _createShowHideAuthor(state),
                const SizedBox(
                  height: 16,
                ),
                state.status.isError ? Text('${state.warningMessage}') : const SizedBox(),
                state.status.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _createButtonSubmit(state),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          );
        }
    );
  }

  Widget _createFotoPlaceHolder(SubmitArticleState state) {
    print('JANCOOK L ${state.photoFile?.path}');
    return state.photoFile != null
        ?
    state.photoFile!.path != ''
        ?
    MaterialButton(
      onPressed: (){
        _showDialogPickImage();
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.file(File(state.photoFile!.path)),
      ),
    )
        :
    _defaultButtonImage() : _defaultButtonImage();
  }

  Widget _createButtonSubmit(SubmitArticleState state) {
    return Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: state.status.isLoading
            ? const CircularProgressIndicator()
            : RegulerButton(
            childWidget: MaterialButton(
              onPressed: () => validateToSubmit(state),
              child: const Text(
                KeyLanguage.labelButtonSubmit,
                style: TextStyle(color: Colors.white),
              ),
            ))
    );
  }

  Widget _createShowHideAuthor(SubmitArticleState state) {
    return Row(
      children: [
        const SizedBox(
          width: 30,
        ),
        Switch(
          value: state.hideAuthor ?? false,
          onChanged: (value) {
            BlocProvider.of<SubmitArticleBloc>(context).add(ChangeHideAuthor(value: value));
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

  Widget _createDateField(SubmitArticleState state) {
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
          initialValue: state.timeSchedule ?? '',
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          onChanged: (val){
            BlocProvider.of<SubmitArticleBloc>(context).add(ChangeTimeSchedule(value: val));
          },
          validator: (val){
            return null;
          },
          onSaved: (val){
            BlocProvider.of<SubmitArticleBloc>(context).add(ChangeTimeSchedule(value: val));
          },
        )
      ),
    );
  }

  validateToSubmit(SubmitArticleState state) {
    BlocProvider.of<SubmitArticleBloc>(context).add(ValidateToSubmitArticle());
  }

  Widget _createTitleFieldJudul({required String label, required SubmitArticleState stateValidator}) {
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
          value: stateValidator.judulIndonesiaIMG,
          onChanged: (value) {
            BlocProvider.of<SubmitArticleBloc>(context).add(ChangeJudulIndonesia(value: value));
          }),
    );
  }

  Widget _createTitleFieldKabupaten({required String label, required SubmitArticleState stateValidator}) {
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
          value: stateValidator.tagKabupatenIMG,
          onChanged: (value) {
              BlocProvider.of<SubmitArticleBloc>(context).add(ChangeKabutapen(value: value));
          }),
    );
  }

  Widget _createTitleFieldKampung({required String label, required SubmitArticleState stateValidator}) {
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
          value: stateValidator.tagKampungIMG,
          onChanged: (value) {
              BlocProvider.of<SubmitArticleBloc>(context).add(ChangeKampung(value: value));
          }),
    );
  }

  Widget _createTitleFieldDistik({required String label, required SubmitArticleState stateValidator}) {
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
          value: stateValidator.tagDistrikIMG,
          onChanged: (value) {
              BlocProvider.of<SubmitArticleBloc>(context).add(ChangeDistrik(value: value));
          }),
    );
  }

  Widget _createDescriptionFieldCaption({required String label, required int maxLines, required SubmitArticleState stateValidator}) {
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
        value: stateValidator.captionIndonesiaIMG,
        onChanged: (value) {
            BlocProvider.of<SubmitArticleBloc>(context).add(ChangeCaptionIndonesia(value: value));
        },
        maxLines: maxLines,
      ),
    );
  }

  Widget _createDescriptionFieldDeskripsi({required String label, required int maxLines, required SubmitArticleState stateValidator}) {
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
        value: stateValidator.deskripsiIndonesiaIMG,
        onChanged: (value) {
          BlocProvider.of<SubmitArticleBloc>(context).add(ChangeDeskripsiIndonesia(value: value));
        },
        maxLines: maxLines,
      ),
    );
  }

  _showDialogPickImage() {
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
                      _getFotoFromCamera('0');
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
                      _getFotoFromCamera('1');
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

  Widget _defaultButtonImage() {
    return MaterialButton(
      onPressed: () {
        _showDialogPickImage();
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
              KeyLanguage.labelTakePhoto,
              style: TextStyle(
                  color: Color.fromARGB(255, 154, 0, 0), fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
