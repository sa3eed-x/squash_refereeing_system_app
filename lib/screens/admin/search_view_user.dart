// ignore_for_file: prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/screens/admin/edit_user.dart';
import 'package:flutter_application_4/data/user_repository.dart';

class SearchViewUser extends StatefulWidget {
  const SearchViewUser({super.key});

  @override
  State<SearchViewUser> createState() => _SearchViewUserState();
}

class _SearchViewUserState extends State<SearchViewUser> {
  var searchName = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: SizedBox(
          height: 40,
          child: TextField(
            onChanged: (value) {
              setState(() {
                searchName = value;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              filled: true,
              fillColor: const Color.fromARGB(255, 246, 242, 242),
              hintText: 'Search',
              hintStyle: const TextStyle(color: Colors.grey),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .orderBy('email')
            .startAt([searchName]).endAt([searchName + "\uf8ff"]).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading');
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var data = snapshot.data!.docs[index];
              return ListTile(
                onTap: () async {
                  await getUserFullData(data['uid']);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditUserScreen(),
                    ),
                  );
                },
                leading: const CircleAvatar(
                  radius: 24,
                ),
                title: Text(data['full Name']),
                subtitle: Text(data['email']),
              );
            },
          );
        },
      ),
    );
  }
}
