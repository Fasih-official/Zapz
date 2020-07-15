import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:listar_flutter/blocs/bloc.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/utils/utils.dart';

class IntroPreview extends StatefulWidget {
  IntroPreview({Key key}) : super(key: key);

  @override
  _IntroPreviewState createState() {
    return _IntroPreviewState();
  }
}

class _IntroPreviewState extends State<IntroPreview> {
  ApplicationBloc _applicationBloc;

  @override
  void initState() {
    _applicationBloc = BlocProvider.of<ApplicationBloc>(context);
    super.initState();
  }

  ///On complete preview intro
  void _onCompleted() {
    _applicationBloc.add(OnCompletedIntro());
  }

  @override
  Widget build(BuildContext context) {
    ///List Intro view page model
    final List<PageViewModel> pages = [
      PageViewModel(
        pageColor: Color(0xff93b7b0),
        bubble: Icon(
          Icons.shop,
          color: Colors.white,
        ),
        body: Text(
          Translate.of(context).translate('intro_1'),
          style: Theme.of(context).textTheme.title.copyWith(
                color: Colors.white,
              ),
        ),
        title: Text(
          Translate.of(context).translate('intro_1_top'),
          style: Theme.of(context)
              .textTheme
              .display1
              .copyWith(color: Colors.white),
        ),
        titleTextStyle: Theme.of(context).textTheme.display1,
        bodyTextStyle: Theme.of(context).textTheme.title,
        mainImage: Image.asset(
          Images.Intro1,
          fit: BoxFit.contain,
        ),
      ),
      PageViewModel(
        pageColor: Color(0xff93b7b0),
        bubble: Icon(
          Icons.phonelink,
          color: Colors.white,
        ),
        body: Text(
          Translate.of(context).translate('intro_2'),
          style:
              Theme.of(context).textTheme.title.copyWith(color: Colors.white),
        ),
        title: Text(
          Translate.of(context).translate('intro_2_top'),
          style: Theme.of(context)
              .textTheme
              .display1
              .copyWith(color: Colors.white),
        ),
        titleTextStyle: Theme.of(context).textTheme.display1,
        bodyTextStyle: Theme.of(context).textTheme.title,
        mainImage: Image.asset(
          Images.Intro2,
          fit: BoxFit.contain,
        ),
      ),
      PageViewModel(
        pageColor: Color(0xff93b7b0),
        bubble: Icon(
          Icons.home,
          color: Colors.white,
        ),
        body: Text(
          Translate.of(context).translate('intro_3'),
          style:
              Theme.of(context).textTheme.title.copyWith(color: Colors.white),
        ),
        title: Text(
          Translate.of(context).translate('intro_3_top'),
          style: Theme.of(context)
              .textTheme
              .display1
              .copyWith(color: Colors.white),
        ),
        titleTextStyle: Theme.of(context).textTheme.display1,
        bodyTextStyle: Theme.of(context).textTheme.title,
        mainImage: Image.asset(
          Images.Intro3,
          fit: BoxFit.contain,
        ),
      ),
    ];

    ///Build Page
    return Scaffold(
      body: IntroViewsFlutter(
        pages,
        onTapSkipButton: _onCompleted,
        onTapDoneButton: _onCompleted,
        pageButtonTextStyles:
            Theme.of(context).textTheme.button.copyWith(color: Colors.white),
      ),
    );
  }
}
