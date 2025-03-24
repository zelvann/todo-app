import 'package:flutter/material.dart';
import 'package:todo_app/extensions/space_exs.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/constant.dart';
import 'package:todo_app/utils/strings.dart';
import 'package:todo_app/view/task/components/task_appbar.dart';

class TaskView extends StatefulWidget {
  const TaskView({
    super.key,
    required this.titleTaskController,
    required this.descriptionTaskController,
    required this.task,
  });

  final TextEditingController?  titleTaskController;
  final TextEditingController? descriptionTaskController;
  final Task? task;

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  dynamic title;
  dynamic subTitle;
  DateTime? time;
  DateTime? date;

  bool isTaskAlreadyExist() {
    if(widget.titleTaskController?.text == null && widget.descriptionTaskController?.text == null) {
      return true;
    } else {
       return false;
    }
  }

  dynamic isTaskAlreadyExistUpdateOtherWiseCreate(){
    if(widget.titleTaskController?.text != null && widget.descriptionTaskController?.text != null) {
      try {
        widget.titleTaskController?.text = title;
        widget.descriptionTaskController?.text = subTitle;
        widget.task?.save();

        Navigator.pop(context);
      } catch(e) {
        updateTaskWarning(context);
      }
    } else {
      if(title != null && subTitle != null) {
        var task = Task.create(title: title, subTitle: subTitle, createdAtDate: DateTime.now(), createdAtTime: DateTime.now());
        BaseWidget.of(context).dataStore.addTask(task: task);
        Navigator.pop(context);
      } else {
        emptyWarning(context);
      }
    }
  }

  dynamic deleteTask() {
    return widget.task?.delete();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => {
        FocusManager.instance.primaryFocus!.unfocus()
      },
      child: Scaffold(
        appBar: const TaskAppBar(),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Top Side Texts
                SizedBox(
                width: double.infinity,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 70,
                      child: Divider(
                        thickness: 2,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: isTaskAlreadyExist() ? AppString.addNewTask: AppString.updateCurrentTask,
                        style: textTheme.titleLarge,
                        children: const [
                          TextSpan(
                            text: AppString.taskString,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 70,
                      child: Divider(
                        thickness: 2,
                      ),
                    ),
                  ],
                ),
              ),
                SizedBox(
                  width: double.infinity,
                  height: 530,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Text(
                          AppString.titleOfTitleTextField,
                          style: textTheme.headlineMedium,
                        ),
                      ),
                      // Title
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: ListTile(
                          title: TextFormField(
                            controller: widget.titleTaskController,
                            maxLines: 6,
                            cursorHeight: 60,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ),
                            onFieldSubmitted: (String inputTitle) {
                              title = inputTitle;
                            },
                            onChanged: (String inputTitle) {
                              title = inputTitle;
                            },
                          ),
                        ),
                      ),
                      10.h,
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: ListTile(
                          title: TextFormField(
                            controller: widget.descriptionTaskController,
                            maxLines: null,
                            cursorHeight: null,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              counter: Container(),
                              hintText: AppString.addNote,
                              prefixIcon: Icon(
                                Icons.bookmark_border,
                                color: Colors.grey,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ),
                            onFieldSubmitted: (String inputSubTitle) {
                              subTitle = inputSubTitle;
                            },
                            onChanged: (String inputSubTitle) {
                              subTitle = inputSubTitle;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          mainAxisAlignment: isTaskAlreadyExist() ? MainAxisAlignment.center : MainAxisAlignment.spaceEvenly,
                          children: [
                            isTaskAlreadyExist() ? Container(): MaterialButton(
                              onPressed: (){
                                deleteTask();
                                Navigator.pop(context);
                              },
                              minWidth: 150,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              height: 55,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.close,
                                    color: AppColors.primaryColor,
                                  ),
                                  5.w,
                                  const Text(
                                    AppString.deleteTask,
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            MaterialButton(
                              onPressed: (){
                                isTaskAlreadyExistUpdateOtherWiseCreate();
                              },
                              minWidth: 150,
                              color: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              height: 55,
                              child: Text(
                                isTaskAlreadyExist() ? AppString.addTaskString : AppString.updateTaskString,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}

