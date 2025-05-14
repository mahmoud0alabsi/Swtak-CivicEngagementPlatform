import 'package:carousel_slider/carousel_slider.dart';
import 'package:citizens_voice_app/features/municipality/business/entities/municipality_project_entity.dart';
import 'package:citizens_voice_app/features/municipality/presentation/bloc/ongoing_projects/ongoing_projects_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'carousal_Item.dart';

class CarouselWithDots extends StatefulWidget {
  const CarouselWithDots({super.key});

  @override
  _CarouselWithDotsState createState() => _CarouselWithDotsState();
}

class _CarouselWithDotsState extends State<CarouselWithDots> {
  int _currentIndex = 0;

  MunicipalityProjectEntity dummyProject = MunicipalityProjectEntity(
    id: '0',
    title: 'dummy',
    details: 'dummy',
    dateOfPost: DateTime.now(),
    durationOfAvailability: 1,
    isFinished: false,
    projectNumber: 1,
    tags: [],
    type: 'dummy',
    voting: {},
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OngoingProjectsBloc, OngoingProjectsState>(
      bloc: context.read<OngoingProjectsBloc>(),
      builder: (context, state) {
        if (state is OngoingProjectsLoading ||
            state is OngoingProjectsInitial) {
          return Skeletonizer(
            enabled: true,
            effect: const ShimmerEffect(
              // duration: Duration(seconds: 2),
              baseColor: Color.fromARGB(255, 255, 255, 255),
              highlightColor: Color.fromARGB(255, 239, 239, 239),
            ),
            child: Column(
              children: [
                CarouselSlider(
                  items: List.generate(3, (index) {
                    return SizedBox(
                      height: 150,
                      width: 478,
                      child: Skeleton.leaf(
                        child: Card(
                          child: ListTile(
                            title: Text('Item number $index as title'),
                            subtitle: const Text('Subtitle here'),
                            trailing: const Icon(Icons.ac_unit),
                          ),
                        ),
                      ),
                    );
                  }),
                  options: CarouselOptions(
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    height: 140,
                    initialPage: 0,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 8),
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                  width: 278,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      child: Container(
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex == index
                              ? Theme.of(context)
                                  .colorScheme
                                  .primary // Active dot color
                              : Colors.grey, // Inactive dot color
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          );
        }
        List<MunicipalityProjectEntity> ongoingProjects =
            context.read<OngoingProjectsBloc>().ongoingProjects;
        ongoingProjects.sort((a, b) => a.dateOfEnd.compareTo(b.dateOfEnd));

        // get the first 3 projects
        ongoingProjects = ongoingProjects.sublist(
            0, ongoingProjects.length > 3 ? 3 : ongoingProjects.length);

        return Column(
          children: [
            CarouselSlider(
              items: ongoingProjects
                  .map((project) => CarousalItem(project: project))
                  .toList(),
              options: CarouselOptions(
                // enlargeStrategy: CenterPageEnlargeStrategy.scale,
                height: 180,
                initialPage: 0,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 8),
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 10,
              width: 278,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(ongoingProjects.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == index
                          ? Theme.of(context)
                              .colorScheme
                              .primary // Active dot color
                          : Colors.grey, // Inactive dot color
                    ),
                  ),
                );
              }),
            ),
          ],
        );
      },
    );
  }
}
