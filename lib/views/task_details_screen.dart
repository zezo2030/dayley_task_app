import 'package:dayley_task_app/routes/pages.dart';
import 'package:dayley_task_app/widgets/animated_todo_item_completed.dart';
import 'package:dayley_task_app/widgets/container_gradient_extension.dart';
import 'package:dayley_task_app/widgets/gradient_mask_widget.dart';
import 'package:dayley_task_app/widgets/padding_extension.dart';
import 'package:dayley_task_app/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:dayley_task_app/utils/color_palette.dart';
import 'package:dayley_task_app/viewmodel/task_view_model.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({super.key});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  bool isCompleted = false;

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
        title: Text(
          "ًWork Space",
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ).redToBlueGradientMask(),
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
                          letterSpacing: 1.2,
                        ),
                      ).redToBlueGradientMask(),
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
                              separatorStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
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
          const SizedBox(height: 10),
          LinearPercentIndicator(
            lineHeight: 30.0,
            percent: 0.82,
            center: Text(
              "50%", //"${(task.completionPercentage * 100).toStringAsFixed(1)}%"
              style: TextStyle(
                fontSize: 16.0,
                color: kWhiteColor,
                fontWeight: FontWeight.w600,
                shadows: [
                  Shadow(
                    color: kPrimaryColor,
                    blurRadius: 10,
                  ),
                ],
                fontStyle: FontStyle.italic,
              ),
            ),
            linearGradient: LinearGradient(
              colors: [Colors.red, Colors.blue],
            ),
            backgroundColor: kGrey3,
            barRadius: Radius.circular(10),
          ),
          const SizedBox(height: 10),
          // task title
          Center(
            child: Text(
              task.title,
              style: TextStyle(
                color: kBlackColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ).redToBlueGradientMask(),
          ),
          const SizedBox(height: 5),
          // task description
          Center(child: Text(task.description)),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("all : 0").redToBlueGradientMask(),
              const SizedBox(width: 10),
              Text("complete : 0").redToBlueGradientMask(),
              const SizedBox(width: 10),
              Text("Incomplete : 0").redToBlueGradientMask(),
            ],
          ).paddingSymmetric(horizontal: 16),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(), // إلغاء التمرير الداخلي
            shrinkWrap: true, // اجعل القائمة تأخذ المساحة المطلوبة فقط
            itemCount: taskViewModel.tasks.length,
            itemBuilder: (context, index) {
              return AnimatedTaskItem(
                title: taskViewModel.tasks[index].title,
                subtitle: 'اضغط للاكمال',
                isCompleted: taskViewModel.tasks[index].isCompleted,
                onTap: () {
                  // تنفيذ شيء عند الضغط
                  taskViewModel.toggleTaskComplection(index);
                },
              ).paddingAll(10);
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
