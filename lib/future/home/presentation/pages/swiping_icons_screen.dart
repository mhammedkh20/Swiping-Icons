import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiping_icons/future/home/presentation/manager/scroll_bloc.dart';
import 'package:swiping_icons/future/home/presentation/widgets/icon_selection.dart';
import 'package:swiping_icons/future/home/presentation/widgets/my_page_view.dart';

class SwipingIconsScreen extends StatefulWidget {
  const SwipingIconsScreen({super.key});

  @override
  State<SwipingIconsScreen> createState() => SwipingIconsScreenState();
}

class SwipingIconsScreenState extends State<SwipingIconsScreen>
    with TickerProviderStateMixin {
  late PageController pageController;

  AlignmentDirectional dragFavorite = AlignmentDirectional.topCenter;
  AlignmentDirectional dragMusic = AlignmentDirectional.center;
  AlignmentDirectional dragTrackCchanges = AlignmentDirectional.bottomCenter;

  late Size size;

  late AnimationController controllerFavorite;
  late AnimationController controllerMusic;
  late AnimationController controllerSensors;
  late AnimationController controllerOpcityPageView;

  bool isOnce = false;

  @override
  void initState() {
    pageController = PageController();
    controllerFavorite = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));

    controllerMusic = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));

    controllerSensors = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));

    controllerOpcityPageView = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    Future.delayed(Duration.zero, () {
      size = MediaQuery.of(context).size;
    });

    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    controllerFavorite.dispose();
    controllerMusic.dispose();
    controllerSensors.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.withOpacity(.4),
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.withOpacity(.4),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: MyPageView(
                pageController: pageController,
                colorTweenController: controllerOpcityPageView,
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              height: 150,
              width: 35,
              child: BlocBuilder<ScrollBloc, ScrollState>(
                buildWhen: (previous, current) =>
                    (current is DragedState) || (current is ActiveItemState),
                builder: (context, state) {
                  AlignmentDirectional draging =
                      context.read<ScrollBloc>().draging;

                  return Stack(
                    clipBehavior: Clip.antiAlias,
                    children: [
                      IconSelection(
                        controller: controllerFavorite,
                        alignment: dragFavorite,
                        icon: Icons.favorite,
                        iconColor: Colors.red,
                        isSelected: draging.y.ceilToDouble() <= dragFavorite.y,
                        onVerticalDragStart: (details) {
                          context.read<ScrollBloc>().add(ActiveItemEvent(true));
                          isOnce = true;
                          context.read<ScrollBloc>().add(
                              DragingEvent(AlignmentDirectional.topCenter));
                          controllerFavorite.forward();

                          controllerOpcityPageView.forward();

                          pageController.animateToPage(0,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.ease);
                        },
                        onVerticalDragUpdate: (DragUpdateDetails details) {
                          AlignmentDirectional draging =
                              context.read<ScrollBloc>().draging;
                          context
                              .read<ScrollBloc>()
                              .add(DragingEvent(draging += AlignmentDirectional(
                                0,
                                details.delta.dy / (size.height / 15),
                              )));
                          changeStatusIcons(draging);
                        },
                        onVerticalDragEnd: (details) {
                          context
                              .read<ScrollBloc>()
                              .add(ActiveItemEvent(false));

                          controllerOpcityPageView.reverse();
                          context.read<ScrollBloc>().add(DragingEvent(null));
                          resetAllControllers();
                        },
                      ),
                      IconSelection(
                        controller: controllerMusic,
                        alignment: dragMusic,
                        iconColor: Colors.blue,
                        icon: Icons.music_note,
                        isSelected: draging.y.ceilToDouble() == dragMusic.y,
                        onVerticalDragStart: (details) {
                          context.read<ScrollBloc>().add(ActiveItemEvent(true));
                          isOnce = true;
                          context
                              .read<ScrollBloc>()
                              .add(DragingEvent(AlignmentDirectional.center));
                          pageController.animateToPage(1,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.ease);
                          controllerOpcityPageView.forward();
                          controllerMusic.forward();
                        },
                        onVerticalDragUpdate: (DragUpdateDetails details) {
                          AlignmentDirectional draging =
                              context.read<ScrollBloc>().draging;
                          context
                              .read<ScrollBloc>()
                              .add(DragingEvent(draging += AlignmentDirectional(
                                0,
                                details.delta.dy / (size.height / 15),
                              )));
                          changeStatusIcons(draging);
                        },
                        onVerticalDragEnd: (details) {
                          context
                              .read<ScrollBloc>()
                              .add(ActiveItemEvent(false));
                          context.read<ScrollBloc>().add(DragingEvent(null));
                          controllerOpcityPageView.reverse();

                          resetAllControllers();
                        },
                      ),
                      IconSelection(
                        controller: controllerSensors,
                        iconColor: Colors.yellow,
                        alignment: dragTrackCchanges,
                        isSelected:
                            draging.y.ceilToDouble() >= dragTrackCchanges.y,
                        icon: Icons.sensors_rounded,
                        onVerticalDragStart: (details) {
                          isOnce = true;
                          context.read<ScrollBloc>().add(ActiveItemEvent(true));

                          context.read<ScrollBloc>().add(
                              DragingEvent(AlignmentDirectional.bottomCenter));
                          pageController.animateToPage(2,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.ease);
                          controllerOpcityPageView.forward();
                          controllerSensors.forward();
                        },
                        onVerticalDragUpdate: (DragUpdateDetails details) {
                          AlignmentDirectional draging =
                              context.read<ScrollBloc>().draging;
                          context
                              .read<ScrollBloc>()
                              .add(DragingEvent(draging += AlignmentDirectional(
                                0,
                                details.delta.dy / (size.height / 15),
                              )));
                          changeStatusIcons(draging);
                        },
                        onVerticalDragEnd: (details) {
                          context
                              .read<ScrollBloc>()
                              .add(ActiveItemEvent(false));
                          context.read<ScrollBloc>().add(DragingEvent(null));
                          controllerOpcityPageView.reverse();
                          resetAllControllers();
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void resetAllControllers() {
    controllerFavorite.reverse();
    controllerMusic.reverse();
    controllerSensors.reverse();
  }

  void changeStatusIcons(AlignmentDirectional draging) {
    if (draging.y.ceilToDouble() >= dragTrackCchanges.y) {
      if (isOnce) {
        isOnce = false;
        controllerFavorite.reverse();
        controllerMusic.reverse();
        controllerSensors.forward();
        pageController.animateToPage(2,
            duration: const Duration(milliseconds: 200), curve: Curves.ease);
        HapticFeedback.heavyImpact();
      }
    } else if (draging.y.ceilToDouble() == dragMusic.y) {
      if (!isOnce) {
        isOnce = true;
        controllerFavorite.reverse();
        controllerMusic.forward();
        controllerSensors.reverse();
        pageController.animateToPage(1,
            duration: const Duration(milliseconds: 200), curve: Curves.ease);
        HapticFeedback.heavyImpact();
      }
    } else if (draging.y.ceilToDouble() <= dragFavorite.y) {
      if (isOnce) {
        isOnce = false;
        controllerFavorite.forward();
        controllerMusic.reverse();
        controllerSensors.reverse();
        pageController.animateToPage(0,
            duration: const Duration(milliseconds: 200), curve: Curves.ease);
        HapticFeedback.heavyImpact();
      }
    }
  }
}
