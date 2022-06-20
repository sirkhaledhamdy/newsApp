import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/components/components.dart';
import '../../cubit/cubit.dart';
import '../../cubit/states.dart';

class SportsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context , state){},
      builder: (context , state){
        var list = NewsCubit.get(context).sports;
        if(list.isNotEmpty) {
          return ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildarticalItem(list[index],context),
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsetsDirectional.only(start: 16.0),
                child: Container(
                  height: 1,
                  color: Colors.grey.shade300,
                ),
              ),
              itemCount: list.length);
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
