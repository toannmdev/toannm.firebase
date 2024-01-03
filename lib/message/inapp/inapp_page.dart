import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:flutter/material.dart';

late final FirebaseAnalytics analytics;
late final FirebaseInAppMessaging fiam;

void initFirebaseInApp() async {
  analytics = FirebaseAnalytics.instance;
  fiam = FirebaseInAppMessaging.instance;
}

class InAppPage extends StatelessWidget {
  const InAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('In-App Messaging example'),
        ),
        body: Builder(
          builder: (BuildContext context) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  AnalyticsEventExample(),
                  ProgrammaticTriggersExample(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ProgrammaticTriggersExample extends StatelessWidget {
  const ProgrammaticTriggersExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: <Widget>[
            const Text(
              'Programmatic Trigger',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            const Text('Manually trigger events programmatically '),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                await fiam.triggerEvent('awesome_event');
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Triggering event: awesome_event'),
                      behavior: SnackBarBehavior.floating
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text(
                'Programmatic Triggers'.toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AnalyticsEventExample extends StatelessWidget {
  const AnalyticsEventExample({super.key});

  Future<void> _sendAnalyticsEvent() async {
    await analytics.logEvent(
      name: 'awesome_event',
      parameters: <String, dynamic>{
        //'id': 1, // not required?
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: <Widget>[
            const Text(
              'Log an analytics event',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            const Text('Trigger an analytics event'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                _sendAnalyticsEvent();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Firing analytics event: awesome_event'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text(
                'Log event'.toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}