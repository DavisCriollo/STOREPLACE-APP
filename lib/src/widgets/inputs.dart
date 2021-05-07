import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:storePlace/src/pages/login/login_controller.dart';
import 'package:storePlace/src/utils/colors.dart';
import 'package:storePlace/src/utils/responsive.dart';
// import 'package:provider/provider.dart';

class InputText extends StatefulWidget {
  final bool Function(String) validator;
  final bool obscureText;
  final Widget prefixIcon;
  final Widget suffixIcon;

// RECUPERO EL DATO DE LA CAJA DE TEXTO

  final void Function(String) onChanged;

  const InputText({
    Key key,
    this.obscureText = false,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
   this.onChanged,
  }) : super(key: key);

  @override
  _InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  bool _isOk = false;
  bool _obscureText;

  @override
  void initState() {
    _obscureText = widget.obscureText;
    super.initState();
  }

  void _validate(String text) {
    if (widget.validator != null) {
      _isOk = widget.validator(text);
      setState(() {});
    }
      if(widget.onChanged!=null)
      {
        widget.onChanged(text);
      }
  }

  void _onVisibleChange() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
// void _submit(BuildContext context) {
//     final controller = context.read<LoginController>();
//     controller.submit();
//   }
  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.wp(10.0)),
      child: TextField(
        obscureText: _obscureText,
        onChanged: _validate,
        textInputAction: TextInputAction.none,
        // textAlign: TextAlign.center,
        decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.obscureText
                ? CupertinoButton(
                    child: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: accentColor,
                    ),
                    onPressed: _onVisibleChange,
                  )
                : Icon(
                    Icons.vpn_key,
                    color: _isOk ? btnSecundaryColor : Colors.grey,
                  )),
        style: TextStyle(
          letterSpacing: 2.0,
          fontSize: size.dp(2.0),
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
