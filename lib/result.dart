import 'package:flutter/material.dart';
import 'package:flutter_app/widget.dart';

class Results extends StatefulWidget {
  final int correct, incorrect, total;
  Results({required this.correct, required this.incorrect, required this.total});

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${widget.correct}/${widget.total}"),
              SizedBox(height: 6,),
              Text(" 정답 ${widget.correct}개 "
                  "그리고 오답 ${widget.incorrect}개"),
              SizedBox(height: 14,),
              GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: blueButton(context: context, label: "돌아가기",
                      buttonWidth: MediaQuery.of(context).size.width)
              )
            ],
          ),
        ),
      ),
    );
  }
}
