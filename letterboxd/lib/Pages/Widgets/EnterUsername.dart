import 'package:flutter/material.dart';
import 'package:letterboxd/Pages/DisplayPage.dart';

class EnterUsername extends StatelessWidget {
  const EnterUsername({super.key});

  void onTapSelected(int index) {}

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final usernameController = TextEditingController();

    void submitUsername() {
      final username = usernameController.text;
      if (username.isEmpty) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: const Text('Please enter a username.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        // Navigate to DisplayPage and pass the entered username
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DisplayPage(username: username),
          ),
        );
      }
    }

    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Center(
            child: SizedBox(
              width: 600,
              child: TextField(
                controller: usernameController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    labelText: 'Enter Your Letterboxd Username',
                    hoverColor: theme.secondaryHeaderColor,
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    floatingLabelBehavior: FloatingLabelBehavior.always),
                style: const TextStyle(
                  color: Colors.white, // Change input text color here
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: submitUsername,
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
