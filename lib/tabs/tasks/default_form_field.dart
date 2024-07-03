import 'package:flutter/material.dart';

class DefaultTextFtromField extends StatefulWidget {
  DefaultTextFtromField(
      {this.isPassword = false,
      this.hintText,
      this.label,
      this.maxline = 1,
      this.validator,
      required this.textEditingController,
      
      super.key});
  final bool isPassword;
  final String? hintText;
  final int? maxline;
  final String? label;
 String? Function(String?)? validator;
  TextEditingController? textEditingController;

  @override
  State<DefaultTextFtromField> createState() => _DefaultTextFtromFieldState();
}

class _DefaultTextFtromFieldState extends State<DefaultTextFtromField> {
  bool isobsecure = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isobsecure,
      controller: widget.textEditingController,
      maxLines: widget.maxline,
      decoration: InputDecoration(
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    isobsecure = !isobsecure;
                    setState(() {});
                  },
                  icon: Icon(Icons.visibility_outlined))
              : null,
          hintText: widget.hintText,
          label: widget.label != null
              ? Text(
                  widget.label!,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                )
              : null),
      validator:widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
