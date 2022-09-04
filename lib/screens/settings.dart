import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/setting.dart';
import 'package:flutter_demo/util/router.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
              child: Column(
                children: [
                  _ProfileWidget(),
                  _LanguageWidget(),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 50,
              child: Container(
                color: const Color.fromARGB(255, 38, 38, 38),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context).settings,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: BackButton(
                onPressed: () {
                  routerPop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Row(
        children: [
          ClipOval(
            child: SizedBox.fromSize(
              size: const Size.fromRadius(40), // Image radius
              child: Container(
                color: Colors.grey,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://storage.googleapis.com/cms-storage-bucket/780e0e64d323aad2cdd5.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 15), // padding
          Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Jasper",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(height: 3), // padding
                  Text(
                    AppLocalizations.of(context).viewProfile,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ]),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              ">",
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ],
      ),
    );
  }
}

class _LanguageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Settings settings = Provider.of<Settings>(context, listen: false);

    return SizedBox(
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context).settingLanguage,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          DropdownButton<String>(
            value: supportedLangs.contains(settings.locale.languageCode)
                ? settings.locale.languageCode
                : supportedLangs.first,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? value) {
              settings.setLocale(value!);
            },
            items: supportedLangs.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
