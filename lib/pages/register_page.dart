// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:register_form_flutter/models/user.dart';
import 'package:register_form_flutter/pages/info_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  User user = User();

  bool _hidePass = true;

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _mailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  final _nameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _passFocus = FocusNode();

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _mailController.dispose();
    _passController.dispose();

    _nameFocus.dispose();
    _phoneFocus.dispose();
    _passFocus.dispose();

    _confirmPassController.dispose();

    super.dispose();
  }

  final List _countries = ['Russia', 'USA', 'Germany', 'England', 'France'];
  late String _selectCountry = 'USA';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Page'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            // name
            TextFormField(
              focusNode: _nameFocus,
              autofocus: true,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _nameFocus, _phoneFocus);
              },
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Full Name *',
                hintText: 'Enter name',
                prefixIcon: Icon(Icons.person),
                suffixIcon: GestureDetector(
                  onTap: () => _nameController.clear(),
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.red, width: 2.0),
                ),
              ),
              validator: _validatedName,
              onSaved: (value) => user.name = value!,
            ),
            SizedBox(
              height: 10,
            ),

            // phone
            TextFormField(
              focusNode: _phoneFocus,
              onFieldSubmitted: (_) =>
                  _fieldFocusChange(context, _phoneFocus, _passFocus),
              validator: _validatedPhone,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone),
                suffixIcon: GestureDetector(
                  onTap: () => _phoneController.clear(),
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(width: 2, color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(width: 2, color: Colors.blue),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.red, width: 2.0),
                ),
                labelText: 'Phone Number *',
                hintText: 'Enter Phone number',
                helperText: 'Please format (XXX)XXX-XXXX',
              ),
              onSaved: (value) => user.phone = value!,
            ),
            SizedBox(
              height: 10,
            ),

            // password & confirm password
            TextFormField(
              focusNode: _passFocus,
              controller: _passController,
              validator: _validatedPassword,
              maxLength: 8,
              obscureText: _hidePass,
              decoration: InputDecoration(
                icon: Icon(Icons.security),
                suffixIcon: IconButton(
                  icon:
                      Icon(_hidePass ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _hidePass = !_hidePass;
                    });
                  },
                ),
                labelText: 'Password *',
                hintText: 'Enter Password',
              ),
            ),
            TextFormField(
              controller: _confirmPassController,
              validator: _validatedPassword,
              maxLength: 8,
              obscureText: _hidePass,
              decoration: const InputDecoration(
                icon: Icon(Icons.border_color),
                labelText: 'Confirm Password *',
                hintText: 'Enter Confirm Password',
              ),
            ),
            SizedBox(
              height: 10,
            ),

            // mail
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                icon: Icon(Icons.mail),
                labelText: 'Mail',
                hintText: 'Enter mail',
              ),
              onSaved: (value) => user.mail = value!,
            ),
            SizedBox(
              height: 10,
            ),

            // country
            DropdownButtonFormField(
              decoration: const InputDecoration(
                labelText: 'Contry',
                focusColor: Colors.green,
                icon: Icon(Icons.map),
              ),
              onChanged: (country) {
                setState(() {
                  _selectCountry = country as String;
                  user.country = _selectCountry;
                });
              },
              items: _countries.map((country) {
                return DropdownMenuItem(
                  child: Text(country),
                  value: country,
                );
              }).toList(),
            ),
            SizedBox(
              height: 20,
            ),

            // story
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Life story',
                hintText: 'Tell us about yourself',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              onSaved: (value) => user.story = value!,
            ),
            SizedBox(
              height: 20,
            ),

            // submit button
            ElevatedButton(
              onPressed: _submitForm,
              child: Text(
                'Submit form',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                textStyle: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _showDialog();
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Registration successful'),
        content: Text(
          '${_nameController.text} is now a verified register form',
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                Route route = MaterialPageRoute(builder: (context) => InfoPage(user));
                Navigator.push(context, route);
              },
              child: Text(
                'Verified',
                style: TextStyle(color: Colors.green, fontSize: 18),
              ))
        ],
      ),
    );
  }

  // validate
  String? _validatedName(String? value) {
    final _nameExp = RegExp(r'^[A-Za-z ]+$');
    if (value == null) {
      return 'Name is reqired.';
    } else if (!_nameExp.hasMatch(value)) {
      return 'Please enter alphabetical characters.';
    } else {
      return null;
    }
  }

  String? _validatedPhone(String? phone) {
    final _phoneExp = RegExp(r'^\(\d\d\d\)\d\d\d\-\d\d\d\d$');

    if (phone == null) {
      return 'Phone number is empty';
    } else if (!_phoneExp.hasMatch(phone)) {
      return 'Phone number must be entered as (###)###-####';
    }

    return null;
  }

  String? _validatedPassword(String? val) {
    if (_passController.text.length != 8) {
      return '8 character required for password';
    } else if (_passController.text != _confirmPassController.text) {
      return 'Password does not match';
    }

    return null;
  }
}
