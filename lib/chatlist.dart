import 'package:flutter/material.dart';
import 'package:fyp/scrap services/scrap_upload.dart';
import 'package:fyp/chat.dart';
import 'package:fyp/config/constant.dart';
import 'package:fyp/inventory/inventory_tab.dart';
import 'package:fyp/notification/notification.dart';
import 'package:fyp/ui/reusable/global_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatListPage extends StatefulWidget {
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  // initialize global widget
  final _globalWidget = GlobalWidget();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Recycle Now',
            style:
                GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          actions: [
            CircleAvatar(
              radius: 20,
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationPage(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.notification_add,
                  size: 25,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: CircleAvatar(
                radius: 20,
                child: PopupMenuButton(
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UploadScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Add item',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        value: 1,
                      ),
                      PopupMenuItem(
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InventoryTab(),
                              ),
                            );
                          },
                          child: Text(
                            'Inventory',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        value: 2,
                      ),
                      PopupMenuItem(
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Report',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        value: 3,
                      ),
                      PopupMenuItem(
                        child: Text('Setting'),
                        value: 3,
                      ),
                    ];
                  },
                  onSelected: (value) {
                    // Handle option selection
                  },
                  child: Icon(Icons.more_vert),
                ),
              ),
            ),
          ],
        ),
        body: ListView(
          padding: EdgeInsets.fromLTRB(24, 24, 24, 16),
          children: [
            Container(
              child: Text('My Chat',
                  style: TextStyle(
                      fontSize: 18,
                      color: BLACK21,
                      fontWeight: FontWeight.w500)),
            ),
            SizedBox(height: 18),
            _globalWidget.screenDetailList(
                context: context, title: 'Talha', page: Chat1Page()),
            _globalWidget.screenDetailList(
                context: context, title: 'Hamza', page: Chat1Page()),
            _globalWidget.screenDetailList(
                context: context, title: 'Umar', page: Chat1Page()),
            _globalWidget.screenDetailList(
                context: context, title: 'Nasir', page: Chat1Page()),
          ],
        ));
  }
}
