import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:order/controllers/location_controller.dart';
import 'package:order/routes/route_helper.dart';
import 'package:order/utils/Dimensions.dart';
import 'package:order/utils/colors.dart';
import 'package:order/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/user_controller.dart';
import '../../widgets/app_text_field.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final String apiKey = "LC4sOMtAkqOQd0Fus94wZZmNWMwpQi1q";

  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;
  CameraPosition _cameraPosition =
      CameraPosition(target: LatLng(45.51563, -122.677433), zoom: 17);
  late LatLng _initialPosition = LatLng(45.51563, -122.677433);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _isLogged = Get.find<AuthController>().userLoggedIn();
    if (_isLogged && Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInfo();
    }
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      _cameraPosition = CameraPosition(
          target: LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["langitude"]),
      ));
      _initialPosition = LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["langitude"]),
      );
    }
  }

  String address = '';

  @override
  Widget build(BuildContext context) {
    final Map<String, String> pickedDatas = {
      'Number 1': address,
      // 'Number 2': 2,
      // 'Number 3': 3,
    };
    const tomtomHQ = LatLng(52.376372, 4.908066);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Address page"),
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<LocationController>(builder: (locationController) {
        _addressController.text = '${locationController.placemark.name ?? ''}'
            '${locationController.placemark.locality ?? ''}'
            '${locationController.placemark.postalCode ?? ''}'
            '${locationController.placemark.country ?? ''}';
        print("address in my view is " + _addressController.text);
        return Column(
          children: [
            Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    width: 2,
                    color: Theme.of(context).primaryColor,
                  )),
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    SizedBox(
                      height: 200,
                      child: Center(
                        child: Text(address),
                      ),
                    ),
                    SizedBox(
                      height: 500,

                      //
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepOrange,
                      ),
                      child: Text('Submit To Next Screen'),
                      onPressed: () async {},
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            BigText(text: "Delivery Address"),
            SizedBox(
              height: Dimensions.height20,
            ),
            AppTextField(
              textController: _addressController,
              hintText: "Your address",
              icon: Icons.map,
            )
          ],
        );
      }),
    );
  }
}

class pickedData {
  late String address;

  // late final String description;

  // const Todo(this.title, this.description);
  pickedData(this.address);
}
