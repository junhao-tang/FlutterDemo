import 'package:flutter/material.dart';
import 'package:flutter_wheel/models/index.dart';
import 'package:flutter_wheel/models/playlist.dart';
import 'package:flutter_wheel/util/http.dart';

Future<String> _getPlaylist(Request request) {
  String response = """
      {
        "id": 3,
        "title": "Daily mix",
        "imageUrl": "https://flutterindia.dev/flappy-dash.gif",
        "description": "hello",
        "likes": 30000,
        "tracks": [
          {
            "title": "Song 0",
            "liked": false,
            "album": {
              "title": "New album",
              "imageUrl": "https://flutterindia.dev/flappy-dash.gif",
              "artist": {
                "name": "singer",
                "imageUrl": "https://flutterindia.dev/flappy-dash.gif"
              }
            }
          },
          {
            "title": "Song 1",
            "liked": false,
            "album": {
              "title": "New album",
              "imageUrl": "https://flutterindia.dev/flappy-dash.gif",
              "artist": {
                "name": "singer",
                "imageUrl": "https://flutterindia.dev/flappy-dash.gif"
              }
            }
          },
          {
            "title": "Song 2",
            "liked": false,
            "album": {
              "title": "New album",
              "imageUrl": "https://flutterindia.dev/flappy-dash.gif",
              "artist": {
                "name": "singer",
                "imageUrl": "https://flutterindia.dev/flappy-dash.gif"
              }
            }
          },
          {
            "title": "Song 3",
            "liked": false,
            "album": {
              "title": "New album",
              "imageUrl": "https://flutterindia.dev/flappy-dash.gif",
              "artist": {
                "name": "singer",
                "imageUrl": "https://flutterindia.dev/flappy-dash.gif"
              }
            }
          },
          {
            "title": "Song 4",
            "liked": false,
            "album": {
              "title": "New album",
              "imageUrl": "https://flutterindia.dev/flappy-dash.gif",
              "artist": {
                "name": "singer",
                "imageUrl": "https://flutterindia.dev/flappy-dash.gif"
              }
            }
          },
          {
            "title": "Song 5",
            "liked": false,
            "album": {
              "title": "New album",
              "imageUrl": "https://flutterindia.dev/flappy-dash.gif",
              "artist": {
                "name": "singer",
                "imageUrl": "https://flutterindia.dev/flappy-dash.gif"
              }
            }
          },
          {
            "title": "Song 6",
            "liked": false,
            "album": {
              "title": "New album",
              "imageUrl": "https://flutterindia.dev/flappy-dash.gif",
              "artist": {
                "name": "singer",
                "imageUrl": "https://flutterindia.dev/flappy-dash.gif"
              }
            }
          },
          {
            "title": "Song 7",
            "liked": false,
            "album": {
              "title": "New album",
              "imageUrl": "https://flutterindia.dev/flappy-dash.gif",
              "artist": {
                "name": "singer",
                "imageUrl": "https://flutterindia.dev/flappy-dash.gif"
              }
            }
          },
          {
            "title": "Song 8",
            "liked": false,
            "album": {
              "title": "New album",
              "imageUrl": "https://flutterindia.dev/flappy-dash.gif",
              "artist": {
                "name": "singer",
                "imageUrl": "https://flutterindia.dev/flappy-dash.gif"
              }
            }
          },
          {
            "title": "Song 9",
            "liked": false,
            "album": {
              "title": "New album",
              "imageUrl": "https://flutterindia.dev/flappy-dash.gif",
              "artist": {
                "name": "singer",
                "imageUrl": "https://flutterindia.dev/flappy-dash.gif"
              }
            }
          }
        ]
      }
    """;
  return Future<String>.delayed(const Duration(seconds: 1), () => response);
}

Future<Playlist> getPlaylist(HttpClient client, int playlistId,
    {Locale? locale}) {
  return Future(() async {
    Map<String, dynamic> jsonResponse = await client.handle(
        Request(HttpMethod.get, "/playlist",
            queryParams: {"lang": locale?.languageCode}),
        _getPlaylist);
    return Playlist.fromJson(jsonResponse);
  });
}
