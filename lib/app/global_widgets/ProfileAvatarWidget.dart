import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:waiter/app/data/models/user_db.dart';

class ProfileAvatarWidget extends StatelessWidget {
  final Userdb userdb;

  ProfileAvatarWidget({
    Key key,
    this.userdb,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: 160,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
              SizedBox(
                width: 50,
                height: 50,
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {},
                  child: Icon(Icons.add, color: Theme.of(context).primaryColor),
                  color: Theme.of(context).accentColor,
                  shape: StadiumBorder(),
                ),
              ),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(300)),
                  child: CachedNetworkImage(
                    height: 135,
                    width: 135,
                    fit: BoxFit.cover,
                    imageUrl: userdb.image.url,
                    placeholder: (context, url) => Image.asset(
                      'assets/img/loading.gif',
                      fit: BoxFit.cover,
                      height: 135,
                      width: 135,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
//              SizedBox(
//                width: 50,
//                height: 50,
//                child: FlatButton(
//                  padding: EdgeInsets.all(0),
//                  onPressed: () {},
//                  child: Icon(Icons.chat, color: Theme.of(context).primaryColor),
//                  color: Theme.of(context).accentColor,
//                  shape: StadiumBorder(),
//                ),
//              ),
              ],
            ),
          ),
          Text(
            userdb?.user_name,
            style: Theme.of(context).textTheme.headline.merge(TextStyle(color: Theme.of(context).primaryColor)),
          ),
//          Text(
//            user?.shipping_address_1,
//            style: Theme.of(context).textTheme.caption.merge(TextStyle(color: Theme.of(context).primaryColor)),
//          ),
        ],
      ),
    );
  }
}
