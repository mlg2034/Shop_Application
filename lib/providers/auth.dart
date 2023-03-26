import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Auth extends ChangeNotifier {
  late String _token;
  late DateTime _expiryDate;
  late String _userId;

  Future<void> _authenticate(String email, String password , String urlSegment)async{
     final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment=AIzaSyAPc6l89vkd_0TxRT4NfFaqzwTY5snSyvI');
        try{
final response = await http.post(
      url,
      body: json.encode(
        {'email': email, 'password': password, 'returnSecureToken': true},
      ),
    );
    final responseData=json.decode(response.body);
    if(responseData['error'!=null]){
    }
        }catch(error){
          throw error;
        }
    
  }

  Future<void> signup(String email, String password) async {
 return  _authenticate(email, password, 'signipNewUser');
  }

  Future<void> login(String email, String password) async {
  return  _authenticate(email, password, 'verifyPassword');
  }
}
