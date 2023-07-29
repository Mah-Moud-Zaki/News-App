import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/news_app/cubit/states.dart';
import 'package:newsapp/modules/business/business_screen.dart';
import 'package:newsapp/modules/science/science_screen.dart';
import 'package:newsapp/modules/settings/settings_screen.dart';
import 'package:newsapp/modules/sports/sport_screen.dart';
import 'package:newsapp/shared/network/remot/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {

  NewsCubit() : super(NewsInitialStates());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business_center,
      ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),

  ];

  List<Widget> screen = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),

  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if(index==1)
      getSports();
    if(index==2)
      getScience();
    emit(NewsBottomNavStates());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingStates());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
       'country': 'us',
       'category': 'business',
       'apiKey': 'db91febea15d4b42a4cbabe1b02d5c2b',
      },
    ).then((value) {
      //print(value.data['articles']);
      business = value.data['articles'];
      print(business[0] ['title']);
      emit(NewsGetBusinessSuccessStates());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorStates(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingStates());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'us',
        'category': 'sports',
        'apiKey': 'db91febea15d4b42a4cbabe1b02d5c2b',
      },
    ).then((value) {
      //print(value.data['articles']);
      sports = value.data['articles'];
      print(sports[0] ['title']);
      emit(NewsGetSportsSuccessStates());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSportsErrorStates(error.toString()));
    });
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingStates());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'us',
        'category': 'science',
        'apiKey': 'db91febea15d4b42a4cbabe1b02d5c2b',
      },
    ).then((value) {
      //print(value.data['articles']);
      science = value.data['articles'];
      print(science[0] ['title']);
      emit(NewsGetScienceSuccessStates());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetScienceErrorStates(error.toString()));
    });
  }

  List<dynamic> search=[];

  void getSearch(String value) {

    emit(NewsGetSearchLoadingStates());

    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$value',
        'apiKey': 'db91febea15d4b42a4cbabe1b02d5c2b',
      },
    ).then((value) {
      //print(value.data['articles']);
      search = value.data['articles'];
      print(search[0] ['title']);
      emit(NewsGetSearchSuccessStates());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorStates(error.toString()));
    });
  }

}