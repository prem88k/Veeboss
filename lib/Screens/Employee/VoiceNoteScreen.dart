import 'dart:convert';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:record_mp3/record_mp3.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../Contants/Colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Presentation/common_widgets.dart';
import '../../Presentation/rounded_button.dart';
import '../LoginScreen.dart';
import 'BottomNavigationBarEmploye.dart';


class VoiceNote extends StatefulWidget {
  int id;
  VoiceNote(this.id);

  @override
  State<VoiceNote> createState() => _VoiceNoteState();
}

class _VoiceNoteState extends State<VoiceNote> {
  String statusText = "";
  int maxduration = 100;
  String currentpostlabel = "0:0:0";
  bool isComplete = false;
  bool isLocal = false;
  int currentpos = 0;
  AudioPlayer audioPlayer = AudioPlayer();
  bool isReset = false;
  Stream<int>? timerStream;
  StreamSubscription<int>? timerSubscription;
  String hoursStr = "0";
  String minutesStr = '0';
  String secondsStr = '0';
  int? language = 1 ;
  bool isLoading=false;
  bool jobsLoading=false;
  String? recordFilePath;

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _expSalaryController = TextEditingController();
  final TextEditingController _experienceYearController = TextEditingController();
  final TextEditingController _qualificationController = TextEditingController();
  final TextEditingController _otherSelectLanguage = TextEditingController();

  List multipleSelected = [];
  List checkListItems = [
    {
      "id": 0,
      "value": true,
      "title": "English",
    },
    {
      "id": 1,
      "value": false,
      "title": "Kannada",
    },
    {
      "id": 2,
      "value": false,
      "title": "Hindi",
    },
    {
      "id": 3,
      "value": false,
      "title": "Telugu",
    },
    {
      "id": 4,
      "value": false,
      "title": "Tamil",
    },
    {
      "id": 5,
      "value": false,
      "title": "Malyalam",
    },
    {
      "id": 6,
      "value": false,
      "title": "Other",
    },
  ];

  @override
  void initState() {
    Future.delayed(Duration.zero,  () async {
      audioPlayer.onDurationChanged.listen((Duration d) { //get the duration of audio
        maxduration = d.inMilliseconds;
        setState(() {

        });
      });
      audioPlayer.onPlayerComplete.listen((event) {
        resetPlayer();
      });
      audioPlayer.onPositionChanged.listen((Duration  p){
        currentpos = p.inMilliseconds; //get the current position of playing audio
        //generating the duration label
        int shours = Duration(milliseconds:currentpos).inHours;
        int sminutes = Duration(milliseconds:currentpos).inMinutes;
        int sseconds = Duration(milliseconds:currentpos).inSeconds;

        int rhours = shours;
        int rminutes = sminutes - (shours * 60);
        int rseconds = sseconds - (sminutes * 60 + shours * 60 * 60);

        currentpostlabel = "$rhours:$rminutes:$rseconds";

        setState(() {
          //refresh the UI
        });
      }, onDone: () => {
        resetPlayer()
      }, cancelOnError: true);

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(
        bottomOpacity: 0,
        shape: Border(
            bottom: BorderSide(
                color: borderColors,
                width: 0.5
            )
        ),
        elevation: 0,
        title: Text(
          "Apply now for your dream job !",
          style: TextStyle(
              fontFamily: 'railway',
              color: appText,
              fontSize: size.height * 0.023,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: appBackground,
        iconTheme: IconThemeData(
            color: appText,
            size: size.height * 0.035 //change your color here
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(size.height * 0.015),
          child: Padding(
            padding:  EdgeInsets.only(top: size.height * 0.01),
            child: Column(children: [
              Container(
                margin: EdgeInsets.only(left: size.width * 0.060, bottom: size.height * 0.01),
                child: Text(
                  "Choose any Required Language",
                  style: TextStyle(
                    fontSize: size.height * 0.022,
                    color: appButton,
                    fontFamily: 'railway',
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Column(
                      children:  List.generate(
                        checkListItems.length,
                            (index) => Theme(
                          data: Theme.of(context).copyWith(
                            unselectedWidgetColor: appText,
                          ),
                          child: CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            contentPadding: EdgeInsets.zero,
                            activeColor: appButton,
                            checkColor: appText,
                            dense: true,
                            title: Text(
                              checkListItems[index]["title"],
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: appText,
                                fontFamily: 'railway',
                              ),
                            ),
                            value:  checkListItems[index]["value"],
                            onChanged: (value) {
                              setState(() {
                                checkListItems[0]["true"] = true;
                                checkListItems[index]["value"] = value;
                                if (multipleSelected.contains(checkListItems[index])) {
                                  multipleSelected.remove(checkListItems[index]);
                                } else {
                                  multipleSelected.add(checkListItems[index]);
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ),

                    checkListItems[6]["value"] ?
                    Padding(
                      padding: EdgeInsets.only(top: 15.0, left: 0.0, right: 30.0, bottom: 15.0),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _otherSelectLanguage,
                        style: TextStyle(
                            fontFamily: 'railway',
                            fontSize: size.height * 0.02,
                            fontWeight: FontWeight.normal,
                            color: appText),
                        decoration: InputDecoration(
                          labelText: 'Other Language',
                          labelStyle: TextStyle(
                              fontFamily: 'railway',
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.normal,
                              color: appText),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: primaryTextColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(

                              color: primaryTextColor,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: primaryTextColor, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ) : Container(),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(left: size.width * 0.060,top: size.height*0.035),
                child: Text(
                  "Record Yourself",
                  style: TextStyle(
                    fontSize: size.height * 0.025,
                    color: appButton,
                    fontFamily: 'railway',
                  ),
                ),
              ),

              SizedBox(height: size.height*0.020,),

              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: size.width * 0.060),
                child: Text(
                  "*  Say something about yourself",
                  style: TextStyle(
                    fontSize: size.height * 0.018,
                    color: appText,
                    fontFamily: 'railway',
                  ),
                ),
              ),

              SizedBox(height: size.height*0.035,),

              Container(
                child: Text(currentpostlabel, style: TextStyle(
                    fontFamily: 'railway',
                    color: appText,
                    fontSize: size.height * 0.018,
                    fontWeight: FontWeight.normal)),
              ),

              Container(
                  child: Slider(
                    value: double.parse(currentpos.toString()),
                    min: 0.0,
                    max: double.parse(maxduration.toString()),
                    divisions: maxduration,
                    label: currentpostlabel,
                    activeColor: appButton,
                    onChanged: (double value) async {
                      int seekval = value.round();
                      int result = seekval; /*await audioPlayer.seek(Duration(milliseconds: seekval));*/
                      if(result == 1){ //seek successful
                        currentpos = seekval;
                      }else{
                        print("Seek unsuccessful.");
                      }
                    },
                  )
              ),
              // recordFilePath == null ?
              !isComplete ?
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  Expanded(
                    child: GestureDetector(
                      child: Container(
                        height: 48.0,
                        child: Center(
                          child: Icon(
                            Icons.not_started_outlined,
                            color: appText,
                            size:size.height*0.055,
                          ),
                        ),
                      ),
                      onTap: () async {
                        startRecord(
                        );
                      },
                    ),
                  ),

                  Expanded(
                    child: GestureDetector(
                      child: Container(
                        height: 48.0,
                        child: Center(
                          child:RecordMp3.instance.status == RecordStatus.PAUSE
                              ? Icon(
                            Icons.not_started_outlined,
                            color: appText,
                            size:size.height*0.055,
                          ):Icon(
                            Icons.pause_circle_outline,
                            color: appText,
                            size:size.height*0.055,
                          ),
                        ),
                      ),
                      onTap: () {
                        pauseRecord();
                      },
                    ),
                  ),

                  Expanded(
                    child: GestureDetector(
                      child: Container(
                        height: 48.0,
                        child: Center(
                          child: Icon(
                            Icons.stop_circle_outlined,
                            color: appText,
                            size:size.height*0.055,
                          ),
                        ),
                      ),
                      onTap: () {
                        stopRecord();
                      },
                    ),
                  )
                ],
              ):Container(),

              Text(
                statusText,
                style: TextStyle(
                    fontFamily: 'railway',
                    color: appText,
                    fontSize: size.height * 0.018,
                    fontWeight: FontWeight.normal),),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      play();
                    },
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          alignment: AlignmentDirectional.center,
                          child: isComplete && recordFilePath != null
                              ? Column(
                            children: [
                              Icon(
                                Icons.not_started_outlined,
                                size:size.height*0.055,
                                color: appText,
                              ),
                              SizedBox(
                                height: size.height * 0.0,
                              ),
                              Text("Play Audio",
                                style: TextStyle(
                                    fontFamily: 'railway',
                                    color: appText,
                                    fontSize: size.height * 0.015,
                                    fontWeight: FontWeight.normal),),
                            ],
                          )
                              : Container(),
                        ),
                      ],
                    ),
                  ),

                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      resetPlayer();
                    },
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          alignment: AlignmentDirectional.center,
                          child: isComplete && (recordFilePath != null || recordFilePath != " ")
                              ? Column(
                            children: [
                              Icon(
                                Icons.restart_alt_outlined,
                                size:size.height*0.055,
                                color: appText,
                              ),
                              SizedBox(
                                height: size.height * 0.0,
                              ),
                              Text("Reset Audio",
                                style: TextStyle(
                                    fontFamily: 'railway',
                                    color: appText,
                                    fontSize: size.height * 0.015,
                                    fontWeight: FontWeight.normal),),
                            ],
                          )
                              : Container(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(left: 10.0, right:  10.0, top: 10.0),
                child: TextFieldWidget(
                  controller: _descriptionController,
                  title: "Description",
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 10.0, right:  10.0),
                child: TextFieldWidget(
                  controller: _expSalaryController,
                  title: "Expected Salary",
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 10.0, right:  10.0),
                child: TextFieldWidget(
                  controller: _qualificationController,
                  title: "Qualification",
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 10.0, right:  10.0),
                child: TextFieldWidget(
                  controller: _experienceYearController,
                  title: "Years of Experience",
                ),
              ),

              SizedBox(height: size.height * 0.040,),
              jobsLoading
                  ? CircularProgressIndicator(
                backgroundColor: buttonTextColor,
              )
                  : RoundedButton(
                text: "Apply Now",
                color: appButton,
                press: () {
                  ApplyJobs(widget.id.toInt());
                },
              ),
              /*  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isLoading
                          ? CircularProgressIndicator(
                        backgroundColor: buttonTextColor,
                      )
                          :   GestureDetector(
                        onTap: () {
                          ApplyJobs(widget.id.toInt());
                        },
                        child: Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.all(size.width * 0.01),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: buttonTextColor,
                              boxShadow: [],
                            ),
                            width: size.width * 0.8,
                            height: size.height * 0.065,
                            child:Center(
                                child: Text(
                                  "Apply To Jobs",
                                  style: TextStyle(
                                      fontFamily: 'railway',
                                      fontSize: size.width * 0.031,
                                      color: whiteTextColor),
                                ))),
                      ),
                    ],
                  ),*/
              SizedBox(height: size.height*0.025,),

            ]),
          ),
        ),
      ),
    );
  }

  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  void startRecord() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      statusText = "Start Recording";
      recordFilePath = await getFilePath();
      isComplete = false;
      RecordMp3.instance.start(recordFilePath!, (type) {
        statusText = "Record error--->$type";
      });
      timerStream = stopWatchStream();
      timerSubscription = timerStream!.listen((int newTick) {
        setState(() {
          if(mounted) return;
          // hoursStr = (()).floor().toString().padLeft(1, '0');
          minutesStr = ((newTick / 60) % 60).floor().toString().padLeft(1, '0');
          secondsStr = (newTick % 60).floor().toString().padLeft(1, '0');
          currentpostlabel = '$hoursStr:$minutesStr:$secondsStr';
        });

      });
    } else {
      statusText = "No microphone permission";
    }
    setState(() {});
  }

  void pauseRecord() {
    if (RecordMp3.instance.status == RecordStatus.PAUSE) {
      bool s = RecordMp3.instance.resume();
      if (s) {
        statusText = "Recording Stop...";
        setState(() {});
      }
    } else {
      bool s = RecordMp3.instance.pause();
      if (s) {
        statusText = "Recording pause...";
        setState(() {});
      }
    }
  }

  void stopRecord() {
    bool s = RecordMp3.instance.stop();
    if (s) {
      statusText = "Record complete";
      // At Recording Stop :
      timerSubscription!.cancel();
      timerStream = null;
      setState(() {
        isComplete = true;
        hoursStr = "0";
        minutesStr = '0';
        secondsStr = '0';
      });
    }
  }

  void resumeRecord() {
    bool s = RecordMp3.instance.resume();
    if (s) {
      statusText = "Recording...";
      setState(() {});
    }
  }

  Stream<int> stopWatchStream() {
    StreamController<int>? streamController;
    Timer? timer;
    Duration timerInterval = Duration(seconds: 1);
    int counter = 0;

    void stopTimer() {
      if (timer != null) {
        timer!.cancel();
        timer = null;
        counter = 0;
        streamController!.close();
      }
    }

    void tick(_) {
      counter++;
      streamController!.add(counter);
      // stopTimer();
    }

    void startTimer() {
      timer = Timer.periodic(timerInterval, tick);
    }

    streamController = StreamController<int>(
      onListen: startTimer,
      onCancel: stopTimer,
      onResume: startTimer,
      onPause: stopTimer,
    );

    return streamController.stream;
  }

  void play() {
    if (recordFilePath != null && File(recordFilePath!).existsSync()) {
      audioPlayer.play(DeviceFileSource(recordFilePath!));

    }
  }

  int i = 0;

  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = storageDirectory.path + "/record";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return sdPath + "/test_${i++}.mp3";
  }

  resetPlayer() {
    currentpostlabel = "0:0:0";
    currentpos = 0;
    setState(() {
      isComplete = false;
      recordFilePath = " ";
      statusText = " ";
    });
  }



  Future<void> ApplyJobs(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      jobsLoading = true;
    });

    var url = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/job/apply',
    );

    var request = new http.MultipartRequest("POST", url);
    request.fields['job_id'] = id.toString();
    request.fields['description'] = _descriptionController.text;
    request.fields['expected_salary'] = _expSalaryController.text;
    request.fields['qualification'] = _qualificationController.text;
    request.fields['experience'] = _experienceYearController.text;
    request.headers['x-session-token'] = '${prefs.getString('sessionToken')}';
    if(language != null)
    {
      request.fields['language'] =  checkListItems[6]["value"] ?  _otherSelectLanguage.text : language.toString();
    }


    if(recordFilePath != null)
    {
      request.files.add(
          http.MultipartFile(
              'voice_note',
              File(recordFilePath!).readAsBytes().asStream(),
              File(recordFilePath!).lengthSync(),
              filename: recordFilePath!.split("/").last
          ));
    }


    request.send().then((response) {
      if (response.statusCode == 200) {
        print("Uploaded!");
        int statusCode = response.statusCode;
        print("response::$response");
        Message(context, "Applied Job Successfully");
        response.stream.transform(utf8.decoder).listen((value) {
          print("ResponseSellerVerification" + value);
          setState(() {
            //  _showDialog(context);
            jobsLoading = false;
          });
          FocusScope.of(context).requestFocus(FocusNode());
          Future.delayed(const Duration(milliseconds: 1000), () {
            setState(() {
              jobsLoading = false;
              _showDialog(context);
            });
          });
        });
      } else {
        setState(() {
          if(!mounted) return;
          jobsLoading = false;
        });
        Message(context," Something went Wrong");
      }
    }
    );
  }

  _showDialog(BuildContext ctx) {
    Size size = MediaQuery.of(context).size;
    showDialog(
      builder: (context) => SimpleDialog(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
            color: Colors.white,
            child: Image.asset(
              "assets/images/checklist.png",
              height: 110.0,
            ),
          ),
          Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  "Are you want to applied this job ?",
                  style: TextStyle(
                      fontFamily: "railway",
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      fontSize: 15.0),
                ),
              )),
          Container(
            padding: EdgeInsets.only(top: 15.0),
            child: Center(
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return BottomNavigationBarEmploye();
                          },
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.all(size.width * 0.01),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: buttonTextColor,
                              boxShadow: [
                                BoxShadow(color: buttonTextColor, spreadRadius: 1),
                              ],
                            ),
                            width: size.width * 0.25,
                            height: size.height * 0.05,
                            child: Center(
                                child: Text(
                                  "OK",
                                  style: TextStyle(
                                      fontFamily: 'railway',
                                      fontSize: size.width * 0.04,
                                      color: whiteTextColor),
                                ))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ), context: ctx,
      barrierDismissible: true,
    );
  }
}