import 'package:firebase_app/auth/auth_provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Screen'),
        actions: [
          InkWell(
            child: const Icon(Icons.logout),
            onTap: () async {
              Provider.of<AuthProvider>(context, listen: false).signOut();
            },
          )
        ],
      ),
      body: Consumer<AuthProvider>(builder: (context, provider, child) {
        return Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                provider.uploadNewFile();
              },
              child: Container(
                height: 150,
                width: 150,
                color: Colors.grey,
                child: provider.loggedUser!.imageURL == null
                    ? Center(child: Icon(Icons.camera))
                    : Image.network(
                        provider.loggedUser!.imageURL!,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            CustomDisplayWidget(
                label: 'Name: ', value: provider.loggedUser!.name),
            CustomDisplayWidget(
                label: 'Email:', value: provider.loggedUser!.email),
            CustomDisplayWidget(
                label: 'Phone:', value: provider.loggedUser!.phone),
          ],
        );
      }),
    );
  }
}

class CustomDisplayWidget extends StatelessWidget {
  String label;
  String? value;
  CustomDisplayWidget({
    required this.label,
    this.value = '',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 30,
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(flex: 6, child: Text(value!))
          ],
        ),
      ),
    );
  }
}
