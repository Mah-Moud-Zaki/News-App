import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/modules/web_view_screen/web_view_screen.dart';

Widget buildArticalItem(article, context) => InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(article['url']),);
  },
  child:   Padding(
        padding: EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Container(
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
);

Widget myDivider() =>
    Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[300],
    );

Widget buildItem(list, context, {isSearch = false}) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) =>
          ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                buildArticalItem(list[index], context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: 10,),
      fallback: (context) => isSearch? Container() : Center(child: CircularProgressIndicator()),
    );

Widget defaultFormField({@required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isPassword = false,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixPressed,
  bool isClickable = true}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: (s) {
        onSubmit(s);
      },
      obscureText: isPassword,
      onChanged: (s) {
        onChange(s);
      },
      validator: validate,
      enabled: isClickable,
      onTap: () {
        onTap();
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null ? Icon(suffix) : null,
        border: OutlineInputBorder(),
      ),
    );

void navigateTo(context, widget) =>
    Navigator.push(
      context,
      MaterialPageRoute(
          builder:(context)=>widget
      ),
    );