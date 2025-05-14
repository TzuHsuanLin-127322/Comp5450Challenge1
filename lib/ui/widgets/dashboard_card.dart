import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../ui/others/dashboard_page.dart';
import '../home_view_model.dart';

class DashboardCard extends StatefulWidget {
  final HomeViewModel vm;
  const DashboardCard({Key? key, required this.vm}) : super(key: key);

  @override
  _DashboardCardState createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
  String selected = 'Today';
  final List<String> filters = ['Today', 'Yesterday', 'This Week', 'This Month'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: filters.map((f) => Padding(
              padding: EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(f),
                selected: selected == f,
                onSelected: (_) => setState(() => selected = f),
              ),
            )).toList(),
          ),
        ),
        SizedBox(height: 16),

        // Summary Text
        Column(
          children: [
            Text('Total Sales: \$${widget.vm.totalSales.toStringAsFixed(2)}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Orders: ${widget.vm.totalOrders}', style: TextStyle(fontSize: 16)),
          ],
        ),
        SizedBox(height: 16),

        // Bar Chart
        SizedBox(
          height: 150,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              barGroups: List.generate(7, (i) => BarChartGroupData(
                x: i,
                barRods: [BarChartRodData(toY: (i + 1) * 10)],
              )),
            ),
          ),
        ),
        SizedBox(height: 16),

        // View Dashboard Button
        Container(
          width: double.infinity,
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey[300],
              textStyle: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DashboardPage())),
            child: Text('View Dashboard', style: TextStyle(color: Colors.black)),
          ),
        ),
      ],
    );
  }
}
