import 'dart:async';

import 'package:flutter/material.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetail extends StatefulWidget {
  Map<String,dynamic> map;

  ProductDetail(this.map, {Key key}) : super(key: key);

  @override
  _ProductDetailState createState() {
    return _ProductDetailState();
  }
}

class _ProductDetailState extends State<ProductDetail> {
  bool _like = false;
  bool _showHour = false;
  ProductModel _detailPage;

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  ///Fetch API
  Future<void> _loadData() async {
    final ProductModel result = await Api.getProductInfo(widget.map['id'], widget.map['node_name']);
    if (result != null) {
      setState(() {
        _detailPage = result;
        _like = _detailPage?.favorite;
      });
    }
  }

  ///On navigate gallery
  void _onPhotoPreview() {
    Navigator.pushNamed(
      context,
      Routes.gallery,
      arguments: _detailPage?.photo,
    );
  }

  ///On navigate map
  void _onLocation() {
    Navigator.pushNamed(
      context,
      Routes.location,
      arguments: _detailPage,
    );
  }

  ///On navigate product detail
  void _onProductDetail(ProductModel item) {
    String route = item.type == ProductType.place
        ? Routes.productDetail
        : Routes.productDetailTab;
    Navigator.pushNamed(context, route);
  }

  ///On navigate review
  void _onReview() {
    Navigator.pushNamed(context, Routes.review);
  }

  ///On like product
  void _onLike() {
    setState(() {
      _like = !_like;
    });
  }

  ///Build banner UI
  Widget _buildBanner() {
    if (_detailPage?.image == null) {
      return Shimmer.fromColors(
        baseColor: Theme.of(context).hoverColor,
        highlightColor: Theme.of(context).highlightColor,
        enabled: true,
        child: Container(
          color: Colors.white,
        ),
      );
    }

    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: <Widget>[
        Image.network(
          _detailPage?.image,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        )
      ],
    );

//    return

//    return
  }

  ///Build info
  Widget _buildInfo() {
    if (_detailPage == null) {
      return Shimmer.fromColors(
        baseColor: Theme.of(context).hoverColor,
        highlightColor: Theme.of(context).highlightColor,
        enabled: true,
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  bottom: 20,
                  top: 20,
                ),
                height: 10,
                width: 150,
                color: Colors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 10,
                        width: 100,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                      ),
                      Container(
                        height: 20,
                        width: 150,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Container(
                    height: 10,
                    width: 100,
                    color: Colors.white,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 10,
                          width: 100,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 3),
                        ),
                        Container(
                          height: 10,
                          width: 200,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 10,
                          width: 100,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 3),
                        ),
                        Container(
                          height: 10,
                          width: 200,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 10,
                          width: 100,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 3),
                        ),
                        Container(
                          height: 10,
                          width: 200,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 10,
                          width: 100,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 3),
                        ),
                        Container(
                          height: 10,
                          width: 200,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 10,
                          width: 100,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 3),
                        ),
                        Container(
                          height: 10,
                          width: 200,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 25),
                child: Container(height: 10, color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Container(height: 10, color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Container(height: 10, color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Container(height: 10, color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Container(height: 10, color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Container(height: 10, color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Container(height: 10, width: 50, color: Colors.white),
              )
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                _detailPage?.title.toString(),
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(fontWeight: FontWeight.w600),
              ),
//              IconButton(
//                icon: Icon(
//                  _like ? Icons.favorite : Icons.favorite_border,
//                  color: Theme.of(context).primaryColorLight,
//                ),
//                onPressed: _onLike,
//              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: InkWell(
                  child: Wrap(
                    direction: Axis.vertical,
                    children: <Widget>[
                      Text(
                        _detailPage?.subtitle.toString(),
                        style: Theme.of(context).textTheme.body2,
                      ),
//                      Padding(
//                        padding: EdgeInsets.only(top: 10),
//                      ),

//                    Row(
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      children: <Widget>[
//                        AppTag(
//                          "${_detailPage?.rate}",
//                          type: TagType.rateSmall,
//                        ),
//                        Padding(padding: EdgeInsets.only(left: 5)),
//                        StarRating(
//                          rating: _detailPage?.rate.toDouble(),
//                          size: 14,
//                          color: AppTheme.yellowColor,
//                          borderColor: AppTheme.yellowColor,
//                          onRatingChanged: (v) {
//                            _onReview();
//                          },
//                        ),
//                        Padding(padding: EdgeInsets.only(left: 5)),
//                        Text(
//                          "(${_detailPage?.numRate})",
//                          style: Theme.of(context).textTheme.body2,
//                        ),
//                      ],
//                    )
                    ],
                  ),
                ),
                fit: FlexFit.tight,
              ),
              IconButton(
                icon: Icon(
                  Icons.map,
                  color: Theme.of(context).primaryColorLight,
                ),
                onPressed: _onLocation,
              ),
//              Flexible(child: AppTag(
//                "${_detailPage?.status}",
//                type: TagType.status,
//              ),
//                flex: 1,),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          _detailPage.offer_one.isNotEmpty ? _buildOfferOne() : Container(),
          SizedBox(
            height: 10.0,
          ),
          _detailPage.offer_two.isNotEmpty ? _buildOfferTwo() : Container(),
          SizedBox(
            height: 10.0,
          ),
          _detailPage?.video_link == null
              ? Container()
              : _detailPage.video_link.isNotEmpty
                  ? _buildVideoOffer()
                  : Container(),
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          InkWell(
            onTap: () {},
            child: Row(
              children: <Widget>[
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).dividerColor,
                  ),
                  child: Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        Translate.of(context).translate('address'),
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        _detailPage?.address.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .body2
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          InkWell(
            onTap: () {},
            child: Row(
              children: <Widget>[
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).dividerColor,
                  ),
                  child: Icon(
                    Icons.phone,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        Translate.of(context).translate('phone'),
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        _detailPage?.phone.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .body2
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
//          Padding(
//            padding: EdgeInsets.only(top: 20),
//          ),
//          InkWell(
//            onTap: () {},
//            child: Row(
//              children: <Widget>[
//                Container(
//                  width: 32,
//                  height: 32,
//                  decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Theme.of(context).dividerColor),
//                  child: Icon(
//                    Icons.email,
//                    color: Colors.white,
//                    size: 18,
//                  ),
//                ),
//                Padding(
//                  padding: EdgeInsets.only(left: 10, right: 10),
//                  child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//                      Text(
//                        Translate.of(context).translate('email'),
//                        style: Theme.of(context).textTheme.caption,
//                      ),
//                      Text(
//                        _detailPage?.email.toString(),
//                        style: Theme.of(context)
//                            .textTheme
//                            .body2
//                            .copyWith(fontWeight: FontWeight.w600),
//                      ),
//                    ],
//                  ),
//                )
//              ],
//            ),
//          ),
//          Padding(
//            padding: EdgeInsets.only(top: 20),
//          ),
//          InkWell(
//            onTap: () {},
//            child: Row(
//              children: <Widget>[
//                Container(
//                  width: 32,
//                  height: 32,
//                  decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Theme.of(context).dividerColor),
//                  child: Icon(
//                    Icons.language,
//                    color: Colors.white,
//                    size: 18,
//                  ),
//                ),
//                Padding(
//                  padding: EdgeInsets.only(left: 10, right: 10),
//                  child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//                      Text(
//                        Translate.of(context).translate('website'),
//                        style: Theme.of(context).textTheme.caption,
//                      ),
//                      Text(
//                        _detailPage?.website.toString(),
//                        style: Theme.of(context)
//                            .textTheme
//                            .body2
//                            .copyWith(fontWeight: FontWeight.w600),
//                      ),
//                    ],
//                  ),
//                )
//              ],
//            ),
//          ),
//          Padding(
//            padding: EdgeInsets.only(top: 20),
//          ),
//          InkWell(
//            onTap: () {
//              setState(() {
//                _showHour = !_showHour;
//              });
//            },
//            child: Row(
//              children: <Widget>[
//                Expanded(
//                  child: Row(
//                    children: <Widget>[
//                      Container(
//                        width: 32,
//                        height: 32,
//                        decoration: BoxDecoration(
//                          shape: BoxShape.circle,
//                          color: Theme.of(context).dividerColor,
//                        ),
//                        child: Icon(
//                          Icons.access_time,
//                          color: Colors.white,
//                          size: 18,
//                        ),
//                      ),
//                      Padding(
//                        padding: EdgeInsets.only(left: 10, right: 10),
//                        child: Column(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: <Widget>[
//                            Text(
//                              Translate.of(context).translate('open_time'),
//                              style: Theme.of(context).textTheme.caption,
//                            ),
//                            Text(
//                              _detailPage?.hour.toString(),
//                              style: Theme.of(context)
//                                  .textTheme
//                                  .body2
//                                  .copyWith(fontWeight: FontWeight.w600),
//                            ),
//                          ],
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//                Icon(
//                  _showHour
//                      ? Icons.keyboard_arrow_up
//                      : Icons.keyboard_arrow_down,
//                )
//              ],
//            ),
//          ),
//          Visibility(
//            visible: _showHour,
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: _detailPage.hourDetail.map((item) {
//                return Container(
//                  decoration: BoxDecoration(
//                    border: Border(
//                      bottom: BorderSide(
//                        color: Theme.of(context).dividerColor,
//                        width: 1,
//                      ),
//                    ),
//                  ),
//                  margin: EdgeInsets.only(
//                    left: 42,
//                  ),
//                  padding: EdgeInsets.only(
//                    top: 10,
//                    bottom: 10,
//                  ),
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: <Widget>[
//                      Text(
//                        Translate.of(context).translate(item.title),
//                        style: Theme.of(context).textTheme.caption,
//                      ),
//                      Text(
//                        item.title == 'day_off'
//                            ? Translate.of(context).translate('day_off')
//                            : item.title,
//                        style: Theme.of(context).textTheme.caption.copyWith(
//                            color: Theme.of(context).accentColor,
//                            fontWeight: FontWeight.w600),
//                      ),
//                    ],
//                  ),
//                );
//              }).toList(),
//            ),
//          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          _detailPage.description.isNotEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
//                    Container(
//                      padding: EdgeInsets.only(left: 5.0, right: 5.0),
//                      child: Text(
//                        'Description',
//                        overflow: TextOverflow.ellipsis,
//                        style: TextStyle(color: Colors.red, fontSize: 14.0),
//                      ),
//                    ),
                    Expanded(
                      child: TextField(
                        readOnly: true,
                        maxLines: 5,
                        controller: TextEditingController(
                            text: _detailPage?.description),
                        decoration: InputDecoration(
                          border: InputBorder.none
                        ),
                      ),
                    )
                  ],
                )
              : Container(),

          SizedBox(
            height: 10.0,
          ),
//          Text(
//            _detailPage?.description.toString(),
//            style: Theme.of(context).textTheme.body2.copyWith(height: 1.3),
//          ),
//          Padding(
//            padding: EdgeInsets.only(top: 20, bottom: 20),
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: <Widget>[
//                Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Text(
//                      Translate.of(context).translate('date_established'),
//                      style: Theme.of(context).textTheme.caption,
//                    ),
//                    Padding(
//                      padding: EdgeInsets.only(top: 3),
//                      child: Text(
//                        _detailPage?.date.toString(),
//                        style: Theme.of(context)
//                            .textTheme
//                            .subtitle
//                            .copyWith(fontWeight: FontWeight.w600),
//                      ),
//                    )
//                  ],
//                ),
////                Column(
////                  crossAxisAlignment: CrossAxisAlignment.end,
////                  children: <Widget>[
////                    Text(
////                      Translate.of(context).translate('price_range'),
////                      style: Theme.of(context).textTheme.caption,
////                    ),
////                    Padding(
////                      padding: EdgeInsets.only(top: 3),
////                      child: Text(
////                        _detailPage?.priceRange.toString(),
////                        style: Theme.of(context)
////                            .textTheme
////                            .subtitle
////                            .copyWith(fontWeight: FontWeight.w600),
////                      ),
////                    )
////                  ],
////                )
//              ],
//            ),
//          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 10, bottom: 20),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Theme.of(context).dividerColor,
                ),
                bottom: BorderSide(
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    Translate.of(context).translate('facilities'),
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: _detailPage.service.split(',').map((item) {
                    return IntrinsicWidth(
                      child: AppTag(
                        item,
                        type: TagType.chip,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfferTwo() {
    return GestureDetector(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
//          Container(
//            padding: EdgeInsets.only(left: 5.0, right: 5.0),
//            child: Text(
//              'Offer two',
//              overflow: TextOverflow.ellipsis,
//              style: TextStyle(color: Colors.red, fontSize: 14.0),
//            ),
//          ),
          Expanded(
            child: TextField(
              readOnly: true,
              onTap: () {
                _openFlyer();
              },
              style: TextStyle(
                color: Colors.red,
              ),
              controller: TextEditingController(text: _detailPage.offer_two_txt),
            ),
          )
        ],
      ),
      onTap: () {
        _openFlyer();
      },
    );
  }

  Widget _buildOfferOne() {
    return GestureDetector(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
//          Container(
//            padding: EdgeInsets.only(left: 5.0, right: 5.0),
//            child: Text(
//              'Offer one',
//              textAlign: TextAlign.start,
//              overflow: TextOverflow.ellipsis,
//              style: TextStyle(color: Colors.red, fontSize: 14.0),
//            ),
//          ),
          Expanded(
            child: TextField(
              readOnly: true,
              onTap: () {
                _openFlyer();
              },
              style: TextStyle(
                color: Colors.red,
              ),
              controller: TextEditingController(text: _detailPage.offer_one_txt),
            ),
          )
        ],
      ),
      onTap: () {
        _openFlyer();
      },
    );
  }

  Widget _buildVideoOffer() {
    return GestureDetector(
      onTap: () {
        _openPlayer();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
//          Container(
//            padding: EdgeInsets.only(left: 5.0, right: 5.0),
//            child: Text(
//              'Video offer',
//              textAlign: TextAlign.start,
//              style: TextStyle(
//                color: Colors.red,
//                fontSize: 14.0,
//              ),
//            ),
//          ),
          Expanded(
            child: TextField(
              readOnly: true,
              onTap: () {
                _openPlayer();
              },
              style: TextStyle(
                color: Colors.red,
              ),
              controller: TextEditingController(text: _detailPage.video_link_txt),
            ),
          )
        ],
      ),
    );
  }

  void _openFlyer() {
    Navigator.pushNamed(context, Routes.webView,
        arguments: _detailPage.offer_one);
  }

  void _openPlayer() {
    Navigator.pushNamed(context, Routes.videoPlayer,
        arguments: _detailPage.video_link);
  }

  ///Build list feature
  Widget _buildFeature() {
    if (_detailPage?.feature == null) {
      return Container();
    }

    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 15,
            ),
            child: Text(
              Translate.of(context).translate('featured'),
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 20),
              itemBuilder: (context, index) {
                final ProductModel item = _detailPage.feature[index];
                return Container(
                  width: MediaQuery.of(context).size.width / 2,
                  padding: EdgeInsets.only(right: 15),
                  child: AppProductItem(
                    onPressed: _onProductDetail,
                    item: item,
                    type: ProductViewType.gird,
                  ),
                );
              },
              itemCount: _detailPage.feature.length,
            ),
          )
        ],
      ),
    );
  }

  ///Build list related
  Widget _buildRelated() {
    if (_detailPage?.related == null) {
      return Container();
    }

    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: Text(
              Translate.of(context).translate('related'),
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Column(
            children: _detailPage.related.map((item) {
              return Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: AppProductItem(
                  onPressed: _onProductDetail,
                  item: item,
                  type: ProductViewType.small,
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            pinned: true,
            iconTheme: IconThemeData(
              color: Theme.of(context).primaryColorLight, //change your color here
            ),
            actions: <Widget>[
//              IconButton(
//                icon: Icon(
//                  Icons.map,
//                ),
//                onPressed: _onLocation,
//              ),
//              IconButton(
//                icon: Icon(Icons.photo_library),
//                onPressed:(){
////                  _onPhotoPreview();
//                } ,
//              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: _buildBanner(),
            ),
          ),
          SliverToBoxAdapter(
            child: SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Column(
                  children: <Widget>[
//                    Padding(
//                      padding: EdgeInsets.only(left: 20, right: 20),
//                      child: AppUserInfo(
//                        user: _detailPage?.author,
//                        onPressed: () {},
//                        type: AppUserType.basic,
//                      ),
//                    ),
                    _buildInfo(),
//                    _buildFeature(),
//                    _buildRelated()
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
