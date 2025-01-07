import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:dayley_task_app/utils/color_palette.dart';
import 'package:dayley_task_app/viewmodel/task_view_model.dart';

class TaskDetailsScreen extends StatelessWidget {
  const TaskDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskViewModel = context.watch<TaskViewModel>();
    final task = taskViewModel.selectedTask!;
    final endTime = task.endDate.millisecondsSinceEpoch;
    final int nowtime = DateTime.now().millisecondsSinceEpoch;
    final int duradata = endTime - nowtime;


    return Scaffold(
      backgroundColor: kGrey3,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        centerTitle: true,
        title: Text(task.title.toUpperCase()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kGrey1),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          Container(

            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              color: kWhiteColor,
            ),
            child: Column(

              children: [
                TableCalendar(

                  calendarFormat: CalendarFormat.week,
                  availableCalendarFormats: const {
                    CalendarFormat.week: 'Week',
                  },
                  focusedDay: DateTime.now(),
                  firstDay: DateTime.utc(2023, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("End Date :",style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,

                    ),),
                    SlideCountdownSeparated(
                      duration: Duration(milliseconds:  duradata),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kWhiteColor,
                      ),
                      separator: " : ",
                      onDone: () {
                        print('Countdown Ended');
                      },
                      decoration: BoxDecoration(
                        color: kPrimaryColor.withAlpha(170),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 60),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(), // إلغاء التمرير الداخلي
            shrinkWrap: true, // اجعل القائمة تأخذ المساحة المطلوبة فقط
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Text("12:00 AM"),
                    const SizedBox(width: 10),
                    Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )
                  ],
                )
              );
            },
          ),
          ListTile(
            title: Text("عنصر عادي 4"),
          ),
        ],
      ),
    );
  }
}