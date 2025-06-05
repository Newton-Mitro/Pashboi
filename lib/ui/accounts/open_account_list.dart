import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';

class OpenAccountList extends StatelessWidget {
  const OpenAccountList({super.key, required this.openAccountListData});

  final Map<String, dynamic> openAccountListData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HtmlWidget(
          openAccountListData['description'],
          customStylesBuilder: (element) {
            if (element.localName == 'a') {
              return {'color': 'red'};
            }
            return null;
          },
          renderMode: RenderMode.column,
          textStyle: TextStyle(fontSize: 14),
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
