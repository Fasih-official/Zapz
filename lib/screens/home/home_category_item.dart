import 'package:flutter/material.dart';
import 'package:listar_flutter/configs/language.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/utils/string_utils.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:shimmer/shimmer.dart';

class HomeCategoryItem extends StatelessWidget {
  final CategoryModel item;
  final ValueChanged<CategoryModel> onPressed;

  HomeCategoryItem({
    Key key,
    this.item,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (item == null) {
      return Shimmer.fromColors(
        baseColor: Theme.of(context).hoverColor,
        highlightColor: Theme.of(context).highlightColor,
        enabled: true,
        child: Container(
          width: MediaQuery.of(context).size.width / 4.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 3),
                child: Text(
                  Translate.of(context).translate('loading'),
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width / 4.5,
      child: GestureDetector(
        onTap: () => onPressed(item),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: item.color,
              ),
              child: Icon(
                item.icon,
                size: 18,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 3),
              child: _buildCategoryLocalizedName(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryLocalizedName(BuildContext context) {
    String name = '';
    if (StringUtils.equalsIgnoreCase(
        AppLanguage.defaultLanguage.languageCode, "en")) {
      name = item.name.toString();
    } else if (StringUtils.equalsIgnoreCase(
        AppLanguage.defaultLanguage.languageCode, "de")) {
      name = item.name_de;
    } else if (StringUtils.equalsIgnoreCase(
        AppLanguage.defaultLanguage.languageCode, "pt")) {
      name = item.name_pt;
    } else if (StringUtils.equalsIgnoreCase(
        AppLanguage.defaultLanguage.languageCode, "fr")) {
      name = item.name_fr;
    } else {
      name = item.name_it;
    }

    if (item.id == 8000) {
      name = Translate.of(context).translate('more');
    }
    return Text(
      name.toString(),
      style: Theme.of(context)
          .textTheme
          .caption
          .copyWith(fontWeight: FontWeight.w500),
    );
  }
}
