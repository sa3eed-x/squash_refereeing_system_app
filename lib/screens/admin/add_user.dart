import 'package:flutter/material.dart';
import 'package:flutter_application_4/data/user_repository.dart';
import 'package:flutter_application_4/widget/custom_button.dart';
import 'package:flutter_application_4/widget/custom_textfield.dart';

class AddUserScreen extends StatefulWidget {
  static const routeName = '/add-user';

  const AddUserScreen({super.key});

  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  String gender = 'male';
  String role = 'referee';
  final _nameController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('assets/backgroundimage.jpg'),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: Center(
          child: FutureBuilder(
            future: _isLoading ? Future.delayed(Duration(seconds: 1)) : null,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              return SingleChildScrollView(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20), // Adjusted space
                    CustomTextField(
                      hintText: 'Name',
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      onPressed: () {},
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      hintText: 'Date of Birth',
                      readOnly: true,
                      controller: _dateOfBirthController,
                      keyboardType: TextInputType.name,
                      onPressed: () async {
                        await _selectDate();
                      },
                    ),
                    SizedBox(height: 10),
                    DropdownButton<String>(
                      items: const [
                        DropdownMenuItem(
                          value: 'male',
                          child: Text('male'),
                        ),
                        DropdownMenuItem(value: 'female', child: Text('female'))
                      ],
                      value: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value!;
                        });
                      }),
                    SizedBox(height: 10),
                    CustomTextField(
                      hintText: 'Phone number',
                      controller: _phoneController,
                      keyboardType: TextInputType.name,
                      onPressed: () {},
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      hintText: 'Email',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      onPressed: () {},
                    ),
                    SizedBox(height: 10),
                    DropdownButton<String>(
                      items: const [
                        DropdownMenuItem(value: 'admin', child: Text('Admin')),
                        DropdownMenuItem(
                            value: 'expert', child: Text('Expert')),
                        DropdownMenuItem(
                            value: 'referee', child: Text('Referee')),
                      ],
                      value: role,
                      onChanged: (value) {
                        setState(() {
                          role = value!;
                        });
                      }),
                    SizedBox(height: 10),
                    CustomTextField(
                      hintText: 'Password',
                      controller: _passwordController,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      onPressed: () {},
                    ),
                    SizedBox(height: 20),
                    CustomButton(
                    labelText: 'Add User',
                    onPressed: () {
                      print('button pressed');
                      setState(() {
                        _isLoading = true;
                      });
                      registerUser(
                        name: _nameController.text,
                        dateOfBirth: _dateOfBirthController.text,
                        email: _emailController.text,
                        phoneNumber: _phoneController.text,
                        password: _passwordController.text,
                        gender: gender,
                        role: role,
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
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dateOfBirthController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
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

