import 'dart:math';

import 'package:flutter/material.dart';

String H = "Hello";
List<String> Na, Re, Ru, Te, Io;
List<List<Widget>> disdata, disnum;
int ft = 0;

class view extends StatefulWidget {
  static void TakeData(
      String name,
      List<String> tNa,
      List<String> tRe,
      List<String> tRu,
      List<String> tIo,
      List<String> tTe,
      int fct,
      List<List<Widget>> tdisdata,
      List<List<Widget>> tdisnum,
      ) {
    H = name;
    Na = tNa;
    ft = fct;
    Re = tRe;
    Te = tTe;
    Ru = tRu;
    Io = tIo;
    disdata = tdisdata;
    disnum = tdisnum;
  }

  @override
  _viewState createState() => _viewState();
}

class _viewState extends State<view> {
  int _t = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          H,
          style: TextStyle(fontFamily: 'Pacifico'),
        ),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 100,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 60,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              'Not Arrived',
                              style:
                              TextStyle(color: Colors.white, fontSize: 25),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.red)),
                              width: 250,
                              height: 50,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Center(
                                  child: Text(
                                    Na[_t],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              'Ready',
                              style:
                              TextStyle(color: Colors.white, fontSize: 25),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.red)),
                              width: 250,
                              height: 50,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Center(
                                  child: Text(
                                    Re[_t],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              'Running',
                              style:
                              TextStyle(color: Colors.white, fontSize: 25),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.red)),
                              width: 250,
                              height: 50,
                              child: Center(
                                child: Text(
                                  Ru[_t],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              'I/O',
                              style:
                              TextStyle(color: Colors.white, fontSize: 25),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.red)),
                              width: 250,
                              height: 50,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Center(
                                  child: Text(
                                    Io[_t],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              'Terminated',
                              style:
                              TextStyle(color: Colors.white, fontSize: 25),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.red)),
                              width: 250,
                              height: 50,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Center(
                                  child: Text(
                                    Te[_t],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 40,
                  child: Container(
                    decoration:
                    BoxDecoration(border: Border.all(color: Colors.red)),
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: disdata[_t],
                          ),
                          Column(
                            children: disnum[_t],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Spacer(flex: 10),
          Expanded(
            flex: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: RaisedButton(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: Colors.red),
                    ),
                    child: Text(
                      '-',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      setState(
                            () {
                          if (_t > 0) _t--;
                        },
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: RaisedButton(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: Colors.red),
                    ),
                    child: Text(
                      _t.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {},
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: RaisedButton(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: Colors.red),
                    ),
                    child: Text(
                      '+',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      setState(
                            () {
                          if (_t < ft) _t++;
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.red),
                  ),
                  child: Text(
                    '-100',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    setState(
                          () {
                        int temp = 0;
                        _t = max(temp, _t - 100);
                      },
                    );
                  },
                ),
                RaisedButton(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.red),
                  ),
                  child: Text(
                    '-10',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    setState(
                          () {
                        int temp = 0;
                        _t = max(temp, _t - 10);
                      },
                    );
                  },
                ),
                RaisedButton(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.red),
                  ),
                  child: Text(
                    '+10',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    setState(
                          () {
                        _t = min(_t + 10, ft);
                      },
                    );
                  },
                ),
                RaisedButton(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.red),
                  ),
                  child: Text(
                    '+100',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    setState(
                          () {
                        _t = min(_t + 100, ft);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}