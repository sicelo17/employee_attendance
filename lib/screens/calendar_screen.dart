import 'package:employee_attendance/models/attendance_model.dart';
import 'package:employee_attendance/services/attendance_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_month_year_picker/simple_month_year_picker.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    final attendanceService = Provider.of<AttendanceService>(context);
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(top: 60, bottom: 10, left: 20),
          child: const Text(
            "My Attendance", style: TextStyle(fontSize: 25),)
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(attendanceService.attendanceHistoryMonth, style: const TextStyle(fontSize: 25),),
            OutlinedButton(onPressed: ()async {
              final selectedDate = await SimpleMonthYearPicker.showMonthYearPickerDialog(context: context, disableFuture: true);
              String pickedMonth = DateFormat("MMMM yyyy").format(selectedDate);
              attendanceService.attendanceHistoryMonth = pickedMonth;
            }, child: const Text("Pick A Month"))
          ],
        ),
        Expanded(child: FutureBuilder(
          future: attendanceService.getAttendanceHistory(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.hasData) {
              if(snapshot.data.length > 0) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      AttendanceModel attendanceData = snapshot.data[index];
                      return Container(
                          margin: const EdgeInsets.only(
                              top: 12, left: 20, right: 20, bottom: 10),
                          height: 150,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(color: Colors.black26,
                                    blurRadius: 10,
                                    offset: Offset(2, 2))
                              ],
                          borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Center(
                                child: Text(DateFormat("EE \n dd").format(attendanceData.createdAt), style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold,)),
                              ),
                            ),),
                             Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text("Check In", style: TextStyle(fontSize: 20, color: Colors.black54),),
                                  const SizedBox(width: 80, child: Divider(),),
                                  Text(attendanceData.checkIn ?? "N/A", style: const TextStyle(fontSize: 25),),
                          ],
                              ),),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text("Check Out", style: TextStyle(fontSize: 20, color: Colors.black54),),
                                  const SizedBox(width: 80, child: Divider(),),
                                  Text(attendanceData.checkOut.toString() ?? "--:--", style: const TextStyle(fontSize: 25),),
                                ],
                              ),),
                            const SizedBox(width: 15)
                        ]));
                    });
              }else {
                return const Center(child: Text("No attendance found for this month"));
              }
            }
            return const LinearProgressIndicator(backgroundColor: Colors.white, color: Colors.grey);
          }
        ))
      ],
    );
  }
}
