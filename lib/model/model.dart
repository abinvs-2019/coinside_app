import 'dart:convert';

List<Modal> modalFromMap(String str) =>
    List<Modal>.from(json.decode(str).map((x) => Modal.fromMap(x)));

String modalToMap(List<Modal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Modal {
  Modal({
    this.chartData,
    this.freeTimeMaxUsage,
    this.deviceUsage,
  });

  late ChartData? chartData;
  late String? freeTimeMaxUsage;
  late DeviceUsage? deviceUsage;

  factory Modal.fromMap(Map<String, dynamic> json) => Modal(
        chartData: ChartData.fromMap(json["chartData"]),
        freeTimeMaxUsage: json["freeTimeMaxUsage"],
        deviceUsage: DeviceUsage.fromMap(json["deviceUsage"]),
      );

  Map<String, dynamic> toMap() => {
        "chartData": chartData!.toMap(),
        "freeTimeMaxUsage": freeTimeMaxUsage,
        "deviceUsage": deviceUsage!.toMap(),
      };
}

class ChartData {
  ChartData({
    this.totalTime,
    this.studyTime,
    this.classTime,
    this.freeTime,
  });

  ChartDataClassTime? totalTime;
  ChartDataClassTime? studyTime;
  ChartDataClassTime? classTime;
  ChartDataClassTime? freeTime;

  factory ChartData.fromMap(Map<String, dynamic> json) => ChartData(
        totalTime: ChartDataClassTime.fromMap(json["totalTime"]),
        studyTime: ChartDataClassTime.fromMap(json["studyTime"]),
        classTime: ChartDataClassTime.fromMap(json["classTime"]),
        freeTime: ChartDataClassTime.fromMap(json["freeTime"]),
      );

  Map<String, dynamic> toMap() => {
        "totalTime": totalTime!.toMap(),
        "studyTime": studyTime!.toMap(),
        "classTime": classTime!.toMap(),
        "freeTime": freeTime!.toMap(),
      };
}

class ChartDataClassTime {
  ChartDataClassTime({
    this.total,
  });

  String? total;

  factory ChartDataClassTime.fromMap(Map<String, dynamic> json) =>
      ChartDataClassTime(
        total: json["total"],
      );

  Map<String, dynamic> toMap() => {
        "total": total,
      };
}

class DeviceUsage {
  DeviceUsage({
    this.totalTime,
    this.studyTime,
    this.classTime,
    this.freeTime,
  });

  DeviceUsageClassTime? totalTime;
  DeviceUsageClassTime? studyTime;
  DeviceUsageClassTime? classTime;
  DeviceUsageClassTime? freeTime;

  factory DeviceUsage.fromMap(Map<String, dynamic> json) => DeviceUsage(
        totalTime: DeviceUsageClassTime.fromMap(json["totalTime"]),
        studyTime: DeviceUsageClassTime.fromMap(json["studyTime"]),
        classTime: DeviceUsageClassTime.fromMap(json["classTime"]),
        freeTime: DeviceUsageClassTime.fromMap(json["freeTime"]),
      );

  Map<String, dynamic> toMap() => {
        "totalTime": totalTime!.toMap(),
        "studyTime": studyTime!.toMap(),
        "classTime": classTime!.toMap(),
        "freeTime": freeTime!.toMap(),
      };
}

class DeviceUsageClassTime {
  DeviceUsageClassTime({
    this.mobile,
    this.laptop,
  });

  String? mobile;
  String? laptop;

  factory DeviceUsageClassTime.fromMap(Map<String, dynamic> json) =>
      DeviceUsageClassTime(
        mobile: json["mobile"],
        laptop: json["laptop"],
      );

  Map<String, dynamic> toMap() => {
        "mobile": mobile,
        "laptop": laptop,
      };
}
