import 'package:dayley_task_app/routes/pages.dart';
import 'package:dayley_task_app/utils/color_palette.dart';
import 'package:dayley_task_app/viewmodel/habits_viewmodel.dart';
import 'package:dayley_task_app/widgets/padding_extension.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class HomeScreenV1 extends StatelessWidget {
  const HomeScreenV1({super.key});

  @override
  Widget build(BuildContext context) {
    final habitviewmodel = context.watch<HabitesViewModel>();







    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: GestureDetector(
        onTap: () => Navigator.pushNamed(context, Pages.addHabite),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Color(0xFF3055CF).withAlpha(200),
            borderRadius: BorderRadius.circular(40),
          ),
          height: 70,
          width: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "New Habit",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Text(
            'Let\'s make a \nhabits together 🙌',
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
              color: Color(0xFF363957),
            ),
          ).paddingAll(16),
          SizedBox(height: 40),
          Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFF3055CF).withAlpha(190),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CircularPercentIndicator(
                    radius: 45.0,
                    lineWidth: 10.0,
                    percent: habitviewmodel.persentageOfCompletedHabits().toDouble(),
                    center: Text(
                      "${(habitviewmodel.persentageOfCompletedHabits() * 100).toInt()}%",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                    linearGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                        const Color.fromARGB(3, 255, 255, 255),
                        Color(0xFFFFFFFF),
                      ],
                    ),
                    rotateLinearGradient: true,
                    circularStrokeCap: CircularStrokeCap.round,
                    backgroundColor: Colors.transparent,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your daily goals',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'almost done! 🔥',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "${habitviewmodel.numberOfCompletedHabits} of ${habitviewmodel.habits.length} completed",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: const Color.fromARGB(255, 199, 196, 196),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ).paddingSymmetric(horizontal: 25),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Today\'s habits',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF363957),
                ),
              ).paddingAll(16),
              IconButton(
                icon: Icon(
                  Icons.align_horizontal_left,
                  color: Color(0xFF363957),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, Pages.home);
                },
              ),
            ],
          ),
          // Container(
          //   height: 200,
          //   width: double.infinity,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       Icon(
          //         Icons.check_circle,
          //         color: Color(0xFF363957),
          //         size: 45,
          //       ),
          //       SizedBox(height: 8),
          //       Text(
          //         'You have no habits yet',
          //         style: TextStyle(
          //           color: Color(0xFF363957),
          //           fontSize: 20,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //     ],
          //   ),
          // )

          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: habitviewmodel.habits.length,
            itemBuilder: (context, index) {
              return habitviewmodel.habits[index].isCompleted
                  ? _habitCardCompleted(index, context)
                      .paddingSymmetric(horizontal: 25, vertical: 10)
                  : _habitCardNonCompleted(index, context)
                      .paddingSymmetric(horizontal: 25, vertical: 10);
            },
          ),
        ],
      ),
    );
  }

  Widget _habitCardCompleted(int index, BuildContext context) {
    final habitviewmodel = context.watch<HabitesViewModel>();
    return Container(
      height: 90,
      width: double.infinity,
      decoration: BoxDecoration(
        //color: Color(0xFF3055CF).withAlpha(190),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.green[200]!,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.green[300],
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      habitviewmodel.habits[index].title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[300],
                      ),
                    ),
                    Text(
                      "Completed!",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[300],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Text(
            habitviewmodel.habits[index].selectedTime.format(context),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.green[300],
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 16),
    );
  }

  Widget _habitCardNonCompleted(int index, BuildContext context) {
    final habitviewmodel = context.watch<HabitesViewModel>();
    return GestureDetector(
      onTap: () {
        habitviewmodel.toggleHabitComplection(index);
      },
      child: Container(
        height: 90,
        width: double.infinity,
        decoration: BoxDecoration(
          //color: Color(0xFF3055CF).withAlpha(190),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: kPrimaryColor,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/cyicleng.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        habitviewmodel.habits[index].title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                        ),
                      ),
                      Text(
                        "pres to Complete!",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Text(
              habitviewmodel.habits[index].selectedTime.format(context),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 16),
      ),
    );
  }
}
