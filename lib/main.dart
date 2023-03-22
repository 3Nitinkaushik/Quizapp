import 'package:flutter/material.dart';
import 'brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
void main() {
  runApp(const Quizhead());
}

class Quizhead extends StatelessWidget {
  const Quizhead({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       home: Scaffold(
         backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.limeAccent,
        title: Center(child: Text("Quiz App",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.teal),
        ),
        ),
      ),
           body: Quizbody(),
    ),

    );
  }
}

class Quizbody extends StatefulWidget {
  const Quizbody({Key? key}) : super(key: key);

  @override
  State<Quizbody> createState() => _QuizbodyState();
}

class _QuizbodyState extends State<Quizbody> {
  List<Icon> score=[];
  Quizbrain quizbrain=Quizbrain();
  int num=0;
  _onAlertButtonPressed(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "END OF QUIZ",
      desc: "TO START AGAIN PRESS GO",
      buttons: [
        DialogButton(
          child: Text(
            "GO",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {Navigator.pop(context);
            setState(() {

            });
            quizbrain.restart();
            score.clear();


          },
          width: 120,
        )
      ],
    ).show();
  }
  checkanswer(bool userenteredans){
      if(quizbrain.getQuestionans()==userenteredans){score.add(
        Icon(Icons.check, color: Colors.green),);}
      else{
        score.add(Icon(Icons.close,color: Colors.red),);}

    setState(() {
      quizbrain.nextQuestion();

    });
      if(score.length>11){
        _onAlertButtonPressed(context);
      }
  }




  @override
  Widget build(BuildContext context) {

    return SafeArea(

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex:5,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(quizbrain.getQuestiontext(),style: TextStyle(color: Colors.white,fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Expanded(

              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextButton( onPressed: (){ checkanswer(true);},child: Text("TRUE", style: TextStyle(color: Colors.white,fontSize: 30 ),
                ),
                  style: TextButton.styleFrom(backgroundColor: Colors.green),
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextButton( onPressed: (){
                  checkanswer(false);}, child: Text("FALSE",
                  style: TextStyle(
                  color: Colors.white,fontSize: 25),
                ),
                style: TextButton.styleFrom(backgroundColor: Colors.red
                ),
              ),
            ),
      ),
            Row(
              children: score
            )
          ],
        ),
      ),
    );
  }
}

