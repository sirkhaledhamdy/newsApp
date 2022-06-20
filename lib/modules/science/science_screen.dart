import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/components/components.dart';
import '../../cubit/cubit.dart';
import '../../cubit/states.dart';

class SienceScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context , state){},
      builder: (context , state){
        var list = NewsCubit.get(context).science;
        if(list.isNotEmpty) {
          return builderNews(list);
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
