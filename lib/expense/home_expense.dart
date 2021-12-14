// ignore_for_file: avoid_print

import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:web3dart/web3dart.dart';

import 'data.dart';
import 'helper.dart';

TransactionsData t1 = new TransactionsData(
    "PAID", "123@oksbi", "200", DateFormat.jm().format(DateTime.now()));

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool data = false;
  Client client = Client();
  late Web3Client ethClient;

  List<TransactionsData> list =
      List<TransactionsData>.filled(1, t1, growable: true);
  final address = "0x4D6E3D247202B1369F2fbdaF6732BF94322DE63C";
  int myAmt = 0;
  var myData;
  int _currentSliderValue = 0;
  @override
  void initState() {
    super.initState();
    client = Client();
    ethClient = Web3Client(
        "https://rinkeby.infura.io/v3/ff2e5232277d482d8278bc7a87888a1c",
        client);
    list = List<TransactionsData>.filled(1, t1, growable: true);
    getBalance(address);
  }

  Future<DeployedContract> loadContract() async {
    String abi = await rootBundle.loadString('assets/abi.json');
    String contractAddress = "0x7C281D42b3283Ba937cf66f6ba62604732c1a317";
    final contract = DeployedContract(ContractAbi.fromJson(abi, "Box"),
        EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  Future<List<dynamic>> query(String functionName, List<dynamic> args) async {
    final contract = await loadContract();
    final ethFunction = contract.function(functionName);
    final result =
        ethClient.call(contract: contract, function: ethFunction, params: args);
    return result;
  }

  Future<void> getBalance(String targetAddress) async {
    EthereumAddress ethaddress = EthereumAddress.fromHex(targetAddress);
    List<dynamic> result = await query("getBalance", []);
    myData = result[0];
    data = true;
    setState(() {});
  }

  Future<String> submit(String functionName, List<dynamic> args) async {
    EthPrivateKey credentials = EthPrivateKey.fromHex(
        "3648a2c2a855d63935c9d78a526bd6dbc7fce461a3145e8506a83ab89b93eea3");
    DeployedContract contract = await loadContract();
    final ethFunction = contract.function(functionName);
    final result = await ethClient.sendTransaction(
        credentials,
        Transaction.callContract(
            contract: contract, function: ethFunction, parameters: args),
        fetchChainIdFromNetworkId: true,
        chainId: null);
    print(result);
    dynamic currentTime = DateFormat.jm().format(DateTime.now());
    if (functionName == "depositBalance") {
      TransactionsData t = new TransactionsData(
          "RECEIVED", result, args[0].toString(), currentTime);
      list.add(t);
      setState(() {});
    } else {
      TransactionsData t =
          new TransactionsData("PAID", result, args[0].toString(), currentTime);
      list.add(t);
      setState(() {});
    }
    return result;
  }

  Future<String> sendCoins() async {
    var bigAmt = BigInt.from(_currentSliderValue);
    var response = await submit("depositBalance", [bigAmt]);
    print("Deposited");
    return response;
  }

  Future<String> withdrawCoins() async {
    var bigAmt = BigInt.from(_currentSliderValue);
    var response = await submit("withdrawBalance", [bigAmt]);
    print("WithDraw");
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.white,
      body: ZStack([
        VxBox()
            .color(Palette.DarkGreen)
            .size(context.screenWidth, context.percentHeight * 30)
            .make(),
        VStack([
          (context.percentHeight * 10).heightBox,
          "Transactions".text.xl4.white.bold.center.makeCentered().py16(),
          (context.percentHeight * 5).heightBox,
          VxBox(
                  child: VStack([
            "Balance".text.gray700.xl2.semiBold.makeCentered(),
            10.heightBox,
            data
                ? "\u{20B9}$myData".text.xl6.bold.makeCentered()
                : CircularProgressIndicator().centered()
          ]))
              .p16
              .white
              .size(context.screenWidth, context.percentHeight * 20)
              .rounded
              .shadowXl
              .make()
              .p16(),
          30.heightBox,
          Slider(
            value: _currentSliderValue.toDouble(),
            min: 0,
            max: 1000,
            divisions: 1000,
            label: _currentSliderValue.round().toString(),
            onChanged: (double value) {
              setState(() {
                _currentSliderValue = (value).round();
                print(_currentSliderValue);
              });
            },
          ),
          HStack(
            [
              FlatButton.icon(
                      onPressed: () {
                        getBalance(address);
                      },
                      icon: Icon(Icons.refresh, color: Colors.white),
                      color: Palette.DarkBlue,
                      shape: Vx.roundedSm,
                      label: "Refresh".text.white.make())
                  .h(50),
              FlatButton.icon(
                      onPressed: () => sendCoins(),
                      icon: Icon(Icons.add_outlined, color: Colors.white),
                      color: Palette.DarkGreen,
                      shape: Vx.roundedSm,
                      label: "Receive".text.white.make())
                  .h(50),
              FlatButton.icon(
                      onPressed: () => withdrawCoins(),
                      icon: Icon(Icons.remove_outlined, color: Colors.white),
                      shape: Vx.roundedSm,
                      color: Palette.Orange,
                      label: "Pay".text.white.make())
                  .h(50)
            ],
            alignment: MainAxisAlignment.spaceEvenly,
            axisSize: MainAxisSize.max,
          ).py16(),
          Expanded(
              child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return (ListTile(
                tileColor: Colors.greenAccent[100],
                hoverColor: Colors.grey,
                leading: list[index].name == "PAID"
                    ? Icon(Icons.call_made_outlined)
                    : Icon(Icons.call_received_outlined),
                title: Text(list[index].name),
                subtitle: Column(children: [
                  Text('\u{20B9}${list[index].amt}'),
                  Text("Token Hash :" + '${list[index].hash.substring(0, 7)}')
                ]),
                onTap: () => print("ListTile"),
                trailing: Text('${list[index].timestamp}'),
              )).p(10);
            },
          ))
        ]),
      ]),
    );
  }
}
