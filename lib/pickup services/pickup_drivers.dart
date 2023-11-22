import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fyp/Api/DriverApi.dart';
import 'package:fyp/config/constant.dart';
import 'package:fyp/model/Drivers.dart';
import 'package:fyp/pickup services/drivers_profile.dart';
import 'package:fyp/ui/reusable/cache_image_network.dart';
import 'package:fyp/ui/reusable/global_function.dart';
import 'package:fyp/ui/reusable/global_widget.dart';
import 'package:fyp/model/feature/product_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DriverContact extends StatefulWidget {
  final String? vehicle;
  const DriverContact({Key? key, this.vehicle}) : super(key: key);

  @override
  State<DriverContact> createState() => _DriverContactState();
}

class _DriverContactState extends State<DriverContact> {
  Driver? driver;
  List<Drivers>? mydata;
  String? city;
  DriverApi driverApi = new DriverApi();

  Future<void> newvalues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      city = prefs.getString('city');
    });
    print("object city $city");

    // After retrieving the city, call fetchAds
    await fetchAds();
  }

  Future<void> fetchAds() async {
    if (city != null) {
      final data = await driverApi.fetchdrivers(widget.vehicle, city);

      if (data != null) {
        setState(() {
          driver = data;
          mydata = data.drivers;
        });
      }
    } else {
      // Handle the case where city is null, e.g., display an error message or take appropriate action.
    }
  }

  final _globalFunction = GlobalFunction();
  final _globalWidget = GlobalWidget();
  bool _loading = true;
  Timer? _timerDummy;
  Color _color = Color(0xFF515151);
  List<ProductModel> _productData = [];

  @override
  void initState() {
    super.initState();
    newvalues();
    _getData();
    print("object ${widget.vehicle}");
  }

  @override
  void dispose() {
    _timerDummy?.cancel();
    super.dispose();
  }

  void _getData() {
    // this timer function is just for demo, so after 2 second, the shimmer loading will disappear and show the content
    _timerDummy = Timer(Duration(seconds: 2), () {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double boxImageSize = (MediaQuery.of(context).size.width / 4);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Driver',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).size.width * 0.06,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: mydata?.length ?? 0,
          padding: EdgeInsets.symmetric(vertical: 0),
          physics: AlwaysScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return _buildItem(index, boxImageSize);
          },
        ),
      ),
    );
  }

  Widget _buildItem(index, boxImageSize) {
    final drive = mydata![index];
    final image = drive.driverImage;
    final name = drive.name;
    final address = drive.address;
    final phone = drive.phoneNumber;

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ContactUs2Page(
                      image: image,
                      name: name,
                      address: address,
                      phone: phone)),
            );
          },
          child: Container(
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
                          url: drive.driverImage != null
                              ? 'http://10.0.2.2:8000${drive.driverImage}'
                              : '')),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          drive.name != null ? drive.name.toString() : '',
                          style: TextStyle(fontSize: 13, color: _color),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Text('\TruckNo ' + drive.carNumber.toString(),
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              Icon(Icons.location_on,
                                  color: SOFT_GREY, size: 12),
                              Text(
                                  drive.name != null
                                      ? ' ' + drive.address.toString()
                                      : '',
                                  style:
                                      TextStyle(fontSize: 11, color: SOFT_GREY))
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Text(
                              drive.name != null
                                  ? ' Rs :' +
                                      drive.price.toString() +
                                      ' ' +
                                      '/ KM'
                                  : '',
                              style: TextStyle(fontSize: 11, color: SOFT_GREY)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        (index == mydata!.length - 1)
            ? Wrap()
            : Divider(
                height: 0,
                color: Colors.grey[400],
              )
      ],
    );
  }
}
