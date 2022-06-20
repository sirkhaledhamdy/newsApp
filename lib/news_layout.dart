import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter/constants/components/components.dart';
import 'package:news_flutter/cubit/appcubit.dart';
import 'package:news_flutter/cubit/cubit.dart';
import 'package:news_flutter/cubit/states.dart';
import 'package:news_flutter/modules/search/searchscreen.dart';


class NewsLayOut extends StatelessWidget {
  const NewsLayOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, State) {},
      builder: (context, State)
      {
        var cubit = NewsCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Extra Daily News',
            ),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(context, SearchScreen());
                },
                icon: Icon(
                  Icons.search,
                ),
              ),
            ],
            leading: IconButton(
              icon: Icon(Icons.dark_mode,),
              onPressed: (){
                AppCubit.get(context).changeAppMode();
              },
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomItems,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
            currentIndex: cubit.currentIndex,
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
