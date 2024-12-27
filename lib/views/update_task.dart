import 'package:dayley_task_app/models/task_model.dart';
import 'package:dayley_task_app/utils/color_palette.dart';
import 'package:dayley_task_app/utils/util.dart';
import 'package:dayley_task_app/viewmodel/task_view_model.dart';
import 'package:dayley_task_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class UpdateTask extends StatefulWidget {
  const UpdateTask({super.key, required this.index});

  final int index;

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  //late int taskIndex = ;
  int get index => widget.index;

  // @override
  // didChangeDependencies() {
  //   if (ModalRoute.of(context)!.settings.arguments != null) {
  //     var _tasks = ModalRoute.of(context)!.settings.arguments as Map;
  //     taskIndex = _tasks['index'];
  //     print(taskIndex);
  //   }
  //    _titleController.text =
  //        Provider.of<TaskViewModel>(context).tasks[taskIndex].title;
  //    _descriptionController.text =
  //        Provider.of<TaskViewModel>(context).tasks[taskIndex].description;
  //    _rangeStart =
  //        Provider.of<TaskViewModel>(context).tasks[taskIndex].startDate;
  //    _rangeEnd = Provider.of<TaskViewModel>(context).tasks[taskIndex].endDate;
  //   super.didChangeDependencies();
  // }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  //late final TaskViewModel taskViewModel;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _titleController.text =
        Provider.of<TaskViewModel>(context, listen: false).tasks[index].title;
    _descriptionController.text =
        Provider.of<TaskViewModel>(context, listen: false)
            .tasks[index]
            .description;
    _rangeStart = Provider.of<TaskViewModel>(context, listen: false)
        .tasks[index]
        .startDate;
    _rangeEnd =
        Provider.of<TaskViewModel>(context, listen: false).tasks[index].endDate;

    print(index);
  }

  _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: kWhiteColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: kWhiteColor,
          title: const Text(
            'Create Task',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusScope.of(context).unfocus(),
            child: ListView(
              children: [
                TableCalendar(
                  calendarFormat: _calendarFormat,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  availableCalendarFormats: const {
                    CalendarFormat.month: 'Month',
                    CalendarFormat.week: 'Week',
                  },
                  rangeSelectionMode: RangeSelectionMode.toggledOn,
                  focusedDay: _focusedDay,
                  firstDay: DateTime.utc(2023, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  rangeStartDay: _rangeStart,
                  rangeEndDay: _rangeEnd,
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onRangeSelected: _onRangeSelected,
                ),
                const SizedBox(height: 20),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(.1),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: buildText(
                      _rangeStart != null && _rangeEnd != null
                          ? 'Task starting at ${formatDate(dateTime: _rangeStart.toString())} - ${formatDate(dateTime: _rangeEnd.toString())}'
                          : 'Select a date range',
                      kPrimaryColor,
                      12,
                      FontWeight.w400,
                      TextAlign.start,
                      TextOverflow.clip),
                ),
                const SizedBox(height: 20),
                buildText(
                  'Title',
                  kBlackColor,
                  14,
                  FontWeight.bold,
                  TextAlign.start,
                  TextOverflow.clip,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter a title' : null,
                  controller: _titleController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Enter the title of the task",
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                    fillColor: kWhiteColor,
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    errorStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: kRed,
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(width: 1, color: kPrimaryColor),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(width: 0, color: kWhiteColor),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(width: 0, color: kGrey1),
                    ),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(width: 0, color: kGrey1)),
                    errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(width: 1, color: kRed)),
                    focusedErrorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(width: 1, color: kGrey1)),
                    focusColor: kWhiteColor,
                    hoverColor: kWhiteColor,
                  ),
                  cursorColor: kPrimaryColor,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: kBlackColor,
                  ),
                ),
                SizedBox(height: 10),
                buildText(
                  "Description",
                  kBlackColor,
                  14,
                  FontWeight.bold,
                  TextAlign.start,
                  TextOverflow.clip,
                ),
                TextFormField(
                  maxLines: null,
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter a Description' : null,
                  controller: _descriptionController,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: "Enter the Description of the task",
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                    fillColor: kWhiteColor,
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    errorStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: kRed,
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(width: 1, color: kPrimaryColor),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(width: 0, color: kWhiteColor),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(width: 0, color: kGrey1),
                    ),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(width: 0, color: kGrey1)),
                    errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(width: 1, color: kRed)),
                    focusedErrorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(width: 1, color: kGrey1)),
                    focusColor: kWhiteColor,
                    hoverColor: kWhiteColor,
                  ),
                  cursorColor: kPrimaryColor,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: kBlackColor,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 225, 225, 248)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Adjust the radius as needed
                            ),
                          ),
                        ),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: kBlackColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Add the task to the database
                          final String taskId =
                              DateTime.now().millisecondsSinceEpoch.toString();
                          final String title = _titleController.text;
                          final String description =
                              _descriptionController.text;
                          if (title.isNotEmpty &&
                              description.isNotEmpty &&
                              _rangeStart != null &&
                              _rangeEnd != null) {
                            taskViewModel.updateTask(
                              index,
                              Task(
                                id: taskId,
                                title: title,
                                description: description,
                                startDate: _rangeStart!,
                                endDate: _rangeEnd!,
                              ),
                            );
                            // _titleController.clear();
                            // _descriptionController.clear();
                            // _rangeStart = null;
                            // _rangeEnd = null;
                            Navigator.pop(context);
                          }
                        },
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(kPrimaryColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                10,
                              ), // Adjust the radius as needed
                            ),
                          ),
                        ),
                        child: Text(
                          "Update",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: kWhiteColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
