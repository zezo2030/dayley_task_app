import 'package:dayley_task_app/utils/color_palette.dart';
import 'package:dayley_task_app/widgets/padding_extension.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedTaskItem extends StatefulWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isCompleted;
  final String completedText;

  const AnimatedTaskItem({
    super.key,
    required this.title,
    this.subtitle = 'اضغط للإنجاز',
    required this.onTap,
    required this.isCompleted,
    this.completedText = 'تم الإنجاز! 🎉',
  });

  @override
  _AnimatedTaskItemState createState() => _AnimatedTaskItemState();
}

class _AnimatedTaskItemState extends State<AnimatedTaskItem>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    _rotateAnimation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutBack,
      ),
    );
  }

  @override
  void didUpdateWidget(AnimatedTaskItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isCompleted != oldWidget.isCompleted) {
      widget.isCompleted ? _controller.forward() : _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return GestureDetector(
          onTap: widget.onTap,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Transform.rotate(
              angle: widget.isCompleted ? _rotateAnimation.value : 0,
              child: Container(
                width: 300,
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: widget.isCompleted
                        ? [Colors.green[400]!, Colors.green[600]!]
                        : [Colors.blueAccent[700]!, Colors.red[700]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: widget.isCompleted
                  //         ? Colors.green.withOpacity(0.4)
                  //         : Colors.black12,
                  //     blurRadius: widget.isCompleted ? 20 : 10,
                  //     spreadRadius: widget.isCompleted ? 4 : 2,
                  //     offset: Offset(0, 5),
                  //   ),
                  // ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTaskContent(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ).paddingSymmetric(horizontal: 16);
  }

  Widget _buildTaskContent() {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: widget.isCompleted
          ? _buildCompletedContent()
          : _buildIncompleteContent(),
    );
  }

  Widget _buildCompletedContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.white,
            size: 45,
          ),
          SizedBox(height: 8),
          Text(
            widget.completedText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncompleteContent() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: kWhiteColor,
                ),
              ),
              SizedBox(height: 2),
              Text(
                widget.subtitle,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Text(
            '12:10 PM',
            style: TextStyle(
              fontSize: 16,
              color: kWhiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
