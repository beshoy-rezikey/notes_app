import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/logic/cubit/tasks_cubit.dart';

// model is map returned from db
Widget taskItemWidget(Map model, BuildContext context) {
  return Dismissible(
    onDismissed: (direction) {
      TasksCubit.get(context).DeleteData(id: model['id']);
    },
    key: Key(model['id'].toString()),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            child: Text('${model['time']}'),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model['title']}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${model['date']}',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          SizedBox(width: 20),
          IconButton(
            onPressed: () {
              TasksCubit.get(context)
                  .updateData(staus: 'Done', id: model['id']);
            },
            icon: Icon(Icons.check_box_outlined),
            color: Colors.blue,
          ),
          IconButton(
              onPressed: () {
                TasksCubit.get(context)
                    .updateData(staus: 'Archive', id: model['id']);
              },
              icon: Icon(
                Icons.archive_outlined,
                color: Colors.grey,
              )),
        ],
      ),
    ),
  );
}
