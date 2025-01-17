import 'package:dayley_task_app/models/todo_in_task_model.dart';
import 'package:dayley_task_app/routes/pages.dart';
import 'package:dayley_task_app/viewmodel/todo_in_task_viewmodel.dart';
import 'package:dayley_task_app/widgets/gradient_mask_widget.dart';
import 'package:dayley_task_app/widgets/padding_extension.dart';
import 'package:dayley_task_app/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import 'package:dayley_task_app/utils/color_palette.dart';
import 'package:dayley_task_app/viewmodel/task_view_model.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({super.key});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  bool isCompleted = false;
  TimeOfDay? timeOfTodo;

  @override
  Widget build(BuildContext context) {
    final taskViewModel = context.watch<TaskViewModel>();
    final todoViewModel = context.watch<TodoInTaskViewModel>();
    final task = taskViewModel.selectedTask!;
    final endTime = task.endDate.millisecondsSinceEpoch;
    final int nowtime = DateTime.now().millisecondsSinceEpoch;
    final int duradata = endTime - nowtime;

    final filteredTodos =
        todoViewModel.todos.where((todo) => todo.taskId == task.id).toList();
    final completedTodos =
        filteredTodos.where((todo) => todo.isCompleted).length;

    // Calculate completion percentage
    final progress =
        filteredTodos.isEmpty ? 0.0 : completedTodos / filteredTodos.length;

    // Update task progress immediately when it changes
    if (task.progress != progress) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        taskViewModel.updateTaskProgress(task.id, progress);

        // Check if all todos are completed
        if (progress == 1.0) {
          taskViewModel.updateTaskCompletion(task.id, true);
        } else {
          taskViewModel.updateTaskCompletion(task.id, false);
        }
        print("rebuilding");
      });
    }

    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        centerTitle: true,
        title: Text(
          "ًWork Space",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: kTextColor,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kTextColor),
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
                          behavior: SnackBarBehavior.floating,
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
      floatingActionButton: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              TextEditingController todoController = TextEditingController();
              return StatefulBuilder(
                // تغيير هنا
                builder: (context, setStateDialog) {
                  // إضافة setStateDialog
                  return AlertDialog(
                    backgroundColor: kWhiteColor,
                    title: Text(
                      'Add ToDo',
                      style: TextStyle(
                        color: kTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: SizedBox(
                      height: 100,
                      child: Column(
                        children: [
                          TextField(
                            controller: todoController,
                            maxLength: 30, // حد أقصى 30 حرف
                            decoration: InputDecoration(
                              hintText: "Enter ToDo",
                              counterText: '', // إخفاء العداد الافتراضي
                              errorText: todoController.text.length > 30
                                  ? 'Maximum 20 characters allowed'
                                  : null,
                            ),
                            onChanged: (value) {
                              setStateDialog(() {}); // لتحديث الواجهة
                            },
                          ),
                          // إظهار عدد الحروف المتبقية
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '${todoController.text.length}/30',
                              style: TextStyle(
                                color: todoController.text.length > 30
                                    ? Colors.red
                                    : Colors.black54,
                              ),
                            ),
                          ),
                          //SizedBox(height: 20),
                          /*
                          SizedBox(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      TimeOfDay? pickedTime =
                                          await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      );
                                      if (pickedTime != null) {
                                        setStateDialog(() {
                                          // استخدام setStateDialog بدلاً من setState
                                          timeOfTodo = pickedTime;
                                        });
                                      }
                                    },
                                    child: Container(
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: task.color,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            offset: const Offset(0, 2),
                                            blurRadius: 2,
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Pick Time',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: kTextColor,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                SizedBox(
                                  child: Text(
                                    timeOfTodo != null
                                        ? timeOfTodo!.format(context)
                                        : '00:00 AM',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: kTextColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          */
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          //timeOfTodo = null;
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          if (todoController.text.isNotEmpty) {
                            // Add the new ToDo to the list
                            todoViewModel.add(
                              TodoInTaskModel(
                                taskId: task.id,
                                todoTitle: todoController.text,
                                isCompleted: false,
                              ),
                            );
                            //timeOfTodo = null;
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text('Add'),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: task.color,
            borderRadius: BorderRadius.circular(40),
          ),
          height: 70,
          width: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "New ToDo",
                style: TextStyle(
                  color: kTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.add,
                color: kTextColor,
                size: 20,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView(
        children: [
          // Container(
          //   height: 200,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.only(
          //       bottomLeft: Radius.circular(40),
          //       bottomRight: Radius.circular(40),
          //     ),
          //     color: kWhiteColor,
          //     boxShadow: [
          //       BoxShadow(
          //         color: kGrey2,
          //         offset: const Offset(0, 4),
          //         blurRadius: 10,
          //       ),
          //     ],
          //   ),
          //   child: Column(
          //     children: [
          //       TableCalendar(
          //         calendarFormat: CalendarFormat.week,
          //         availableCalendarFormats: const {
          //           CalendarFormat.week: 'Week',
          //         },
          //         focusedDay: DateTime.now(),
          //         firstDay: DateTime.utc(2023, 1, 1),
          //         lastDay: DateTime.utc(2030, 12, 31),
          //       ),
          //       const SizedBox(height: 15),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         children: [
          //           if (duradata > 0)
          //             Text(
          //               "End Date :",
          //               style: TextStyle(
          //                 color: kBlackColor,
          //                 fontSize: 16,
          //                 fontWeight: FontWeight.bold,
          //                 letterSpacing: 1.2,
          //               ),
          //             ).redToBlueGradientMask(),
          //           Container(
          //             child: duradata <= 0
          //                 ? GestureDetector(
          //                     onTap: () => Navigator.pushNamed(
          //                         context, Pages.updateTask),
          //                     child: Container(
          //                       padding: const EdgeInsets.all(10),
          //                       decoration: BoxDecoration(
          //                         color: kPrimaryColor.withAlpha(170),
          //                         borderRadius: BorderRadius.circular(10),
          //                       ),
          //                       child: Text(
          //                         "Time is up , PLZ Update Your Task",
          //                         style: TextStyle(
          //                           color: kWhiteColor,
          //                           fontSize: 15,
          //                           fontWeight: FontWeight.w500,
          //                         ),
          //                       ),
          //                     ),
          //                   )
          //                 : SlideCountdownSeparated(
          //                     duration: Duration(milliseconds: duradata),
          //                     style: const TextStyle(
          //                       fontSize: 20,
          //                       fontWeight: FontWeight.bold,
          //                       color: kWhiteColor,
          //                     ),
          //                     separator: " : ",
          //                     separatorStyle: const TextStyle(
          //                       fontSize: 20,
          //                       fontWeight: FontWeight.bold,
          //                     ),
          //                     onDone: () {
          //                       print('Countdown Ended');
          //                     },
          //                     decoration: BoxDecoration(
          //                       color: kPrimaryColor.withAlpha(170),
          //                       borderRadius: BorderRadius.circular(10),
          //                     ),
          //                   ),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          const SizedBox(height: 20),
          LinearPercentIndicator(
            lineHeight: 30.0,
            percent: progress, // استخدم القيمة المحسوبة
            center: Text(
              "${(progress * 100).toStringAsFixed(1)}%",
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
            backgroundColor: task.color.withOpacity(0.1),
            barRadius: Radius.circular(10),
          ).paddingSymmetric(horizontal: 16),
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
              Text("all : ${filteredTodos.length}").redToBlueGradientMask(),
              const SizedBox(width: 10),
              Text("complete : ${filteredTodos.where((todo) => todo.isCompleted).length}")
                  .redToBlueGradientMask(),
              const SizedBox(width: 10),
              Text("Incomplete : ${filteredTodos.where((todo) => !todo.isCompleted).length}")
                  .redToBlueGradientMask(),
            ],
          ).paddingSymmetric(horizontal: 16),
          SizedBox(height: 20),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(), // إلغاء التمرير الداخلي
            shrinkWrap: true, // اجعل القائمة تأخذ المساحة المطلوبة فقط
            itemCount: filteredTodos.length,
            itemBuilder: (context, index) {
              final todo = filteredTodos[index];
              return Container(
                decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    if (!filteredTodos[index].isCompleted)
                      BoxShadow(
                        color: task.color.withOpacity(0.6),
                        offset: const Offset(0, 4),
                        blurRadius: 10,
                      ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          filteredTodos[index].todoTitle,
                          maxLines: 2,
                          style: TextStyle(
                            color: filteredTodos[index].isCompleted
                                ? task.color
                                : kTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    /* Text(filteredTodos[index].todoTime.format(context),
                        style: TextStyle(
                          color: filteredTodos[index].isCompleted
                              ? task.color
                              : kTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        )),*/
                    GestureDetector(
                      onTap: () {
                        int orignalIndex = todoViewModel.todos.indexOf(todo);
                        todoViewModel.toggle(orignalIndex);

                        // Recalculate progress after toggling todo
                        final updatedCompletedTodos =
                            filteredTodos.where((t) => t.isCompleted).length;
                        final newProgress = filteredTodos.isEmpty
                            ? 0.0
                            : updatedCompletedTodos / filteredTodos.length;

                        taskViewModel.updateTaskProgress(task.id, newProgress);

                        // Update task completion status
                        if (newProgress == 1.0) {
                          taskViewModel.updateTaskCompletion(task.id, true);
                        } else {
                          taskViewModel.updateTaskCompletion(task.id, false);
                        }
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: filteredTodos[index].isCompleted
                              ? task.color
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: task.color,
                            width: 1,
                          ),
                        ),
                        child: Visibility(
                          visible: filteredTodos[index].isCompleted,
                          child: Icon(
                            Icons.check,
                            color: kWhiteColor,
                          ),
                        ),
                        // child: Center(
                        //   child: IconButton(
                        //     icon: Visibility(
                        //       visible: filteredTodos[index].isCompleted,
                        //       child: Center(
                        //         child: Icon(
                        //           Icons.check,
                        //           color: kWhiteColor,
                        //         ),
                        //       ),
                        //     ),
                        //     onPressed: () {
                        //       int orignalIndex =
                        //           todoViewModel.todos.indexOf(todo);
                        //       todoViewModel.toggle(orignalIndex);
                        //     },
                        //   ),
                        // ),
                      ),
                    ),
                  ],
                ).paddingSymmetric(vertical: 10, horizontal: 10),
              ).paddingSymmetric(horizontal: 16, vertical: 8);
            },
          ),
        ],
      ),
    );
  }
}
