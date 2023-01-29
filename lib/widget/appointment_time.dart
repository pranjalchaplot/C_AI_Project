import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:online_scheduler/appointments_data.dart';
import 'package:path_provider/path_provider.dart';

import '../model/operator_model.dart';

class Appointment extends StatefulWidget {
  final int operatorId;
  final List<int> timeId;
  final String dateFormat;
  bool isAvailable = true;

  Appointment(this.operatorId, this.timeId, this.isAvailable, this.dateFormat,
      {super.key});
  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  // Future<List<OperatorModel>> operatorList() async {
  //   //read json file

  //   //map json and initialize using DataModel
  //   print(list);
  //   return list.map((e) => OperatorModel.fromJson(e)).toList();
  // }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  void changeBookingStatus(int operatorId, int timeSlot) async {
    final jsondata = await rootBundle.rootBundle.loadString('/data_file.json');
    //decode json data as list
    final list = json.decode(jsondata);

    List<dynamic> oL = list.map((e) => OperatorModel.fromJson(e)).toList();

    final path = await _localPath;
    final File file = File('$path/data_file.json');

    setState(() {
      if (widget.isAvailable) {
        if ((oL[widget.operatorId].meetings
                as Map<String, dynamic>)[widget.dateFormat] ==
            null) {
          (oL[widget.operatorId].meetings as Map<String, dynamic>)
              .addAll({widget.dateFormat: List.empty(growable: true)});
        }

        (oL[widget.operatorId].meetings
                as Map<String, dynamic>)[widget.dateFormat]
            .add(timeSlot);
        // ((operatorBookings[operatorId]
        //         as Map<String, List<int>>)[widget.dateFormat] as List<int>)
        //     .add(timeSlot);
        // ((operatorBookings[operatorId]
        //         as Map<String, List<int>>)[widget.dateFormat] as List<int>)
        //     .sort();
      } else {
        // ((operatorBookings[operatorId]
        //         as Map<String, List<int>>)[widget.dateFormat] as List<int>)
        //     .removeWhere((element) => element == timeSlot);
        (oL[widget.operatorId].meetings
                as Map<String, dynamic>)[widget.dateFormat]
            .removeWhere((element) => element == timeSlot);
      }
      widget.isAvailable = !widget.isAvailable;
      oL.map((e) {
        print(e);
        e.toJson();
      });

      file.writeAsStringSync(json.encode(oL));
    });
    // print(
    //   ((operatorBookings[operatorId]
    //       as Map<String, List<int>>)[widget.dateFormat] as List<int>),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        return changeBookingStatus(widget.operatorId, widget.timeId[0]);
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
        widget.isAvailable ? Colors.blue.shade900 : Colors.red.shade900,
      )),
      child: Text('${widget.timeId[0]} - ${widget.timeId[1]}'),
    );
  }
}
