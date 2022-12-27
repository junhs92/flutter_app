import 'package:flutter/material.dart';

Widget appBar(BuildContext context){
  return RichText(
    text: TextSpan(
      style: TextStyle(fontSize: 22),
      children: <TextSpan>[
        TextSpan(text: '두뇌 인지 테스트',
          style: TextStyle(fontWeight: FontWeight.w500,
              color: Colors.red, fontSize: 24), ),
        TextSpan(text: '클릭하기',
            style: TextStyle(fontWeight: FontWeight.w500,
                color: Colors.black54, fontSize: 24)),
      ],
    ),
  );
}

Widget blueButton({required BuildContext context, required String label, buttonWidth}){
  return Container(
    padding: EdgeInsets.symmetric(vertical: 18),
    decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(30)
    ),
    alignment: Alignment.center,
    height: 50,
    width: buttonWidth != null ? buttonWidth : MediaQuery.of(context).size.width - 48,
    child: Text(label, style: TextStyle(color: Colors.white, fontSize: 16),),
  );
}