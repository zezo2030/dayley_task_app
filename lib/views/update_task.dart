import 'package:dayley_task_app/models/task_model.dart';
import 'package:dayley_task_app/utils/color_palette.dart';
import 'package:dayley_task_app/viewmodel/task_view_model.dart';
import 'package:dayley_task_app/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class UpdateTask extends StatefulWidget {
  const UpdateTask({
    super.key,
  });

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  //late final TaskViewModel taskViewModel;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
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
    //final taskViewModel = Provider.of<TaskViewModel>(context);
    final taskViewModel = context.watch<TaskViewModel>();
    final task = taskViewModel.selectedTask;

    if (task != null) {
      _titleController.text = task.title;
      _descriptionController.text = task.description;
      _rangeStart = task.startDate;
      _rangeEnd = task.endDate;
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: kWhiteColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: kWhiteColor,
          title: Text(
            'updateTask'.tr(),
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
                  availableCalendarFormats: {
                    CalendarFormat.month: 'designMonth'.tr(),
                    CalendarFormat.week: 'designWeek'.tr(),
                  },
                  locale: context.locale.languageCode,
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
                buildSelectedDate(_rangeStart, _rangeEnd, context),
                const SizedBox(height: 20),
                buildText(
                  'title'.tr(),
                  kBlackColor,
                  14,
                  FontWeight.bold,
                  TextAlign.start,
                  TextOverflow.clip,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  child: buildTextFormField(
                    _titleController,
                    "updateTaskTitle".tr(),
                    true,
                  ),
                ),
                SizedBox(height: 25),
                buildText(
                  "description".tr(),
                  kBlackColor,
                  14,
                  FontWeight.bold,
                  TextAlign.start,
                  TextOverflow.clip,
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 150,
                  child: buildTextFormField(
                    _descriptionController,
                    "updateDescription".tr(),
                    false,
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
                              WidgetStateProperty.all<Color>(Colors.white),
                          backgroundColor: WidgetStateProperty.all<Color>(
                              Color.fromARGB(255, 225, 225, 248)),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Adjust the radius as needed
                            ),
                          ),
                        ),
                        child: Text(
                          "cancel".tr(),
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

                              Task(
                                id: task!.id,
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
                              WidgetStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              WidgetStateProperty.all<Color>(kPrimaryColor),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                10,
                              ), // Adjust the radius as needed
                            ),
                          ),
                        ),
                        child: Text(
                          "update".tr(),
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
