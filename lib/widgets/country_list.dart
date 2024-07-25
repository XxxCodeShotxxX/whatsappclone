import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsappclone/controllers/register_controller.dart';
import 'package:whatsappclone/models/servermodel/country_model.dart';

class CountryList extends StatelessWidget {
  const CountryList({super.key});
  static RegisterController registerController = Get.put(RegisterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Choose your country",
          style: TextStyle(
              // fontSize: 18,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.separated(
        itemCount: RegisterController.countryModel.data.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          Datum data = RegisterController.countryModel.data[index];
          return SizedBox(
            width: Get.width,
            child: ListTile(
              onTap: ()=>registerController.changeCountry(data),
              minLeadingWidth: 0.0,
              dense: true,
              leading: Text(data.flag),
              title: Text(data.name),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(data.dialCode),
                  data.name == registerController.selectedCountry.value.name
                      ? Icon(
                          Icons.check,
                          color: Theme.of(context).colorScheme.secondary,
                        )
                      : const SizedBox(
                          width: 24,
                        )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
