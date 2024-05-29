import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:technicaltestfan/model/UserModel.dart';
import 'package:technicaltestfan/service/FireStoreService.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final FireStoreService fireStoreService = FireStoreService();
  TextEditingController searchController = TextEditingController();
  Stream<List<UserModel>>? userStream;

  @override
  void initState() {
    super.initState();
    userStream = fireStoreService.streamAllUsers();
    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      if (searchController.text.isEmpty) {
        userStream = fireStoreService.streamAllUsers();
      } else {
        userStream = fireStoreService.searchUsersByEmail(searchController.text);
      }
    });
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  void funcFilter() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Filter Users', style: GoogleFonts.libreBaskerville()),
          content: Text('Choose filter option:',
              style: GoogleFonts.libreBaskerville()),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  userStream =
                      fireStoreService.filterUsersByEmailVerification(true);
                });
                Navigator.of(context).pop();
              },
              child: Text('Verified', style: GoogleFonts.libreBaskerville()),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  userStream =
                      fireStoreService.filterUsersByEmailVerification(false);
                });
                Navigator.of(context).pop();
              },
              child:
                  Text('Not Verified', style: GoogleFonts.libreBaskerville()),
            ),
          ],
        );
      },
    );
  }

  void verified(String useruid) {
    FirebaseFirestore.instance.collection('users').doc(useruid).update({
      'emailVerified': true,
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double topMargin = screenHeight * 0.05;
    double leftMargin = screenWidth * 0.01;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: topMargin, left: leftMargin),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    labelText: 'Search',
                    labelStyle: GoogleFonts.libreBaskerville(),
                    hintText: 'Enter user email',
                    hintStyle: GoogleFonts.libreBaskerville(),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: topMargin),
              child: IconButton(
                onPressed: _onSearchChanged,
                icon: Icon(Icons.search),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: topMargin),
              child: IconButton(
                onPressed: funcFilter,
                icon: Icon(Icons.edit_note),
              ),
            ),
          ],
        ),
        Expanded(
          child: StreamBuilder<List<UserModel>>(
            stream: userStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                    child: Text('Error: ${snapshot.error}',
                        style: GoogleFonts.libreBaskerville()));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                    child: Text('No users found',
                        style: GoogleFonts.libreBaskerville()));
              } else {
                List<UserModel> users = snapshot.data!;

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      columnSpacing: 30.0,
                      dataRowHeight: 60.0,
                      columns: [
                        DataColumn(
                            label: Text('Email',
                                style: GoogleFonts.libreBaskerville())),
                        DataColumn(
                            label: Text('Status',
                                style: GoogleFonts.libreBaskerville())),
                        DataColumn(
                            label: Text('Action',
                                style: GoogleFonts.libreBaskerville())),
                      ],
                      rows: users.map((user) {
                        return DataRow(cells: [
                          DataCell(Text(user.email,
                              style: GoogleFonts.libreBaskerville())),
                          DataCell(Text(
                            user.emailVerified
                                ? 'Email Verified'
                                : 'Email Not Verified',
                            style: GoogleFonts.libreBaskerville(),
                          )),
                          DataCell(
                            user.emailVerified
                                ? SizedBox()
                                : ElevatedButton(
                                    onPressed: () {
                                      verified(user.uid);
                                    },
                                    child: Text('Verify',
                                        style: GoogleFonts.libreBaskerville()),
                                  ),
                          ),
                        ]);
                      }).toList(),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
