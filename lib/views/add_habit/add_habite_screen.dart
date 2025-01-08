import 'package:dayley_task_app/widgets/padding_extension.dart';
import 'package:dayley_task_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AddHabiteScreen extends StatefulWidget {
  const AddHabiteScreen({super.key});

  @override
  State<AddHabiteScreen> createState() => _AddHabiteScreenState();
}

class _AddHabiteScreenState extends State<AddHabiteScreen> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
