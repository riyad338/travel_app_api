import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  PagesNameModel pagesNameModel = PagesNameModel();
  var size, height, width;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(50)),
                color: Colors.blue,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("images/Bank.jpeg"),
                      ),
                      SizedBox(width: 10),
                      Column(
                        children: [
                          Text(
                            'Name:',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 18),
                          ),
                          Text(
                            'Score:',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 18),
                          ),
                          Text(
                            'Badge:',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 18),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text(
                'Profile',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
              onTap: () {},
            ),
            ListTile(
              title: const Text(
                'Facebook Page',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
              onTap: () {},
            ),
            ListTile(
              title: const Text(
                'Facebook Group',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
              onTap: () {},
            ),
            ListTile(
              title: const Text(
                'Contact',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
              onTap: () {},
            ),
            ListTile(
              title: const Text(
                'About',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(
        //shadowColor: null,
        title: Text("BCS eBook"),
      ),
      body: Container(
        height: height,
        color: Colors.grey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.indigo,
                child: SizedBox(
                  height: height / 4, //half of the height size
                  width: double.infinity, //half of the width size
                ),
              ),
              //Gridview
              GridView(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 2),
                children: [
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (context) => Learn()));
                    },
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        height: 100,
                        width: 205,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                backgroundImage:
                                    AssetImage("images/Learn.jpeg")),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "LEARN",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (context) => Learn()));
                    },
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        height: 100,
                        width: 205,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                backgroundImage:
                                    AssetImage("images/Bank.jpeg")),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "BANK",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (context) => Learn()));
                    },
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        height: 100,
                        width: 205,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                backgroundImage:
                                    AssetImage("images/question_bank.jpeg")),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "QUESTION BANK",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (context) => Quiz()));
                    },
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        height: 100,
                        width: 205,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                backgroundImage:
                                    AssetImage("images/quiz.jpeg")),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Quiz",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (context) => Learn()));
                    },
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        height: 100,
                        width: 205,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                backgroundImage:
                                    AssetImage("images/Vocabolary.jpeg")),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "VOCABOLARY ",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (context) => Learn()));
                    },
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        height: 100,
                        width: 205,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                backgroundImage:
                                    AssetImage("images/current_affairs.jpeg")),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "CURRENT AFFAIRS",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (context) => Newspaper()));
                    },
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        height: 100,
                        width: 205,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                backgroundImage:
                                    AssetImage("images/Newspaper.jpeg")),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "NEWSPAPER",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (context) => Learn()));
                    },
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        height: 100,
                        width: 205,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                backgroundImage:
                                    AssetImage("images/ebook.jpeg")),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "EBOOK",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (context) => Learn()));
                    },
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        height: 100,
                        width: 205,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                backgroundImage:
                                    AssetImage("images/Translation.jpeg")),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "TRANSLATION",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (context) => Learn()));
                    },
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        height: 100,
                        width: 205,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                backgroundImage:
                                    AssetImage("images/subjective_exam.jpeg")),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "SUBJECTIVE EXAM",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (context) => Learn()));
                    },
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        height: 100,
                        width: 205,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                backgroundImage:
                                    AssetImage("images/mmodel_test.jpeg")),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "MODEL TEST",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (context) => LiveExam()));
                    },
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        height: 100,
                        width: 205,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                backgroundImage:
                                    AssetImage("images/live_exam.jpeg")),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "LIVE EXAM",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                shrinkWrap: true,
                itemCount: nameList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    color: Colors.blueGrey[100],
                    child: Center(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Image(image: AssetImage("${nameList[index].img}")),
                            Text(
                              "${nameList[index].name}",
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PagesNameModel {
  String? name;
  String? img;

  PagesNameModel({this.name, this.img});
}

List<PagesNameModel> nameList = [
  PagesNameModel(name: "LEARN", img: "images/Learn.jpeg"),
  PagesNameModel(name: "BANK", img: "images/Bank.jpeg"),
  PagesNameModel(name: "QUESTION BANK", img: "images/question_bank.jpeg"),
];
