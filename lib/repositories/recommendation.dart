import 'package:flutter/material.dart';
import 'package:flutter_demo/models/index.dart';
import 'package:flutter_demo/util/http.dart';

Future<String> _getRecommendations(Request r) {
  String response = """
    [
      {
        "type": "primary",
        "playlists": [
          {
            "id": 1,
            "title": "Daily Mix 25",
            "imageUrl": "https://flutterindia.dev/flappy-dash.gif",
            "description": "A mix of music and wellness to guide you there",
            "likes": 20,
            "tracks": null
          },
          {
            "id": 2,
            "title": "Daily Mix 3",
            "imageUrl": "https://flutterindia.dev/flappy-dash.gif",
            "description": "A mix of music and wellness to guide you there",
            "likes": 20,
            "tracks": null
          },
          {
            "id": 3,
            "title": "Daily Mix 25",
            "imageUrl": "https://flutterindia.dev/flappy-dash.gif",
            "description": "A mix of music and wellness to guide you there",
            "likes": 20,
            "tracks": null
          },
          {
            "id": 4,
            "title": "Daily Mix 25",
            "imageUrl": "https://flutterindia.dev/flappy-dash.gif",
            "description": "A mix of music and wellness to guide you there",
            "likes": 20,
            "tracks": null
          },
          {
            "id": 5,
            "title": "Daily Mix 25",
            "imageUrl": "https://flutterindia.dev/flappy-dash.gif",
            "description": "A mix of music and wellness to guide you there",
            "likes": 20,
            "tracks": null
          }
        ],
        "title": "",
        "artist": null
      },
      {
        "type": "normal",
        "playlists": [
          {
            "id": 1,
            "title": "Daily Mix 1",
            "imageUrl": "https://flutterindia.dev/flappy-dash.gif",
            "description": "A mix of music and wellness to guide you there",
            "likes": 20,
            "tracks": null
          },
          {
            "id": 2,
            "title": "Daily Mix 2",
            "imageUrl": "https://flutterindia.dev/flappy-dash.gif",
            "description": "A mix of music and wellness to guide you there",
            "likes": 20,
            "tracks": null
          },
          {
            "id": 3,
            "title": "Daily Mix 3",
            "imageUrl": "https://flutterindia.dev/flappy-dash.gif",
            "description": "A mix of music and wellness to guide you there",
            "likes": 20,
            "tracks": null
          }
        ],
        "title": "Made for you",
        "artist": null
      },
      {
        "type": "recentlyplayed",
        "playlists": [
          {
            "id": 0,
            "title": "Liked songs",
            "imageUrl": null,
            "description": "",
            "likes": 20,
            "tracks": null
          },
          {
            "id": 2,
            "title": "Daily Mix 2",
            "imageUrl": "https://flutterindia.dev/flappy-dash.gif",
            "description": "A mix of music and wellness to guide you there",
            "likes": 20,
            "tracks": null
          },
          {
            "id": 3,
            "title": "Daily Mix 3",
            "imageUrl": "https://flutterindia.dev/flappy-dash.gif",
            "description": "A mix of music and wellness to guide you there",
            "likes": 20,
            "tracks": null
          }
        ],
        "title": "",
        "artist": null
      },
      {
        "type": "moreLike",
        "playlists": [
          {
            "id": 2,
            "title": "Daily Mix 2",
            "imageUrl": "https://flutterindia.dev/flappy-dash.gif",
            "description": "A mix of music and wellness to guide you there",
            "likes": 20,
            "tracks": null
          },
          {
            "id": 3,
            "title": "Daily Mix 3",
            "imageUrl": "https://flutterindia.dev/flappy-dash.gif",
            "description": "A mix of music and wellness to guide you there",
            "likes": 20,
            "tracks": null
          }
        ],
        "title": "More like",
        "artist": {
          "name": "inger",
          "imageUrl": "https://flutterindia.dev/flappy-dash.gif"
        }
      },
      {
        "type": "spotlight",
        "playlists": [
          {
            "id": 2,
            "title": "Daily Mix 2",
            "imageUrl": "https://flutterindia.dev/flappy-dash.gif",
            "description": "A mix of music and wellness to guide you there",
            "likes": 20,
            "tracks": null
          },
          {
            "id": 3,
            "title": "Daily Mix 3",
            "imageUrl": "https://flutterindia.dev/flappy-dash.gif",
            "description": "A mix of music and wellness to guide you there",
            "likes": 20,
            "tracks": null
          }
        ],
        "title": "Picked for you",
        "artist": null
      }
    ]
    """;
  return Future.delayed(const Duration(seconds: 3), () => response);
}

Future<List<Recommendation>> getRecommendations(HttpClient client,
    {Locale? locale}) {
  return Future<List<Recommendation>>(() async {
    List<dynamic> recommendationsJson = await client.handle(
        Request(HttpMethod.get, "/recommendations",
            queryParams: {"lang": locale?.languageCode}),
        _getRecommendations);
    List<Recommendation> recommendations = List<Recommendation>.from(
        recommendationsJson.map((j) => Recommendation.fromJson(j)));
    recommendations.sort();
    return recommendations;
  });
}
