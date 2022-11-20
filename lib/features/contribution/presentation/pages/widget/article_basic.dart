import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_bakarbatu/db/models/article_model.dart';
import 'package:new_bakarbatu/features/contribution/presentation/bloc/submit_article/submit_article_bloc.dart';
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
    return BlocBuilder<SubmitArticleBloc, SubmitArticleState>(
      builder: (context, state){
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
              _createDescriptionField(label: 'Deskripsi',  maxLines: 7),
              const SizedBox(
                height: 16,
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
      },
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
            BlocProvider.of<SubmitArticleBloc>(context).add(ChangeTitleArticle(value: value));
          }),
    );
  }

  Widget _createDescriptionField({required String label, required int maxLines}) {
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
            BlocProvider.of<SubmitArticleBloc>(context).add(ChangeDescriptionArticle(value: value));
          },
          maxLines: maxLines,
      ),
    );
  }

  Widget _createButtonSubmit(SubmitArticleState state) {
    return state.status.isLoading
        ?
    const Center(
      child: SizedBox(
        width: 30.0,
        height: 30.0,
        child: CircularProgressIndicator(),
      ),
    )
        :
    Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: RegulerButton(
            childWidget: MaterialButton(
          onPressed: (){
            BlocProvider.of<SubmitArticleBloc>(context).add(SubmitArticleBasic(article: Article(
                filename: '-',
                title: '${state.titleArticle}',
                description: '${state.descriptionArticle}',
                hideauthor: '${state.hideAuthor}'
            )));
          },
          child: const Text(
            'Submit',
            style: TextStyle(color: Colors.white),
          ),
        )));
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
            BlocProvider.of<SubmitArticleBloc>(context).add(ChangeHideShowAuthor(value: value));
          },
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

  // _addArticle() async {
  //   var boxx = await Hive.openBox<Article>('articleBakarbatu');
  //   // var box = Hive.box('articleBakarbatu');
  //
  //   // await boxx.add(item);
  //
  //   // box.put('filename', item.filename);
  //   // box.put('title', item.title);
  //   // box.put('description', item.description);
  //   // box.put('hideauthor', item.hideauthor);
  //
  //   // _articleList = boxx.values.toList();
  //   //
  //   debugPrint('JUMLAH : ${boxx.values.length}');
  //   for(int i=0; i<boxx.values.length; i++){
  //     debugPrint('HALO : ${boxx.get(i)?.title}');
  //   }
  //   // debugPrint('HALOO GAESS : ${boxx.values}');
  // }

}

class Articles {
  final String? filename;
  final String?title;
  final String? description;
  final String? hideauthor;

  Articles({this.filename, this.title, this.description, this.hideauthor});
}