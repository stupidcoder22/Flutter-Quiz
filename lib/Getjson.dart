import 'dart:async';
import 'dart:convert';
// import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:time_pass/resultpage.dart';

class Getjson extends StatelessWidget {
  String? langname;
  Getjson(this.langname);
  String? assettoload;

  // a function
  // sets the asset to a particular JSON file
  // and opens the JSON
  setasset() {
    if (langname == "Python") {
      assettoload = "Jsonfile/python.json";
    } else if (langname == "Java") {
      assettoload = "Jsonfile/java.json";
    } else if (langname == "Javascript") {
      assettoload = "Jsonfile/js.json";
    } else if (langname == "C++") {
      assettoload = "Jsonfile/cpp.json";
    } else {
      assettoload = "Jsonfile/linux.json";
    }
  }

  @override
  Widget build(BuildContext context) {
    setasset();
    return FutureBuilder(
      future:
          DefaultAssetBundle.of(context).loadString(assettoload!, cache: false),
      builder: (context, snapshot) {
        var mydata = jsonDecode(snapshot.data.toString());
        if (mydata == null) {
          return Scaffold(
            body: Center(
              child: Text('Loading'),
            ),
          );
        } else {
          return Quizpage(mydata: mydata);
        }
      },
    );
  }
}

class Quizpage extends StatefulWidget {
  var mydata;
  Quizpage({Key? key, @required this.mydata}) : super(key: key);

  @override
  _QuizpageState createState() => _QuizpageState();
}

class _QuizpageState extends State<Quizpage> {
  Color colortoshow = Colors.indigoAccent;
  Color right = Colors.green;
  Color wrong = Colors.red;
  int marks = 0;
  int i = 1;
  int timer = 30;
  String showtimer = '30';
  bool cancel = false;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  Map<String, Color> btncolor = {
    'a': Colors.indigoAccent,
    'b': Colors.indigoAccent,
    'c': Colors.indigoAccent,
    'd': Colors.indigoAccent,
  };

  void startTimer() async {
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (Timer t) {
      // setState(() {
      //   if (timer < 1) {
      //     t.cancel();
      //     nextquestion();
      //   } else if (cancel == true) {
      //     t.cancel();
      //   } else {
      //     timer = timer - 1;
      //   }
      //   showtimer = timer.toString();
      // });

      if (this.mounted) {
        // check whether the state object is in tree
        setState(() {
          if (timer < 1) {
            t.cancel();
            nextquestion();
          } else if (cancel == true) {
            t.cancel();
          } else {
            timer = timer - 1;
          }
          showtimer = timer.toString();
        });
      }
    });
  }

  void nextquestion() {
    cancel = false;
    timer = 30;
    setState(() {
      if (i < 9) {
        i++;
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => resultpage(marks: marks)),
        );
      }
      btncolor['a'] = Colors.indigoAccent;
      btncolor['b'] = Colors.indigoAccent;
      btncolor['c'] = Colors.indigoAccent;
      btncolor['d'] = Colors.indigoAccent;
    });
    startTimer();
  }

  void checkanswer(String op) {
    if (widget.mydata[2][i.toString()] == widget.mydata[1][i.toString()][op]) {
      // (mydata[2][i.toString()] == mydata[1][i.toString()][k])
      marks = marks + 5;
      colortoshow = right;
    } else {
      colortoshow = wrong;
    }
    setState(() {
      cancel = true;
      btncolor[op] = colortoshow;
    });

    Timer(Duration(seconds: 1), nextquestion);
  }

  Future<bool> redirectTo() async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                "Quizstar",
              ),
              content: Text("You Can't Go Back At This Stage."),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Ok',
                  ),
                )
              ],
            ));
    return true;
  }

  Widget choicebutton(String ch) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: MaterialButton(
          child: Text(
            widget.mydata[1][i.toString()][ch],
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          color: btncolor[ch],
          splashColor: Colors.indigo[700],
          highlightColor: Colors.indigo[700],
          minWidth: 200,
          height: 45,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(20),
          ),
          onPressed: () {
            checkanswer(ch);
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: redirectTo,
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      widget.mydata[0][i.toString()],
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      choicebutton('a'),
                      choicebutton('b'),
                      choicebutton('c'),
                      choicebutton('d'),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Text(
                    showtimer,
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
