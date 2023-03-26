import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/data_base/cubit/cubit.dart';
import 'package:to_do_app/data_base/cubit/states.dart';
import 'package:to_do_app/shared/components/shared.dart';

class NewTasksScreen extends StatelessWidget {
  const NewTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var tasks = AppCubit.get(context).newTasks;
          return tasksBuilder(tasks: tasks);
        });
  }
}
