import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_bakarbatu/shared/widgets/shimmer_loading_image.dart';

import '../../../data/models/article_response.dart';
import '../../bloc/submit_article/submit_article_bloc.dart';
import '../detail_video.dart';

class ItemArticleOnline extends StatelessWidget {
  final DataNewsroom dataNewsroom;

  const ItemArticleOnline({Key? key, required this.dataNewsroom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF800000),
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dataNewsroom.articleUrl.toString().contains('.mp4')
              ?
          Container(
            width: MediaQuery.of(context).size.width,
            height: 150,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
            ),
            child: MaterialButton(
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailVideo(articleUrl: '${dataNewsroom.articleUrl}', idArticle: '${dataNewsroom.idNewsroom}')
                    )
                );
              },
              child: const Icon(Icons.play_circle_outline_outlined, color: Colors.red,),
            )
          )
              :
          ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                child: CachedNetworkImage(
                imageUrl: '${dataNewsroom.articleUrl}',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                height: 150,
                width: MediaQuery.of(context).size.width,
                placeholder: (context, url){
                  return const Center(
                    child: ShimmerLoadingImage()
                  );
                },
              )
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
                  child: Text('${dataNewsroom.title}', style: const TextStyle(color: Colors.black54, fontSize: 18, fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10, bottom: 10),
                  child: Text(dataNewsroom.nameEditor ?? 'Private Author', style: const TextStyle(color: Colors.black54),),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10, bottom: 10),
                    child: Row(
                      children: [
                        Text('${dataNewsroom.saved}', style: const TextStyle(color: Color(0xFFC7C7C7)),),
                        const SizedBox(width: 8,),
                        Text('${dataNewsroom.categoryName}', style: const TextStyle(color: Color(0xFFC7C7C7)),),
                        const SizedBox(width: 8,),
                        _buttonEdit(context)
                      ],
                    )
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10, bottom: 10),
                  child: Text('${dataNewsroom.description}', style: const TextStyle(color: Colors.black54)),
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
          BlocProvider.of<SubmitArticleBloc>(context).add(SetDetailArticleOnline(data: dataNewsroom));
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

  void _showDialogEdit(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 16,
          child: BlocBuilder<SubmitArticleBloc, SubmitArticleState>(
            builder: (context, state){
              return SizedBox(
                height: MediaQuery.of(context).size.height - 150,
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Text('${state.editJudulIndonesia}'),
                    // _createFotoPlaceHolder(context, state.editPhotoFile?.path),
                    // const SizedBox(
                    //   height: 16,
                    // ),
                    // _createDateField(context, state.editTimeSchedule),
                    // const SizedBox(
                    //   height: 16,
                    // ),
                    // _createTitleFieldJudul(
                    //     context: context,
                    //     label: KeyLanguage.labelJudul,
                    //     stateValidator: state.editJudulIndonesia
                    // ),
                    // const SizedBox(
                    //   height: 16,
                    // ),
                    // _createDescriptionFieldCaption(
                    //     context: context,
                    //     label: KeyLanguage.labelCaptipn,
                    //     maxLines: 3,
                    //     stateValidator: state.editDeskripsiIndonesia
                    // ),
                    // const SizedBox(
                    //   height: 16,
                    // ),
                    // _createDescriptionFieldDeskripsi(
                    //     context: context,
                    //     label: KeyLanguage.labelDeskripsi,
                    //     maxLines: 7,
                    //     stateValidator: state.editDeskripsiIndonesia
                    // ),
                    // const SizedBox(
                    //   height: 16,
                    // ),
                    // const Padding(
                    //   padding: EdgeInsets.only(left: 30),
                    //   child: Text(KeyLanguage.labelLokasi, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),),
                    // ),
                    // const SizedBox(
                    //   height: 16,
                    // ),
                    // _createTitleFieldKabupaten(
                    //     context: context,
                    //     label: KeyLanguage.labelKabupaten,
                    //     stateValidator: state.editTagKabupaten
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // _createTitleFieldKampung(
                    //     context: context,
                    //     label: KeyLanguage.labelKampung,
                    //     stateValidator: state.editTagKampung
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // _createTitleFieldDistik(
                    //     context: context,
                    //     label: KeyLanguage.labelDistrik,
                    //     stateValidator: state.editTagDistrik
                    // ),
                    // _createShowHideAuthor(context, state.edithideAuthor),
                    // const SizedBox(
                    //   height: 16,
                    // ),
                    // _createButtonSubmit(context, state.editPhotoFile),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
