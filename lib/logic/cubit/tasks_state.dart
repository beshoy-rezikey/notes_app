part of 'tasks_cubit.dart';

@immutable
abstract class TasksState {}

class TaksInitial extends TasksState {}

class TasksCreateDataBaseState extends TasksState {}

class TasksinsertDataBaseState extends TasksState {}

class TasksGetDataBaseState extends TasksState {}

class TasksUpdatetDataBaseState extends TasksState {}
class TasksDeletetDataBaseState extends TasksState {}


class TasksDeleteDataBaseLoadingState extends TasksState {}

class TasksChangeBottomSheetState extends TasksState {}

class TasksAppBottomNavBarChangeState extends TasksState {}
