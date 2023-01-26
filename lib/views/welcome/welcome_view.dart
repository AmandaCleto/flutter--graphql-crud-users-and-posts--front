import 'package:flutter/material.dart';
import 'package:graphql_crud_users/app/config/routes/constants.dart';
import 'package:graphql_crud_users/shared/graphql/config_graphql.dart';
import 'package:graphql_crud_users/shared/theme/colors.dart';
import 'package:graphql_crud_users/shared/theme/font_sizes.dart';
import 'package:graphql_crud_users/shared/theme/gradient_decoration.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  ValueNotifier<GraphQLClient>? clientNotifier;

  @override
  void initState() {
    clientNotifier = ConfigGraphQl.initializeGQLClient(
      context,
      clientNotifier: clientNotifier,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      text: 'Welcome to ',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: FontSizesTheme.extra,
                      ),
                      children: [
                        TextSpan(
                          text: 'GraphQL ',
                          style: TextStyle(
                            color: ColorsTheme.primary,
                          ),
                        ),
                        TextSpan(text: 'Authors & Posts '),
                        TextSpan(
                          text: 'Integration with ',
                          style: TextStyle(
                            color: ColorsTheme.black,
                          ),
                        ),
                        TextSpan(
                          text: 'Flutter',
                          style: TextStyle(
                            color: ColorsTheme.blueLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Image.asset('assets/png/flutter_graphql.png'),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: GradientDecoration.bluePinkGradientDecoration,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                  shadowColor: MaterialStateProperty.all(Colors.transparent),
                  overlayColor:
                      MaterialStateProperty.all(Colors.black.withOpacity(0.1)),
                  surfaceTintColor:
                      MaterialStateProperty.all(Colors.transparent),
                  elevation: MaterialStateProperty.all(0.0),
                ),
                child: const Text(
                  'Start!',
                  style: TextStyle(
                    color: ColorsTheme.blue,
                    fontSize: FontSizesTheme.title,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    homeRoute,
                    arguments: ScreenArguments(
                      clientNotifier: clientNotifier,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
