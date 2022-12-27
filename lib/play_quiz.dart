import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/database.dart';
import 'package:flutter_app/question_model.dart';
import 'package:flutter_app/quiz_play_widget.dart';
import 'package:flutter_app/result.dart';
import 'package:flutter_app/widget.dart';

class PlayQuiz extends StatefulWidget {

  final String quizId;
  PlayQuiz(this.quizId);

  @override
  _PlayQuizState createState() => _PlayQuizState();
}

int total = 0;
int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;

class _PlayQuizState extends State<PlayQuiz> {

  DatabaseService databaseService = new DatabaseService();
  late QuerySnapshot questionsSnapshot;

  QuestionModel getQuestionModelFromDataSnapshot(DocumentSnapshot questionSnapshot){
    QuestionModel questionModel = new QuestionModel();
    questionModel.question = questionSnapshot.get(FieldPath(['question']));

    List<String> options =
    [
      questionSnapshot.get(FieldPath(['option1'])),
      questionSnapshot.get(FieldPath(['option2'])),
      questionSnapshot.get(FieldPath(['option3'])),
      questionSnapshot.get(FieldPath(['option4']))
    ];

    options.shuffle();
    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctAnswer = questionSnapshot.get(FieldPath(['option1']));
    questionModel.answered = false;

    return questionModel;
  }

  @override
  void initState() {
    print("${widget.quizId}");
    databaseService.getQuizData(widget.quizId).then((value) {
      questionsSnapshot = value;
      _notAttempted = 0;
      _correct = 0;
      _incorrect = 0;
      total = questionsSnapshot.docs.length;

      print("$total this is total");
      setState(() {

      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(
            color: Colors.black54
        ),
        brightness: Brightness.light,
      ),
      body: Container(
        child: Column(
          children: [
            questionsSnapshot == null ?
            Container(
              child: Center(child: CircularProgressIndicator(),),
            ) :
            ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 24),
              itemCount: questionsSnapshot.docs.length,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemBuilder: (context, index){
                return QuizPlayTile(
                    questionModel : getQuestionModelFromDataSnapshot(questionsSnapshot.docs[index]),
                    index: index
                );
              },)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Results(
            correct: _correct, incorrect: _incorrect, total: total,
          )));
        },
      ),
    );
  }
}


class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;
  QuizPlayTile({required this.questionModel, required this.index});


  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {

  String optionSelected = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Q${widget.index+1} ${widget.questionModel.question}", style: TextStyle(fontSize: 17, color: Colors.black54),),
          SizedBox(height: 12,),
          GestureDetector(
            onTap: (){
              if(!widget.questionModel.answered){
                if(widget.questionModel.option1 == widget.questionModel.correctAnswer){
                  optionSelected = widget.questionModel.option1;
                  widget.questionModel.answered = true;
                  _correct = _correct +1;
                  _notAttempted = _notAttempted-1;
                  setState(() {
                    //for qpp to reload
                  });
                } else{
                  optionSelected = widget.questionModel.option1;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect +1;
                  _notAttempted = _notAttempted-1;
                  setState(() {

                  });
                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.questionModel.correctAnswer,
              description: widget.questionModel.option1,
              option: "A",
              optionSelected: optionSelected,
            ),
          ),

          SizedBox(height: 10,),
          GestureDetector(
            onTap: (){
              if(!widget.questionModel.answered){
                if(widget.questionModel.option2 == widget.questionModel.correctAnswer){
                  optionSelected = widget.questionModel.option2;
                  widget.questionModel.answered = true;
                  _correct = _correct +1;
                  _notAttempted = _notAttempted-1;
                  setState(() {
                    //for qpp to reload
                  });
                } else{
                  optionSelected = widget.questionModel.option2;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect +1;
                  _notAttempted = _notAttempted-1;
                  setState(() {

                  });
                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.questionModel.correctAnswer,
              description: widget.questionModel.option2,
              option: "B",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(height: 10,),
          GestureDetector(
            onTap: (){
              if(!widget.questionModel.answered){
                if(widget.questionModel.option3 == widget.questionModel.correctAnswer){
                  optionSelected = widget.questionModel.option3;
                  widget.questionModel.answered = true;
                  _correct = _correct +1;
                  _notAttempted = _notAttempted-1;
                  setState(() {
                    //for qpp to reload
                  });
                } else{
                  optionSelected = widget.questionModel.option3;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect +1;
                  _notAttempted = _notAttempted-1;
                  setState(() {

                  });
                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.questionModel.correctAnswer,
              description: widget.questionModel.option3,
              option: "C",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(height: 10,),
          GestureDetector(
            onTap: (){
              if(!widget.questionModel.answered){
                if(widget.questionModel.option4 == widget.questionModel.correctAnswer){
                  optionSelected = widget.questionModel.option4;
                  widget.questionModel.answered = true;
                  _correct = _correct +1;
                  _notAttempted = _notAttempted-1;
                  setState(() {
                    //for qpp to reload
                  });
                } else{
                  optionSelected = widget.questionModel.option4;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect +1;
                  _notAttempted = _notAttempted-1;
                  setState(() {

                  });
                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.questionModel.correctAnswer,
              description: widget.questionModel.option4,
              option: "D",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(height: 12,),
        ],
      ),
    );
  }
}

