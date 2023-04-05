import 'package:flutter/material.dart';
import 'package:musify/ui/homePage.dart';
import 'package:musify/ui/signUpPage.dart';


void main() => runApp(const MyApps());

class MyApps extends StatelessWidget {
  const MyApps({super.key});

  static const String _title = 'Project µ6';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}
class _MyStatefulWidgetState extends State<MyStatefulWidget> {

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[

                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Project µ6',
                      style: TextStyle(
                        color: Colors.pink,
                        fontWeight: FontWeight.w500,
                        fontSize: 30,),
                    ),),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    ),),

                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                      ),
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Please enter your Name';
                        }
                        return null;
                      },
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Please enter your Password';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 60,
                    width: 500,
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child:
                    ElevatedButton(
                      child: const Text('Login'),
                      onPressed: () {
                        if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                          final name = _nameController.text;
                          final password = _passwordController.text;
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>  HomePage()),
                          );
                        }
                      },
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Does not have account?'),
                      TextButton(
                        child: const Text('Sign Up'),
                        onPressed: () {
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>   SignupPage  ()),
                          );

                        },
                      ),
                    ],
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