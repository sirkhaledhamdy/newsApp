import 'package:flutter/material.dart';
import 'package:news_flutter/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter/modules/business/business_screen.dart';
import 'package:news_flutter/modules/sports/sports_screen.dart';

import '../modules/science/science_screen.dart';
import '../network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    SienceScreen(),
  ];
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business_center,
      ),
      label: 'Business',

    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports_soccer,
      ),
      label: 'Sports',

    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science_outlined,
      ),
      label: 'Science',
    ),

  ];

  void changeBottomNavBar(int index){
    currentIndex = index;

    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness(){
      emit(NewsGetBusinessLoadingState());
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country':'eg',
        'category':'business',
        'apiKey':'f8fcf96ebefa4fbfa62ef46fc85c3aaa',
      }).then((value) {
        business = value?.data['articles'];
        print(business.length);
        emit(NewsGetBusinessSuccessState());
      }).catchError((error){
        print(error);
        emit(NewsGetBusinessErrorState(error));
      });
  }

  List<dynamic> sports = [];

  void getSports(){
    if(sports.isEmpty){
      emit(NewsGetSportsLoadingState());
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country':'eg',
        'category':'sports',
        'apiKey':'f8fcf96ebefa4fbfa62ef46fc85c3aaa',
      }).then((value) {
        sports = value?.data['articles'];
        print(sports.length);
        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print(error);
        emit(NewsGetSportsErrorState(error));
      });
    } else{
      emit(NewsGetSportsSuccessState());
    }
  }
  List<dynamic> science = [];

  void getScience(){
    if(science.isEmpty){
      emit(NewsGetScienceLoadingState());
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country':'eg',
        'category':'science',
        'apiKey':'f8fcf96ebefa4fbfa62ef46fc85c3aaa',
      }).then((value) {
        science = value?.data['articles'];
        print(science.length);
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error);
        emit(NewsGetScienceErrorState(error));
      });
    } else{
      emit(NewsGetScienceSuccessState());
    }
  }


  List<dynamic> search = [];

  void getSearch(String value)

  {
    emit(NewsGetSearchLoadingState());

    DioHelper.getData(
        url: 'v2/everything',
        query:
        {
      'q':'$value',
      'apiKey':'f8fcf96ebefa4fbfa62ef46fc85c3aaa',
    }).then((value) {
      search = value?.data['articles'];
      print(search.length);
      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print(error);
      emit(NewsGetSearchErrorState(error));
    });
  }




}
