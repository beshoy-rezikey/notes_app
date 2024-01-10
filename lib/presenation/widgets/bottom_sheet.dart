import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/presenation/widgets/text_form_field.dart';

Widget myBottomSheet({
  required TextEditingController titleController,
  required TextEditingController timeController,
  required TextEditingController DateController,
  required BuildContext context,
  required GlobalKey<FormState> formkey,
}) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(
        style: BorderStyle.solid,
        width: 1,
      ),
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(50),
    ),
    padding: EdgeInsets.all(20),
    child: Form(
      key: formkey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // title field
          MyTextFormField(
            controller: titleController,
            type: TextInputType.text,
            validate: (value) {
              if (value!.isEmpty)
                return 'Please Enter Title';
              else
                return null;
            },
            lable: 'Task Title',
            preFix: Icons.title,
          ),
          SizedBox(
            height: 15,
          ),
          //time field
          MyTextFormField(
            readOnly: true,
            onTap: () {
              showTimePicker(context: context, initialTime: TimeOfDay.now())
                  .then((value) {
                print(value.toString());
                timeController.text = value!.format(context).toString();
              });
            },
            controller: timeController,
            type: TextInputType.datetime,
            validate: (value) {
              if (value!.isEmpty)
                return 'Please Enter Time';
              else
                return null;
            },
            lable: 'Task Time',
            preFix: Icons.watch_later_outlined,
          ),
          SizedBox(
            height: 15,
          ),
          // date field
          MyTextFormField(
            readOnly: true,
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 30)),
              ).then((value) {
                DateController.text = DateFormat.yMMMMd().format(value!);
              }).catchError(() {});
            },
            controller: DateController,
            type: TextInputType.datetime,
            validate: (value) {
              if (value!.isEmpty)
                return 'Please Enter Date';
              else
                return null;
            },
            lable: 'Task Date',
            preFix: Icons.calendar_today,
          ),
        ],
      ),
    ),
  );
}
