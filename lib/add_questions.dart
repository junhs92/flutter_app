import 'package:flutter/material.dart';
import 'package:flutter_app/database.dart';
import 'package:flutter_app/widget.dart';

class AddQuestions extends StatefulWidget {
  final String quizId;
  AddQuestions(this.quizId);

  @override
  _AddQuestionsState createState() => _AddQuestionsState();
}

class _AddQuestionsState extends State<AddQuestions> {
  final _formKey = GlobalKey<FormState>();
  late String question, option1, option2, option3, option4;
  bool _isLoading = false;

  DatabaseService databaseService = new DatabaseService();

  uploadQuestionData() async {
    if(_formKey.currentState!.validate()){

      setState(() {
        _isLoading = true;
      });

      Map<String, String> questionMap = {
        "question" : question,
        "option1" : option1,
        "option2" : option2,
        "option3" : option3,
        "option4" : option4
      };
      await databaseService.addQuestionData(questionMap, widget.quizId)
          .then((value){
        setState(() {
          _isLoading = false;
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
        child: Center(child: CircularProgressIndicator(),),
      ) : Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(children: [
            TextFormField(
              validator: (val) => val!.isEmpty ? "Enter Question" : null,
              decoration: InputDecoration(
                hintText: "Question",
              ),
              onChanged: (val){
                question = val;
              },
            ),
            SizedBox(height: 6,),
            TextFormField(
              validator: (val) => val!.isEmpty ? "Enter Option1" : null,
              decoration: InputDecoration(
                hintText: "Option1(Correct Answer)",
              ),
              onChanged: (val){
                option1 = val;
              },
            ),
            SizedBox(height: 6,),
            TextFormField(
              validator: (val) => val!.isEmpty ? "Enter Option2" : null,
              decoration: InputDecoration(
                hintText: "Option2",
              ),
              onChanged: (val){
                option2 = val;
              },
            ),
            SizedBox(height: 6,),
            TextFormField(
              validator: (val) => val!.isEmpty ? "Enter Option3" : null,
              decoration: InputDecoration(
                hintText: "Option3",
              ),
              onChanged: (val){
                option3 = val;
              },
            ),
            SizedBox(height: 6,),
            TextFormField(
              validator: (val) => val!.isEmpty ? "Enter Option4" : null,
              decoration: InputDecoration(
                hintText: "Option4",
              ),
              onChanged: (val){
                option4 = val;
              },
            ),
            Spacer(),
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    uploadQuestionData();
                    Navigator.pop(context);
                  },
                  child: blueButton(context: context,
                      label: "Submit",
                      buttonWidth: MediaQuery.of(context).size.width/2 - (36)),
                ),
                SizedBox(width: 24,),
                GestureDetector(
                  onTap: (){
                    uploadQuestionData();
                  },
                  child: blueButton(context: context,
                      label: "Add Question",
                      buttonWidth: MediaQuery.of(context).size.width/2 - 36 ),
                ),
              ],
            )
          ],),
        ),
      ),
    );
  }
}
