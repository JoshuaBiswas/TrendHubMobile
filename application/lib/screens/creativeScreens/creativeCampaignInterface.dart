import 'package:application/models/campaign.dart';
import 'package:application/models/message.dart';
import 'package:application/services/database.dart';
import 'package:application/shared/globals.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';

class CreativeCampaignInterface extends StatelessWidget {
  final Campaign campState;
  const CreativeCampaignInterface(this.campState, {super.key});

  @override
  Widget build(BuildContext context) {
    var msgController = TextEditingController();
    return Scaffold(
        body: Column(
      children: [
        StreamProvider<List<Message>>.value(
            initialData: const [],
            value: DatabaseService(uid: Globals.currentUser.uid)
                .getMessages(campState.uid),
            child: Consumer<List<Message>>(
              builder: (context, provider, child) => Expanded(
                  child: GroupedListView<Message, DateTime>(
                padding: const EdgeInsets.all(8),
                reverse: true,
                order: GroupedListOrder.DESC,
                useStickyGroupSeparators: true,
                floatingHeader: true,
                elements: Message.sortByTime(context.read<List<Message>>()),
                groupBy: (message) => DateTime(
                    message.created.toDate().year,
                    message.created.toDate().month,
                    message.created.toDate().day),
                groupHeaderBuilder: (Message message) => SizedBox(
                    height: 40,
                    child: Center(
                        child: Card(
                      color: Colors.amber,
                      child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            message.created.toDate().year.toString(),
                            style: const TextStyle(color: Colors.white),
                          )),
                    ))),
                itemBuilder: (context, Message message) => Align(
                    alignment: message.sponsorSent
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Card(
                        color: message.sponsorSent
                            ? Colors.grey.shade200
                            : Colors.blue.shade100,
                        elevation: 8,
                        child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(message.body)))),
              )),
            )),
        Container(
          color: Colors.grey.shade200,
          child: TextField(
            controller: msgController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(12),
              hintText: "Type message here",
            ),
            onSubmitted: (text) async {
              Message m = Message();
              m.body = text;
              m.creativeUID = Globals.currentUser.uid;
              m.sponsorUID = campState.hostUID;
              await DatabaseService(uid: m.creativeUID)
                  .sendMessage(m, campState.uid);
              msgController.clear();
            },
          ),
        ),
        // TextField(
        //   onSubmitted: (text) async {
        //     Message m = Message();
        //     m.body = text;
        //     m.creativeUID = Globals.currentUser.uid;
        //     m.sponsorUID = campState.hostUID;
        //     await DatabaseService(uid: m.creativeUID)
        //         .sendMessage(m, campState.uid);
        //   },
        //   decoration: const InputDecoration(
        //     border: OutlineInputBorder(),
        //     hintText: 'Enter message',
        //   ),
        // ),
      ],
    ));
  }
}
