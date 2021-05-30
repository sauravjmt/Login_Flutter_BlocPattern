import 'package:flutter/material.dart';
import 'package:flutter_login_bloc/bloc/app_state.dart';
import 'file:///D:/Flutter/Flutter_Login_Bloc/flutter_login_bloc/lib/bloc/login_bloc.dart';
import 'file:///D:/Flutter/Flutter_Login_Bloc/flutter_login_bloc/lib/pages/second_page.dart';

void main() {
  var blocProvider = BlocProvider(loginBloc: LoginBloc());
  runApp(AppStateContainer(
    blocProvider: blocProvider,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LoginBloc loginBloc;

  changeThePage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SecondPage()));
  }

  @override
  void didChangeDependencies() {
    loginBloc = AppStateContainer.of(context).blocProvider.loginBloc;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bloc Pattern"),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StreamBuilder<String>(
                  stream: loginBloc.emailStream,
                  builder: (context, snapshot) {
                    return TextField(
                      onChanged: loginBloc.emailChanged,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter email",
                          labelText: "Email",
                          errorText: snapshot.error),
                    );
                  }),
              SizedBox(
                height: 20.0,
              ),
              StreamBuilder<String>(
                  stream: loginBloc.passwordStream,
                  builder: (context, snapshot) {
                    return TextField(
                      onChanged: loginBloc.passwordChanged,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter password",
                          labelText: "Password",
                          errorText: snapshot.error),
                    );
                  }),
              SizedBox(
                height: 20.0,
              ),
              StreamBuilder<bool>(
                  stream: loginBloc.submitStream,
                  builder: (context, snapshot) {
                    return RaisedButton(
                      color: Colors.tealAccent,
                      onPressed: snapshot.hasData
                          ? () => changeThePage(context)
                          : null,
                      child: Text("Submit"),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
