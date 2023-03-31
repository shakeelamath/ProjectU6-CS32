import 'package:flutter/material.dart';
import 'package:musify/signUpInfo/SignUpData.dart';
import 'logInpage.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'SignupPage',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Sign Up for μ6'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.pink,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Navigate back to the previous screen or page
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _userNameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                    ),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Please enter your Username';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                    ),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Please enter your email';
                      }
                      // add more email validation here
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Please enter your password';
                      }
                      // add more password validation here
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    child: Text('Sign Up'),
                    onPressed: () async {
                      if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                        // form is valid
                        String username = _userNameController.text;
                        String name = _nameController.text;
                        String email = _emailController.text;
                        String password = _passwordController.text;

                        final signUpData = SignUpData(username: username, name: name, email: email, password: password);
                        storeSignUpData(signUpData);

                        if(checkSignUpData(username, email)!=null){
                          /**ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('These details are already exist.'),
                              backgroundColor: Colors.red,
                            ),
                          );**/
                        }
                        else{
                          /**ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Your account is created.'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>   MyApps()
                            ),
                          );**/
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
