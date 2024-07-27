import 'package:whatsappclone/handlers/http_handler.dart';
import 'package:whatsappclone/keys/api_routes.dart';

class ChatRepo {

  HttpHandler _httpHandler = HttpHandler();
  Future<dynamic> sendMessage(dynamic body) async =>
      await _httpHandler.post(Api.sendMessage, body);

  Future<dynamic> sendImage(String imagePath,dynamic body) async {
    var response = await _httpHandler.multipart(
        url: Api.sendMessage, fieldName: "image", filePath: imagePath , body:body);

    return response;
  }
  Future<dynamic> receivedMessageUpdate(dynamic body) async =>
      await _httpHandler.put(Api.receivedMessageUpdate, body);

  Future<dynamic> openedMessageUpdate(dynamic body) async =>
      await _httpHandler.put(Api.openedMessageUpdate, body);
}