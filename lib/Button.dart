import 'package:flutter/material.dart';
import './FCFS.dart';
import './SJF.dart';
import './SRTF.dart';
import './LJF.dart';
import './LRTF.dart';
import './RR.dart';
import './priority.dart';
import './PPriority.dart';

class Schedule extends StatelessWidget {
  @override
  String s;
  BuildContext conText;

  //constructor
  Schedule(this.s);

  //next page function
  void Page() {
    if (s == 'FCFS') {
      Navigator.push(
        conText,
        MaterialPageRoute(builder: (conText) => FCFS()),
      );
    } else if (s == 'SJF') {
      Navigator.push(
        conText,
        MaterialPageRoute(builder: (conText) => SJF()),
      );
    } else if (s == 'SRTF') {
      Navigator.push(
        conText,
        MaterialPageRoute(builder: (conText) => SRTF()),
      );
    } else if (s == 'LJF') {
      Navigator.push(
        conText,
        MaterialPageRoute(builder: (conText) => LJF()),
      );
    } else if (s == 'LRTF') {
      Navigator.push(
        conText,
        MaterialPageRoute(builder: (conText) => LRTF()),
      );
    } else if (s == 'RR') {
      Navigator.push(
        conText,
        MaterialPageRoute(builder: (conText) => RR()),
      );
    } else if (s == 'Priority') {
      Navigator.push(
        conText,
        MaterialPageRoute(builder: (conText) => Priority()),
      );
    } else if (s == 'Priority preemp') {
      Navigator.push(
        conText,
        MaterialPageRoute(builder: (conText) => PPriority()),
      );
    }
  }

  Widget build(BuildContext context) {
    conText = context;
    //style this raised button anyone..!!!
    //raised button on home page
    return RaisedButton(
      child: Container(
        child: Center(
          child: Text(s,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              )),
        ),
        width: 150,
        height: 25,
      ),
      onPressed: Page,
      color: Colors.red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: Colors.redAccent),
      ),
      padding: EdgeInsets.all(15),
    );
  }
}