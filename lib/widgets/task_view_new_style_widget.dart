import 'package:dayley_task_app/routes/pages.dart';
import 'package:dayley_task_app/utils/color_palette.dart';
import 'package:dayley_task_app/viewmodel/task_view_model.dart';
import 'package:dayley_task_app/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:dayley_task_app/utils/date_formatter.dart';

class TaskViewNewStyleWidget extends StatefulWidget {
  const TaskViewNewStyleWidget({super.key});

  @override
  State<TaskViewNewStyleWidget> createState() => _TaskViewNewStyleWidgetState();
}

class _TaskViewNewStyleWidgetState extends State<TaskViewNewStyleWidget> {
  @override
  Widget build(BuildContext context) {
    final taskViewModel = context.watch<TaskViewModel>();
    return ListView.builder(
      itemCount: taskViewModel.tasks.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            taskViewModel.setSelectedTask(taskViewModel.tasks[index]);
            Navigator.pushNamed(context, Pages.taskDetails);
          },
          child: Container(
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
            child: Slidable(
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  GestureDetector(
                    onTap: () {
                      if (!taskViewModel.tasks[index].isCompleted) {
                        Navigator.pushNamed(context, Pages.updateTask);
                        taskViewModel
                            .setSelectedTask(taskViewModel.tasks[index]);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('cannotEditCompleted'.tr()),
                            duration: const Duration(seconds: 2),
                            backgroundColor:
                                const Color.fromARGB(255, 29, 255, 40),
                          ),
                        );
                      }
                    },
                    child: Container(
                      height: 160,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 81, 236, 148),
                        borderRadius: context.locale.languageCode == 'en'
                            ? BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              )
                            : BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/svgs/edit.svg',
                              width: 20,
                              colorFilter: ColorFilter.mode(
                                kWhiteColor,
                                BlendMode.srcIn,
                              ),
                            ),
                            buildText(
                              'edit'.tr(),
                              kWhiteColor,
                              12,
                              FontWeight.w400,
                              TextAlign.center,
                              TextOverflow.clip,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (taskViewModel.tasks[index].isCompleted) {
                        taskViewModel.deleteTask(index);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Cannot delete completed task'),
                            duration: Duration(seconds: 2),
                            backgroundColor: Color.fromARGB(255, 255, 102, 92),
                          ),
                        );
                      }
                    },
                    child: Container(
                      height: 160,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 140, 140),
                        borderRadius: context.locale.languageCode == 'en'
                            ? BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              )
                            : BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/svgs/delete.svg',
                              width: 20,
                              colorFilter: ColorFilter.mode(
                                  kWhiteColor, BlendMode.srcIn),
                            ),
                            buildText(
                              'delete'.tr(),
                              kWhiteColor,
                              12,
                              FontWeight.w400,
                              TextAlign.center,
                              TextOverflow.clip,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              child: Container(
                height: 160,
                width: double.infinity,
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.circular(10),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Color(0xFFC8D9CF).withOpacity(0.5),
                  //     blurRadius: 8,
                  //     offset: Offset(0, 2),
                  //   ),
                  // ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildText(
                              taskViewModel.tasks[index].title,
                              kBlackColor,
                              16,
                              FontWeight.bold,
                              TextAlign.start,
                              TextOverflow.clip,
                              isComplete:
                                  taskViewModel.tasks[index].isCompleted,
                            ),
                            SizedBox(height: 5),
                            buildText(
                              taskViewModel.tasks[index].description,
                              kGrey1,
                              14,
                              FontWeight.normal,
                              TextAlign.start,
                              TextOverflow.clip,
                              isComplete:
                                  taskViewModel.tasks[index].isCompleted,
                            ),
                          ],
                        ),
                        ToggleSwitch(
                          minWidth: 40.0,
                          minHeight: 30.0,
                          initialLabelIndex:
                              taskViewModel.tasks[index].isCompleted ? 1 : 0,
                          cornerRadius: 5.0,
                          radiusStyle: true,
                          activeFgColor: Colors.white,
                          inactiveBgColor: kGrey4,
                          inactiveFgColor: Colors.white,
                          totalSwitches: 2,
                          icons: [
                            FontAwesomeIcons.lightbulb,
                            FontAwesomeIcons.solidLightbulb,
                          ],
                          iconSize: 30.0,
                          activeBgColors: [
                            [Colors.black45, Colors.black26],
                            [
                              const Color.fromARGB(255, 95, 240, 102),
                              Colors.orange
                            ],
                          ],
                          animate: false,
                          curve: Curves.easeInBack,
                          onToggle: (indext) {
                            taskViewModel.toggleTaskComplection(index);
                          },
                        )
                      ],
                    ),
                    Container(
                      height: 30,
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: kPrimaryColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/svgs/calender.svg',
                              width: 14,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            buildText(
                                '${formatDateByLocale(taskViewModel.tasks[index].startDate.toString(), context.locale.languageCode)} - ${formatDateByLocale(taskViewModel.tasks[index].endDate.toString(), context.locale.languageCode)}',
                                kBlackColor,
                                12,
                                FontWeight.w400,
                                TextAlign.start,
                                TextOverflow.clip,
                                isComplete:
                                    taskViewModel.tasks[index].isCompleted),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
