import 'package:flutter/material.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:shimmer/shimmer.dart';

class AppMessageItem extends StatelessWidget {
  final MessageModel item;
  final VoidCallback onPressed;
  final bool border;

  AppMessageItem({
    Key key,
    this.item,
    this.onPressed,
    this.border = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (item == null) {
      return Shimmer.fromColors(
        child: Container(
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 48,
                height: 48,
                color: Colors.white,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            height: 10,
                            width: 150,
                            color: Colors.white,
                          ),
                          Container(
                            height: 10,
                            width: 50,
                            color: Colors.white,
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                      ),
                      Container(
                        height: 10,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        baseColor: Theme.of(context).hoverColor,
        highlightColor: Theme.of(context).highlightColor,
      );
    }

    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
        decoration: BoxDecoration(
          border: border
              ? Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Theme.of(context).dividerColor,
                  ),
                )
              : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 48,
              height: 48,
              child: Image.asset(
                item.from.image,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            item.from.name,
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                        Text(
                          item.date,
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 3),
                    ),
                    Text(
                      item.message,
                      maxLines: 1,
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
