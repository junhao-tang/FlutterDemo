import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_wheel/models/index.dart';
import 'package:flutter_wheel/repositories/playlist.dart';
import 'package:flutter_wheel/setting.dart';
import 'package:flutter_wheel/util/router.dart';
import 'package:flutter_wheel/widgets/retry.dart';
import 'package:flutter_wheel/widgets/track.dart';
import 'package:provider/provider.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen(this.playlistId, {Key? key}) : super(key: key);

  final int playlistId;

  @override
  State<StatefulWidget> createState() => _PlaylistScreen();
}

class _PlaylistScreen extends State<PlaylistScreen> {
  @override
  Widget build(BuildContext context) {
    Settings settings = Provider.of<Settings>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: getPlaylist(settings.httpClient, widget.playlistId,
              locale: settings.locale),
          builder: (BuildContext context, AsyncSnapshot<Playlist> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return RetryWidget(
                    snapshot.error.toString(), () => setState(() {}));
              }
              Playlist data = snapshot.data!;
              return Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: AnimationLimiter(
                      child: ListView.builder(
                        itemCount: data.tracks!.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return _Header(
                                data.imageUrl, data.description, data.likes);
                          }
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: TrackWidget(
                                    data.tracks![index - 1]), // TODO: ugly
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Row(
                      children: [
                        BackButton(
                          onPressed: () {
                            routerPop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String? imageUrl;
  final String description;
  final int likes;

  const _Header(this.imageUrl, this.description, this.likes, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (imageUrl != null)
          Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: CachedNetworkImage(
              imageUrl: imageUrl!,
              width: 200,
              height: 200,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        if (description != "")
          Text(
            description,
            maxLines: 2,
          ),
        Container(
          height: 30,
          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: Row(
            children: [
              CachedNetworkImage(
                imageUrl:
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/Spotify_logo_without_text.svg/2048px-Spotify_logo_without_text.svg.png",
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                width: 25,
                height: 25,
              ),
              const SizedBox(width: 15),
              Text(
                "Spotify",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30,
          child: Row(
            children: [
              Text("$likes likes . 2h 34min"),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 100,
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(Icons.favorite_outline),
                  Icon(Icons.download),
                  Icon(Icons.more_vert),
                ],
              ),
            ),
            const Icon(
              Icons.play_circle_fill,
              color: Colors.green,
              size: 60,
            ),
          ],
        ),
      ],
    );
  }
}
