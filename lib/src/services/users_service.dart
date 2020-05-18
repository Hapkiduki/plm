import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import 'package:plm/src/models/user_model.dart';

class UsersService {
  Future<http.Response> uploadUser(File photo, UserModel user) async {
    final url = Uri.parse('https://plm.com.co/test/users');
    final mimeType = mime(photo.path).split('/');

    final userUploadRequest = http.MultipartRequest(
      'POST',
      url,
    )..fields.addAll(user.toJson());
    final file = await http.MultipartFile.fromPath(
      'foto',
      photo.path,
      contentType: MediaType(mimeType[0], mimeType[1]),
    );

    userUploadRequest.files.add(file);
    final streamResponse = await userUploadRequest.send();
    final response = await http.Response.fromStream(streamResponse);
    return response;
  }
}
