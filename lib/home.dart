import 'package:flutter/material.dart';
import 'package:flutter_app/play_quiz.dart';
import 'package:flutter_app/widget.dart';

import 'create_quiz.dart';
import 'database.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late Stream quizStream;
  DatabaseService databaseService = new DatabaseService();

  Widget quizList(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: StreamBuilder(
        stream: quizStream,
        builder: (context, snapshot){
          return snapshot.data == null ? Container()
              : ListView.builder(itemCount: snapshot.data.documents.length, itemBuilder: (context, index){
            return QuizTile(
              imgUrl: snapshot.data.documents[index].data["quizImgUrl"],
              title: snapshot.data.documents[index].data["quizTitle"],
              desc: snapshot.data.documents[index].data["quizDesc"],
              quizId: snapshot.data.documents[index].data["quizId"],
            );
          });
        },
      ),
    );
  }

  @override
  void initState() {
    databaseService.getQuizzesData().then((val){
      setState(() {
        quizStream = val;
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
        brightness: Brightness.light,
      ),
      body: quizList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateQuiz()
          ));
        },
      ),
    );
  }
}

class QuizTile extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String desc;
  final String quizId;

  QuizTile({required this.imgUrl, required this.title, required this.desc, required this.quizId});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => PlayQuiz(quizId)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        height: 150,
        child: Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(imgUrl,
                    width: MediaQuery.of(context).size.width - 48,
                    fit: BoxFit.cover,)),
              Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                      color: Colors.black26),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(title, style: TextStyle(color: Colors.white, fontSize: 17,
                          fontWeight: FontWeight.w900),),
                      SizedBox(height: 6,),
                      Text(desc, style: TextStyle(color: Colors.white, fontSize: 14,
                          fontWeight: FontWeight.w900),)
                    ],)
              )
            ]

        ),
      ),
    );
  }
}
