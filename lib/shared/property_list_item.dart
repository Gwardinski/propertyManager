import 'package:flutter/material.dart';
import 'package:property_manager/models/property_model.dart';
import 'package:property_manager/pages/property/property_message_page.dart';
import 'package:property_manager/services/authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class PropertyListItem extends StatelessWidget {
  PropertyListItem({
    @required this.propertyModel,
    this.isFavourited = false,
    this.showMessage = false,
  });

  final PropertyModel propertyModel;
  final bool isFavourited;
  final bool showMessage;

  _navigateToPropertyDetailsPage(context) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 1),
        content: Text("Navigate to property details page"),
      ),
    );
  }

  _messageProperty(context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PropertyMessagePage(
          propertyModel: propertyModel,
        ),
      ),
    );
  }

  _updateFavourites(context) async {
    // todo display prompt when not logged in
    AuthenticationService authenticationService = Provider.of(context);
    await authenticationService.addRemoveProperty(propertyModel.id);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _navigateToPropertyDetailsPage(context);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(8, 8, 0, 8),
        height: 140,
        child: Row(
          children: [
            Container(
              height: 120,
              width: 120,
              child: FadeInImage.memoryNetwork(
                fit: BoxFit.cover,
                placeholder: kTransparentImage,
                image: propertyModel.imageUrl,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Text(
                        propertyModel.title,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Text(
                        propertyModel.address,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Text(
                          propertyModel.description,
                          maxLines: 3,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            showMessage
                ? ListItemMessageButton(
                    onTap: () {
                      _messageProperty(context);
                    },
                  )
                : ListItemHeartButton(
                    isFavourited: isFavourited,
                    onTap: () {
                      _updateFavourites(context);
                    },
                  )
          ],
        ),
      ),
    );
  }
}

class ListItemHeartButton extends StatelessWidget {
  const ListItemHeartButton({
    Key key,
    @required this.onTap,
    @required this.isFavourited,
  }) : super(key: key);

  final Function onTap;
  final bool isFavourited;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      child: MaterialButton(
        height: 64,
        onPressed: onTap,
        child: Icon(
          isFavourited ? Icons.favorite : Icons.favorite_outline,
          size: 32,
        ),
      ),
    );
  }
}

class ListItemMessageButton extends StatelessWidget {
  const ListItemMessageButton({
    Key key,
    @required this.onTap,
  }) : super(key: key);

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      child: MaterialButton(
        height: 64,
        onPressed: onTap,
        child: Icon(
          Icons.chat,
          size: 32,
        ),
      ),
    );
  }
}
