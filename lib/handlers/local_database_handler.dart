

import 'package:hive_flutter/hive_flutter.dart';
import 'package:whatsappclone/keys/db_cnames.dart';
import 'package:whatsappclone/models/localdbmodel/db_chat_list_model.dart';
import 'package:whatsappclone/models/localdbmodel/db_message_model.dart';
import 'package:whatsappclone/models/localdbmodel/db_pending_message_model.dart';
import 'package:whatsappclone/models/localdbmodel/db_user_model.dart';


class LocalDatabaseHandler {


  Future<void> initDb() async{

  await Hive.initFlutter();


  //register Adapters
  Hive.registerAdapter(DbChatListModelAdapter());
  Hive.registerAdapter(DbMessageModelAdapter());
  Hive.registerAdapter(DbPendingMessageModelAdapter());
  Hive.registerAdapter(DbUserModelAdapter());

  //open boxs

  Hive.openBox<DbUserModel>(DbCnames.user);
  Hive.openBox<DbChatListModel>(DbCnames.chatList);
  Hive.openBox<DbMessageModel>(DbCnames.message);
  Hive.openBox<DbPendingMessageModel>(DbCnames.pendingMessage);

  }
}