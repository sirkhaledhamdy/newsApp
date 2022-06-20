import 'package:flutter/material.dart';
import 'package:news_flutter/modules/web_view/web_view.dart';

Widget buildarticalItem(article, context) => InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(article['url'],),);
  },
  child:   Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      children: [
        Container(
          width: 130.0,
          height: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: NetworkImage('${article['urlToImage']}',
              ),
  
  
              fit: BoxFit.cover,
            ),
          ),
  
        ),
        SizedBox(width: 20.0,),
        Expanded(
          child: Container(
            height: 120.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text('${article['title']}',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Text('${article['publishedAt']}',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  ),
);


Widget builderNews(list) => ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, index) => buildarticalItem(list[index], context),
    separatorBuilder: (context, index) => Padding(
      padding: const EdgeInsetsDirectional.only(start: 16.0),
      child: Container(
        height: 1,
        color: Colors.grey.shade300,
      ),
    ),
    itemCount: list.length);


Widget defaultFormField ({
  required TextEditingController controller,
  required TextInputType type,
  void Function(String)? onSubmit,
  void Function(String)? onChange,
  required Function validate,
  required String label,
  required IconData prefix,

}) => TextFormField(
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(
      prefix,
  ),
    border: OutlineInputBorder(),
  ),

  controller: controller,
  keyboardType: type,
  onFieldSubmitted: onSubmit,
  validator: (value){
    if(value!.isEmpty) {
      return 'User Must Input Data';
    }
    return null;
  },
);

void navigateTo(context, widget)
{
  Navigator.push(context, MaterialPageRoute(builder:
  (context) => widget,
  ),);
}

