import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:news_app/layouts/news_states.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/modules/webView/webView_screen.dart';

Widget buildArticleItem(Map news,BuildContext context) => InkWell(
  onTap:(){
    navigateTo(context,WebViewScreen(url: news['url']));
  } ,
  child:   Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 180.0,
              height: 112.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  24.0,
                ),
                image: DecorationImage(
                  image: NetworkImage(news['urlToImage']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 16.0,
            ),
            Expanded(
              child: Container(
                height: 120.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${news['title']}',
                        style:Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${news['publishedAt']}',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
);

Widget articleBuilder(List list, NewsStates state,BuildContext context) => ConditionalBuilder(
      condition: state is! NewsGetBusinessLoadingState,
      builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return buildArticleItem(list[index],context);
        },
        separatorBuilder: (context, index) {
          return divider();
        },
        itemCount: list.length,
      ),
      fallback: (context) => Center(child: CircularProgressIndicator()),
    );

Widget divider() => Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey,
    );


Widget defaultTextFormField({
  required String labelText,
  required TextEditingController controller,
  required TextInputType textInputType,
  bool obscureText = false,
  required IconData prefixIcon,
  IconData? suffixIcon,
  GestureTapCallback? onTap,
  bool? isClickable,
  required FormFieldValidator validate,
  ValueChanged? onSubmit,
  ValueChanged? onChange,
  VoidCallback? onPressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: textInputType,
      obscureText: obscureText,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      validator: validate,
      onTap: onTap,
      enabled: isClickable,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon != null
            ? IconButton(
          onPressed: onPressed,
          icon: Icon(suffixIcon),
        )
            : null,
      ),
    );

void navigateTo(BuildContext context,Widget widget) {
  Navigator.push(context,MaterialPageRoute(builder: (context) => widget),);
}
