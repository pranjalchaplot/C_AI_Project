import 'package:flutter/material.dart';

class OperatorButton extends StatefulWidget {
  final int id;
  final Function _bookAppointment;
  const OperatorButton(this.id, this._bookAppointment, {super.key});

  @override
  State<OperatorButton> createState() => _OperatorButtonState();
}

class _OperatorButtonState extends State<OperatorButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Colors.green,
        ),
      ),
      onPressed: () => widget._bookAppointment(context),
      child: Text(
        'Operator: ${widget.id + 1}',
      ),
    );
  }
}
