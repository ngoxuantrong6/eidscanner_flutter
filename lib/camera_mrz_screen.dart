import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:camera/camera.dart';

class CameraMRZScreen extends StatefulWidget {
  const CameraMRZScreen({super.key});

  @override
  State<CameraMRZScreen> createState() => _CameraMRZScreenState();
}

class _CameraMRZScreenState extends State<CameraMRZScreen> {
  // late CameraController _controller;
  // late Future<void> _initializeControllerFuture;
  static const platform = MethodChannel('read_mrz');

  @override
  void initState() {
    // // Khởi tạo camera controller
    // _controller = CameraController(
    //   // Chọn camera sau (phía sau)
    //   const CameraDescription(
    //     name: '0',
    //     lensDirection: CameraLensDirection.back,
    //     sensorOrientation: 0,
    //   ),
    //   // Độ phân giải ảnh tối đa
    //   ResolutionPreset.high,
    // );
    //
    // // Khởi tạo controller
    // _initializeControllerFuture = _controller.initialize();
    callReadMRZ();
    super.initState();
  }

  // @override
  // void dispose() {
  //   // Hủy bỏ controller khi không cần thiết
  //   _controller.dispose();
  //   super.dispose();
  // }

  void callReadMRZ() async {
    final mrz = await platform.invokeMethod<String>('mrz');
    platform.setMethodCallHandler((call) {
      final dynamic argument = call.arguments;
      switch (call.method) {
        case "onSuccess":
          // String payload = '';

          // _busBookingBloc.dispatch(BookingButtonPressed(
          //     _busBookingBloc.bookingForm, argument, payload));
        print("argggggg $argument");
          break;
      }
      return Future.value(null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Read MRZ')),
      // Sử dụng FutureBuilder để đợi controller khởi tạo xong
      // body: FutureBuilder<void>(
      //   future: _initializeControllerFuture,
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       // Nếu khởi tạo thành công, hiển thị CameraPreview trong Container giữa màn hình
      //       return Center(
      //         child: AspectRatio(
      //           aspectRatio: _controller.value.aspectRatio,
      //           child: CameraPreview(_controller),
      //         ),
      //       );
      //     } else {
      //       // Nếu đang khởi tạo, hiển thị một tiêu đề chờ
      //       return Center(child: CircularProgressIndicator());
      //     }
      //   },
      // ),
      body: Container(),
    );
  }
}
