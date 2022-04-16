
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  String contactKey;

  EditProfile({Key? key, required this.contactKey}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController _nameController, _numberController,_queryController;
  String _typeSelected = '';

  late DatabaseReference _ref;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = TextEditingController();
    _numberController = TextEditingController();
    _queryController = TextEditingController();
    _ref = FirebaseDatabase.instance.reference().child('Complaints');
    getContactDetail();
  }

  Widget _buildContactType(String title) {
    return InkWell(
      child: Container(
        height: 40,
        width: 90,
        decoration: BoxDecoration(
          color: _typeSelected == title
              ? Colors.yellow
              : Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
      onTap: () {
        setState(() {
          _typeSelected = title;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Update Complaint'),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Enter Name',
                  prefixIcon: Icon(
                    Icons.account_circle,
                    size: 30,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(15),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _numberController,
                decoration: InputDecoration(
                  hintText: 'Enter Number',
                  prefixIcon: Icon(
                    Icons.phone_iphone,
                    size: 30,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(15),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text('Query'),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                maxLines: 5,
                controller: _queryController,
                decoration: InputDecoration(
                  hintText: 'Enter Description',
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(15),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: RaisedButton(
                  child: Text(
                    'Update ProfilePage',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () {
                    saveContact();
                  },
                  color: Theme.of(context).primaryColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  getContactDetail() async {
    DataSnapshot snapshot = (await _ref.child(widget.contactKey).once()) as DataSnapshot;
    Map? contact = snapshot.value as Map?;

    _nameController.text = contact!['name'];

    _numberController.text = contact['number'];
    _queryController.text = contact!['query'];
    setState(() {
      _typeSelected = contact['type'];
    });
  }

  void saveContact() {
    String name = _nameController.text;
    String number = _numberController.text;
    String query =_queryController.text;
    Map<String, String> contact = {
      'name': name,
      'number':  number,
      'query': query,
      'type': _typeSelected,
    };
    _ref.child(widget.contactKey).update(contact).then((value) {
      Navigator.pop(context);
    });
  }
}
