// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, unused_import, avoid_print, no_leading_underscores_for_local_identifiers, empty_statements

import 'package:flutter/material.dart';
import 'package:flutter_application_4/data/user_repository.dart';
import 'package:flutter_application_4/models/user_model.dart';
import 'package:flutter_application_4/widget/custom_button.dart';
import 'package:flutter_application_4/widget/custom_textfield.dart';

class EditUserScreen extends StatefulWidget {
  const EditUserScreen({
    super.key,
  });
  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final _nameController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    _nameController.text = user.name!;
    _dateOfBirthController.text = user.dateOfBirth!;

    _phoneController.text = user.phoneNumber!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backgroundimage.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      child:Center(
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
                    hintText: 'Name',
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    onPressed: () {},
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    hintText: 'Date of Birth',
                    readOnly: true,
                    controller: _dateOfBirthController,
                    keyboardType: TextInputType.name,
                    onPressed: () async {
                      await _selectDate();
                    },
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    hintText: 'Phone number',
                    controller: _phoneController,
                    keyboardType: TextInputType.name,
                    onPressed: () {},
                  ),
                  SizedBox(height: 40),
                  CustomButton(
                    labelText: 'edit User',
                    onPressed: () {
                      print('button pressed');
                      setState(() {
                        _isLoading = true;
                      });
                      updateUser(
                        uid: user.uid!,
                        name: _nameController.text,
                        dateOfBirth: _dateOfBirthController.text,
                        phoneNumber: _phoneController.text,
                      );

                      setState(() {
                        _isLoading = false;
                      });
                    },
                  ),
                  SizedBox(height: 40),
                  CustomButton(
                    labelText: 'Delete User',
                    onPressed: () {
                      print('button pressed');
                      setState(() {
                        _isLoading = true;
                      });
                      deleteUser(
                        uid: user.uid!,
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
      )
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dateOfBirthController.dispose();
    _phoneController.dispose();
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
          _dateOfBirthController.text = _pickedDate.toString().split(' ')[0];
        },
      );
    }
    ;
  }
}
