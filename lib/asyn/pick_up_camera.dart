// import 'dart:async';
// import 'dart:io';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:tianqu/widget/videoPlayer.dart';
// ///App模块类型：图片，视频
// enum FileType { image, video}
// class FileClass {
//   File file;
//   FileType fileType;
//   FileClass({required this.file,required this.fileType});
// }
//
// class PickUpCamera{
//   Future<FileClass> pickUpCamera()async{
//     return (await Get.to(()=>const PickUpCameraWidget()));
//   }
// }
//
// class PickUpCameraWidget extends StatefulWidget {
//   const PickUpCameraWidget({Key? key}) : super(key: key);
//
//   @override
//   State<PickUpCameraWidget> createState() => _PickUpCameraWidgetState();
// }
//
// class _PickUpCameraWidgetState extends State<PickUpCameraWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.black,
//         body: SizedBox(
//           height: Get.height,
//           width: Get.width,
//           child: Stack(children: [
//             SafeArea(
//               child: isInit
//                   ? GestureDetector(
//                 onTapDown: (TapDownDetails detail) {
//                   _onFocus(context, detail.localPosition);
//                 },
//                 child: SizedBox(
//                   width: Get.width,
//                   height: Get.height,
//                   child: Column(
//                     children: [
//                       CameraPreview(
//                         _controller,
//                       )
//                     ],
//                   ),
//                 ),
//               )
//                   : Container(
//                 width: Get.width,
//                 height: Get.height * 0.8,
//                 color: Colors.black,
//               ),
//             ),
//             Positioned(
//               bottom: 0,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 width: Get.width,
//                 height: Get.height * 0.2,
//                 color: Colors.black,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     IconButton(
//                         onPressed: () {},
//                         icon: const Icon(
//                           Icons.flip_camera_android_sharp,
//                           color: Colors.transparent,
//                         )),
//                     GestureDetector(
//                       onLongPress: () {
//                         startVideoRecording();
//                       },
//                       onTap: () async {
//                         await takePicture().then((value) async {
//                           imageFile = value;
//                           final result =
//                           await Get.to(() => showImageOrVideoPage());
//                           if (result != null) {
//                             FileClass fileClass = FileClass(file: File(imageFile!.path), fileType: FileType.image);
//                             Get.back(result: fileClass);
//                           } else {
//                             File(imageFile!.path).deleteSync();
//                             imageFile = null;
//                           }
//                         });
//                       },
//                       onLongPressUp: () async {
//                         stopVideoRecording().then((value) async {
//                           final result =
//                           await Get.to(() => showImageOrVideoPage());
//                           if (result != null) {
//                             FileClass fileClass = FileClass(file: File(videoFile!.path), fileType: FileType.video);
//                             Get.back(result: fileClass);
//                           } else {
//                             File(videoFile!.path).deleteSync();
//                             videoFile = null;
//                           }
//                         });
//                       },
//                       child: Container(
//                         height: 75,
//                         width: 75,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(96),
//                             border: Border.all(color: Colors.white, width: 1)),
//                         child: Stack(
//                           alignment: Alignment.center,
//                           children: [
//                             Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(96),
//                               ),
//                               width: 55,
//                               height: 55,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                         onPressed: () {
//                           _onCameraSwitch();
//                         },
//                         icon: const Icon(
//                           Icons.flip_camera_android_sharp,
//                           color: Colors.white,
//                         )),
//                   ],
//                 ),
//               ),
//             ),
//           ]),
//         ));
//   }
//
//   //查看视频 / 图片
//   Widget showImageOrVideoPage() {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         leading: InkWell(
//           onTap: () {
//             Get.back();
//           },
//           child: const Icon(Icons.arrow_back_ios),
//         ),
//         actions: [
//           ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.transparent,
//               ),
//               onPressed: () => Get.back(result: 1),
//               child: Text("confirm".tr)),
//         ],
//       ),
//       body: Column(
//         children: [
//           videoFile != null
//               ? VideoShowWidget(
//             video: videoFile!.path,
//             isAuto: true,
//           )
//               : Container(),
//           imageFile != null ? Image.file(File(imageFile!.path)) : Container(),
//         ],
//       ),
//     );
//   }
//
//   Future<void> _onFocus(BuildContext context, Offset globalPosition) async {
//     final RenderBox box = context.findRenderObject() as RenderBox;
//     final Offset tapPos = box.globalToLocal(globalPosition);
//     final Size size = box.size;
//     final double relX = tapPos.dx / size.width;
//     final double relY = tapPos.dy / size.height;
//
//     try {
//       await _controller.unlockCaptureOrientation();
//       await _controller.setExposurePoint(Offset(relX, relY));
//       await _controller.setFocusPoint(Offset(relX, relY));
//       await _controller.lockCaptureOrientation();
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//     _cameras = [];
//   }
//
//   late CameraController _controller;
//
//   late List<CameraDescription> _cameras;
//
//   XFile? imageFile;
//
//   XFile? videoFile;
//
//   bool isInit = false;
//
//   bool isRecording = false;
//
//   int maxCount = 60;
//
//   int initCount = 0;
//
//   Timer? timer;
//
//   bool isEnough = false;
//
//   //计数器
//   void startVideoTimer() {
//     initCount = 0;
//     if (isEnough) {
//       setState(() {
//         isEnough = false;
//       });
//     }
//     timer = Timer.periodic(const Duration(seconds: 1), (v) {
//       if (maxCount == initCount) {
//         setState(() {
//           isEnough = true;
//         });
//         stopVideoRecording();
//         v.cancel();
//         return;
//       }
//       setState(() {
//         initCount += 1;
//       });
//     });
//   }
//
//   /// 初始化摄像头
//   Future<void> _initCamera() async {
//     _cameras = await availableCameras();
//
//     /// 获取设备摄像头，默认0:后置 1:前置
//     _controller = CameraController(_cameras[0], ResolutionPreset.max);
//     _controller.initialize().then((_) {
//       /// 这里可以设置个变量用来监控是否初始化完成
//       if (mounted) {
//         setState(() {
//           isInit = true;
//         });
//       } else {
//         return;
//       }
//     });
//   }
//
//   /// 翻转摄像头
//   Future<void> _onCameraSwitch() async {
//     final CameraDescription cameraDescription =
//     (_controller.description == _cameras[0]) ? _cameras[1] : _cameras[0];
//     await _controller.dispose();
//     _controller = CameraController(cameraDescription, ResolutionPreset.max);
//
//     try {
//       await _controller.initialize();
//     } on CameraException catch (e) {
//       Fluttertoast.showToast(msg: e.description!);
//     }
//
//     if (mounted) {
//       setState(() {});
//     }
//   }
//
//   /// 录制视频
//   Future<void> startVideoRecording() async {
//     //如果没有初始化
//     if (!_controller.value.isInitialized) {}
//     isRecording = true;
//     //是否正在录像
//     if (_controller.value.isRecordingVideo) {
//       return;
//     }
//     try {
//       await _controller.startVideoRecording();
//       startVideoTimer();
//
//       /// 开始录制，会卡一下
//     } on CameraException catch (e) {
//       debugPrint("$e");
//     }
//   }
//
//   /// 停止录制
//   Future<void> stopVideoRecording() async {
//     if (!_controller.value.isRecordingVideo) {
//       return;
//
//       /// 如果不在录制，则无效
//     }
//     try {
//       isRecording = false;
//       timer?.cancel();
//       videoFile = await _controller.stopVideoRecording();
//
//       /// 这里为文件地址，测试中我去找的时候未找到，但是可以拿到文件，应该是隐藏地址。
//     } on CameraException catch (e) {
//       debugPrint("$e");
//     }
//   }
//
//   //拍照
//   Future<XFile> takePicture() async {
//     XFile file = await _controller.takePicture();
//     print("file > ${file.path}");
//     return file;
//   }
//
//   @override
//   void initState() {
//     _initCamera();
//     super.initState();
//   }
// }