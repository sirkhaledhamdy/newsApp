import 'package:flutter/material.dart';
import 'package:news_flutter/network/local/cache_helper.dart';
import 'constants/constants.dart';
import 'cubit/appcubit.dart';
import 'cubit/appstates.dart';
import 'cubit/cubit.dart';
import 'network/remote/dio_helper.dart';
import 'news_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
void main() {

  BlocOverrides.runZoned(
        () async {
          WidgetsFlutterBinding.ensureInitialized();
          DioHelper.init();
         await CacheHelper.init();
         bool? isDark = CacheHelper.getData(key: 'isDark',);
          runApp(MyApp(isDark));
        },
    blocObserver: MyBlocObserver(),
  );
}


class MyApp extends StatelessWidget {
  final bool? isDark;
  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsCubit()..getBusiness()..getSports()..getScience(),),
        BlocProvider(create: (context) => AppCubit()..changeAppMode(fromShared: isDark,),),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context , state){},
        builder: (context,  state){

          return MaterialApp(
            theme: ThemeData(
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              primarySwatch: Colors.teal,
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.teal,
                unselectedItemColor: Colors.grey.shade400,
                elevation: 15.0,
                backgroundColor: Colors.white,
              ),
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(
                  color: Colors.teal,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
                backgroundColor: Colors.white,
                elevation: 0,
              ),
            ),
            darkTheme: ThemeData(
              
              scaffoldBackgroundColor: Colors.grey.shade900,
              primarySwatch: Colors.grey,
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.teal,
                unselectedItemColor: Colors.grey.shade300,
                elevation: 15.0,
                backgroundColor: Colors.grey.shade900,
              ),
              appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
                backgroundColor: Colors.grey.shade900,
                elevation: 0,
              ),

              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),

            ),
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: NewsLayOut(),
          );
        },
      ),
    );
  }
}