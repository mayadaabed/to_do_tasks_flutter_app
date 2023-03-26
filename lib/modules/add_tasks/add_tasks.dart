import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:time_picker_widget/time_picker_widget.dart';

import '../../data_base/cubit/cubit.dart';
import '../../data_base/cubit/states.dart';
import '../../shared/components/shared.dart';
import '../../style/colors.dart';

class AddTasks extends StatefulWidget {
  const AddTasks({super.key});

  @override
  State<AddTasks> createState() => _AddTasksState();
}

class _AddTasksState extends State<AddTasks> {
  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  String? date;
  String? time;

  showTimePicker() async {
    showCustomTimePicker(
      context: context,
      onFailValidation: (context) => debugPrint('Unavailable selection'),
      initialTime: const TimeOfDay(hour: 2, minute: 0),
    ).then((times) {
      time = times!.format(context);
      debugPrint(time);

      setState(() {
        time = times.format(context);
        timeController.text = time!;
      });
    });
  }

  showDataPicker() async {
    var picker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2024),
    );
    setState(() {
      var newDate = DateFormat('EEE, d MMM').format(picker!);
      date = newDate.toString();
      debugPrint('$date ksm');
      dateController.text = date!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
                child: Text(
                  'Manage your Tasks',
                  style: textStyle(
                      color: seconderyColor,
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                child: defaultFormField(
                  controller: titleController,
                  type: TextInputType.text,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'title must not be Empty';
                    } else {
                      return null;
                    }
                  },
                  label: 'Task Title',
                  prefix: Icons.title,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    showTimePicker();
                  });
                },
                child: deafultContainer(
                    title: time ?? 'Task Time',
                    icon: Icons.watch_later_rounded),
              ),
              const SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    showDataPicker();
                  });
                },
                child: deafultContainer(
                    title: date ?? 'Task Date', icon: Icons.date_range),
              ),
              const SizedBox(
                height: 50.0,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                color: mainColor,
                child: MaterialButton(
                  height: 50,
                  onPressed: () {
                    debugPrint(timeController.text + dateController.text);
                    cubit.insertToDatabase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text);
                  },
                  child: Text(
                    'Add Task',
                    style: textStyle(color: white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
