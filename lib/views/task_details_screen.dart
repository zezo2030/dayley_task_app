import 'package:dayley_task_app/routes/pages.dart';
import 'package:dayley_task_app/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
        actions: [
          PopupMenuButton<int>(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: kWhiteColor,
            elevation: 1,
            onSelected: (value) {
              switch (value) {
                case 0:
                  {
                    Navigator.pushNamed(context, Pages.updateTask);
                    break;
                  }
                case 1:
                  {
                    if (taskViewModel.selectedTask!.isCompleted) {
                      int ind = taskViewModel.tasks
                          .indexOf(taskViewModel.selectedTask!);
                      taskViewModel.deleteTask(ind);
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('cannotDeleteNotCompleted'.tr()),
                          backgroundColor: kRed,
                        ),
                      );
                    }
                    break;
                  }
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svgs/edit.svg',
                      width: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    buildText('Edit task', kBlackColor, 14, FontWeight.normal,
                        TextAlign.start, TextOverflow.clip)
                  ],
                ),
              ),
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svgs/delete.svg',
                      width: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    buildText('Delete task', kRed, 14, FontWeight.normal,
                        TextAlign.start, TextOverflow.clip)
                  ],
                ),
              ),
            ],
            //child: SvgPicture.asset('assets/svgs/vertical_menu.svg'),
          )
        ],
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
              boxShadow: [
                BoxShadow(
                  color: kGrey2,
                  offset: const Offset(0, 4),
                  blurRadius: 10,
                ),
              ],
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
                    if (duradata > 0)
                      Text(
                        "End Date :",
                        style: TextStyle(
                          color: kBlackColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    Container(
                      child: duradata <= 0
                          ? GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, Pages.updateTask),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: kPrimaryColor.withAlpha(170),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  "Time is up , PLZ Update Your Task",
                                  style: TextStyle(
                                    color: kWhiteColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                          : SlideCountdownSeparated(
                              duration: Duration(milliseconds: duradata),
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
                  ));
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
