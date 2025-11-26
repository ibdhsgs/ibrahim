
import 'package:flutter/material.dart';

class Textfild extends StatefulWidget {
  Textfild({super.key});

  @override
  State<Textfild> createState() => _TextfildState();
}

class _TextfildState extends State<Textfild> {
  TextEditingController _controller1= TextEditingController();
  TextEditingController _controller2= TextEditingController();
  late String controller3;
  void _login(){
    setState(() {
      _controller2.text=_controller1.text;
    });
  }
  void _Navgitor(){

    Navigator.push(
        context,
        MaterialPageRoute(builder: (context)=>Towpage(
            name: _controller1.text

        )));
  }
  void _Navgitor1(){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context)=>Towpage1(
            name: _controller1.text

        )));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page'),
        backgroundColor: Colors.blueGrey,

      ),
      body: Column(
        children: [
          SizedBox(height: 20,),
          TextField(
            decoration: InputDecoration(
                labelText: 'Enter the Name',
                hintText:'ahmed' ,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0)
                )
            ),
            controller: _controller1,
          ),
          SizedBox(height: 20,),
          TextField(
            decoration: InputDecoration(
                labelText: ' the Name',
                //  hintText:'ahmed' ,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0)
                )
            ),
            controller: _controller2,
            readOnly: true,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
              ),
              onPressed: (){

                _login();
              },

              child: Text('Submit')),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
              ),
              onPressed: (){
                _Navgitor();
              },
              child: Text('Navgitor')),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
              ),
              onPressed: (){
                _Navgitor1();
              },
              child: Text('Navgitor1')),
        ],
      ),

    );

  }
}
class Towpage extends StatelessWidget {
  final String name;
  Towpage({super.key,
    required this.name
  });

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('Tow Page'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Text(name),
      ),
    );
  }
}

class Towpage1 extends StatefulWidget {
  final String name;

  Towpage1({super.key,
    required this.name
  });

  @override
  State<Towpage1> createState() => _Towpage1State();
}

class _Towpage1State extends State<Towpage1> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(title: Text('Tow Page'),
          backgroundColor: Colors.blueGrey,
        ),
        body:
        Column(
          children: [
            Center(
              child: Text(widget.name),
            ),
            Text('data'),

            ElevatedButton(onPressed:() {
              Navigator.pop(context);
            },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                ),
                child: Text('Back'))
          ],
        )



    );
  }
}