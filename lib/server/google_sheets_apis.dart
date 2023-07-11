

import 'package:blnk/model/user_model.dart';
import 'package:gsheets/gsheets.dart';

class UserSheetsApis {
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "grand-pact-392418",
  "private_key_id": "9443c152cac3e8bdb9dea6db9abc93cff624e975",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCYsMfYjDMiWp4E\nlt/x+2AeDtCzN+k5S9B7j0P0I6IJE1JTRw3uHTkVPSh8Ebo/1yt6BzDFd6SIMzBS\nYr12FZtNipwMVM8NvhhBkIc6Iin398gFEV+6C9cGiBitMdho9Y4hzjJRE+Shd6ya\nBhA3T3MQfBpErA+boZYG4snBay9wl3ONSEAKR3Un3zKoiPVOURMqz4eqB3pfdbsy\nAUlbGr3ZvLDobGEzof7dEgGG85Ebop+jEI0hMHE9mySyWfmF1vQZBXKkGCk+MLuw\nP+i/9gkQdxxYBf4vayCndLa21CziDyhL3LVZPSU7ZI4ps5/fXnjjCqlbeC5MsJ3G\n6s8duQaFAgMBAAECggEASitRIDjWG+FtsagCJ16mjWM/8FZ/5TOVFXf9l8l5S7RF\ngKtasmgiktUO5dmMobco6NE2WS1pUDmhRtus0X/kXRGwBHNr0m6dBLgqX8w5m7iS\nQhfy6oIW1JbmebblOvLQtE4fde/WVrK1tmmsldlzeLX34pS7zir7H+QpAdnJhQRk\nYhQQZnYUCZBLjHvijehO+z7xH5ubsTVAlpvK/B/yhy9T/zauI7hcMY7aDaqbOYWn\nl8ltyYq72ic2qh6j+huKjBaQC7fHk43bt0ac+QI8L7+lWTI2iV9thiFqm8WsaESo\nAjf7XbWA7ajWBiKAUpURjIigcGueSHOwolyNsgxrnwKBgQDJeJxS2gQVFzG7dx9d\nkLXZoDxHmxk0g2IDnhVGzxIeu0xeio/eMwiNOKY2h3t6jffdaKhm2BtG6MBB7Idg\nh+k47v6qla7pgo93KiOCwq5Hf7LVh69oeCQZ+io4wr74zl7wrC/fdTIEH7x5mIF+\nM2FL++bM+6z9C4DWBSFWO4CiSwKBgQDCBEuZuorilkkzv/6SKE2i6fHu1n41/r6o\nqGOC4R9OP2HdkwPN2rD7etRggMS+1KavSWJVuykW2Pxhab1ubw69l3i95cMlxaFU\nb+W82ojxlgLcCOsZXC6+zgM/6DQAU2KhOhX3cFN3YouKDQ9rnAwht1n9LvoOoYmE\nBbJcNu74bwKBgQC4+BPFeUXwOxg8vbQ9SeO7RwKw1zO/47O0EIoGNYy0TE9kKSDG\n5uG+DjmDrMVwEjFzxGd/7H62jnAc1lTACmfUDpAe+0fYOTcQN87ceXJaUGJW6rjf\nWBYFB4mGDT4Z3haKLfvR05407RI0LREOVYvJoB8ZKSN8OvhxBcrCieSimwKBgBK4\nv2LSMVy0C9RGjpYj9XnnAUV+xScIsfUsao3Sk2bFjvgGm7Ndiv55V80IH/QaKQt5\nFVgYe1qNDa2IupLRfKam2yvX5ADdFThEo/KZU+WcCCKbabRExO38iyu7iGkPotDT\n/hKmcCdxBu4HXJmRsUn/m1tnERIgXFi1BAUJ9/1ZAoGBAKLZHfJm2Wbi7rtaTxlq\n1LkwyiwSHKOTmEwBWoBsT0tYOziOBnWl6w80fCmjK6lPz6rDRrhNVL8TRyO/nCeC\nlMd4Xdsn/RbYSvTWXZqEIpPJo9EiO5xlThvL390SzNWByXLJvCcumztsEQhnd7LB\nM44aVcfOWxQDwMzomwdr3Se6\n-----END PRIVATE KEY-----\n",
  "client_email": "google-sheets@grand-pact-392418.iam.gserviceaccount.com",
  "client_id": "102423330212370141479",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/google-sheets%40grand-pact-392418.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
  }
 ''' ;
  static final _spreadSheetId = '13qAAldS7NOtQz33IMO2T4gkAYihZl7QIbg4qEyiVsdQ';
  static final _gSheets = GSheets(_credentials);
  static Worksheet? _userSheet;
  static Future init() async {
    try{
 final spreadsheet = await _gSheets.spreadsheet(_spreadSheetId);
    _userSheet = await _getWorkSheets(spreadsheet, title: 'users');
    final firstRow =UserModel.getFeilds();
    _userSheet!.values.insertRow(1,firstRow);
    } catch(e){
      print('There is an Error:$e');
    }
   
  }

  static Future<Worksheet> _getWorkSheets(
    Spreadsheet spreadsheet, {
    required String title,
  }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }
  static Future insert(List<Map<String ,dynamic>>rowsList)async{
    if(_userSheet ==null) return ;
  await _userSheet!.values.map.appendRows(rowsList);

  }
}
