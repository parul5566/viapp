
import  'package:flutter/material.dart';
import 'package:viapp/UserApp/screens/sub_mit.dart';


class ComplaintPage extends StatefulWidget {
    ComplaintPage({Key? key}) : super(key: key);

  @override
  State<ComplaintPage> createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {

  int _value = 1;
  final List<int> list_items = <int>[1, 2, 3];

  int _currentIndex = 0;

  void _updateIndex(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/icon.png',width: 30),
              Text('Village Complaint App'),
              Image.asset('assets/icon.png',width: 30),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _updateIndex,
        selectedItemColor: Colors.green[700],
        selectedFontSize: 13,
        unselectedFontSize: 13,
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            label: "Submit",
            icon: Icon(Icons.join_left_rounded),
          ),
          BottomNavigationBarItem(
            label: "Track",
            icon: Icon(Icons.location_on),
          ),
          BottomNavigationBarItem(
            label: "NotificationPage",
            icon: Icon(Icons.notifications),
          ),

        ],
      ),


      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(

          child: Column(
            children: [


              Text("Submit your Complaint "),
              Container(
                padding: EdgeInsets.all(20),
                child:DropdownButton(
                  value: _value,
                  items: list_items.map((int item) {
                    return DropdownMenuItem<int>(
                      child: Text('Other $item'),
                      value: item,
                    );
                  }).toList(),
                  onChanged:(value) {
                    setState(() {
                      _value = _value;
                    });
                  },
                  hint:Text("Select Category"),
                  disabledHint:Text("Disabled"),
                  elevation: 1,
                  style:TextStyle(color:Colors.green, fontSize: 16),
                  icon: Icon(Icons.arrow_drop_down_circle),
                  iconDisabledColor: Colors.red,
                  iconEnabledColor: Colors.green,
                  isExpanded: true,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter the title of your complaint * ',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Kindly fill in your complaint here  *  * ',
                ),
              ),

              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name of Person / Respondent',
                ),
              ),

              SizedBox(height: 20),
              Container(
                width: 150,
                child: new SizedBox(
                  width: 200.0,
                  child: ElevatedButton(
                    child: Text('Submit Complaint'),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  SuccessPage()),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
