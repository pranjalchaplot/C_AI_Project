import 'package:flutter/material.dart';
import 'package:online_scheduler/pages/choose_time_slot.dart';
import 'package:online_scheduler/widget/operator_button.dart';

class Operator extends StatefulWidget {
  final int operatorId;
  final String dateFormat;
  final Map<String, dynamic> meets;
  const Operator(this.operatorId, this.dateFormat, this.meets, {super.key});

  @override
  State<Operator> createState() => _OperatorState();
}

class _OperatorState extends State<Operator> {
  List<Widget> mergedOpenSlot() {
    // Future<List<dynamic>> operatorJSON = operatorList();

    List<dynamic> bookedSlot = [];

    if (widget.meets[widget.dateFormat] != null) {
      if ((widget.meets[widget.dateFormat] as List<dynamic>).isNotEmpty) {
        bookedSlot = (widget.meets[widget.dateFormat] as List<dynamic>);
      }
    }

    // if ((widget.meets as Map<String, List<int>>)[widget.dateFormat] != null) {
    //   bookedSlot = (widget.meets as Map<String, List<int>>)[widget.dateFormat]
    //       as List<int>;
    // }

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

    List<List<int>> mergedIntervals = [];
    List<int> currRange = [];
    List<int> temp;
    if (availableBookings.isNotEmpty) {
      availableBookings.forEach((mappedElement) {
        if (currRange.isEmpty) {
          currRange = mappedElement.values.elementAt(0) as List<int>;
        } else {
          temp = mappedElement.values.elementAt(0) as List<int>;
          if (temp[0] == currRange[1]) {
            currRange[1] = temp[1];
          } else {
            mergedIntervals.add(currRange);
            currRange = temp;
          }
        }
      });
      mergedIntervals.add(currRange);
    }
    print(mergedIntervals);
    if (mergedIntervals.isEmpty) return [const Spacer()];

    return [
      ...mergedIntervals.map((intervals) {
        return ElevatedButton(
            onPressed: () {}, child: Text('${intervals[0]} - ${intervals[1]}'));
      })
    ];
  }

  void _bookAppointment(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: ChooseTimePage(
            widget.operatorId,
            widget.dateFormat,
            widget.meets,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 30,
        child: Wrap(
            direction: Axis.horizontal,
            // padding: EdgeInsets.symmetric(horizontal: 10),
            spacing: 10,
            children: [
              OperatorButton(widget.operatorId, _bookAppointment),
              ...mergedOpenSlot(),
              // items
            ]
            // ...timeSlots(),
            // ...mergedOpenSlot(),
            ));
  }
}
