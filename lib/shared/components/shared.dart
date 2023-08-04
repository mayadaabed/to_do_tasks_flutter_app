import 'dart:math';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/data_base/cubit/cubit.dart';

import '../../style/colors.dart';

TextStyle textStyle({
  final double fontSize = 20,
  final color = black,
  final FontWeight fontWeight = FontWeight.normal,
}) =>
    TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight);

Widget defaultFormField(
        {required TextEditingController controller,
        required TextInputType type,
        Function? onSubmit,
        Function? onChange,
        Function? onTap,
        bool isPassword = false,
        Function? validate,
        required String label,
        required IconData prefix,
        IconData? suffix,
        Function? suffixPressed,
        bool isClickable = true,
        bool readOnly = false}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      readOnly: readOnly,
      onFieldSubmitted: (value) {
        if (onSubmit != null) {
          onSubmit(value);
        } else {
          null;
        }
      },
      onChanged: (value) {
        if (onChange != null) {
          onChange(value);
        } else {
          null;
        }
      },
      onTap: () {
        onTap;
      },
      validator: (value) {
        return validate!(value);
      },
      decoration: InputDecoration(
        labelText: label,
        labelStyle: textStyle(color: grey, fontSize: 16),
        prefixIcon: Icon(
          prefix,
          color: grey,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: mainColor)),
        border: OutlineInputBorder(borderSide: BorderSide(color: mainColor)),
        disabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: mainColor)),
      ),
    );

Widget buildTaksItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction) {
        AppCubit.get(context).delete(id: model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: Offset(0, -3),
                    blurRadius: 10),
              ]),
          child: Row(
            children: [
              CircleAvatar(
                radius: 40.0,
                backgroundColor:
                    Colors.primaries[Random().nextInt(Colors.primaries.length)],
                child: Center(
                  child: Text(
                    '${model['time']}',
                    style: textStyle(color: white, fontSize: 12),
                  ),
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model['title']}',
                      style: textStyle(fontSize: 25),
                    ),
                    Text(
                      '${model['date']}',
                      style: textStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              IconButton(
                  onPressed: () {
                    AppCubit.get(context)
                        .update(status: 'done', id: model['id']);
                  },
                  icon: Icon(
                    Icons.check_box,
                    color: mainColor,
                  )),
              IconButton(
                  onPressed: () {
                    AppCubit.get(context)
                        .update(status: 'archive', id: model['id']);
                  },
                  icon: Icon(
                    Icons.archive,
                    color: seconderyColor,
                  )),
            ],
          ),
        ),
      ),
    );

Widget tasksBuilder({required List<Map> tasks}) => ConditionalBuilder(
      condition: tasks.isNotEmpty,
      fallback: (context) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/notasks.png',
                height: 100,
                width: 100,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 200,
                child: Text(
                  'No Tasks Yet, Please Add some Tasks',
                  textAlign: TextAlign.center,
                  style: textStyle(),
                ),
              )
            ],
          ),
        );
      },
      builder: (context) {
        return ListView.separated(
            itemBuilder: (context, index) {
              return buildTaksItem(tasks[index], context);
            },
            separatorBuilder: (context, index) => SizedBox(),
            itemCount: tasks.length);
      },
    );

Widget deafultContainer(
        {double? height, required String title, IconData? icon}) =>
    Container(
      height: height ?? 60,
      margin: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: grey)),
      child: Row(
        children: [
          const SizedBox(
            width: 12,
          ),
          Icon(
            icon,
            color: grey,
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            title,
            style: textStyle(color: grey, fontSize: 16),
          ),
          const SizedBox(
            width: 12,
          ),
        ],
      ),
    );
