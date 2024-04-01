import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../style.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        titleTextStyle: appBarTextStyle(context),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            'assets/image/launcher_icon.png',
            width: 180,
            fit: BoxFit.cover,
          )),
          SizedBox(height: 14),
          Text(
            'WutTodo?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "A Minimalistic Todo App !",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () async {
                  var url = Uri.https('github.com', '/therealhex/WutTodo.git');
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  }
                },
                icon: Icon(
                  Icons.code,
                  color: Colors.blue,
                ),
                label: Text('Source'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.background),
              ),
              SizedBox(width: 20),
              ElevatedButton.icon(
                onPressed: () async {
                  var url = Uri.https('github.com', '/therealhex');
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  }
                },
                icon: Icon(
                  Icons.cloud,
                  // color: Colors.black,
                ),
                label: Text('Github'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.background),
              ),
            ],
          )
        ],
      ),
    );
  }
}
