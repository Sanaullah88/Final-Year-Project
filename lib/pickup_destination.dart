import 'package:flutter/material.dart';
import 'package:fyp/scrap services/scrap_upload.dart';
import 'package:fyp/inventory/inventory_tab.dart';
import 'package:fyp/model/feature/pickup_model.dart';
import 'package:fyp/notification/notification.dart';
import 'package:fyp/ui/reusable/cache_image_network.dart';
import 'package:fyp/ui/reusable/global_function.dart';
import 'package:fyp/ui/reusable/global_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class PickupDestinationPage extends StatefulWidget {
  final PickupModel PickupData;

  const PickupDestinationPage({Key? key, required this.PickupData})
      : super(key: key);

  @override
  _PickupDestinationPage createState() => _PickupDestinationPage();
}

class _PickupDestinationPage extends State<PickupDestinationPage> {
  // initialize global widget
  final _globalWidget = GlobalWidget();
  final _globalFunction = GlobalFunction();

  Color _color1 = Color(0xFF515151);
  Color _color2 = Color(0xFFaaaaaa);

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
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(24, 24, 24, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _globalWidget.createDetailWidget(
                  title: 'Destination Page',
                  desc: 'This is the destination page from auto complete page'),
              _buildProduct(),
            ],
          ),
        ));
  }

  Widget _buildProduct() {
    final double boxImageSize = (MediaQuery.of(context).size.width / 4);
    return Container(
      margin: EdgeInsets.fromLTRB(12, 6, 12, 6),
      child: Container(
        margin: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                child: buildCacheNetworkImage(
                    width: boxImageSize,
                    height: boxImageSize,
                    url: widget.PickupData.image)),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.PickupData.name,
                    style: TextStyle(fontSize: 13, color: _color1),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                        '\$ ' +
                            _globalFunction.removeDecimalZeroFormat(
                                widget.PickupData.price),
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        Icon(Icons.location_on, color: _color2, size: 12),
                        Text(' ' + widget.PickupData.location,
                            style: TextStyle(fontSize: 11, color: _color2))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        _globalWidget.createRatingBar(
                            rating: widget.PickupData.rating, size: 12),
                        Text('(' + widget.PickupData.review.toString() + ')',
                            style: TextStyle(fontSize: 11, color: _color2))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(widget.PickupData.sale.toString() + ' Sale',
                        style: TextStyle(fontSize: 11, color: _color2)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
