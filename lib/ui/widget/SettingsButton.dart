import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  final String text;
  final SettingsButtonListener listener;

  const SettingsButton({Key? key, required this.text, required this.listener})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    var textStyle = themeData.textTheme.headline6?.copyWith(color: themeData.accentColor);

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () => listener(),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                    Expanded(child: Text(text, style: textStyle)),
                    Icon(Icons.chevron_right, color: themeData.accentColor),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

typedef SettingsButtonListener = void Function();
