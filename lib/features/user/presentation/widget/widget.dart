import 'package:flutter/material.dart';

class ButtonWidget {
  Widget textFieldButton(
      TextEditingController _controller, String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, top: 25, right: 25),
      child: TextFormField(
        controller: _controller,
        decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: Colors.white,
            ),
            labelText: title,
            labelStyle: TextStyle(color: Colors.white, fontSize: 20),
            fillColor: Colors.grey.shade600,
            filled: true,
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            )),
      ),
    );
  }

  Widget textButton(String title, Function fun) {
    return TextButton(
        onPressed: ()=>fun(),
        child: Text(title,
            style: const TextStyle(
                color: Colors.grey,
                fontSize: 15,
                decoration: TextDecoration.underline,
                decorationThickness: 2,
                decorationColor: Colors.grey)));
  }


 Container textButtonWithcontainer(String title, Function fun) {
    return Container(
      child: TextButton(
          onPressed:()=> fun(),
          child: Text(title,
              style: const TextStyle(
                color: Color(0xff1c4257),
                fontSize: 20,
              ))),
    );
  }
}
