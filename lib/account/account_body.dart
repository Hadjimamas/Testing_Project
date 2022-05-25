import 'package:flutter/material.dart';
import 'package:testing/api.dart';
import 'package:testing/models/account_model.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  AccountState createState() => AccountState();
}

class AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events of the match'),
      ),
      body: FutureBuilder(
        future: SoccerApi().getAccountStatus(),
        //Here we will call our getFixtures method,
        builder: (context, snapshot) {
          //the future builder is very interesting to use when you work with api
          if (snapshot.hasData) {
            var dataLength = (snapshot.data).length;
            print("Total Data => $dataLength");
            return accountBody(snapshot.data, context);
          } else {
            return const CircularProgressIndicator();
          }
        }, // here we will built the app layout
      ),
    );
  }

  Widget accountBody(List<AccountStatus> account, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemCount: account.length,
            itemBuilder: (context, index) {
              return accountTile(account[index]);
            },
          ),
        )
      ],
    );
  }
  Widget accountTile(AccountStatus accountStatus) {
    var account = accountStatus.account?.email;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.lightBlueAccent),
        color: const Color(0xFF44484A),
        borderRadius: const BorderRadius.all(Radius.circular(24.0)),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: ListTile(
                  textColor: Colors.black,
                  title: Text(
                    account!,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}


