import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/data_base/cubit/cubit.dart';
import 'package:to_do_app/data_base/cubit/states.dart';

import '../shared/components/main_app_bar.dart';
import '../style/colors.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return SafeArea(
            child: Scaffold(
              key: scaffoldKey,
              appBar: MainAppBar(
                cubit.titles[cubit.currentIndex],
              ),
              body: ConditionalBuilder(
                condition: state is! AppGetDatabaseLoadingState,
                builder: (context) => cubit.screens[cubit.currentIndex],
                fallback: (context) =>
                    const Center(child: CircularProgressIndicator()),
              ),
              bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: seconderyColor,
                  currentIndex: cubit.currentIndex,
                  onTap: (value) {
                    cubit.changeIndex(value);
                  },
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.task), label: 'Tasks'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.task_alt_rounded), label: 'Done'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.archive_outlined), label: 'Archive'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.add_circle_rounded),
                        label: 'Add Task'),
                  ]),
            ),
          );
        },
      ),
    );
  }
}
