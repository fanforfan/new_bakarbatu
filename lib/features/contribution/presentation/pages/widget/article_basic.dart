import 'package:flutter/material.dart';
import 'package:new_bakarbatu/shared/widgets/reguler_button.dart';
import 'package:new_bakarbatu/shared/widgets/reguler_text_area.dart';
import 'package:new_bakarbatu/shared/widgets/reguler_text_form_field.dart';

class ArticleBasic extends StatefulWidget {
  const ArticleBasic({super.key});

  @override
  State<ArticleBasic> createState() => _ArticleBasicState();
}

class _ArticleBasicState extends State<ArticleBasic> {
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
          _createTitleField(label: 'Judul laporan Text'),
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
}