import 'package:dayley_task_app/utils/color_palette.dart';
import 'package:dayley_task_app/viewmodel/task_view_model.dart';
import 'package:dayley_task_app/widgets/padding_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class ModerTaskView extends StatefulWidget {
  const ModerTaskView({super.key});

  @override
  State<ModerTaskView> createState() => _ModerTaskViewState();
}

class _ModerTaskViewState extends State<ModerTaskView> {
  // https://dribbble.com/shots/20159263-Task-and-Project-Management-Mobile-App

  bool isCompleted = false;
  @override
  Widget build(BuildContext context) {
    final taskViewModel = context.watch<TaskViewModel>();

    return Scaffold(
      backgroundColor: kWhiteColor,
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Text(
            "Your \nAll Tasks ✌️",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ).paddingAll(16),
          ListView.builder(
            itemCount: taskViewModel.tasks.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final lko = taskViewModel.tasks[index].color.withOpacity(0.5);
              return Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 110,
                          decoration: BoxDecoration(
                            color: lko,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25),
                              topLeft: Radius.circular(16),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Completed",
                              style: TextStyle(
                                color: kTextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ).paddingAll(8),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: lko,
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: kWhiteColor,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                ),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 10),
                                  SizedBox(
                                    width: 130,
                                    child: LinearPercentIndicator(
                                      lineHeight: 5,
                                      percent: 0.5,
                                      progressColor: lko,
                                      backgroundColor: lko.withOpacity(0.2),
                                      barRadius: Radius.circular(10),
                                    ),
                                  ),
                                  Text(
                                    "50%",
                                    style: TextStyle(
                                      color: taskViewModel.tasks[index].color,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ).paddingAll(8),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: lko,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                              topRight: Radius.circular(20)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              child: Transform.rotate(
                                angle: 45 * 3.1415927 / 180,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: taskViewModel.tasks[index].color,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Transform.rotate(
                                    angle: -45 * 3.1415927 / 180,
                                    child: SvgPicture.asset(
                                      'assets/svgs/task_list.svg',
                                      height: 50,
                                      color: kWhiteColor,
                                    ).paddingAll(16),
                                  ),
                                ),
                              ).paddingAll(20),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    taskViewModel.tasks[index].title,
                                    style: TextStyle(
                                      color: kTextColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                                  Text(
                                    taskViewModel.tasks[index].title,
                                    style: TextStyle(
                                      color: kTextColor,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 50,
                              child: IconButton(
                                onPressed: () {
                                  taskViewModel.deleteTask(index);
                                },
                                icon: SvgPicture.asset(
                                  'assets/svgs/delete.svg',
                                  height: 22,
                                  colorFilter: ColorFilter.mode(
                                    kTextColor,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ).paddingSymmetric(horizontal: 20, vertical: 10);
            },
          ),
        ],
      ),
    );
  }
}
