import 'package:flutter/material.dart';
import 'package:todo_app/theme.dart';

class DefaultElevtedButton extends StatelessWidget {
  const DefaultElevtedButton({required this.onpress,required this.child, super.key});
  final Widget child;
  final   VoidCallback onpress;
  
  // final  Function? func;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,con) {
        print('the constain is ${con.maxWidth}');
        print('the double.inifity is ${double.infinity}');

        return ElevatedButton(
          
          onPressed:onpress,
          child: child,
          style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              
               fixedSize:Size(MediaQuery.of(context).size.width, 50),
               shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))
              ),
        );
      }
    );
  }
}
