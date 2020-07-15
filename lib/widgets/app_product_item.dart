import 'package:flutter/material.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/widgets/widget.dart';
import 'package:shimmer/shimmer.dart';

enum ProductViewType { small, gird, list, block, cardLarge, cardSmall }

class AppProductItem extends StatelessWidget {
  AppProductItem({
    Key key,
    this.item,
    this.onPressed,
    this.type,
  }) : super(key: key);

  final ProductModel item;
  final ProductViewType type;
  final Function(ProductModel) onPressed;

  @override
  Widget build(BuildContext context) {
    switch (type) {

      ///Mode View Small
      case ProductViewType.small:
        if (item == null) {
          return Shimmer.fromColors(
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 80,
                    height: 80,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 5,
                    bottom: 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 10,
                        width: 200,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                      ),
                      Container(
                        height: 10,
                        width: 150,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      Container(
                        height: 10,
                        width: 100,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            baseColor: Theme.of(context).hoverColor,
            highlightColor: Theme.of(context).highlightColor,
          );
        }

        return FlatButton(
          onPressed: () {
            onPressed(item);
          },
          padding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: item.image.startsWith("http")
                    ? Image.network(
                        item.image.toString(),
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/images/ic_placeholder.png',
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 5,
                  bottom: 5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.title.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    Text(
                      item.subtitle.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
//                    Row(
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      children: <Widget>[
//                        AppTag(
//                          "${item.rate}",
//                          type: TagType.rateSmall,
//                        ),
//                        Padding(padding: EdgeInsets.only(left: 5)),
//                        StarRating(
//                          rating: item.rate.toDouble(),
//                          size: 14,
//                          color: AppTheme.yellowColor,
//                          borderColor: AppTheme.yellowColor,
//                        )
//                      ],
//                    )
                  ],
                ),
              )
            ],
          ),
        );

      ///Mode View Gird
      case ProductViewType.gird:
        if (item == null) {
          return Shimmer.fromColors(
            child: Container(
              child: Wrap(
//                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      color: Colors.white,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 5)),
                  Container(
                    height: 10,
                    width: 80,
                    color: Colors.white,
                  ),
                  Padding(padding: EdgeInsets.only(top: 5)),
                  Container(
                    height: 10,
                    width: 100,
                    color: Colors.white,
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Container(
                    height: 20,
                    width: 100,
                    color: Colors.white,
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Container(
                    height: 10,
                    width: 80,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            baseColor: Theme.of(context).hoverColor,
            highlightColor: Theme.of(context).highlightColor,
          );
        }

        return FlatButton(
          onPressed: () {
            onPressed(item);
          },
          padding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            child: Wrap(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(item.image.toString()),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              item.status != null
                                  ? Padding(
                                      padding: EdgeInsets.all(5),
                                      child: AppTag(
                                        item.status.toString(),
                                        type: TagType.status,
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.end,
//                        children: <Widget>[
//                          Padding(
//                            padding: EdgeInsets.all(5),
//                            child: Icon(
//                              item.favorite
//                                  ? Icons.favorite
//                                  : Icons.favorite_border,
//                              color: Colors.white,
//                            ),
//                          )
//                        ],
//                      )
                        ],
                      ),
                    ),

                    Padding(padding: EdgeInsets.only(top: 3)),

                    Text(
                      item.subtitle.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    Text(
                      item.title.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
//                Row(
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  children: <Widget>[
//                    AppTag(
//                      "${item.rate}",
//                      type: TagType.rateSmall,
//                    ),
//                    Padding(padding: EdgeInsets.only(left: 5)),
//                    StarRating(
//                      rating: item.rate.toDouble(),
//                      size: 14,
//                      color: AppTheme.yellowColor,
//                      borderColor: AppTheme.yellowColor,
//                    )
//                  ],
//                ),
                    Padding(padding: EdgeInsets.only(top: 3.0)),
                    Text(
                      item.address.toString(),
                      maxLines: 1,
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
              ],
            ),
          ),
        );

      ///Mode View List
      case ProductViewType.list:
        if (item == null) {
          return Shimmer.fromColors(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 120,
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                      left: 10,
                      right: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 10,
                          width: 80,
                          color: Colors.white,
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Container(
                          height: 10,
                          width: 100,
                          color: Colors.white,
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Container(
                          height: 20,
                          width: 80,
                          color: Colors.white,
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Container(
                          height: 10,
                          width: 100,
                          color: Colors.white,
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Container(
                          height: 10,
                          width: 80,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                width: 18,
                                height: 18,
                                color: Colors.white,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            baseColor: Theme.of(context).hoverColor,
            highlightColor: Theme.of(context).highlightColor,
          );
        }

        return FlatButton(
          onPressed: () {
            onPressed(item);
          },
          padding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 120,
                height: 140,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(item.image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    item.status != null
                        ? Padding(
                            padding: EdgeInsets.all(5),
                            child: AppTag(
                              item.status.toString(),
                              type: TagType.status,
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item.subtitle.toString(),
                        style: Theme.of(context).textTheme.caption.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 5)),
                      Text(
                        item.title.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      Padding(padding: EdgeInsets.only(top: 5)),
//                      Row(
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        children: <Widget>[
//                          AppTag(
//                            "${item.rate}",
//                            type: TagType.rateSmall,
//                          ),
//                          Padding(padding: EdgeInsets.only(left: 5)),
//                          StarRating(
//                            rating: item.rate.toDouble(),
//                            size: 14,
//                            color: AppTheme.yellowColor,
//                            borderColor: AppTheme.yellowColor,
//                          )
//                        ],
//                      ),
                      Padding(padding: EdgeInsets.only(top: 5)),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 3),
                            child: Icon(
                              Icons.location_on,
                              size: 12,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Expanded(
                            child: Text(item.address.toString(),
                                maxLines: 1,
                                style: Theme.of(context).textTheme.caption),
                          )
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 5)),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 3),
                            child: Icon(
                              Icons.phone,
                              size: 12,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Expanded(
                            child: Text(item.phone.toString(),
                                maxLines: 1,
                                style: Theme.of(context).textTheme.caption),
                          )
                        ],
                      ),
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.end,
//                        children: <Widget>[
//                          Icon(
//                            item.favorite
//                                ? Icons.favorite
//                                : Icons.favorite_border,
//                            color: Theme.of(context).primaryColor,
//                          )
//                        ],
//                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );

      ///Mode View Block
      case ProductViewType.block:
        if (item == null) {
          return Shimmer.fromColors(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 200,
                  color: Colors.white,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 10,
                        width: 150,
                        color: Colors.white,
                      ),
                      Padding(padding: EdgeInsets.only(top: 5)),
                      Container(
                        height: 10,
                        width: 200,
                        color: Colors.white,
                      ),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Container(
                        height: 10,
                        width: 150,
                        color: Colors.white,
                      ),
                      Padding(padding: EdgeInsets.only(top: 5)),
                      Container(
                        height: 10,
                        width: 150,
                        color: Colors.white,
                      ),
                    ],
                  ),
                )
              ],
            ),
            baseColor: Theme.of(context).hoverColor,
            highlightColor: Theme.of(context).highlightColor,
          );
        }

        return FlatButton(
          onPressed: () {
            onPressed(item);
          },
          padding: EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(item.image.toString()),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          item.status != null
                              ? AppTag(
                                  item.status.toString(),
                                  type: TagType.status,
                                )
                              : Container(),
//                          Icon(
//                            item.favorite
//                                ? Icons.favorite
//                                : Icons.favorite_border,
//                            color: Colors.white,
//                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
//                              Row(
//                                children: <Widget>[
//                                  AppTag(
//                                    "${item.rate}",
//                                    type: TagType.rateSmall,
//                                  ),
//                                  Padding(
//                                    padding: EdgeInsets.only(left: 5),
//                                    child: Column(
//                                      crossAxisAlignment:
//                                          CrossAxisAlignment.start,
//                                      children: <Widget>[
//                                        Padding(
//                                          padding: EdgeInsets.only(left: 3),
//                                          child: Text(
//                                            item.rateText.toString(),
//                                            style: Theme.of(context)
//                                                .textTheme
//                                                .caption
//                                                .copyWith(
//                                                  color: Colors.white,
//                                                  fontWeight: FontWeight.w600,
//                                                ),
//                                          ),
//                                        ),
//                                        StarRating(
//                                          rating: item.rate.toDouble(),
//                                          size: 14,
//                                          color: AppTheme.yellowColor,
//                                          borderColor: AppTheme.yellowColor,
//                                        )
//                                      ],
//                                    ),
//                                  )
//                                ],
//                              ),
//                              Padding(
//                                padding: EdgeInsets.only(top: 3),
//                                child: Text(
//                                  "${item.numRate} reviews",
//                                  style: Theme.of(context)
//                                      .textTheme
//                                      .caption
//                                      .copyWith(
//                                        color: Colors.white,
//                                        fontWeight: FontWeight.w600,
//                                      ),
//                                ),
//                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.subtitle.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    Text(
                      item.title.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          size: 12,
                          color: Theme.of(context).primaryColor,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 3, right: 3),
                            child: Text(
                              item.address.toString(),
                              maxLines: 1,
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.phone,
                          size: 12,
                          color: Theme.of(context).primaryColor,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 3, right: 3),
                            child: Text(
                              item.phone.toString(),
                              maxLines: 1,
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        );

      ///Case View Card large
      case ProductViewType.cardLarge:
        if (item == null) {
          return SizedBox(
            width: 135,
            height: 160,
            child: AppCard(type: CardType.basic),
          );
        }

        return SizedBox(
          width: 160,
          height: 160,
          child: AppCard(
            onPressed: () {
              onPressed(item);
            },
            text: item.title.toString(),
            type: CardType.rectangular,
            image: item.image,
          ),
        );

      ///Case View Card small
      case ProductViewType.cardSmall:
        if (item == null) {
          return SizedBox(
            width: 100,
            height: 100,
            child: AppCard(
              type: CardType.basic,
            ),
          );
        }

        return AppCard(
          onPressed: () {
            onPressed(item);
          },
          text: item.title.toString(),
          type: CardType.basic,
          image: item.image.toString(),
        );
      default:
        return Container(
          width: 160.0,
          color: Colors.red,
        );
    }
  }
}
