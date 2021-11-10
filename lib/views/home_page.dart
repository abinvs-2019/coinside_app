import 'package:calicut/bloc/percentagebloc_bloc.dart';
import 'package:calicut/service/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PercentageblocBloc _bloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("main init");
    _bloc = BlocProvider.of<PercentageblocBloc>(context);
    print(_bloc);
    _bloc.add(FetchData());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CostomAppBar(),
        body: BlocListener<PercentageblocBloc, PercentageblocState>(
          listener: (context, state) {
            if (state is ErrorStae) {
              Text("data");
            }
          },
          child: BlocBuilder<PercentageblocBloc, PercentageblocState>(
              builder: (context, state) {
            if (state is PercentageblocInitial) {
              print("object");
              return loadingWidget();
            } else if (state is PercentageLoadingState) {
              print("object2");
              return loadingWidget();
            } else if (state is PercentageLoadedState) {
              print("object3");
              return CircularIndicator(state);
            } else if (state is ErrorStae) {
              print("objectE");
              errorWidget(state.error);
            }
            return Text("");
          }),
        ),
      ),
    );
  }

  AppBar CostomAppBar() {
    return AppBar(
      title: const Text(
        "Micheal",
        style: TextStyle(color: Colors.black),
      ),
      leading: CircleAvatar(
        maxRadius: 5,
        backgroundColor: Colors.redAccent[100],
      ),
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      actions: [
        const Icon(
          Icons.settings_outlined,
          color: Colors.grey,
        ),
      ],
    );
  }

  Widget loadingWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget errorWidget(msg) {
    return Center(
      child: Text(
        "$msg",
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  SingleChildScrollView CircularIndicator(state) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Text(
              "Dashboard",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 200.0,
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                      width: 200,
                      height: 200,
                      child: CircularProgressIndicator(
                        strokeWidth: 15,
                        backgroundColor: Colors.orange,
                        value: double.parse(state
                                .data[0].chartData!.classTime!.total
                                .toString()) /
                            100,
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${(double.parse(state.data[0].chartData!.totalTime!.total.toString()) / 60).toString().replaceAll(".", "h")}m",
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                timeClassWidget(
                    text1: "Class",
                    text2: state.data[0].chartData!.classTime!.total.toString(),
                    color: Colors.blue),
                timeClassWidget(
                    text1: "Study Time",
                    text2: state.data[0].chartData!.studyTime!.total.toString(),
                    color: Colors.orange),
                timeClassWidget(
                    text1: "Free Time",
                    text2: state.data[0].chartData!.freeTime!.total.toString(),
                    color: Colors.green)
              ],
            ),
          ),
          const Divider(),
          const Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Free-Time Usage",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 50),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Text(
                          "Used",
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${state.data[0].chartData!.freeTime!.total.toString()}m",
                          style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          "Max ",
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${(double.parse(state.data[0].freeTimeMaxUsage.toString()) / 100).toString().replaceAll(".", "h")}h"
                              .toString(),
                          style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      child: LinearProgressIndicator(
                        minHeight: 30,
                        value: double.parse(state
                                .data[0].chartData!.freeTime!.total
                                .toString()) /
                            100,
                        backgroundColor: Colors.grey,
                        color: Colors.green,
                      ),
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            child: Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Center(
                child: Text(
                  "Extend Free-Time",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            child: Center(
                child: Text("Change Time Restrictions",
                    style: TextStyle(color: Colors.blue))),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            child: Center(
              child: Text(
                "By Device",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(
                  Icons.phone_android,
                  size: 100,
                  color: Colors.grey,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Adis Phone',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                        "${state.data[0].deviceUsage!.totalTime!.mobile.toString()}m",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue))
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(
                  Icons.laptop_chromebook,
                  size: 100,
                  color: Colors.grey,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Adis Laptop',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                        "${state.data[0].deviceUsage!.totalTime!.laptop.toString()}m",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue))
                  ],
                ),
              ],
            ),
          ),
          TextButton(onPressed: () {}, child: Text("See all Device"))
        ],
      ),
    );
  }

  Column timeClassWidget({String? text1, text2, Color? color}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: color,
                radius: 8,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                text1!,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
        Text(text2!),
      ],
    );
  }
}
