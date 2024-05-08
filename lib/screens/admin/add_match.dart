// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, unused_import, avoid_print, no_leading_underscores_for_local_identifiers, empty_statements, duplicate_ignore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/data/match_repository.dart';
import 'package:flutter_application_4/data/user_repository.dart';
import 'package:flutter_application_4/models/match_model.dart';
import 'package:flutter_application_4/models/user_model.dart';
import 'package:flutter_application_4/widget/custom_button.dart';
import 'package:flutter_application_4/widget/custom_textfield.dart';

class AddMatchScreen extends StatefulWidget {
  static const routeName = '/add-match';

  const AddMatchScreen({super.key});

  @override
  _AddMatchScreenState createState() => _AddMatchScreenState();
}

class _AddMatchScreenState extends State<AddMatchScreen> {
  final _player1Controller = TextEditingController();
  final _player2Controller = TextEditingController();
  final _courtNumberController = TextEditingController();
  final _dateTimeController = TextEditingController();
  final _refereeController = TextEditingController();

  bool _isLoading = false;
  String? _selectedReferee;

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
                    hintText: 'Player 1',
                    controller: _player1Controller,
                    keyboardType: TextInputType.name,
                    onPressed: () {},
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    hintText: 'Player 2',
                    controller: _player2Controller,
                    keyboardType: TextInputType.name,
                    onPressed: () {},
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    hintText: 'Court number',
                    controller: _courtNumberController,
                    keyboardType: TextInputType.number,
                    onPressed: () {},
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    hintText: 'Date and Time',
                    readOnly: true,
                    controller: _dateTimeController,
                    keyboardType: TextInputType.name,
                    onPressed: () async {
                      await _selectDate();
                    },
                  ),
                  SizedBox(height: 20),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .where('role', isEqualTo: 'referee')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text('Loading');
                      }
                      List<DropdownMenuItem<String>> items = [];
                      for (var doc in snapshot.data!.docs) {
                        bool hasMatch = false;
                        // Assume you have a 'atches' collection in Firestore
                        FirebaseFirestore.instance
                            .collection('matches')
                            .where('referee', isEqualTo: doc.id)
                            .where('dateTime',
                                isEqualTo: _dateTimeController.text)
                            .get()
                            .then((querySnapshot) {
                          if (querySnapshot.docs.isNotEmpty) {
                            hasMatch = true;
                          }
                        }).whenComplete(() {
                          if (!hasMatch) {
                            items.add(DropdownMenuItem<String>(
                              value: doc.id,
                              child: Text(doc['full Name']),
                            ));
                          }
                        });
                      }
                      return DropdownButtonFormField<String>(
                        value: _selectedReferee,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedReferee = newValue;
                            _refereeController.text = newValue!;
                          });
                        },
                        items: items,
                        decoration: InputDecoration(
                          labelText: 'Select Referee',
                          border: OutlineInputBorder(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 40),
                  CustomButton(
                    labelText: 'Add Match',
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      createMatchInDatabase(
                        player1: _player1Controller.text,
                        player2: _player2Controller.text,
                        courtNumber: _courtNumberController.text,
                        dateTime: _dateTimeController.text,
                        referee: _refereeController.text,
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
      firstDate: DateTime.now(),
      lastDate: DateTime.now()
          .add(const Duration(days: 365)), // Add one year to the current date
      initialDate: DateTime.now(),
    );
    if (_pickedDate != null) {
      setState(
        () {
          _dateTimeController.text = _pickedDate.toString().split(' ')[0];
        },
      );
    }
  }
}
