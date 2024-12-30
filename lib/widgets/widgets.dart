import 'package:dayley_task_app/utils/color_palette.dart';
import 'package:dayley_task_app/utils/util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Text buildText(String text, Color color, double fontSize, FontWeight fontWeight,
    TextAlign textAlign, TextOverflow overflow,
    {bool isComplete = false}) {
  return Text(
    text,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: 3,
    style: TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      decoration: isComplete ? TextDecoration.lineThrough : TextDecoration.none,
    ),
  );
}

TextFormField buildTextFormField(
    TextEditingController controller, String hintText, bool isTitle) {
  return TextFormField(
    controller: controller,
    validator: (val) => val!.isEmpty ? 'pleaseAllFields'.tr() : null,
    maxLines: null, // يتيح إدخال نصوص متعددة السطور
    expands: true, // يجعل الحقل يمتد لملء الارتفاع المخصص
    textAlignVertical:
        isTitle ? TextAlignVertical.center : TextAlignVertical.top,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: Colors.grey[400], // لون النص الخاص بالمكان الفارغ
        fontSize: 16,
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 12.0,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: Colors.grey[300]!,
          width: 1.5,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: Colors.grey[300]!,
          width: 1.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: Colors.blueAccent,
          width: 1.5,
        ),
      ),
    ),
  );
}

Container buildSelectedDate(
    DateTime? startDate, DateTime? endDate, BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(.1),
        borderRadius: const BorderRadius.all(Radius.circular(5))),
    child: buildText(
        startDate != null && endDate != null
            ? '${'taskStartingAt'.tr()} ${formatDate(
                dateTime: startDate.toString(),
                context: context,
              )} - ${formatDate(
                dateTime: endDate.toString(),
                context: context,
              )}'
            : 'selectDateRange'.tr(),
        kPrimaryColor,
        12,
        FontWeight.w400,
        TextAlign.start,
        TextOverflow.clip),
  );
}
