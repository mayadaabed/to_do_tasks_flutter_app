import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_base/cubit/cubit.dart';
import '../../data_base/cubit/states.dart';
import '../../shared/components/shared.dart';

class ArchiveTasksScreen extends StatelessWidget {
  const ArchiveTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var tasks = AppCubit.get(context).archiveTasks;
          return tasksBuilder(tasks: tasks);
        });
  }
}