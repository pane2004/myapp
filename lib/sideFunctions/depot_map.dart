import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // ignore: prefer_final_fields
  Completer<GoogleMapController> _controller = Completer();

  Iterable markers = [];

  // ignore: prefer_final_fields
  Iterable _markers = Iterable.generate(AppConstant.list.length, (index) {
    return Marker(
        markerId: MarkerId(AppConstant.list[index]['id']),
        position: LatLng(
          AppConstant.list[index]['lat'],
          AppConstant.list[index]['lon'],
        ),
        infoWindow: InfoWindow(
            title: AppConstant.list[index]["title"],
            snippet: AppConstant.list[index]["snippet"]));
  });

  @override
  void initState() {
    setState(() {
      markers = _markers;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Local Waste Depots"),
          backgroundColor: const Color(0xFF84C879),
          shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50))),
        ),
        body: GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: Set.from(markers),
          initialCameraPosition: const CameraPosition(
            target: LatLng(43.592337920450426, -79.61564521970341),
            zoom: 10,
          ),
        ));
  }
}

class AppConstant {
  static List<Map<String, dynamic>> list = [
    {
      "title": "WM Mississauga Transfer Station",
      "snippet": "6465 Danville Rd, Mississauga, ON L5T 2H7",
      "id": "1",
      "lat": 43.6553242463149,
      "lon": -79.68118478254947,
    },
    {
      "title": "Disposal Bins Mississauga",
      "snippet": "1270 Central Pkwy W #404, Mississauga, ON L5C 4P4",
      "id": "2",
      "lat": 43.581256635270016,
      "lon": -79.66813851813716,
    },
    {
      "title": "Call Disposal Services Ltd",
      "snippet": "190 Bovaird Dr W, Brampton, ON L7A 1A2",
      "id": "3",
      "lat": 43.70498288451847,
      "lon": -79.79173470730636
    },
    {
      "title": "Walker Waste & Recycling Drop-off",
      "snippet": "5030 Mainway, Burlington, ON L7L 5Z1",
      "id": "4",
      "lat": 43.38895249350822,
      "lon": -79.7793750883646
    },
    {
      "title": "AG Disposal Services Inc",
      "snippet": "740 Weller Ct, Oakville, ON L6K 3S9",
      "id": "5",
      "lat": 43.441822373575995,
      "lon": -79.69972421090003
    },
    {
      "title": "Halton Waste Management Site",
      "snippet": "5400 Regional Rd 25, Milton, ON L9E 0L2",
      "id": "6",
      "lat": 43.47693679264958,
      "lon": -79.82373223320872
    },
    {
      "title": "Tech Reset Electronic Recycling",
      "snippet": "2301 Royal Windsor Dr Unit # 2, Mississauga, ON L5J 1K5",
      "id": "7",
      "lat": 43.5059772432798,
      "lon": -79.63681031810616
    },
    {
      "title": "Roadrunner Bins Inc.",
      "snippet": "100 Emby Dr, Mississauga, ON L5M 1H6",
      "id": "8",
      "lat": 43.578893919269774,
      "lon": -79.71491624285193
    },
    {
      "title": "WM Wentworth Transfer Station",
      "snippet": "117 Wentworth Ct, Brampton, ON L6T 5L4",
      "id": "9",
      "lat": 43.744308163762604,
      "lon": -79.66397572841385
    },
    {
      "title": "SHORNCLIFFE DISPOSAL SERVICES",
      "snippet": "51 Shorncliffe Rd, Etobicoke, ON M8Z 5K2",
      "id": "10",
      "lat": 43.628988504649456,
      "lon": -79.54213906683528
    },
    {
      "title": "Toronto Household Hazardous Waste Drop-off Depot",
      "snippet": "50 Ingram Dr, North York, ON M6M 2L6",
      "id": "11",
      "lat": 43.70129481679347,
      "lon": -79.47144140281334
    },
    {
      "title": "GIC Medical Disposal",
      "snippet": "250 University Avenue, 2nd Floor, Toronto, ON M5H 3E5",
      "id": "12",
      "lat": 43.650181453627965,
      "lon": -79.38857187345802
    },
    {
      "title": "WM Wentworth Transfer Station",
      "snippet": "20 Esandar Dr, Toronto, ON M4G 1Y2",
      "id": "13",
      "lat": 43.70641384044831,
      "lon": -79.3582307264573
    },
    {
      "title": "Commissioners Street Transfer Station",
      "snippet": "400 Commissioners St, Toronto, ON M4M 3K2",
      "id": "14",
      "lat": 43.651734040547794,
      "lon": -79.33925141578226
    },
    {
      "title": "Bin There Dump That Toronto",
      "snippet": "56 The Esplanade, Toronto, ON M5E 1A6",
      "id": "15",
      "lat": 43.64726248044176,
      "lon": -79.37422742209225
    },
    {
      "title": "Bermondsey Transfer Station",
      "snippet": "188 Bermondsey Rd, North York, ON M4A 1Y1",
      "id": "16",
      "lat": 43.72078355240848,
      "lon": -79.32011117245861
    },
    {
      "title": "Scarborough Disposal",
      "snippet": "63 Raleigh Ave, Scarborough, ON M1K 1A1",
      "id": "17",
      "lat": 43.703582856330044,
      "lon": -79.26467514742986
    },
    {
      "title": "Waste Connections of Canada - Toronto",
      "snippet": "650 Creditstone Rd, Concord, ON L4K 5C8",
      "id": "18",
      "lat": 43.80439746693767,
      "lon": -79.52025747838844
    },
    {
      "title": "Thornhill Recycling Depot",
      "snippet": "5 Green Ln, Thornhill, ON L3T 7P7",
      "id": "19",
      "lat": 43.82127499043211,
      "lon": -79.40069533121884
    },
    {
      "title": "Victoria Park Transfer Station",
      "snippet": "3350 Victoria Park Ave, North York, ON M2H 2E1",
      "id": "20",
      "lat": 43.80353023638217,
      "lon": -79.33752394528311
    },
    {
      "title": "Earl Turcott Waste Management Facility",
      "snippet": "300 Rodick Rd, Markham, ON L6G 1E2",
      "id": "21",
      "lat": 43.83461879171274,
      "lon": -79.34833861183542
    },
    {
      "title": "Markham Household Hazardous Waste Depot",
      "snippet": "403 Rodick Rd #383, Markham, ON L6G 1B2",
      "id": "22",
      "lat": 43.83725004768767,
      "lon": -79.34518433409096
    },
  ];
}
