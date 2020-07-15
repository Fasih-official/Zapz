import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

enum CardType { basic, rectangular }

class AppCard extends StatelessWidget {
  AppCard({
    Key key,
    this.text,
    this.type,
    this.image,
    this.onPressed,
  }) : super(key: key);

  final String text;
  final CardType type;
  final String image;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case CardType.basic:
        if (image == null) {
          return Shimmer.fromColors(
            baseColor: Theme.of(context).hoverColor,
            highlightColor: Theme.of(context).highlightColor,
            enabled: true,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        }

        return GestureDetector(
          onTap: onPressed,
          child: Card(
            elevation: 2,
            margin: EdgeInsets.all(0),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: image.startsWith("http")
                      ? NetworkImage(image)
                      : AssetImage('assets/images/ic_placeholder.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      text,
                      style: Theme.of(context).textTheme.subtitle.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );

      case CardType.rectangular:
        if (image == null) {
          return Shimmer.fromColors(
            baseColor: Theme.of(context).hoverColor,
            highlightColor: Theme.of(context).highlightColor,
            enabled: true,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        }

        return GestureDetector(
          onTap: onPressed,
          child: Card(
            elevation: 2,
            margin: EdgeInsets.all(0),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: image.startsWith("http")
                      ? NetworkImage(image)
                      : AssetImage('assets/images/ic_placeholder.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      text,
                      style: Theme.of(context).textTheme.subtitle.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );

      default:
        return Container(
          width: 160.0,
          color: Colors.red,
        );
    }
  }
}
