import 'package:application/models/campaign.dart';
import 'package:application/models/message.dart';
import 'package:application/models/user.dart';
import 'package:application/services/database.dart';
import 'package:application/shared/helper.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';

class SponsorChatInterface extends StatelessWidget {
  final User userState;
  final Campaign campState;
  const SponsorChatInterface(this.campState, this.userState, {super.key});

  @override
  Widget build(BuildContext context) {
    var msgController = TextEditingController();
    return Scaffold(
        body: Column(
      children: [
        StreamProvider<List<Message>>.value(
            initialData: const [],
            value:
                DatabaseService(uid: userState.uid).getMessages(campState.uid),
            child: Consumer<List<Message>>(
              builder: (context, provider, child) => Expanded(
                  child: SizedBox(
                height: 200.0,
                child: GroupedListView<Message, DateTime>(
                  padding: const EdgeInsets.all(8),
                  reverse: true,
                  order: GroupedListOrder.DESC,
                  useStickyGroupSeparators: true,
                  floatingHeader: true,
                  elements: Message.sortByTime(
                      List.from(context.read<List<Message>>())),
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
                              toDate(message.created.toDate()),
                              style: const TextStyle(color: Colors.white),
                            )),
                      ))),
                  itemBuilder: (context, Message message) => Align(
                      alignment: message.sponsorSent
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Card(
                          color: message.sponsorSent
                              ? Colors.blue.shade100
                              : Colors.grey.shade200,
                          elevation: 8,
                          child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(message.body)))),
                ),
              )),
            )),
        Container(
          color: Colors.grey.shade200,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: msgController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    hintText: "Type message here",
                  ),
                  onSubmitted: (text) async {
                    Message m = Message();
                    m.body = text;
                    m.sponsorSent = true;
                    m.creativeUID = userState.uid;
                    m.sponsorUID = campState.hostUID;
                    await DatabaseService(uid: userState.uid)
                        .sendMessage(m, campState.uid);
                    msgController.clear();
                  },
                ),
              ),
              SizedBox(
                  width: 100,
                  child: TextButton(
                      onPressed: () => {specialMessage(campState, userState)},
                      child: const Text("Send Money")))
            ],
          ),
        ),
      ],
    ));
  }

  void specialMessage(campState, userState) {
    DatabaseService(uid: userState.uid)
        .sendPaymentMessage(campState, userState);
  }
}
