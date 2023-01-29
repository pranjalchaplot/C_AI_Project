import 'package:flutter/material.dart';

// Future<List<OperatorModel>> operatorList() async {
//     //read json file
//     final jsondata =
//         await rootBundle.rootBundle.loadString('assets/data_file.json');
//     //decode json data as list
//     final list = json.decode(jsondata) as List<dynamic>;

//     //map json and initialize using DataModel
//     print(list);
//     return list.map((e) => OperatorModel.fromJson(e)).toList();
//   }

Map<int, Object> operatorBookings = {
  0: {
    '29/1/2023': [0, 1, 2, 23]
  },
  1: {
    '29/1/2023': [1, 2, 3]
  },
  2: {
    '29/1/2023': [1, 2, 5]
  },
};
