import 'package:flutter/material.dart';
import 'package:graphql_crud_users/shared/components/alert_dialog_widget.dart';
import 'package:graphql_crud_users/shared/themes/colors.dart';
import 'package:graphql_crud_users/shared/extensions/size_extension.dart';
import 'package:graphql_crud_users/shared/themes/font_sizes.dart';
import 'package:graphql_crud_users/shared/typedefs/typedefs.dart';

class PostWidget extends StatefulWidget {
  final String text, title, author, postId;
  final FutureCallback callbackFn;

  const PostWidget({
    super.key,
    required this.text,
    required this.title,
    required this.author,
    required this.postId,
    required this.callbackFn,
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
      confirmDismiss: (DismissDirection direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialogWidget(
              title: 'Are you sure?',
              content: 'By deleting this post, you cannot undo this action.',
              confirmationButtonText: "I'm sure!",
              denialButtonText: "No",
              confirmationFn: () async {
                await widget.callbackFn();
              },
            );
          },
        );
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
            children: [
              Expanded(
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
                  ],
                ),
              ),
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
