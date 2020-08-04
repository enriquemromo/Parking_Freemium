import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkingfreemium/api/parking_api.dart';
import 'package:parkingfreemium/model/parking.dart';

import '../theme.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mis estacionamientos'),
        ),
        body: Center(
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20.0),
              FutureBuilder<List<Parking>>(
                future: ParkingApi.getParkingList(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return drawView(snapshot.data);
                  } else if (!snapshot.hasData) {
                    return Text(
                      'Sin estacionamientos',
                      style: TextStyle(
                          fontSize: 35.0,
                          color: kTextColor,
                          fontWeight: FontWeight.bold),
                    );
                  } else if (snapshot.hasError) {
                    return Text('error');
                  }
                  return Center(
                    child: Container(child: CircularProgressIndicator()),
                  );
                },
              ),
            ],
          )),
        ));
  }

  Expanded drawView(List<Parking> parkingList) {
    return Expanded(
      child: GridView.builder(
        itemCount: parkingList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 0.85,
        ),
        itemBuilder: (BuildContext context, int index) {
          final parking = parkingList[index];
          return Card(
            elevation: 0.0,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  style: BorderStyle.solid,
                  width: 1.0,
                  color: kPrimaryLightColor,
                ),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  /*Image.asset(
                    //category.imageUrl,
                    fit: BoxFit.cover,
                  ),*/
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      parking.name,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "(${parking.adress})",
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
