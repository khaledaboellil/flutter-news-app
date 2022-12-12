import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layout/newsapp/cubit/cubit.dart';
import 'package:shop_app/layout/newsapp/cubit/states.dart';
import 'package:shop_app/layout/newsapp/news_app.dart';

import 'package:shop_app/layout/todo%20app/todo_app.dart';

import 'package:shop_app/layout/todo%20app/todo_app.dart';

import 'package:shop_app/shared/Bloc_observe.dart';
import 'package:shop_app/shared/comapnents/constans.dart';
import 'package:shop_app/shared/network/locale/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

import 'layout/newsapp/cubit/modecubit.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  blocObserver: MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData("isDark");
  bool? onBoarding =CacheHelper.getData('onBoarding');
  token =CacheHelper.loadStringData(key: 'token');

  if(isDark==null)
  {
    isDark=false ;
  }


  runApp(MyApp(isDark));
}


class MyApp extends StatelessWidget{
  final bool isDark;
  MyApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

      providers: [
        BlocProvider(create: (BuildContext context) => NewsCubit()..getBusiness()..getScience()..getSports()),
        BlocProvider(create: (BuildContext context) => ModeCubit()..changelightmode(fromShared: isDark)),
      ],
      child: BlocConsumer<ModeCubit, NewsStates>(

          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lighttheme ,
              darkTheme: darktheme,
              themeMode: ModeCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
              home: NewsApp(),
            ) ;
          }

      ),
    ) ;
  }


}