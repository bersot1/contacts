import 'package:dio/dio.dart';

class AddressRepository {
  String url = "";
  Future<dynamic> searchAdress(adress) async {
    Response response = await Dio().get(url + adress);

    String addressLine1 =
        response.data["results"][0]["address_components"][0]["long_name"];

    String addressLine2 = response.data["results"][0]["formatted_address"];

    return {'addressLine1': addressLine1, 'addressLine2': addressLine2};
  }
}
