import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/add_questions.dart';
import 'package:flutter_app/database.dart';
import 'package:flutter_app/widget.dart';
import 'package:random_string/random_string.dart';

class CreateQuiz extends StatefulWidget {
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {

  final _formKey = GlobalKey<FormState>();
  late String quizImageUrl, quizTitle, quizDescription, quizId;
  DatabaseService databaseService = new DatabaseService();
  bool _isLoading = false;

  createQuizOnline() async {
    if(_formKey.currentState!.validate()){
      setState(() {
        _isLoading = true;
      });
      quizId = randomAlphaNumeric(16);
      Map<String, String> quizMap = {
        "quizId" : quizId,
        "quizImgUrl" : quizImageUrl,
        "quizTitle" : quizTitle,
        "quizDesc" : quizDescription
      };
      await databaseService.addQuizData(quizMap, quizId).then((value){
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddQuestions(quizId)
          ));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black87),
        brightness: Brightness.light,
      ),
      body: _isLoading ? Container(
        child: Center(
          child: CircularProgressIndicator(),),
      ) : Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(children: [
            TextFormField(
              validator: (val) => val!.isEmpty ? "Enter Image url" : null,
              decoration: InputDecoration(
                hintText: "Quiz Image url",
              ),
              onChanged: (val){
                quizImageUrl = val;
              },
            ),
            SizedBox(height: 6,),
            TextFormField(
              validator: (val) => val!.isEmpty ? "Enter Quiz Title" : null,
              decoration: InputDecoration(
                hintText: "Quiz Title",
              ),
              onChanged: (val){
                quizTitle = val;
              },
            ),
            TextFormField(
              validator: (val) => val!.isEmpty ? "Enter Quiz Description" : null,
              decoration: InputDecoration(
                hintText: "Quiz Description",
              ),
              onChanged: (val){
                quizDescription = val;
              },
            ),
            Spacer(),
            GestureDetector(
              onTap: (){
                createQuizOnline();
              },
              child: blueButton(context: context, label: "Create Quiz"),
            ),
            SizedBox(height: 6,),
          ],
          ),
        ),
      ),
    );
  }
}
