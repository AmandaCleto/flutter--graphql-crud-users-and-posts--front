import 'package:flutter/material.dart';
import 'package:graphql_crud_users/shared/theme/colors.dart';
import 'package:graphql_crud_users/shared/extensions/size_extension.dart';
import 'package:graphql_crud_users/shared/theme/font_sizes.dart';

class PostWidget extends StatelessWidget {
  final String text;
  final String title;
  final String author;
  const PostWidget({
    super.key,
    required this.text,
    required this.title,
    required this.author,
  });

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontSize: FontSizesTheme.small,
      color: ColorsTheme.blue,
      overflow: TextOverflow.ellipsis,
    );

    return Container(
      height: 144.0,
      width: context.screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: ColorsTheme.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: context.screenWidth,
              child: Text(
                title,
                textAlign: TextAlign.start,
                maxLines: 1,
                style: style.copyWith(
                  fontSize: FontSizesTheme.subtitle,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Flexible(
              child: Text(
                text,
                textAlign: TextAlign.justify,
                maxLines: 4,
                style: style,
              ),
            ),
            const SizedBox(height: 5.0),
            SizedBox(
              width: context.screenWidth,
              child: Text(
                author,
                textAlign: TextAlign.end,
                maxLines: 1,
                style: style,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
