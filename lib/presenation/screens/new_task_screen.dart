import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:todo_app/data/local/creat_local_db.dart';
import 'package:todo_app/logic/cubit/tasks_cubit.dart';
import 'package:todo_app/presenation/widgets/condtional_builder.dart';
import 'package:todo_app/presenation/widgets/separtor_widget.dart';
import 'package:todo_app/presenation/widgets/task_item_widget.dart';


class NewTaskScreen extends StatelessWidget {
  NewTaskScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit, TasksState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var tasks = TasksCubit.get(context).Newtasks;

        return myCondtionalBuider(tasks: tasks);
      },
    );
  }
}
