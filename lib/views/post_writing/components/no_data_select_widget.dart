import 'package:flutter/material.dart';
import 'package:graphql_crud_users/shared/themes/colors.dart';

class NoDataSelect extends StatelessWidget {
  final bool _isLoading;

  const NoDataSelect({super.key}) : _isLoading = false;
  const NoDataSelect.loading({super.key}) : _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      decoration: BoxDecoration(
        color: ColorsTheme.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20.0),
      ),
      width: 150.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _isLoading
              ? const Expanded(
                  child: Center(
                    child: SizedBox(
                      width: 20.0,
                      height: 20.0,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                      ),
                    ),
                  ),
                )
              : Expanded(
                  child: Center(
                      child: Text(
                    'No data...',
                    style: TextStyle(color: Colors.grey.shade600),
                  )),
                ),
          Icon(
            Icons.keyboard_arrow_down_rounded,
            color: ColorsTheme.blue.withOpacity(0.6),
          )
        ],
      ),
    );
  }
}
