import 'package:flutter/material.dart';
import '../widget/appointment_time.dart';

class ChooseTimePage extends StatefulWidget {
  final int operatorId;
  final String dateFormat;
  final Map<String, dynamic> meets;
  const ChooseTimePage(this.operatorId, this.dateFormat, this.meets,
      {super.key});

  @override
  State<ChooseTimePage> createState() => _ChooseTimePageState();
}

class _ChooseTimePageState extends State<ChooseTimePage> {
  // void changeBookingStatus(int operatorId, int timeSlot) {

  // }

  List<Widget> timeSlots() {
    List<dynamic> bookedSlot = [];

    if (widget.meets[widget.dateFormat] != null) {
      if ((widget.meets[widget.dateFormat] as List<dynamic>).isNotEmpty) {
        bookedSlot = (widget.meets[widget.dateFormat] as List<dynamic>);
      }
    }
    // if ((operatorBookings[widget.operatorId]
    //         as Map<String, Object>)[widget.dateFormat] !=
    //     null) {
    //   bookedSlot = (operatorBookings[widget.operatorId]
    //       as Map<String, Object>)[widget.dateFormat] as List<int>;
    // }

    List<Map<int, List<int>>> availableBookings = List.generate(24, (index) {
      return {
        index: [index, index + 1]
      };
    });

    for (var i = 0; i < bookedSlot.length; i++) {
      // availableBookings.removeAt(bookedSlot[i]);
      availableBookings
          .removeWhere((element) => element.keys.elementAt(0) == bookedSlot[i]);
    }

    // availableBookings.sort();

    // List<List<int>> mergedBookings;
    return [
      ...(availableBookings.map(
        (e) => Appointment(
          widget.operatorId,
          (e.values.elementAt(0) as List<int>),
          true,
          widget.dateFormat,
        ),
      )),
      ...(bookedSlot.map(
        (e) => Appointment(
          widget.operatorId,
          [e, e + 1],
          false,
          widget.dateFormat,
        ),
      )),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Wrap(
          direction: Axis.vertical,
          spacing: 10,
          children: [
            ...timeSlots(),
          ],
        ),
      ),
    );
  }
}
