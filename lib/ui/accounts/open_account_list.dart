import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';

class OpenAccountList extends StatelessWidget {
  const OpenAccountList({super.key, required this.openAccountListData});

  final Map<String, dynamic> openAccountListData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Html(
          data: openAccountListData['description'],
          style: {
            "body": Style(color: Colors.black, fontSize: FontSize.medium),
          },
        ),
        AppPrimaryButton(
          iconBefore: Icon(FontAwesomeIcons.check),
          label: "Apply",
          onPressed: () {},
        ),
      ],
    );
  }
}
