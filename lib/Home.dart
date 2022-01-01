import 'package:flutter/material.dart';
import 'package:time_pass/Getjson.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> images = [
    "assets/py.png",
    "assets/java.png",
    "assets/js.png",
    "assets/cpp.png",
    "assets/linux.png",
  ];

  List<String> des = [
    "Python is one of the most popular and fastest programming language since half a decade.\nIf You think you have learnt it.. \nJust test yourself !!",
    "Java has always been one of the best choices for Enterprise World. If you think you have learn the Language...\nJust Test Yourself !!",
    "Javascript is one of the most Popular programming language supporting the Web.\nIt has a wide range of Libraries making it Very Powerful !",
    "C++, being a statically typed programming language is very powerful and Fast.\nit's DMA feature makes it more useful. !",
    "Linux is a OPEN SOURCE Operating System which powers many Servers and Workstation.\nIt is also a top Priority in Developement Work !",
  ];
  // ignore: non_constant_identifier_names
  Widget customcard(String langname, String image, String desc) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => Getjson(langname),
            ),
          );
        },
        child: Material(
          color: Colors.indigoAccent,
          borderRadius: BorderRadius.circular(20),
          elevation: 10,
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: Material(
                    borderRadius: BorderRadius.circular(
                      100,
                    ),
                    elevation: 5,
                    child: Container(
                      height: 200,
                      width: 200,
                      child: ClipOval(
                        child: Image(
                          image: AssetImage(
                            image,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    langname,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(20),
                  child: Text(
                    desc,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    maxLines: 5,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quizzo'),
      ),
      body: ListView(
        children: [
          customcard("Python", images[0], des[0]),
          customcard("Java", images[1], des[1]),
          customcard("Javascript", images[2], des[2]),
          customcard("C++", images[3], des[3]),
          // customcard("Linux", images[4], des[4]),
        ],
      ),
    );
  }
}
