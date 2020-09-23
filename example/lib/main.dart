import 'package:flutter/material.dart';

import 'package:theme_flipper/theme_flipper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SelectedTheme _selectedTheme = SelectedTheme.light;

  void _onChangeTheme() {
    setState(
      () => _selectedTheme = _selectedTheme == SelectedTheme.light
          ? SelectedTheme.dark
          : SelectedTheme.light,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ThemeFlipper(
      selectedTheme: _selectedTheme,
      lightTheme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      child: DemoPage(
        onChangeTheme: _onChangeTheme,
        selectedTheme: _selectedTheme,
      ),
    );
  }
}

class DemoPage extends StatefulWidget {
  DemoPage({
    this.onChangeTheme,
    this.selectedTheme,
  });
  final Function onChangeTheme;
  final SelectedTheme selectedTheme;

  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  TextStyle _fontSize = TextStyle(fontSize: 18);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.grey),
        ),
        child: Container(
          width: 175,
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Change Theme',
                style: _fontSize,
              ),
              const SizedBox(
                width: 10,
              ),
              Icon(
                Icons.settings,
                size: 25,
              ),
            ],
          ),
        ),
        onPressed: widget.onChangeTheme,
      ),
      appBar: AppBar(
        title: Text(
          'Theme Flipper',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(46),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'First Name',
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  children: <Widget>[
                    Checkbox(
                      value: true,
                      onChanged: (value) {},
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'I agree to the Terms of Services',
                        style: _fontSize,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  const Spacer(),
                  OutlineButton(
                    highlightedBorderColor: Colors.black,
                    onPressed: () {},
                    child: Text(
                      'Register',
                      style: _fontSize,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
