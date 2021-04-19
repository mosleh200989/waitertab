import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:waiter/app/global_widgets/DrawerWidget.dart';
import 'package:waiter/app/global_widgets/indicator.dart';

import '../controllers/order_history_controller.dart';

class OrderHistoryView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      drawer: DrawerWidget(),
      appBar: AppBar(title: Text('Order History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.rice_bowl),
            color: Colors.white,
            onPressed: () {
              print('android');
            },
          ),
          TextButton(
            onPressed: () {
              // Get.offNamed(Routes.NOTIFICATION_PAGE, arguments: 0);
            },
            child: Stack(
              alignment: AlignmentDirectional.topStart,
              children: <Widget>[
                Icon(
                  Icons.notifications_none,
                  color: Colors.white,
                  size: 28,
                ),
                Container(
                  child: Text('10',
                    textAlign: TextAlign.center,
                    style: Get.theme.textTheme.caption.merge(
                      TextStyle(color: Colors.black, fontSize: 10,),
                    ),
                  ),
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(color: Colors.orange.shade200, borderRadius: BorderRadius.all(Radius.circular(10))),
                  constraints: BoxConstraints(minWidth: 15, maxWidth: 15, minHeight: 15, maxHeight: 15),
                ),
              ],
            ),
            // color: Colors.transparent,
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children:<Widget> [
              AspectRatio(
                aspectRatio: 1.3,
                child: Card(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: PieChart(
                            PieChartData(
                                pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                                  setState(() {
                                    final desiredTouch = pieTouchResponse.touchInput is! PointerExitEvent &&
                                        pieTouchResponse.touchInput is! PointerUpEvent;
                                    if (desiredTouch && pieTouchResponse.touchedSection != null) {
                                      touchedIndex = pieTouchResponse.touchedSection.touchedSectionIndex;
                                    } else {
                                      touchedIndex = -1;
                                    }
                                  });
                                }),
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                sectionsSpace: 0,
                                centerSpaceRadius: 35,
                                sections: showingSections()),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Indicator(
                            color: Color(0xff0293ee),
                            text: 'Overall Amount',
                            isSquare: true,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Indicator(
                            color: Color(0xfff8b250),
                            text: 'Last week amount',
                            isSquare: true,
                          ),
                          SizedBox(
                            height: 4,
                          ),

                        ],
                      ),

                    ],
                  ),
                ),
              ),
              AspectRatio(
                aspectRatio: 1.3,
                child: Card(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: PieChart(
                            PieChartData(
                                pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                                  setState(() {
                                    final desiredTouch = pieTouchResponse.touchInput is! PointerExitEvent &&
                                        pieTouchResponse.touchInput is! PointerUpEvent;
                                    if (desiredTouch && pieTouchResponse.touchedSection != null) {
                                      touchedIndex = pieTouchResponse.touchedSection.touchedSectionIndex;
                                    } else {
                                      touchedIndex = -1;
                                    }
                                  });
                                }),
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                sectionsSpace: 0,
                                centerSpaceRadius: 40,
                                sections: showingSections()),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Indicator(
                            color: Color(0xff0293ee),
                            text: 'Overall order',
                            isSquare: true,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Indicator(
                            color: Color(0xfff8b250),
                            text: 'last week order',
                            isSquare: true,
                          ),
                          SizedBox(
                            height: 4,
                          ),

                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );

        default:
          return null;
      }
    });
  }
}