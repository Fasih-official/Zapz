import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/screens/chat/chat_item.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Chat extends StatefulWidget {
  final UserModel user;

  Chat({this.user});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final _controller = RefreshController(initialRefresh: false);
  final _textChatController = TextEditingController();
  bool _loading = true;
  List<MessageModel> _message;

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  ///Fetch API
  Future<void> _loadData() async {
    final ResultApiModel result = await Api.getDetailMessage();
    if (result.success) {
      final Iterable convertMessage = result.data['message'] ?? [];
      setState(() {
        _message = convertMessage.map((item) {
          return MessageModel.fromJson(item);
        }).toList();
        _loading = false;
      });
    }
  }

  ///On async get Image file
  Future _attachImage() async {
    final image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final chat = MessageModel.fromJson({
        "id": 10,
        "from": {"id": 3},
        "date": DateFormat.jm().format(DateTime.now()),
        "file": image.path,
        "status": "sent"
      });
      setState(() {
        _message.add(chat);
      });
      UtilOther.hiddenKeyboard(context);
    }
  }

  ///On load more
  Future<void> _onLoading() async {
    await Future.delayed(Duration(seconds: 1));
    _controller.loadComplete();
  }

  ///On refresh
  Future<void> _onRefresh() async {
    await Future.delayed(Duration(seconds: 1));
    _controller.refreshCompleted();
  }

  ///On Send message
  void _onSend() {
    final chat = MessageModel.fromJson({
      "id": 6,
      "from": {"id": 3, "level": "", "description": ""},
      "message": _textChatController.text,
      "date": DateFormat.jm().format(DateTime.now()),
      "status": "sent"
    });
    if (_textChatController.text.isNotEmpty) {
      setState(() {
        _message.add(chat);
      });
    }
    _textChatController.text = '';
    UtilOther.hiddenKeyboard(context);
  }

  ///Build Content
  Widget _buildContent() {
    if (_loading) {
      return Center(
        child: SizedBox(
          width: 26,
          height: 26,
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }

    return Column(
      children: <Widget>[
        Expanded(
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            controller: _controller,
            header: ClassicHeader(
              idleText: Translate.of(context).translate('pull_down_refresh'),
              refreshingText: Translate.of(context).translate('refreshing'),
              completeText:
                  Translate.of(context).translate('refresh_completed'),
              releaseText:
                  Translate.of(context).translate('release_to_refresh'),
              refreshingIcon: SizedBox(
                width: 16.0,
                height: 16.0,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
            footer: ClassicFooter(
              loadingText: Translate.of(context).translate('loading'),
              canLoadingText: Translate.of(context).translate(
                'release_to_load_more',
              ),
              idleText: Translate.of(context).translate('pull_to_load_more'),
              loadStyle: LoadStyle.ShowWhenLoading,
              loadingIcon: SizedBox(
                width: 16.0,
                height: 16.0,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
            child: ListView.builder(
              padding: EdgeInsets.all(15),
              itemCount: _message.length,
              itemBuilder: (context, index) {
                final item = _message[index];
                return ChatItem(item: item);
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 8, top: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                    color: Theme.of(context).dividerColor,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.face),
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: Translate.of(context).translate(
                              'type_something',
                            ),
                            border: InputBorder.none,
                          ),
                          controller: _textChatController,
                          onSubmitted: (value) {
                            _onSend();
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.attach_file),
                        onPressed: _attachImage,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: InkWell(
                  onTap: _onSend,
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            AppCircleAvatar(
              imgUrl: widget.user.image,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.user.name,
                    style: Theme.of(context).textTheme.subhead.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    "Online",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle
                        .apply(color: Theme.of(context).primaryColorLight),
                  )
                ],
              ),
            )
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.phone),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: _buildContent(),
      ),
    );
  }
}
