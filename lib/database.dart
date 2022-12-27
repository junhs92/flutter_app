import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final db = FirebaseFirestore.instance;

  Future<void> addQuizData(Map<String, dynamic> quizData, String quizId) async {
    await db.collection("Quiz")
        .doc(quizId)
        .set(quizData)
        .catchError((e){
      print(e.toString());
    });
  }

  Future<void> addQuestionData(Map<String, dynamic> questionData, String quizId) async {
    await db.collection("Quiz")
        .doc(quizId).collection("QuestionsAndAnswers")
        .add(questionData).catchError((e){//auto-generate id -> add function / specifying id -> set function
      print(e);
    });
  }

  getQuizzesData() async {
    return await db.collection("Quiz").snapshots();
  }

  getQuizData(String quizId) async{
    return await db.collection("Quiz")
        .doc(quizId).collection("QuestionsAndAnswers").get();
  }
}