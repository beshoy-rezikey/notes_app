import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/logic/cubit/tasks_cubit.dart';
import 'package:todo_app/presenation/widgets/condtional_builder.dart';

import '../widgets/separtor_widget.dart';
import '../widgets/task_item_widget.dart';

class ArchiveTaskScreen extends StatelessWidget {
  const ArchiveTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit, TasksState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var tasks = TasksCubit.get(context).Archivedtasks;

        return myCondtionalBuider(tasks: tasks);
      },
    );
  }
}
