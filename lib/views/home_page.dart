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
      title: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.pink[100],
          ),
          SizedBox(
            width: 10,
          ),
          const Text(
            "Micheal",
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      actions: [
        const Icon(
          Icons.settings_outlined,
          color: Colors.black,
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 23),
            child: Text(
              "Dashboard",
              style: TextStyle(
                fontSize: 43,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: SizedBox(
              width: 250,
              height: 250.0,
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Transform.rotate(
                      angle: 90.5,
                      child: Container(
                        width: 250,
                        height: 250,
                        child: CircularProgressIndicator(
                          color: Colors.blue[700],
                          strokeWidth: 16,
                          backgroundColor: Colors.orange,
                          value: double.parse(state
                                  .data[0].chartData!.classTime!.total
                                  .toString()) /
                              100,
                        ),
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
                              fontSize: 36, fontWeight: FontWeight.w800),
                        ),
                        Text(
                          "${(double.parse(state.data[0].chartData!.totalTime!.total.toString()) / 60).toString().replaceAll(".", "h ")}m",
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                timeClassWidget(
                    text1: "Class",
                    text2: state.data[0].chartData!.classTime!.total.toString(),
                    color: Colors.blue),
                timeClassWidget(
                    text1: "Study",
                    text2: state.data[0].chartData!.studyTime!.total.toString(),
                    color: Colors.orange),
                timeClassWidget(
                    text1: "Free-Time",
                    text2: state.data[0].chartData!.freeTime!.total.toString(),
                    color: Colors.green)
              ],
            ),
          ),
          const Divider(),
          const Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Text(
              "Free-Time Usage",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
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
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${state.data[0].chartData!.freeTime!.total.toString()}m",
                          style: const TextStyle(
                              fontSize: 37,
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
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${(double.parse(state.data[0].freeTimeMaxUsage.toString()) / 100).toString().replaceAll(".", "h ")}m"
                              .toString(),
                          style: const TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 17),
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      child: LinearProgressIndicator(
                        minHeight: 30,
                        value: double.parse(state
                                .data[0].chartData!.freeTime!.total
                                .toString()) /
                            100,
                        backgroundColor: Colors.blue[100],
                        color: Colors.green,
                      ),
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            child: Container(
              height: 55,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2.5,
                  color: Colors.blue,
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: const Center(
                child: Text(
                  "Extend Free-Time",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 25),
            child: Center(
              child: Text(
                "Change Time Restrictions",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 23,
                ),
              ),
            ),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            child: Center(
              child: Text(
                "By Devices",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Container(
                    height: 100,
                    width: 150,
                    child: Image(
                      fit: BoxFit.contain,
                      image: AssetImage("assets/images/mobile_img.png"),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Adi's Phone",
                      style:
                          TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${state.data[0].deviceUsage!.totalTime!.mobile.toString()}m",
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 100,
                  width: 150,
                  child: Image(
                    fit: BoxFit.contain,
                    image: AssetImage("assets/images/laptop_img.png"),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Adi's Laptop",
                      style:
                          TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${(double.parse(state.data[0].deviceUsage!.totalTime!.laptop.toString()) / 60).toString().replaceAll(".", "h ")}m",
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    )
                  ],
                ),
              ],
            ),
          ),
          TextButton(
              onPressed: () {},
              child: Text(
                "See all Device",
                style: TextStyle(fontSize: 20),
              ))
        ],
      ),
    );
  }

  Column timeClassWidget({String? text1, text2, Color? color}) {
    if (double.parse(text2) > 60) {
      {
        text2 = (double.parse(text2.toString()) / 60)
            .toString()
            .substring(0, 3)
            .replaceAll(".", "h ");
      }
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
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
                style: TextStyle(fontSize: 23),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Text(
              "${text2}m",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
