import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart' as signIn;
import 'package:googleapis/drive/v3.dart';
import 'dart:io' as g;
import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:googleapis_auth/auth_io.dart' as auth;

import '../core/component/app_constants/app_const.dart';

class GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;

  final http.Client _client = http.Client();
  GoogleAuthClient(this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _client.send(request..headers.addAll(_headers));
  }
}

class GoogleDriveApis {
  static String? getIdFile;
  static Future<String?> createFolder() async {
    final googleSignIn =
        signIn.GoogleSignIn.standard(scopes: [drive.DriveApi.driveScope]);
    final signIn.GoogleSignInAccount? account = await googleSignIn.signIn();
    final authheader = await account?.authHeaders;

    var client = GoogleAuthClient(authheader!);
    var driveFile = drive.DriveApi(client);

    var fileMetadata = drive.File();
    fileMetadata.name = 'test ';
    fileMetadata.mimeType = 'application/vnd.google-apps.folder';
    try {
      var file = await driveFile.files.create(fileMetadata);
      print('Folder ID: ${file.id}');
      var getIdFile = file.id;
      print('Git the ID$getIdFile');
    } catch (e) {
      print('Error $e');
    }
    return getIdFile;
  }

  static void addImageToFolder(String imagePath, String folderId) async {
    final googleSignIn =
        signIn.GoogleSignIn.standard(scopes: [drive.DriveApi.driveScope]);
    final signIn.GoogleSignInAccount? account = await googleSignIn.signIn();
    final authheader = await account?.authHeaders;
    var client = GoogleAuthClient(authheader!);
    var driveApi = drive.DriveApi(client);
    final imageBytes = g.File(imagePath);
    final media = Media(imageBytes.openRead(), imageBytes.lengthSync());
    final response = await driveApi.files.create(
      drive.File(
        name: 'test ',
        parents: ['$folderId'],
      ),
      uploadMedia: media,
    );
    print('reeeeeeeeee${response}');
  }

  static void addSpreadsheets() async {
    final credentials = await auth.clientViaServiceAccount(
        AppConst.accountCredentials, [sheets.SheetsApi.driveFileScope]);
    final driveApi = drive.DriveApi(credentials);
    final spreadsheet = await driveApi.files.create(drive.File(
      name: 'users',
      mimeType: 'application/vnd.google-apps.spreadsheet',
    ));

    print('Spreadsheet created. ID: ${spreadsheet.id}');
  }
}
