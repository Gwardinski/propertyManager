import 'package:flutter/material.dart';
import 'package:property_manager/models/property_model.dart';
import 'package:property_manager/models/user_model.dart';
import 'package:property_manager/services/property_collection_service.dart';
import 'package:property_manager/shared/property_list_item.dart';
import 'package:provider/provider.dart';

class PropertiesShortList extends StatelessWidget {
  final UserModel userModel;

  PropertiesShortList({
    @required this.userModel,
  });

  Widget build(BuildContext context) {
    PropertyCollectionService propertyCollectionService = Provider.of(context);
    return Container(
      child: StreamBuilder(
        stream: propertyCollectionService.getPropertiesByIds(
          ids: userModel.savedProperties ?? [],
        ),
        builder: (BuildContext context, AsyncSnapshot<List<PropertyModel>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text("You have not saved any properties yet"),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("An error has occured"),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data.length ?? 0,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int i) {
              PropertyModel propertyModel = snapshot.data[i];
              return PropertyListItem(
                propertyModel: propertyModel,
                showMessage: true,
              );
            },
          );
        },
      ),
    );
  }
}
