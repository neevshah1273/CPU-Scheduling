import 'package:flutter/material.dart';
import './Button.dart';

void main() {
  runApp(MaterialApp(title: 'CPU scheduling', home: MyApp()));
}

// home page sateful class
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              title: Center(child: Text('CPU scheduling')),
              backgroundColor: Colors.red,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      "CPU Scheduling is a process of determining which process will own CPU for execution while another process is on hold. The main task of CPU scheduling is to make sure that whenever the CPU remains idle, the OS at least select one of the processes available in the ready queue for execution. The selection process will be carried out by the CPU scheduler. It selects one of the processes in memory that are ready for execution.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    padding: EdgeInsets.all(20),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Center(child: Schedule('FCFS')),
                      ),
                      Expanded(
                        child: Center(child: Schedule('SJF')),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Center(child: Schedule('SRTF')),
                      ),
                      Expanded(
                        child: Center(child: Schedule('LJF')),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Center(child: Schedule('LRTF')),
                      ),
                      Expanded(
                        child: Center(child: Schedule('RR')),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Center(child: Schedule('Priority')),
                      ),
                      Expanded(
                        child: Center(child: Schedule('Priority preemp')),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}