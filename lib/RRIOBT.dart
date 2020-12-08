import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './RR.dart';
import './Card.dart';
import './Viewiobt.dart';

//FCFS page stateful class
class RRIOBT extends StatefulWidget {
  @override
  _RRIOBTState createState() => _RRIOBTState();
}

class _RRIOBTState extends State<RRIOBT> {
  var _counter = 0;
  double _avg_tat = 0, _avg_wt = 0;
  int TQ = 1;
  List<DataRow> _rowList = [];
  List<List<int>> _data = [];
  List<List<String>> _datas = [];
  List<List<int>> _cardv = [];
  List<List<String>> _cardvs = [];
  List<List<bool>> _readyq = [];
  List<String> _Na = [], _Re = [], _Ru = [], _Te = [], _Io = [];
  List<List<Widget>> _disdata = [], _disNum = [];

  void _Gant() {
    _cardv.clear();
    _cardvs.clear();
    _readyq.clear();

    List<int> RQ = [], bt1, bt2, iobt, at;
    List<bool> inTQP;
    bt1 = new List<int>.filled(_counter, 0);
    bt2 = new List<int>.filled(_counter, 0);
    iobt = new List<int>.filled(_counter, 0);
    at = new List<int>.filled(_counter, 0);
    for (int i = 0; i < _counter; ++i) {
      bt1[i] = _data[i][1];
      iobt[i] = _data[i][2];
      bt2[i] = _data[i][3];
      at[i] = _data[i][0];
    }
    int ttnp = 0, _iofRQ = 0, _st = 0, _tt = -1;
    inTQP = new List<bool>.filled(_counter, false);
    while (true) {
      bool flag = true;
      for (int i = 0; i < _counter; ++i) {
        if (_data[i][3] > 0) flag = false;
      }
      if (flag) break;

      for (int i = 0; i < _counter; ++i) {
        if (_data[i][0] == _st &&
            !inTQP[i] &&
            (_data[i][1] > 0 || _data[i][3] > 0)) {
          RQ.add(i);
          //print('here chance');
        }
        if (_data[i][0] == _st &&
            inTQP[i] &&
            (_data[i][1] > 0 || _data[i][3] > 0)) {
          //print('object');
          RQ.add(i);
          inTQP[i] = !inTQP[i];
        }
      }
      if (_st >= ttnp && _iofRQ < RQ.length) {
        if (_data[RQ[_iofRQ]][1] > 0) {
          _tt++;
          _readyq.add(List.filled(_counter, false));
          _cardv.add([0, 0, 0, 0]);
          _cardvs.add(['0', '0', '0', '0']);
          for (int j = _iofRQ + 1; j < RQ.length; ++j) {
            _readyq[_tt][RQ[j]] = true;
          }
          _cardv[_tt][0] = RQ[_iofRQ];
          _cardv[_tt][1] = _st;

          int temp = min(TQ, _data[RQ[_iofRQ]][1]);
          _data[RQ[_iofRQ]][0] = _st + TQ + temp;
          _data[RQ[_iofRQ]][1] -= temp;
          ttnp = _st + temp;
          _cardv[_tt][2] = ttnp;
          _data[RQ[_iofRQ]][4] = ttnp;
          inTQP[RQ[_iofRQ]] = !inTQP[RQ[_iofRQ]];
          if (_data[RQ[_iofRQ]][1] == 0) {
            _data[RQ[_iofRQ]][0] += _data[RQ[_iofRQ]][2];
            _cardv[_tt][3] = 2;
          }

          _data[RQ[_iofRQ]][5] = _data[RQ[_iofRQ]][4] - at[RQ[_iofRQ]];
          _data[RQ[_iofRQ]][6] =
              _data[RQ[_iofRQ]][5] - bt1[RQ[_iofRQ]] - bt2[RQ[_iofRQ]];
          _st++;
          for (int i = 0; i < 4; ++i)
            _cardvs[_tt][i] = _cardv[_tt][i].toString();
        } else if (_data[RQ[_iofRQ]][3] > 0) {
          _tt++;
          _readyq.add(List.filled(_counter, false));
          _cardv.add([0, 0, 0, 0]);
          _cardvs.add(['0', '0', '0', '0']);

          _cardv[_tt][0] = RQ[_iofRQ];
          _cardv[_tt][1] = _st;

          for (int j = _iofRQ + 1; j < RQ.length; ++j) {
            _readyq[_tt][RQ[j]] = true;
          }
          int temp = min(TQ, _data[RQ[_iofRQ]][3]);
          _data[RQ[_iofRQ]][0] = _st + temp;
          _data[RQ[_iofRQ]][3] -= temp;
          ttnp = _st + temp;
          _cardv[_tt][2] = ttnp;

          _data[RQ[_iofRQ]][4] = ttnp;
          inTQP[RQ[_iofRQ]] = !inTQP[RQ[_iofRQ]];
          if (_data[RQ[_iofRQ]][3] == 0) {
            _cardv[_tt][3] = 1;
          }
          _data[RQ[_iofRQ]][5] = _data[RQ[_iofRQ]][4] - at[RQ[_iofRQ]];
          _data[RQ[_iofRQ]][6] =
              _data[RQ[_iofRQ]][5] - bt1[RQ[_iofRQ]] - bt2[RQ[_iofRQ]];
          _st++;
          for (int i = 0; i < 4; ++i)
            _cardvs[_tt][i] = _cardv[_tt][i].toString();
        }
        _iofRQ++;
      } else {
        _st++;
      }
    }

    for (int i = 0; i < _counter; ++i) {
      _data[i][1] = bt1[i];
      _data[i][0] = at[i];
      _data[i][3] = bt2[i];
    }
  }

  void _viz() {
    int fct = 0;
    for (int i = 0; i < _counter; ++i) {
      fct = max(fct, _data[i][4]);
    }
    List<int> _ddata;
    _ddata = new List<int>.filled(fct + 1, -1);
    List<int> _Running, _IoIn, _IoOut;
    _Running = new List<int>.filled(fct + 1, -1);
    _IoIn = new List<int>.filled(_counter, -1);
    _IoOut = new List<int>.filled(_counter, -1);

    List<int> RQ = [], bt1, bt2, iobt, at;
    List<bool> inTQP, vis;
    bt1 = new List<int>.filled(_counter, 0);
    bt2 = new List<int>.filled(_counter, 0);
    iobt = new List<int>.filled(_counter, 0);
    at = new List<int>.filled(_counter, 0);
    for (int i = 0; i < _counter; ++i) {
      bt1[i] = _data[i][1];
      iobt[i] = _data[i][2];
      bt2[i] = _data[i][3];
      at[i] = _data[i][0];
    }
    int ttnp = 0, _iofRQ = 0, st = 0;
    inTQP = new List<bool>.filled(_counter, false);
    vis = new List<bool>.filled(_counter, false);
    while (true) {
      bool flag = true;
      for (int i = 0; i < _counter; ++i) {
        if (_data[i][3] > 0) flag = false;
      }
      if (flag) break;

      for (int i = 0; i < _counter; ++i) {
        if (_data[i][0] == st &&
            !inTQP[i] &&
            (_data[i][1] > 0 || _data[i][3] > 0)) {
          RQ.add(i);
          //print('here chance');
        }
        if (_data[i][0] == st &&
            inTQP[i] &&
            (_data[i][1] > 0 || _data[i][3] > 0)) {
          //print('object');
          RQ.add(i);
          inTQP[i] = !inTQP[i];
        }
      }
      if (st >= ttnp && _iofRQ < RQ.length) {
        if (_data[RQ[_iofRQ]][1] > 0) {
          if (!vis[RQ[_iofRQ]]) {
            _data[RQ[_iofRQ]][7] = st - at[RQ[_iofRQ]];
            vis[RQ[_iofRQ]] = true;
          }
          int temp = min(TQ, _data[RQ[_iofRQ]][1]);
          _data[RQ[_iofRQ]][0] = st + temp;
          for (int i = st + 1; i <= st + temp; ++i) _ddata[i] = RQ[_iofRQ];
          _data[RQ[_iofRQ]][1] -= temp;
          ttnp = st + temp;
          _data[RQ[_iofRQ]][4] = ttnp;
          inTQP[RQ[_iofRQ]] = !inTQP[RQ[_iofRQ]];

          _data[RQ[_iofRQ]][5] = _data[RQ[_iofRQ]][4] - at[RQ[_iofRQ]];
          _data[RQ[_iofRQ]][6] =
              _data[RQ[_iofRQ]][5] - bt1[RQ[_iofRQ]] - bt2[RQ[_iofRQ]];
          if (_data[RQ[_iofRQ]][1] == 0) {
            _IoIn[RQ[_iofRQ]] = _data[RQ[_iofRQ]][0];
            _data[RQ[_iofRQ]][0] += _data[RQ[_iofRQ]][2];
            _IoOut[RQ[_iofRQ]] = _data[RQ[_iofRQ]][0] - 1;
          }
          st++;
        } else if (_data[RQ[_iofRQ]][3] > 0) {
          if (!vis[RQ[_iofRQ]]) {
            _data[RQ[_iofRQ]][7] = st - at[RQ[_iofRQ]];
            vis[RQ[_iofRQ]] = true;
          }
          int temp = min(TQ, _data[RQ[_iofRQ]][3]);
          _data[RQ[_iofRQ]][0] = st + temp;
          for (int i = st + 1; i <= st + temp; ++i) _ddata[i] = RQ[_iofRQ];
          _data[RQ[_iofRQ]][3] -= temp;
          ttnp = st + temp;
          _data[RQ[_iofRQ]][4] = ttnp;
          inTQP[RQ[_iofRQ]] = !inTQP[RQ[_iofRQ]];
          _data[RQ[_iofRQ]][5] = _data[RQ[_iofRQ]][4] - at[RQ[_iofRQ]];
          _data[RQ[_iofRQ]][6] =
              _data[RQ[_iofRQ]][5] - bt1[RQ[_iofRQ]] - bt2[RQ[_iofRQ]];
          st++;
        }
        _iofRQ++;
      } else {
        st++;
      }
    }
    for (int i = 0; i < _counter; ++i) {
      _data[i][1] = bt1[i];
      _data[i][0] = at[i];
      _data[i][3] = bt2[i];
    }
    //end
    for (int i = 0; i < fct; ++i) {
      if (_ddata[i] == _ddata[i + 1]) {
        _Running[i] = _ddata[i];
      }
    }
    _disdata.clear();
    _disdata.add([]);
    _disNum.clear();
    _disNum.add([]);
    for (int i = 1; i <= fct; ++i) {
      _disdata.add([]);
      _disNum.add(
        [
          Container(
            height: 30,
            child: Text(
              '0',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
        ],
      );
      for (int j = 1; j <= i; ++j) {
        String temp = 'P' + _ddata[j].toString();
        if (_ddata[j] == -1) temp = ' ';
        if (j + 1 <= i && _ddata[j] == _ddata[j + 1]) continue;
        _disNum[i].add(
          Container(height: 70),
        );
        _disNum[i].add(
          Container(
            height: 30,
            child: Text(
              j.toString(),
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
        );
        if (j == i && j + 1 <= fct && _ddata[j] == _ddata[j + 1]) {
          _disdata[i].add(
            Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: Colors.red),
                  right: BorderSide(color: Colors.red),
                  top: BorderSide(color: Colors.red),
                ),
              ),
              width: 100,
              height: 100,
              child: Center(
                child: Text(
                  temp,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          );
          continue;
        }
        _disdata[i].add(
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.red)),
            width: 100,
            height: 100,
            child: Center(
              child: Text(
                temp,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
        );
      }
    }
    _Na.clear();
    _Re.clear();
    _Ru.clear();
    _Te.clear();
    _Io.clear();
    for (int i = 0; i <= fct; ++i) {
      String tempNa = '', tempRe = '', tempTe = '', tempRu = '', tempIo = '';
      for (int j = 0; j < _counter; ++j) {
        if (_data[j][0] > i) {
          if (tempNa.isEmpty)
            tempNa += 'P' + j.toString();
          else
            tempNa += ', P' + j.toString();
        } else if (_data[j][4] <= i) {
          if (tempTe.isEmpty)
            tempTe += 'P' + j.toString();
          else
            tempTe += ', P' + j.toString();
        } else if (_Running[i] == j) {
          tempRu += 'P' + j.toString();
        } else if (_IoIn[j] <= i && _IoOut[j] >= i) {
          if (tempIo.isEmpty)
            tempIo += 'P' + j.toString();
          else
            tempIo += ', P' + j.toString();
        } else {
          if (tempRe.isEmpty)
            tempRe += 'P' + j.toString();
          else
            tempRe += ', P' + j.toString();
        }
      }
      _Na.add(tempNa);
      _Te.add(tempTe);
      _Re.add(tempRe);
      _Ru.add(tempRu);
      _Io.add(tempIo);
    }

    view.TakeData('RR', _Na, _Re, _Ru, _Io, _Te, fct, _disdata, _disNum);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => view()),
    );
  }

  void _calculate() {
    List<int> RQ = [], bt1, bt2, iobt, at;
    List<bool> inTQP, vis;
    bt1 = new List<int>.filled(_counter, 0);
    bt2 = new List<int>.filled(_counter, 0);
    iobt = new List<int>.filled(_counter, 0);
    at = new List<int>.filled(_counter, 0);
    for (int i = 0; i < _counter; ++i) {
      bt1[i] = _data[i][1];
      iobt[i] = _data[i][2];
      bt2[i] = _data[i][3];
      at[i] = _data[i][0];
    }
    int ttnp = 0, _iofRQ = 0, st = 0;
    inTQP = new List<bool>.filled(_counter, false);
    vis = new List<bool>.filled(_counter, false);
    while (true) {
      bool flag = true;
      for (int i = 0; i < _counter; ++i) {
        if (_data[i][3] > 0) flag = false;
      }
      if (flag) break;

      for (int i = 0; i < _counter; ++i) {
        if (_data[i][0] == st &&
            !inTQP[i] &&
            (_data[i][1] > 0 || _data[i][3] > 0)) {
          RQ.add(i);
          //print('here chance');
        }
        if (_data[i][0] == st &&
            inTQP[i] &&
            (_data[i][1] > 0 || _data[i][3] > 0)) {
          //print('object');
          RQ.add(i);
          inTQP[i] = !inTQP[i];
        }
      }
      if (st >= ttnp && _iofRQ < RQ.length) {
        if (_data[RQ[_iofRQ]][1] > 0) {
          if (!vis[RQ[_iofRQ]]) {
            _data[RQ[_iofRQ]][7] = st - at[RQ[_iofRQ]];
            vis[RQ[_iofRQ]] = true;
          }
          int temp = min(TQ, _data[RQ[_iofRQ]][1]);
          _data[RQ[_iofRQ]][0] = st + temp;
          _data[RQ[_iofRQ]][1] -= temp;
          ttnp = st + temp;
          _data[RQ[_iofRQ]][4] = ttnp;
          inTQP[RQ[_iofRQ]] = !inTQP[RQ[_iofRQ]];

          _data[RQ[_iofRQ]][5] = _data[RQ[_iofRQ]][4] - at[RQ[_iofRQ]];
          _data[RQ[_iofRQ]][6] =
              _data[RQ[_iofRQ]][5] - bt1[RQ[_iofRQ]] - bt2[RQ[_iofRQ]];
          if (_data[RQ[_iofRQ]][1] == 0) {
            _data[RQ[_iofRQ]][0] += _data[RQ[_iofRQ]][2];
          }
          st++;
        } else if (_data[RQ[_iofRQ]][3] > 0) {
          if (!vis[RQ[_iofRQ]]) {
            _data[RQ[_iofRQ]][7] = st - at[RQ[_iofRQ]];
            vis[RQ[_iofRQ]] = true;
          }
          int temp = min(TQ, _data[RQ[_iofRQ]][3]);
          _data[RQ[_iofRQ]][0] = st + temp;
          _data[RQ[_iofRQ]][3] -= temp;
          ttnp = st + temp;
          _data[RQ[_iofRQ]][4] = ttnp;
          inTQP[RQ[_iofRQ]] = !inTQP[RQ[_iofRQ]];
          _data[RQ[_iofRQ]][5] = _data[RQ[_iofRQ]][4] - at[RQ[_iofRQ]];
          _data[RQ[_iofRQ]][6] =
              _data[RQ[_iofRQ]][5] - bt1[RQ[_iofRQ]] - bt2[RQ[_iofRQ]];
          st++;
        }
        _iofRQ++;
      } else {
        st++;
      }
    }
    int _sum = 0;
    for (int i = 0; i < _counter; ++i) _sum += _data[i][5];
    _avg_tat = _sum / _counter;
    _sum = 0;
    for (int i = 0; i < _counter; ++i) _sum += _data[i][6];
    _avg_wt = _sum / _counter;
    for (int loc = 0; loc < _counter; ++loc) {
      for (int i = 0; i < 8; ++i) _datas[loc][i] = _data[loc][i].toString();
      int t = loc;
      _rowList[loc] = DataRow(cells: <DataCell>[
        DataCell(
            Text('P' + t.toString(), style: TextStyle(color: Colors.white))),
        DataCell(TextField(
          //expands: true,
          inputFormatters: [
            LengthLimitingTextInputFormatter(2),
          ],
          maxLines: 1,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: TextStyle(color: Colors.white),
          onChanged: (val) {
            setState(() {
              _datas[t][0] = val;
              _data[t][0] = int.parse(val);
              _calculate();
            });
          },
        )),
        DataCell(TextField(
          maxLines: 1,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: TextStyle(color: Colors.white),
          onChanged: (val) {
            _datas[t][1] = val;
            _data[t][1] = int.parse(val);
            setState(() {
              _calculate();
            });
          },
        )),
        DataCell(TextField(
          maxLines: 1,
          //       inputFormatters:[
          //   LengthLimitingTextInputFormatter(2),
          // ],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: TextStyle(color: Colors.white),
          onChanged: (val) {
            setState(() {
              _datas[t][2] = val;
              _data[t][2] = int.parse(val);
              _calculate();
            });
          },
        )),
        DataCell(TextField(
          maxLines: 1,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: TextStyle(color: Colors.white),
          onChanged: (val) {
            setState(() {
              _datas[t][3] = val;
              _data[t][3] = int.parse(val);
              _calculate();
            });
          },
        )),
        DataCell(Text(_datas[t][4], style: TextStyle(color: Colors.white))),
        DataCell(Text(_datas[t][5], style: TextStyle(color: Colors.white))),
        DataCell(Text(_datas[t][6], style: TextStyle(color: Colors.white))),
        DataCell(Text(_datas[t][7], style: TextStyle(color: Colors.white))),
      ]);
    }
    for (int i = 0; i < _counter; ++i) {
      _data[i][1] = bt1[i];
      _data[i][0] = at[i];
      _data[i][3] = bt2[i];
    }
  }

  void _addrow() {
    setState(() {
      var t = _counter;
      _counter++;
      _data.add([0, 0, 0, 0, 0, 0, 0, 0]);
      _datas.add(['0', '0', '0', '0', '0', '0', '0', '0']);
      _rowList.add(DataRow(cells: <DataCell>[
        DataCell(Text('P' + (_counter - 1).toString(),
            style: TextStyle(color: Colors.white))),
        DataCell(TextField(
          maxLines: 1,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: TextStyle(color: Colors.white),
          onChanged: (val) {
            setState(() {
              _datas[t][0] = val;
              _data[t][0] = int.parse(val);
              _calculate();
            });
          },
        )),
        DataCell(TextField(
          maxLines: 1,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: TextStyle(color: Colors.white),
          onChanged: (val) {
            _datas[t][1] = val;
            _data[t][1] = int.parse(val);
            setState(() {
              _calculate();
            });
          },
        )),
        DataCell(TextField(
          maxLines: 1,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: TextStyle(color: Colors.white),
          onChanged: (val) {
            _datas[t][2] = val;
            _data[t][2] = int.parse(val);
            setState(() {
              _calculate();
            });
          },
        )),
        DataCell(TextField(
          maxLines: 1,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: TextStyle(color: Colors.white),
          onChanged: (val) {
            _datas[t][3] = val;
            _data[t][3] = int.parse(val);
            setState(() {
              _calculate();
            });
          },
        )),
        DataCell(Text(_datas[t][4], style: TextStyle(color: Colors.white))),
        DataCell(Text(_datas[t][5], style: TextStyle(color: Colors.white))),
        DataCell(Text(_datas[t][6], style: TextStyle(color: Colors.white))),
        DataCell(Text(_datas[t][7], style: TextStyle(color: Colors.white))),
      ]));
    });
  }

  void _RemoveRow() {
    setState(() {
      _counter--;
      _rowList.removeLast();
      _data.removeLast();
      _datas.removeLast();
      _calculate();
    });
  }

  var f = true;
  @override
  Widget build(BuildContext context) {
    if (f) {
      _addrow();
      f = false;
    }
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            'RR',
            style: TextStyle(fontFamily: 'Pacifico'),
          ),
          backgroundColor: Colors.red,
        ),
        body: Container(
          width: double.infinity,
          child: ListView(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Align(
                          child: Row(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      'TQ',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(20),
                                  ),
                                  Container(
                                    width: 60,
                                    child: TextField(
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            borderSide:
                                            BorderSide(color: Colors.red)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            borderSide:
                                            BorderSide(color: Colors.red)),
                                      ),
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(color: Colors.white),
                                      onChanged: (val) {
                                        TQ = int.parse(val);
                                        setState(() {
                                          _calculate();
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Row(),
                            ],
                          ),
                          alignment: Alignment.topLeft,
                        ),
                        padding: EdgeInsets.all(30),
                        //color: Colors.lightBlue[400],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Align(
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    'I/O Device',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Switch(
                                      value: true,
                                      onChanged: (t) {
                                        Navigator.pop(context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => RR()),
                                        );
                                      }),
                                ],
                              ),
                            ],
                          ),
                          alignment: Alignment.topRight,
                        ),
                        padding: EdgeInsets.all(30),
                        //color: Colors.deepPurple[800],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: [
                        DataColumn(
                            label: Text('P',
                                style: TextStyle(color: Colors.white)),
                            numeric: false),
                        DataColumn(
                            label: Text('AT',
                                style: TextStyle(color: Colors.white)),
                            numeric: true),
                        DataColumn(
                            label: Text('BT',
                                style: TextStyle(color: Colors.white)),
                            numeric: true),
                        DataColumn(
                            label: Text('I/O BT',
                                style: TextStyle(color: Colors.white)),
                            numeric: true),
                        DataColumn(
                            label: Text('BT',
                                style: TextStyle(color: Colors.white)),
                            numeric: true),
                        DataColumn(
                            label: Text('CT',
                                style: TextStyle(color: Colors.white)),
                            numeric: true),
                        DataColumn(
                            label: Text('TAT',
                                style: TextStyle(color: Colors.white)),
                            numeric: true),
                        DataColumn(
                            label: Text('WT',
                                style: TextStyle(color: Colors.white)),
                            numeric: true),
                        DataColumn(
                            label: Text('RT',
                                style: TextStyle(color: Colors.white)),
                            numeric: true),
                      ],
                      rows: _rowList,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: (RaisedButton(
                      onPressed: _addrow,
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(color: Colors.red),
                      ),
                      child: Text(
                        'Add Process',
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Builder(
                      builder: (context) => (RaisedButton(
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(color: Colors.red),
                        ),
                        child: Text(
                          'Delete Process',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          _RemoveRow();
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('Row Deleted'),
                          ));
                        },
                      )),
                    ),
                    /*
                    child: (RaisedButton(
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(color: Colors.red),
                      ),
                      child: Text(
                        'Delete Process',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: (){
                        _RemoveRow();
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Row Deleted'),
                          )
                        );
                      },
                    )),*/
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(5),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: (RaisedButton(
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(color: Colors.red),
                      ),
                      child: Text(
                        'Gantt Chart',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        _Gant();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CARD(_cardvs, _readyq),
                            ));
                      },
                    )),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: (RaisedButton(
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(color: Colors.red),
                      ),
                      child: Text(
                        'Visulization',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: _viz,
                    )),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    padding: EdgeInsets.all(10),
                    //padding: EdgeInsets.fromLTRB(60, 25, 0, 0),
                    child: Text('AVg. TAT = ' + _avg_tat.toStringAsFixed(2),
                        style: TextStyle(color: Colors.white)),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    padding: EdgeInsets.all(10),
                    //padding: EdgeInsets.fromLTRB(100, 25, 0, 0),
                    child: Text('AVg. WT = ' + _avg_wt.toStringAsFixed(2),
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              Container(height: 700),
            ],
          ),
        ));
  }
}