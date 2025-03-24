import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/extensions/space_exs.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/strings.dart';
import 'package:todo_app/view/home/components/fab.dart';
import 'package:todo_app/view/home/components/home_appbar.dart';
import 'package:todo_app/view/home/components/slider_drawer.dart';
import 'package:todo_app/view/home/widgets/task_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey<SliderDrawerState> drawerKey = GlobalKey<SliderDrawerState>();
  final List<int> tasks = [];

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: const Fab(),
      body: SliderDrawer(
        key: drawerKey,
        isDraggable: false,
        slider: CustomDrawer(),
        appBar: HomeAppbar(
          drawerKey: drawerKey,
        ),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              // Custom App Bar
              Container(
                margin: const EdgeInsets.only(top: 60),
                width: double.infinity,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Progress indicator
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(
                        value: 1 / 3,
                        backgroundColor: Colors.grey,
                        valueColor: AlwaysStoppedAnimation(
                          AppColors .primaryColor
                        ),
                      ),
                    ),
                    25.w,
                    // Top Level Task Info
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppString.mainTitle,
                          style: textTheme.displayLarge,
                        ),
                        3.h,
                        Text(
                          "1 of 2 task",
                          style: textTheme.titleMedium,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              // Divider
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Divider(
                  thickness: 2,
                  indent: 100,
                ),
              ),
              // Tasks
              Expanded(
                child: tasks.isNotEmpty
                // Task list is not empty
                    ? ListView.builder(
                    itemCount: tasks.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: Key(
                          index.toString()
                        ),
                        direction: DismissDirection.horizontal,
                        onDismissed: (_) {
                         setState(() {
                           tasks.removeAt(index);
                         });
                        },
                        background: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.delete_outline,
                              color: Colors.grey,
                            ),
                            Text(
                              AppString.deletedTask,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        child: const TaskWidget(),
                      );
                    }
                ) :
                // Task List is Empty
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Lottie Anime
                    FadeIn(
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: Lottie.asset(
                          'assets/lottie/1.json',
                          animate: tasks.isNotEmpty ? false: true,
                        ),
                      ),
                    ),
                    // Sub Text
                    FadeInUp(
                      from: 30,
                      child: Text(
                        AppString.doneAllTask,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

