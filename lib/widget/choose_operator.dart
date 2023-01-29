import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:intl/intl.dart';
import 'package:online_scheduler/widget/operator.dart';

import '../model/operator_model.dart';

class ChooseOperator extends StatefulWidget {
  final DateTime _chosenDate;
  const ChooseOperator(this._chosenDate, {super.key});

  @override
  State<ChooseOperator> createState() => _ChooseOperatorState();
}

class _ChooseOperatorState extends State<ChooseOperator> {
  Future<List<dynamic>> operatorList() async {
    //read json file
    final jsondata = await rootBundle.rootBundle.loadString('/data_file.json');
    //decode json data as list
    final list = json.decode(jsondata) as List<dynamic>;

    //map json and initialize using DataModel
    print(list);
    return list.map((e) => OperatorModel.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final String dateFormat =
        "${widget._chosenDate.day}/${widget._chosenDate.month}/${widget._chosenDate.year}";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Text(
            "Chosen Date: ${DateFormat.yMMMd().format(widget._chosenDate)}",
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        FutureBuilder(
            future: operatorList(),
            builder: (context, data) {
              if (data.hasError) {
                return Center(child: Text("${data.error}"));
              } else if (data.hasData) {
                var items = data.data as List<OperatorModel>;
                return Wrap(
                  direction: Axis.vertical,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  spacing: 30,
                  children: [
                    // Operator(0, dateFormat),
                    // Operator(1, dateFormat),
                    // Operator(2, dateFormat),
                    ...items.map((opModel) {
                      return Operator(opModel.id as int, dateFormat,
                          opModel.meetings as Map<String, dynamic>);
                    }),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            })
      ],
    );
  }
}
