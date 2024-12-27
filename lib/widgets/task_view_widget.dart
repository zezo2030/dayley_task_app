import 'package:dayley_task_app/routes/pages.dart';
import 'package:dayley_task_app/utils/color_palette.dart';
import 'package:dayley_task_app/utils/util.dart';
import 'package:dayley_task_app/viewmodel/task_view_model.dart';
import 'package:dayley_task_app/views/update_task.dart';
import 'package:dayley_task_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class TaskViewWidget extends StatelessWidget {
  const TaskViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var taskViewModel = Provider.of<TaskViewModel>(context);
    return ListView.builder(
      itemCount: taskViewModel.tasks.length,
      itemBuilder: (context, index) {
        return Container(
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.only(bottom: 20),
            child: Row(
              children: [
                Checkbox(
                  value: taskViewModel.tasks[index].isCompleted,
                  onChanged: (bool? value) {
                    taskViewModel.toggleTaskComplection(index);
                  },
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: buildText(
                                  taskViewModel.tasks[index].title,
                                  kBlackColor,
                                  14,
                                  FontWeight.w500,
                                  TextAlign.start,
                                  TextOverflow.clip)),
                          PopupMenuButton<int>(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: kWhiteColor,
                            elevation: 1,
                            onSelected: (value) {
                              switch (value) {
                                case 0:
                                  {
                                    // Navigator.pushNamed(
                                    //     context, Pages.updateTask,
                                    //     arguments: {"index": index});
                                    // break;
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return UpdateTask(
                                        index: index,
                                      );
                                    }));
                                  }
                                case 1:
                                  {
                                    // context.read<TasksBloc>().add(DeleteTaskEvent(
                                    //     taskModel: widget.taskModel));
                                    // break;
                                    // taskViewModel.deleteTask(
                                    //     int.parse(taskViewModel.tasks[index].id));
                                    taskViewModel.deleteTask(index);
                                  }
                              }
                            },
                            itemBuilder: (BuildContext context) {
                              return [
                                PopupMenuItem<int>(
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
                                      buildText(
                                          'Edit task',
                                          kBlackColor,
                                          14,
                                          FontWeight.normal,
                                          TextAlign.start,
                                          TextOverflow.clip)
                                    ],
                                  ),
                                ),
                                PopupMenuItem<int>(
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
                                      buildText(
                                          'Delete task',
                                          kRed,
                                          14,
                                          FontWeight.normal,
                                          TextAlign.start,
                                          TextOverflow.clip)
                                    ],
                                  ),
                                ),
                              ];
                            },
                            child: SvgPicture.asset(
                                'assets/svgs/vertical_menu.svg'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      buildText(
                          taskViewModel.tasks[index].description,
                          kGrey1,
                          12,
                          FontWeight.normal,
                          TextAlign.start,
                          TextOverflow.clip),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                              color: kPrimaryColor.withOpacity(.1),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/svgs/calender.svg',
                                width: 12,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: buildText(
                                    '${formatDate(dateTime: taskViewModel.tasks[index].startDate.toString())} - ${formatDate(dateTime: taskViewModel.tasks[index].endDate.toString())}',
                                    kBlackColor,
                                    10,
                                    FontWeight.w400,
                                    TextAlign.start,
                                    TextOverflow.clip),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ));
      },
    );
  }
}
