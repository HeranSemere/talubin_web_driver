/// Bar chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:talu_bin_driver/apps/models/completed_task.dart';
import 'package:intl/intl.dart';

class SimpleBarChart extends StatelessWidget {


List<CompletedTask> completedTasks;

String dropdownValue;



  SimpleBarChart(this.completedTasks, this.dropdownValue);



  @override
  Widget build(BuildContext context) {

    //print("The list in chart class length: "+completedTasks.length.toString());
    

    
    return new charts.BarChart(

      _createSampleData(),
      animate: true,
      behaviors: [charts.SeriesLegend()],
    );
  }




  int getSummationOfWeights(List<CompletedTask> value){

    int totalWeight = 0; 

    for(CompletedTask ct in value){
      int weight = ct.weight!.blue! + ct.weight!.red! +ct.weight!.other!;
      totalWeight += weight; 
    }

    return totalWeight;

  }
  

  List<charts.Series<Performance, String>> _createSampleData() {

    List<Performance> data = [];
    var monthdata = groupBy(completedTasks, (CompletedTask obj) => DateFormat('MMM').format(DateTime(0, DateTime.parse(obj.completedDate.toString()).month)));

  

    data = [
      new Performance('July', 5000),
      new Performance('Aug', 2500),
      new Performance('Sep', 1000),
     // new Performance('Oct', 75),
    ];

    monthdata.forEach((key, value){
    //print('Key: $key');
   // print('Value: $value');
    //print('------------------------------');

          data.add(new Performance(key, getSummationOfWeights(value)));

    });

    

    return [
      new charts.Series<Performance, String>(

        id: 'Trash collected in ${dropdownValue.toString()} (kg)',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.teal.shade300),
        domainFn: (Performance sales, _) => sales.year,
        measureFn: (Performance sales, _) => sales.weight,
        data: data,
      )
    ];
  }
}

/// Sample ordinal data type.
class Performance {
  final String year;
  final int weight;
  Performance(this.year, this.weight);
}