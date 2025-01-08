import 'package:dayley_task_app/utils/color_palette.dart';
import 'package:dayley_task_app/viewmodel/task_view_model.dart';
import 'package:dayley_task_app/widgets/gradient_mask_widget.dart';
import 'package:dayley_task_app/widgets/padding_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ModerTaskView extends StatelessWidget {
  const ModerTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    final taskViewModel = context.watch<TaskViewModel>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return MasonryGridView.builder(
              itemCount: taskViewModel.tasks.length,
              gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: constraints.maxWidth > 600 ? 3 : 2,
              ),
              itemBuilder: (context, index) {
                final task = taskViewModel.tasks[index];
                return Container(
                  padding: const EdgeInsets.all(8),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    // gradient: LinearGradient(
                    //   colors: [Colors.grey[400]!, Colors.blue[100]!],
                    //   begin: Alignment.topLeft,
                    //   end: Alignment.bottomRight,
                    // ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: kWhiteColor,
                          letterSpacing: 1,
                          shadows: [
                            Shadow(
                              color: kGrey2,
                              offset: Offset(1, 1),
                              blurRadius: 2,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'All Todo : 0',
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ).redToBlueGradientMask(),
                      Text(
                        'Completed Todo: 0',
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ).redToBlueGradientMask(),
                      Text(
                        'Uncompleted Todo : 0',
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ).redToBlueGradientMask(),
                      Text(
                        'Created At: ${task.endDate.toString()}',
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ).redToBlueGradientMask(),
                      Text(
                        'Updated At: ${task.startDate.toString()}',
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ).redToBlueGradientMask(),
                    ],
                  ),
                ).paddingAll(8);
              },
            );
          },
        ),
      ),
    );
  }
}
