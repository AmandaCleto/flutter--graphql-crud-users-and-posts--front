import 'package:flutter/material.dart';
import 'package:graphql_crud_users/shared/theme/colors.dart';
import 'package:graphql_crud_users/shared/theme/font_sizes.dart';
import 'package:graphql_crud_users/views/configuration/components/item_widget.dart';

class ConfigurationView extends StatefulWidget {
  const ConfigurationView({Key? key}) : super(key: key);

  @override
  State<ConfigurationView> createState() => _ConfigurationViewState();
}

class _ConfigurationViewState extends State<ConfigurationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CONFIGURATION'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Authors',
                style: TextStyle(
                  color: ColorsTheme.white,
                  fontSize: FontSizesTheme.title,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              ItemWidget(
                firstName: "amanad",
                lastName: 'cleto',
                editCallback: () async {},
                deleteCallback: () async {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
