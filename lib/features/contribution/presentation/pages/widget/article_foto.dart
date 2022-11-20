import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_bakarbatu/features/contribution/presentation/bloc/submit_article/submit_article_bloc.dart';
import 'package:new_bakarbatu/shared/widgets/reguler_button.dart';
import 'package:new_bakarbatu/shared/widgets/reguler_text_area.dart';
import 'package:new_bakarbatu/shared/widgets/reguler_text_form_field.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleFoto extends StatefulWidget {
  const ArticleFoto({super.key});

  @override
  State<ArticleFoto> createState() => _ArticleFotoState();
}

class _ArticleFotoState extends State<ArticleFoto> {
  final _picker = ImagePicker();

  Future _getFotoFromCamera(String title) async {
    final pickedFotoFile = await _picker.pickImage(source: ImageSource.camera);

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
        listener: (context, state){},
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
                _createButtonSubmit(state),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          );
        }
    );
  }

  Widget _createFotoPlaceHolder(SubmitArticleState state) {
    return state.photoFile != null
        ?
    MaterialButton(
      onPressed: (){
        _getFotoFromCamera('First Pick');
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(state.photoFile!.path),
      ),
    )
        :
    MaterialButton(
      onPressed: () {
        _getFotoFromCamera('First Pick');
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
              'Take foto',
              style: TextStyle(
                  color: Color.fromARGB(255, 154, 0, 0), fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createTitleField({required String label, required String key, required SubmitArticleState stateValidator}) {
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
            if(key == 'field_img_0'){
              BlocProvider.of<SubmitArticleBloc>(context).add(ChangeJudulIndonesia(value: value));
            }else if(key == 'field_img_3'){
              BlocProvider.of<SubmitArticleBloc>(context).add(ChangeKabutapen(value: value));
            }else if(key == 'field_img_4'){
              BlocProvider.of<SubmitArticleBloc>(context).add(ChangeKampung(value: value));
            }else if(key == 'field_img_5'){
              BlocProvider.of<SubmitArticleBloc>(context).add(ChangeDistrik(value: value));
            }
          }),
    );
  }

  Widget _createDescriptionField({required String label, required int maxLines, required String key}) {
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
            if(key == 'field_img_1'){
              BlocProvider.of<SubmitArticleBloc>(context).add(ChangeCaptionIndonesia(value: value));
            }else if(key == 'field_img_2'){
              BlocProvider.of<SubmitArticleBloc>(context).add(ChangeDeskripsiIndonesia(value: value));
            }
          },
          maxLines: maxLines,
      ),
    );
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
                'Submit',
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
          'Sembuyikan Kepemilikan',
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
            label: Text('Time Schedule'),
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
}
