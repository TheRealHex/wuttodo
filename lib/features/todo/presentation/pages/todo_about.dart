import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/style.dart';

class TodoAbout extends StatelessWidget {
  const TodoAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        titleTextStyle: appBarTextStyle(context),
        backgroundColor: Theme.of(context).colorScheme.onSurface,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            semanticLabel: 'Go back',
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
      ),
      body: Semantics(
        label: 'About Developer',
        child: Container(
          color: Theme.of(context).colorScheme.onSurface,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Image.asset(
                'assets/icon/icon.png',
                width: 180,
                fit: BoxFit.cover,
              )),
              const SizedBox(height: 14),
              Text(
                'WutTodo?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "A minimal TODO app !",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      var url =
                          Uri.https('github.com', '/therealhex/WutTodo.git');
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      }
                    },
                    icon: const Icon(
                      Icons.code,
                      color: Colors.blue,
                      semanticLabel: 'Launch source url',
                    ),
                    label: const Text('Source'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.onSurface),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton.icon(
                    onPressed: () async {
                      var url = Uri.https('nischal-dhakal.com.np');
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      }
                    },
                    icon: const Icon(
                      Icons.link,
                      color: Colors.deepOrangeAccent,
                      semanticLabel: 'Launch dev website',
                    ),
                    label: const Text('Confer'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.onSurface),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
