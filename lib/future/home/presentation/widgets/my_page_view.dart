import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiping_icons/future/home/presentation/manager/scroll_bloc.dart';

class MyPageView extends StatefulWidget {
  const MyPageView({
    super.key,
    required this.pageController,
    required this.colorTweenController,
  });

  final PageController pageController;
  final AnimationController colorTweenController;

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView>
    with SingleTickerProviderStateMixin {
  late final Animation<Color?> _colorTween;

  @override
  void initState() {
    _colorTween = ColorTween(
            begin: Colors.transparent,
            end: const Color.fromARGB(53, 79, 79, 79))
        .animate(widget.colorTweenController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocBuilder<ScrollBloc, ScrollState>(
          builder: (context, state) {
            bool isScrollActive = context.read<ScrollBloc>().isActive;

            return AnimatedBuilder(
              animation: _colorTween,
              builder: (context, child) {
                return AnimatedContainer(
                  height: isScrollActive ? 550 : 600,
                  width: isScrollActive ? 300 : 350,
                  duration: const Duration(milliseconds: 200),
                  child: Stack(
                    children: [
                      PageView(
                        controller: widget.pageController,
                        scrollDirection: Axis.vertical,
                        children: [
                          const FavoritePage(),
                          Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20)),
                            child: const Icon(
                              Icons.music_note,
                              size: 60,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(20)),
                            child: const Icon(
                              Icons.sensors_rounded,
                              size: 60,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      if (isScrollActive)
                        Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: _colorTween.value,
                          ),
                        )
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _sizeIcon;
  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));

    _sizeIcon = Tween<double>(begin: 50, end: 80).animate(_controller);
    _controller.addListener(() {
      if (_controller.isCompleted) {
        _controller.reverse();
      } else if (_controller.isDismissed) {
        _controller.forward();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(20)),
      child: GestureDetector(
        onTap: () {
          _controller.forward();
        },
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Icon(
              Icons.favorite,
              size: _sizeIcon.value,
              color: Colors.white,
            );
          },
        ),
      ),
    );
  }
}
