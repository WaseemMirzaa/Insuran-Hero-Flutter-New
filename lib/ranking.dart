import 'package:flutter/material.dart';

class RankingView extends StatefulWidget {
  const RankingView({super.key});

  @override
  State<RankingView> createState() => _RankingViewState();
}

class _RankingViewState extends State<RankingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
          icon: Image.asset(
            'assets/images/menu.png',
            scale: 1.2,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Student Ranking',
          style: TextStyle(
            fontFamily: 'Calibri',
            fontSize: 18,
            color: Color(0xff000000),
          ),
          textAlign: TextAlign.center,
          softWrap: false,
        ),
        elevation: 1.5,
      ),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        Container(
          height: 125,
          width: 320,
          decoration: BoxDecoration(
            color: const Color(0xffffffff),
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(width: 2.0, color: const Color(0xffe9e9e9)),
            boxShadow: const [
              BoxShadow(
                color: Color(0xffe9e9e9),
                offset: Offset(0, 3),
                blurRadius: 0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/Rectangle 77.png',
                      scale: 3,
                    ),
                    SizedBox(
                      height: 60,
                      width: 235,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    'Peter Jackson',
                                    style: TextStyle(
                                      fontFamily: 'Calibri',
                                      fontSize: 24,
                                      color: Color(0xff000000),
                                      letterSpacing: 0.26,
                                    ),
                                    softWrap: false,
                                  ),
                                ),
                                Container(
                                  width: 20.0,
                                  height: 20.0,
                                  alignment: Alignment.centerRight,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffffffff),
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(
                                        width: 1.5,
                                        color: const Color(0xffe9e9e9)),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0xffe9e9e9),
                                        offset: Offset(0, 1),
                                        blurRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                    child: Text.rich(
                                      TextSpan(
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 10,
                                          color: Color(0xff333333),
                                          letterSpacing: 0.1,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: '1',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'st',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      textHeightBehavior: TextHeightBehavior(
                                          applyHeightToFirstAscent: false),
                                      softWrap: false,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 20.0,
                                  height: 20.0,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffffffff),
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(
                                        width: 1.5,
                                        color: const Color(0xffe9e9e9)),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0xffe9e9e9),
                                        offset: Offset(0, 1),
                                        blurRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: Image.asset(
                                    'assets/images/english-small.png',
                                    scale: 3,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  'English Quiz',
                                  style: TextStyle(
                                    fontFamily: 'Calibri',
                                    fontSize: 14,
                                    color: Color(0xff333333),
                                    letterSpacing: 0.14,
                                  ),
                                  softWrap: false,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Total Questions: 50',
                    style: TextStyle(
                      fontFamily: 'Calibri',
                      fontSize: 9,
                      color: Color(0xff7a7a7a),
                    ),
                    softWrap: false,
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      height: 10,
                      width: 300,
                      decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                    ),
                    Container(
                      height: 10,
                      width: 250,
                      decoration: BoxDecoration(
                        color: const Color(0xff89e100),
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Container(
          height: 125,
          width: 320,
          decoration: BoxDecoration(
            color: const Color(0xffffffff),
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(width: 2.0, color: const Color(0xffe9e9e9)),
            boxShadow: const [
              BoxShadow(
                color: Color(0xffe9e9e9),
                offset: Offset(0, 3),
                blurRadius: 0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/Rectangle 77.png',
                      scale: 3,
                    ),
                    SizedBox(
                      height: 60,
                      width: 235,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    'Peter Jackson',
                                    style: TextStyle(
                                      fontFamily: 'Calibri',
                                      fontSize: 24,
                                      color: Color(0xff000000),
                                      letterSpacing: 0.26,
                                    ),
                                    softWrap: false,
                                  ),
                                ),
                                Container(
                                  width: 20.0,
                                  height: 20.0,
                                  alignment: Alignment.centerRight,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffffffff),
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(
                                        width: 1.5,
                                        color: const Color(0xffe9e9e9)),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0xffe9e9e9),
                                        offset: Offset(0, 1),
                                        blurRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                    child: Text.rich(
                                      TextSpan(
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 10,
                                          color: Color(0xff333333),
                                          letterSpacing: 0.1,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: '1',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'st',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      textHeightBehavior: TextHeightBehavior(
                                          applyHeightToFirstAscent: false),
                                      softWrap: false,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 20.0,
                                  height: 20.0,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffffffff),
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(
                                        width: 1.5,
                                        color: const Color(0xffe9e9e9)),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0xffe9e9e9),
                                        offset: Offset(0, 1),
                                        blurRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: Image.asset(
                                    'assets/images/english-small.png',
                                    scale: 3,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  'English Quiz',
                                  style: TextStyle(
                                    fontFamily: 'Calibri',
                                    fontSize: 14,
                                    color: Color(0xff333333),
                                    letterSpacing: 0.14,
                                  ),
                                  softWrap: false,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Total Questions: 50',
                    style: TextStyle(
                      fontFamily: 'Calibri',
                      fontSize: 9,
                      color: Color(0xff7a7a7a),
                    ),
                    softWrap: false,
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      height: 10,
                      width: 300,
                      decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                    ),
                    Container(
                      height: 10,
                      width: 250,
                      decoration: BoxDecoration(
                        color: const Color(0xff89e100),
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Container(
          height: 125,
          width: 320,
          decoration: BoxDecoration(
            color: const Color(0xffffffff),
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(width: 2.0, color: const Color(0xffe9e9e9)),
            boxShadow: const [
              BoxShadow(
                color: Color(0xffe9e9e9),
                offset: Offset(0, 3),
                blurRadius: 0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/Rectangle 77.png',
                      scale: 3,
                    ),
                    SizedBox(
                      height: 60,
                      width: 235,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    'Peter Jackson',
                                    style: TextStyle(
                                      fontFamily: 'Calibri',
                                      fontSize: 24,
                                      color: Color(0xff000000),
                                      letterSpacing: 0.26,
                                    ),
                                    softWrap: false,
                                  ),
                                ),
                                Container(
                                  width: 20.0,
                                  height: 20.0,
                                  alignment: Alignment.centerRight,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffffffff),
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(
                                        width: 1.5,
                                        color: const Color(0xffe9e9e9)),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0xffe9e9e9),
                                        offset: Offset(0, 1),
                                        blurRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                    child: Text.rich(
                                      TextSpan(
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 10,
                                          color: Color(0xff333333),
                                          letterSpacing: 0.1,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: '1',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'st',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      textHeightBehavior: TextHeightBehavior(
                                          applyHeightToFirstAscent: false),
                                      softWrap: false,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 20.0,
                                  height: 20.0,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffffffff),
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(
                                        width: 1.5,
                                        color: const Color(0xffe9e9e9)),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0xffe9e9e9),
                                        offset: Offset(0, 1),
                                        blurRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: Image.asset(
                                    'assets/images/english-small.png',
                                    scale: 3,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  'English Quiz',
                                  style: TextStyle(
                                    fontFamily: 'Calibri',
                                    fontSize: 14,
                                    color: Color(0xff333333),
                                    letterSpacing: 0.14,
                                  ),
                                  softWrap: false,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Total Questions: 50',
                    style: TextStyle(
                      fontFamily: 'Calibri',
                      fontSize: 9,
                      color: Color(0xff7a7a7a),
                    ),
                    softWrap: false,
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      height: 10,
                      width: 300,
                      decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                    ),
                    Container(
                      height: 10,
                      width: 250,
                      decoration: BoxDecoration(
                        color: const Color(0xff89e100),
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Container(
          height: 125,
          width: 320,
          decoration: BoxDecoration(
            color: const Color(0xffffffff),
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(width: 2.0, color: const Color(0xffe9e9e9)),
            boxShadow: const [
              BoxShadow(
                color: Color(0xffe9e9e9),
                offset: Offset(0, 3),
                blurRadius: 0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/Rectangle 77.png',
                      scale: 3,
                    ),
                    SizedBox(
                      height: 60,
                      width: 235,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    'Peter Jackson',
                                    style: TextStyle(
                                      fontFamily: 'Calibri',
                                      fontSize: 24,
                                      color: Color(0xff000000),
                                      letterSpacing: 0.26,
                                    ),
                                    softWrap: false,
                                  ),
                                ),
                                Container(
                                  width: 20.0,
                                  height: 20.0,
                                  alignment: Alignment.centerRight,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffffffff),
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(
                                        width: 1.5,
                                        color: const Color(0xffe9e9e9)),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0xffe9e9e9),
                                        offset: Offset(0, 1),
                                        blurRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                    child: Text.rich(
                                      TextSpan(
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 10,
                                          color: Color(0xff333333),
                                          letterSpacing: 0.1,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: '1',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'st',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      textHeightBehavior: TextHeightBehavior(
                                          applyHeightToFirstAscent: false),
                                      softWrap: false,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 20.0,
                                  height: 20.0,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffffffff),
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(
                                        width: 1.5,
                                        color: const Color(0xffe9e9e9)),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0xffe9e9e9),
                                        offset: Offset(0, 1),
                                        blurRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: Image.asset(
                                    'assets/images/english-small.png',
                                    scale: 3,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  'English Quiz',
                                  style: TextStyle(
                                    fontFamily: 'Calibri',
                                    fontSize: 14,
                                    color: Color(0xff333333),
                                    letterSpacing: 0.14,
                                  ),
                                  softWrap: false,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Total Questions: 50',
                    style: TextStyle(
                      fontFamily: 'Calibri',
                      fontSize: 9,
                      color: Color(0xff7a7a7a),
                    ),
                    softWrap: false,
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      height: 10,
                      width: 300,
                      decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                    ),
                    Container(
                      height: 10,
                      width: 250,
                      decoration: BoxDecoration(
                        color: const Color(0xff89e100),
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ]),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 80,
          width: double.maxFinite,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Image.asset(
                  'assets/images/grey-home.png',
                  scale: 3,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Image.asset(
                  'assets/images/history.png',
                  scale: 3,
                ),
                onPressed: () {},
              ),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: const Color(0xff77c801),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: IconButton(
                  icon: Image.asset(
                    'assets/images/white-user.png',
                    scale: 3,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
