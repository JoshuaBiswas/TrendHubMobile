import 'package:application/models/campaign.dart';
import 'package:application/models/message.dart';
import 'package:application/services/database.dart';
import 'package:application/shared/globals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreativeCampaignInterface extends StatelessWidget {
  final Campaign campState;
  const CreativeCampaignInterface(this.campState, {super.key});

  @override
  Widget build(BuildContext context) {
    String message = "";
    return Scaffold(
        body: Column(
      children: [
        StreamProvider<List<Message>>.value(
            initialData: const [],
            value: DatabaseService(uid: Globals.currentUser.uid).messages,
            child: Consumer<List<Message>>(
                builder: (context, provider, child) => Expanded(
                        child: ListView.separated(
                      itemCount: context.read<List<Message>>().length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        Message m = context.read<List<Message>>()[index];
                        return Text(
                          m.created.toString(),
                          textAlign:
                              m.sponsorSent ? TextAlign.left : TextAlign.right,
                        );
                      },
                    )))),
        Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: (text) {
                  message = text;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter message',
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  Message m = Message();
                  m.body = message;
                  m.creativeUID = Globals.currentUser.uid;
                  m.sponsorUID = campState.hostUID;
                },
                child: const Text("Send")),
          ],
        ),
      ],
    ));
  }
}
