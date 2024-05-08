// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, unused_import, avoid_print, no_leading_underscores_for_local_identifiers, empty_statements, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/data/match_repository.dart';
import 'package:flutter_application_4/models/match_model.dart';
import 'package:flutter_application_4/widget/custom_button.dart';
import 'package:flutter_application_4/widget/custom_textfield.dart';

class EditMatchScreen extends StatefulWidget {
  const EditMatchScreen({
    super.key,
  });
  @override
  _EditMatchScreenState createState() => _EditMatchScreenState();
}

class _EditMatchScreenState extends State<EditMatchScreen> {
  final _player1Controller = TextEditingController();
  final _player2Controller = TextEditingController();
  final _courtNumberController = TextEditingController();
  final _dateTimeController = TextEditingController();
  final _refereeController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    _player1Controller.text = match.player1!;
    _player2Controller.text = match.player2!;
    _courtNumberController.text = match.courtNumber!;
    _dateTimeController.text = match.dateTime!.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: _isLoading ? Future.delayed(Duration(seconds: 1)) : null,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
                  CustomTextField(
                    hintText: 'Player 1 Name',
                    controller: _player1Controller,
                    keyboardType: TextInputType.name,
                    onPressed: () {},
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    hintText: 'Player 2 Name',
                    readOnly: true,
                    controller: _player2Controller,
                    keyboardType: TextInputType.name,
                    onPressed: () {},
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    hintText: 'Court Number',
                    controller: _courtNumberController,
                    keyboardType: TextInputType.name,
                    onPressed: () {},
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    hintText: 'Date and Time',
                    controller: _dateTimeController,
                    keyboardType: TextInputType.name,
                    onPressed: () {},
                  ),
                  SizedBox(height: 40),
                  CustomButton(
                    labelText: 'edit match',
                    onPressed: () {
                      print('button pressed');
                      setState(() {
                        _isLoading = true;
                      });
                      updateMatch(
                        uid: match.uid!,
                        player1: _player1Controller.text,
                        player2: _player2Controller.text,
                        courtNumber: _courtNumberController.text.toString(),
                        dateTime: _dateTimeController.text,
                        referee: _refereeController.text,
                      );

                      setState(() {
                        _isLoading = false;
                      });
                    },
                  ),
                  SizedBox(height: 40),
                  CustomButton(
                    labelText: 'Delete match',
                    onPressed: () {
                      print('button pressed');
                      setState(() {
                        _isLoading = true;
                      });
                      deleteMatch(
                        uid: match.uid!,
                      );

                      setState(() {
                        _isLoading = false;
                      });
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _player1Controller.dispose();
    _player2Controller.dispose();
    _courtNumberController.dispose();
    _dateTimeController.dispose();
    _refereeController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    DateTime? _pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        initialDate: DateTime.now());
    if (_pickedDate != null) {
      setState(
        () {
          _dateTimeController.text = _pickedDate.toString().split(' ')[0];
        },
      );
    }
    ;
  }
}
