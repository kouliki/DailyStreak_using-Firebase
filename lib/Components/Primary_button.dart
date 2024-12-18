
import 'package:flutter/material.dart';
class  PrimaryButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  bool loading;
  PrimaryButton(
      {required this.title, required this.onPressed, this.loading = false});

  // const   PrimaryButton ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
    height: 60,
    width: double.infinity,
  child: ElevatedButton(

  onPressed: (){
    onPressed();
  },
  child: Text(title,
    style: TextStyle(fontSize: 18),
  ),
    style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xfffc3b77),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30))),
  )

  );
  }
}
