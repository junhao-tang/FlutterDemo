import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_demo/models/index.dart';
import 'package:flutter_demo/models/recommendation.dart';
import 'package:flutter_demo/repositories/recommendation.dart';
import 'package:flutter_demo/setting.dart';
import 'package:flutter_demo/widgets/more_like_section.dart';
import 'package:flutter_demo/widgets/normal_section.dart';
import 'package:flutter_demo/widgets/recently_played_section.dart';
import 'package:flutter_demo/widgets/retry.dart';
import 'package:flutter_demo/widgets/spotlight_section.dart';
import 'package:flutter_demo/widgets/tile_playlists_section.dart';
import 'package:flutter_demo/widgets/top_nav.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  Widget getSection(Recommendation e) {
    switch (e.type) {
      case RecommendationType.spotlight:
        return SpotlightSectionWidget(e.title, e.playlists[0]);
      case RecommendationType.primary:
        return TilePlaylistsSectionWidget(e.playlists, 2);
      case RecommendationType.normal:
        return NormalSectionWidget(e.playlists);
      case RecommendationType.moreLike:
        return MoreLikeSection(e.title, e.artist!, e.playlists);
      case RecommendationType.recentlyplayed:
        return RecentlyPlayedSectionWidget(e.playlists);
      default:
        throw Exception();
    }
  }

  @override
  Widget build(BuildContext context) {
    Settings settings = Provider.of<Settings>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: FutureBuilder(
            future: getRecommendations(settings.httpClient,
                locale: settings.locale),
            builder: (BuildContext context,
                AsyncSnapshot<List<Recommendation>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return RetryWidget(
                      snapshot.error.toString(), () => setState(() {}));
                }
                List<Recommendation> data = snapshot.data!;
                return AnimationLimiter(
                  child: ListView(
                    children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 300),
                      childAnimationBuilder: (widget) => SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: widget,
                        ),
                      ),
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: const TopNavWidget(),
                        ),
                        ...data.map((e) => Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: getSection(e),
                            )),
                        const SizedBox(height: 100), // padding
                      ],
                    ),
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
