import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_bakarbatu/core/util/routes.dart';
import 'package:new_bakarbatu/db/models/article_model.dart';
import 'package:new_bakarbatu/db/models/contribution_article_model.dart';
import 'package:new_bakarbatu/features/authentication/presentation/bloc/bloc/authentication_bloc.dart';
import 'package:new_bakarbatu/features/authentication/presentation/bloc/cubit_password/obsecure_password_cubit.dart';
import 'package:new_bakarbatu/features/contribution/presentation/bloc/article/article_bloc.dart';
import 'package:new_bakarbatu/features/contribution/presentation/bloc/bottom_nav/bottom_nav_bloc.dart';
import 'package:new_bakarbatu/features/contribution/presentation/bloc/download%20_video/download_video_bloc.dart';
import 'package:new_bakarbatu/features/contribution/presentation/bloc/submit_article/submit_article_bloc.dart';
import 'package:new_bakarbatu/features/contribution/presentation/bloc/submit_article_video/submit_artikel_video_bloc.dart';
import 'package:new_bakarbatu/features/home/presentation/bloc/home_bloc.dart';
import 'package:new_bakarbatu/features/home/presentation/pages/home_page.dart';
import 'package:path_provider/path_provider.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Hive.initFlutter();
  Hive.registerAdapter(ArticleAdapter());
  Hive.registerAdapter(ContributionArticleAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
              create: (context) => di.sl<AuthenticationBloc>(),
            ),
        BlocProvider<HomeBloc>(
                create: (context) => di.sl<HomeBloc>(),
              ),
        BlocProvider<SubmitArticleBloc>(
            create: (context) => di.sl<SubmitArticleBloc>()
        ),
        BlocProvider<SubmitArtikelVideoBloc>(
            create: (context) => di.sl<SubmitArtikelVideoBloc>()
        ),
        BlocProvider<BottomNavBloc>(
            create: (context) => di.sl<BottomNavBloc>()
        ),
        BlocProvider<ObsecurePasswordCubit>(
            create: (context) => di.sl<ObsecurePasswordCubit>(),
        ),
        BlocProvider<ArticleBloc>(
            create: (context) => di.sl<ArticleBloc>(),
        ),
        BlocProvider<DownloadVideoBloc>(
            create: (context) => di.sl<DownloadVideoBloc>()
        )
      ], 
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BAKAR BATU',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
        initialRoute: Routes.initialPage,
        routes: CustomRoutes
      )
    );
  }
}