import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/style.dart';

class TodoAbout extends StatelessWidget {
  const TodoAbout({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('About', style: appBarTextStyle(context)),
        backgroundColor: theme.colorScheme.onSurface,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.surface),
          // semanticLabel: 'Go back',
        ),
      ),
      body: Semantics(
        label: 'About Developer',
        child: Container(
          color: theme.colorScheme.onSurface,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/icon/ic_launcher.webp',
                    width: 180,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Wut Todo?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: theme.colorScheme.surface,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "A minimal TODO app!",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 14,
                    color: theme.colorScheme.surface,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildButtonRow(theme),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildButtonRow(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildElevatedButton(
          url: Uri.https('github.com', '/therealhex/WutTodo'),
          icon: Icons.code,
          label: 'Source',
          color: Colors.blue,
          backgroundColor: theme.colorScheme.onSurface,
        ),
        const SizedBox(width: 20),
        _buildElevatedButton(
          url: Uri.https('nischal-dhakal.com.np'),
          icon: Icons.link,
          label: 'Confer',
          color: Colors.deepOrangeAccent,
          backgroundColor: theme.colorScheme.onSurface,
        ),
      ],
    );
  }

  ElevatedButton _buildElevatedButton({
    required Uri url,
    required IconData icon,
    required String label,
    required Color color,
    required Color backgroundColor,
  }) {
    return ElevatedButton.icon(
      onPressed: () async {
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          print("Can't launch");
        }
      },
      icon: Icon(icon, color: color),
      label: Text(label),
      style: ElevatedButton.styleFrom(backgroundColor: backgroundColor),
    );
  }
}

