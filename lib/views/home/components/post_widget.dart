import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:graphql_crud_users/shared/theme/colors.dart';
import 'package:graphql_crud_users/shared/extensions/size_extension.dart';
import 'package:graphql_crud_users/shared/theme/font_sizes.dart';

class PostWidget extends StatefulWidget {
  final String text, title, author, postId;

  const PostWidget({
    super.key,
    required this.text,
    required this.title,
    required this.author,
    required this.postId,
  });

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(20.0);

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontSize: FontSizesTheme.small,
      color: ColorsTheme.blue,
      overflow: TextOverflow.ellipsis,
    );

    return Dismissible(
      key: Key(widget.postId),
      onDismissed: (direction) {
        // Remove the item from the data source.

        // Then show a snackbar.
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('dismissed')));
      },
      direction: DismissDirection.endToStart,
      onUpdate: (dismissUpdateDetails) {
        if (dismissUpdateDetails.progress == 0) {
          setState(() {
            _borderRadius = BorderRadius.circular(20.0);
          });
        } else {
          setState(() {
            _borderRadius = BorderRadius.circular(0.0);
          });
        }
      },
      background: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: ColorsTheme.pinkLight,
        ),
        child: const Padding(
          padding: EdgeInsets.all(18.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: Icon(Icons.delete),
          ),
        ),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        curve: Curves.linear,
        height: 144.0,
        width: context.screenWidth,
        margin: const EdgeInsets.only(left: 20.0),
        decoration: BoxDecoration(
          borderRadius: _borderRadius,
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
                  widget.title,
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
                  widget.text,
                  textAlign: TextAlign.justify,
                  maxLines: 4,
                  style: style,
                ),
              ),
              const SizedBox(height: 5.0),
              SizedBox(
                width: context.screenWidth,
                child: Text(
                  widget.author,
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  style: style,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
