import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/presenation/widgets/separtor_widget.dart';
import 'package:todo_app/presenation/widgets/task_item_widget.dart';

Widget myCondtionalBuider({ required tasks}) {
  return ConditionalBuilder(
          builder: (context) => Container(
            child: ListView.separated(
                itemBuilder: (context, index) => taskItemWidget(tasks[index],
                    context), // task is list of map hold returem of get db
                separatorBuilder: (context, index) => seperatorWidegt(),
                itemCount: tasks.length),
          ),
          condition: tasks.length > 0,
          fallback: (context) => Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.menu,
                size: 100,
                color: Colors.grey,
              ),
              Text(
                'No Tasks Yet Please Add New One',
                style: TextStyle(fontSize: 20),
              )
            ],
          )),
        );
}
