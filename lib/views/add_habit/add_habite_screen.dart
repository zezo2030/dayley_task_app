import 'package:dayley_task_app/models/habpits_model.dart';
import 'package:dayley_task_app/routes/pages.dart';
import 'package:dayley_task_app/utils/color_palette.dart';
import 'package:dayley_task_app/viewmodel/habits_viewmodel.dart';
import 'package:dayley_task_app/widgets/padding_extension.dart';
import 'package:dayley_task_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddHabiteScreen extends StatefulWidget {
  const AddHabiteScreen({super.key});

  @override
  State<AddHabiteScreen> createState() => _AddHabiteScreenState();
}

class _AddHabiteScreenState extends State<AddHabiteScreen> {
  final TextEditingController controller = TextEditingController();
  bool isRepeatable = false;
  TimeOfDay? timeOfHabits;

  @override
  Widget build(BuildContext context) {
    final habitsViewModel = context.watch<HabitesViewModel>();

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Text(
            'Let\'s add \nyour habits 🙌',
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
              color: Color(0xFF363957),
            ),
          ).paddingAll(16),
          SizedBox(height: 40),
          SizedBox(
            height: 50,
            child: buildTextFormField(
              controller,
              "your habites",
              true,
            ),
          ).paddingSymmetric(horizontal: 16),
          SizedBox(height: 40),
          Container(
            height: 60,
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isRepeatable = true;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isRepeatable
                            ? kPrimaryColor
                            : kPrimaryColor.withAlpha(140),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                      child: Center(
                          child: Text(
                        'Repeatable',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isRepeatable = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isRepeatable
                            ? kPrimaryColor.withAlpha(140)
                            : kPrimaryColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Center(
                          child: Text(
                        'Non Repeatable',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ).paddingSymmetric(horizontal: 16),
          SizedBox(height: 40),
          Container(
            height: 50,
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        setState(() {
                          // Update the time here
                          timeOfHabits = pickedTime;
                          print(timeOfHabits!.format(context));
                        });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Pick Time',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  width: 120,
                  child: Text(
                    timeOfHabits != null
                        ? timeOfHabits!.format(context)
                        : '00:00 AM',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ).paddingSymmetric(horizontal: 16),
          SizedBox(height: 40),
          Container(
            height: 60,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 30),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Save the data here
                      if (controller.text.isNotEmpty && timeOfHabits != null) {
                        // Save the data here
                        habitsViewModel.addHabit(
                          Habits(
                            id: DateTime.now().toString(),
                            title: controller.text,
                            isRepetable: isRepeatable,
                            selectedTime: timeOfHabits!,
                          ),
                        );
                        print(habitsViewModel.habits.length);
                        Navigator.pushNamed(context, Pages.home1);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ).paddingSymmetric(horizontal: 16),
        ],
      ),
    );
  }
}
