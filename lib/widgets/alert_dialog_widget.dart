import 'package:flutter/material.dart';

enum DialogType {
  confirm,
  options,
}

class AlertWidget extends StatelessWidget {
  const AlertWidget({
    required this.message,
    required this.dialogType,
    this.btnConfirmPressed,
    this.btnPressed01,
  }) : super();

  final String message;
  final DialogType dialogType;
  final Function? btnConfirmPressed;
  final Function? btnPressed01;
  // final Widget customMessage;
  // final String buttonTitle;
  // final String customAsset;
  // final VoidCallback onPressed;

  Widget _makeIcon() => Padding(
        padding: const EdgeInsets.only(
          top: 36.0,
        ),
        child: _makeImage(),
      );

  Widget _makeImage() {
    if (dialogType == DialogType.confirm) {
      return Icon(Icons.done);
    } else {
      return Icon(Icons.warning);
    }
  }

  Widget _makeMessage(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 40.0,
          horizontal: 20.0,
        ),
        child: Text(
          message,
          textAlign: TextAlign.center,
        ),
      );

  Widget _makeButton(double maxWidht, BuildContext context) => Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16.7),
            ),
          ),
          width: maxWidht,
          child: dialogType == DialogType.confirm
              ? TextButton(
                  onPressed: () =>
                      btnConfirmPressed ?? Navigator.of(context).pop(),
                  child: Text('SHOW !!!'),
                )
              : Row(
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('NÃO'),
                    ),
                    TextButton(
                      onPressed: () => btnPressed01,
                      child: Text('SIM'),
                    ),
                  ],
                ),
        ),
      );

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.transparent,
        child: LayoutBuilder(
          builder: (context, constraints) => Container(
            color: Colors.transparent.withOpacity(.30),
            child: Align(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 27,
                  right: 27,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.all(
                      Radius.circular(16.7),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _makeIcon(),
                      _makeMessage(context),
                      _makeButton(constraints.maxWidth, context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
