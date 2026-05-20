import 'dart:io';
import 'package:digitalads/views/screens/storeApp/widgets/commonButton.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class AdvertiserAdContentScreen extends StatefulWidget {
  const AdvertiserAdContentScreen({super.key});

  @override
  State<AdvertiserAdContentScreen> createState() =>
      _AdvertiserAdContentScreenState();
}

class _AdvertiserAdContentScreenState extends State<AdvertiserAdContentScreen> {
  final List<Map<String, dynamic>> ads = [
    {
      "title": "Tata Curve",
      "date": "18 July 2025 at 10:44",
      "image": "assets/images/tata.png",
      "isVideo": false,
      "status": "Approved",
      "description":
          "The Tata Curve is a futuristic SUV concept with elegant design and advanced features.",
    },
    {
      "title": "Mhindra be 6",
      "date": "18 July 2025 at 10:44",
      "image": "assets/images/mahindra.png",
      "isVideo": true,
      "status": "Approved",
      "description":
          "The Mahindra BE6 is a rear-wheel-drive electric SUV built on Mahindra's new INGLO platform, positioned in the premium EV space.",
    },
  ];

  void _openAdDetail(Map<String, dynamic> adData) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _AdDetailsBottomSheet(adData: adData),
    );
  }

  void _openAddAdBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const _AddAdBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,

      /// Floating button
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFFF385C),
        onPressed: _openAddAdBottomSheet,
        child: const Icon(Icons.add, color: Colors.white),
      ),

      /// Ad content list
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: w * 0.04,
          vertical: h * 0.015,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ad Content List",
              style: TextStyle(fontSize: w * 0.05, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: h * 0.015),

            /// Search + Filter
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: h * 0.055,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade100,
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: w * 0.03),
                        Icon(
                          Icons.search,
                          color: Colors.grey.shade600,
                          size: w * 0.05,
                        ),
                        SizedBox(width: w * 0.03),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText:
                                  "Search By Campaign, Advertiser Or Status",
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: w * 0.033,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: w * 0.025),
                Container(
                  height: h * 0.055,
                  width: w * 0.12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade100,
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Icon(Icons.filter_list, color: Colors.grey.shade700),
                ),
              ],
            ),

            SizedBox(height: h * 0.02),

            /// Ad list cards
            Expanded(
              child: ListView.builder(
                itemCount: ads.length,
                itemBuilder: (context, index) {
                  var ad = ads[index];
                  return GestureDetector(
                    onTap: () => _openAdDetail(ad),
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: h * 0.015),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(w * 0.03),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  ad["image"],
                                  width: w * 0.22,
                                  height: w * 0.18,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: w * 0.04),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ad["title"],
                                      style: TextStyle(
                                        fontSize: w * 0.04,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: h * 0.004),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_today_outlined,
                                          color: Colors.grey.shade600,
                                          size: w * 0.035,
                                        ),
                                        SizedBox(width: w * 0.015),
                                        Text(
                                          ad["date"],
                                          style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: w * 0.03,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// ✅ Approved tag (Top Right)
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: w * 0.03,
                              vertical: h * 0.005,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.thumb_up,
                                  color: Colors.green,
                                  size: w * 0.035,
                                ),
                                SizedBox(width: w * 0.01),
                                Text(
                                  ad["status"],
                                  style: TextStyle(
                                    color: Colors.green.shade700,
                                    fontSize: w * 0.032,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 🔹 Bottom Sheet for ad details
class _AdDetailsBottomSheet extends StatefulWidget {
  final Map<String, dynamic> adData;
  const _AdDetailsBottomSheet({required this.adData});

  @override
  State<_AdDetailsBottomSheet> createState() => _AdDetailsBottomSheetState();
}

class _AdDetailsBottomSheetState extends State<_AdDetailsBottomSheet> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    if (widget.adData["isVideo"]) {
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(
          "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
        ),
      )..initialize().then((_) => setState(() {}));
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: h * 0.02,
        left: w * 0.04,
        right: w * 0.04,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 5,
                width: w * 0.12,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: h * 0.02),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  widget.adData["isVideo"]
                      ? (_controller != null && _controller!.value.isInitialized
                            ? AspectRatio(
                                aspectRatio: _controller!.value.aspectRatio,
                                child: VideoPlayer(_controller!),
                              )
                            : Container(
                                height: h * 0.25,
                                color: Colors.black12,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ))
                      : Image.asset(
                          widget.adData["image"],
                          width: double.infinity,
                          height: h * 0.25,
                          fit: BoxFit.cover,
                        ),
                  if (widget.adData["isVideo"])
                    GestureDetector(
                      onTap: () {
                        if (_controller!.value.isPlaying) {
                          _controller!.pause();
                        } else {
                          _controller!.play();
                        }
                        setState(() {});
                      },
                      child: CircleAvatar(
                        radius: w * 0.08,
                        backgroundColor: Colors.white,
                        child: Icon(
                          _controller!.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.pinkAccent,
                          size: w * 0.08,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: h * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.adData["title"],
                  style: TextStyle(
                    fontSize: w * 0.045,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "18 July 2025 at 10:44",
                  style: TextStyle(
                    fontSize: w * 0.03,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: h * 0.01),
            Text(
              widget.adData["description"],
              style: TextStyle(
                fontSize: w * 0.035,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: h * 0.03),
          ],
        ),
      ),
    );
  }
}

/// 🔹 Bottom Sheet for Add New Ad
class _AddAdBottomSheet extends StatefulWidget {
  const _AddAdBottomSheet();

  @override
  State<_AddAdBottomSheet> createState() => _AddAdBottomSheetState();
}

class _AddAdBottomSheetState extends State<_AddAdBottomSheet> {
  final _picker = ImagePicker();
  File? selectedFile;
  bool isVideo = false;
  VideoPlayerController? _controller;

  Future<void> _pickFile() async {
    final choice = await showModalBottomSheet<String>(
      context: context,
      builder: (ctx) => Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.image),
            title: const Text('Upload Image'),
            onTap: () => Navigator.pop(ctx, 'image'),
          ),
          ListTile(
            leading: const Icon(Icons.video_library),
            title: const Text('Upload Video'),
            onTap: () => Navigator.pop(ctx, 'video'),
          ),
        ],
      ),
    );

    if (choice == 'image') {
      final file = await _picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        setState(() {
          selectedFile = File(file.path);
          isVideo = false;
        });
      }
    } else if (choice == 'video') {
      final file = await _picker.pickVideo(source: ImageSource.gallery);
      if (file != null) {
        setState(() {
          selectedFile = File(file.path);
          isVideo = true;
          _controller = VideoPlayerController.file(selectedFile!)
            ..initialize().then((_) => setState(() {}));
        });
      }
    }
  }

  void _removeFile() {
    setState(() {
      selectedFile = null;
      isVideo = false;
      _controller?.dispose();
      _controller = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: h * 0.02,
        left: w * 0.05,
        right: w * 0.05,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 5,
                width: w * 0.12,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: h * 0.02),
            Center(
              child: Text(
                "Add new ad content",
                style: TextStyle(
                  fontSize: w * 0.045,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: h * 0.03),
            Text(
              "Campaign",
              style: TextStyle(
                fontSize: w * 0.035,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: h * 0.008),
            TextField(
              decoration: InputDecoration(
                hintText: "Campaign Name",
                contentPadding: EdgeInsets.symmetric(
                  horizontal: w * 0.04,
                  vertical: h * 0.015,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: h * 0.02),
            Text(
              "Campaign Description",
              style: TextStyle(
                fontSize: w * 0.035,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: h * 0.008),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "description",
                contentPadding: EdgeInsets.symmetric(
                  horizontal: w * 0.04,
                  vertical: h * 0.015,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: h * 0.02),
            Text(
              "Upload Ad Content",
              style: TextStyle(
                fontSize: w * 0.035,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: h * 0.008),
            GestureDetector(
              onTap: _pickFile,
              child: Container(
                width: double.infinity,
                height: h * 0.15,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: selectedFile == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_upload_outlined,
                            size: w * 0.1,
                            color: Colors.grey.shade500,
                          ),
                          Text(
                            "Upload Your Files Here",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: w * 0.035,
                            ),
                          ),
                          Text(
                            "Supported Format images & Video Only",
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: w * 0.03,
                            ),
                          ),
                        ],
                      )
                    : Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(w * 0.02),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: isVideo
                                  ? (_controller != null &&
                                            _controller!.value.isInitialized
                                        ? AspectRatio(
                                            aspectRatio:
                                                _controller!.value.aspectRatio,
                                            child: VideoPlayer(_controller!),
                                          )
                                        : const Center(
                                            child: CircularProgressIndicator(),
                                          ))
                                  : Image.file(
                                      selectedFile!,
                                      width: double.infinity,
                                      height: h * 0.14,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: InkWell(
                              onTap: _removeFile,
                              child: CircleAvatar(
                                radius: w * 0.03,
                                backgroundColor: Colors.redAccent,
                                child: Icon(
                                  Icons.close,
                                  size: w * 0.035,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            SizedBox(height: h * 0.03),
            CommonButtonWithIcon(text: "Add", onPressed: () {}),
            SizedBox(height: h * 0.03),
          ],
        ),
      ),
    );
  }
}
