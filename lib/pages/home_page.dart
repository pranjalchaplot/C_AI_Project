import 'package:flutter/material.dart';
import '../widget/choose_operator.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _dateOfAppointment = DateTime.now();
  bool dateSelected = false;

  void _datePicker(BuildContext ctx) {
    showDatePicker(
            context: ctx,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2024))
        .then(
      (selectedDate) {
        if (selectedDate == null) return;
        setState(
          () {
            _dateOfAppointment = selectedDate;
            dateSelected = true;
          },
        );
        // print(
        //     "${_dateOfAppointment.day}/${_dateOfAppointment.month}/${_dateOfAppointment.year}");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Car Service Agency',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('24/7 Servicing'),
              const SizedBox(
                width: 10,
              ),
              OutlinedButton(
                onPressed: () => _datePicker(context),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.lightBlueAccent),
                ),
                child: const Text(
                  'Book Here',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          if (dateSelected) ChooseOperator(_dateOfAppointment),
        ],
      ),
    );
  }
}
