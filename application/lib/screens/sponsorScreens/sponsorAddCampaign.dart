import 'package:application/models/campaign.dart';
import 'package:application/services/database.dart';
import 'package:application/shared/constants.dart';
import 'package:application/shared/globals.dart';
import 'package:flutter/material.dart';

class SponsorAddCampaign extends StatefulWidget {
  const SponsorAddCampaign({super.key});

  @override
  State<SponsorAddCampaign> createState() => _SponsorAddCampaignState();
}

class _SponsorAddCampaignState extends State<SponsorAddCampaign> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String description = '';
  String expiration = '';
  String notes = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              //Name Field
              const SizedBox(height: 20.0),
              const Text(
                "Type in campaign information",
                style: TextStyle(
                  color: textColor,
                  fontSize: 26,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: "Name"),
                  validator: (val) => val!.isEmpty ? 'Enter a name' : null,
                  onChanged: (val) {
                    setState(() => name = val);
                  }),

              //Description Field
              const SizedBox(height: 20.0),
              TextFormField(
                  maxLines: 5,
                  decoration:
                      textInputDecoration.copyWith(hintText: "Description"),
                  validator: (val) =>
                      val!.isEmpty ? 'Enter a description' : null,
                  onChanged: (val) {
                    setState(() => description = val);
                  }),

              //Expiration Field
              const SizedBox(height: 20.0),
              TextFormField(
                  decoration:
                      textInputDecoration.copyWith(hintText: "Expiration"),
                  validator: (val) => val!.isEmpty ? 'Enter expiration' : null,
                  onChanged: (val) {
                    setState(() => expiration = val);
                  }),

              //Notes Field
              const SizedBox(height: 20.0),
              TextFormField(
                  maxLines: 5,
                  decoration: textInputDecoration.copyWith(hintText: "Notes"),
                  validator: (val) => val!.isEmpty ? 'Notes' : null,
                  onChanged: (val) {
                    setState(() => notes = val);
                  }),

              //Add Campaign button
              const SizedBox(height: 20.0),
              ElevatedButton(
                  child: const Text(
                    'Add Campaign',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      Campaign campaign =
                          Campaign(uid: "meaningless UID that will be deleted");
                      campaign.name = name;
                      campaign.description = description;
                      campaign.expiration = expiration;
                      campaign.hostUID = Globals.currentUser.uid;
                      campaign.notes = notes;
                      DatabaseService(uid: Globals.currentUser.uid)
                          .addCampaign(campaign);
                    } else {
                      print("VALIDATION FOR SPONSOR ADD CAMPAIGN ERROR");
                    }
                  }),
            ])),
      ),
    );
  }
}
