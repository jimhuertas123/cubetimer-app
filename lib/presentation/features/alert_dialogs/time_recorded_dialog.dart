
import 'package:cube_timer_2/config/test-data/times_recorded.dart';
import 'package:cube_timer_2/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';


String getMonthAbbreviation(String month) {
  const monthAbbreviations = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  final monthInt = int.tryParse(month);
  return (monthInt != null && monthInt >= 1 && monthInt <= 12)
      ? monthAbbreviations[monthInt - 1]
      : '';
}

class ShowTimerRecordedDialog extends StatefulWidget {
  final BuildContext context;
  final String comments;
  final Date recordedDate;
  final Time recordedTime;
  final SolveTime solveTime;
  final String scramble;
  final Penalty penalty;

  const ShowTimerRecordedDialog(
      {super.key,
      required this.context,
      required this.comments,
      required this.scramble, 
      required this.penalty, 
      required this.recordedDate,
      required this.recordedTime,
      required this.solveTime
    });

  @override
  State<ShowTimerRecordedDialog> createState() =>
      _ShowTimerRecordedDialogState();
}

class _ShowTimerRecordedDialogState extends State<ShowTimerRecordedDialog> {
  bool showImage = false;

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      enableHeight: false,
      fontTittleSize: 20.0,
      context: widget.context,
      insetPadding: const EdgeInsets.symmetric(horizontal: 0),
      contentPadding:
          const EdgeInsets.only(right: 0, left: 0, top: 0, bottom: 0),
      tittleContent: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //time recorded
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "19.",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Text(
                  "36",
                  style: TextStyle(
                      fontSize: 26, fontWeight: FontWeight.bold, height: 1.45, color: Colors.black),
                ),
                SizedBox(width: 5),
                Text(
                  widget.penalty == Penalty.noPenalty 
                    ? ""
                    : widget.penalty == Penalty.dnf
                      ? "DNF"
                      : "+2",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 2,
                    color: Colors.red
                  ),
                )
              ],
            ),

            //date recorded
            Row(
              children: [
                Icon(Icons.date_range_outlined, size: 20, color: Colors.black),
                SizedBox(width: 5),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "${widget.recordedDate.day} ${getMonthAbbreviation(widget.recordedDate.month)} ${widget.recordedDate.year}",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.black
                        )),
                    Text(widget.recordedTime.time, style: TextStyle(fontSize: 11, color: Colors.black)),
                  ],
                )
              ],
            )
          ],
        ),
      ),
      content: <Widget>[
        Divider(
          height: 1,
          thickness: 1,
          color: Colors.black12,
        ),
        Column(
          children: <Widget>[
            Visibility(
                maintainSize: false,
                visible: widget.comments != "",
                child: Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 10),
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      Icon(Icons.comment_outlined, size: 20, color: Colors.black),
                      SizedBox(width: 15),
                      Text(widget.comments, style: TextStyle(fontSize: 15, color: Colors.black)),
                    ],
                  ),
                )),
            GestureDetector(
              onTap: () {
                setState(() {
                  showImage = !showImage;
                });
              },
              child: Container(
                padding:
                    EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    Icon(Icons.casino_outlined, size: 20, color: Colors.black,),
                    SizedBox(width: 15),
                    SizedBox(
                      width: MediaQuery.of(context).size.width > 450
                          ? MediaQuery.of(context).size.width - 680
                          : MediaQuery.of(context).size.width - 170,
                      child: Text(
                        widget.scramble,
                        style: TextStyle(fontSize: 15, color: Colors.black),
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    SizedBox(width: 20),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 20,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            AnimatedSize(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: showImage
                  ? Container(
                      margin: EdgeInsets.only(left: 40, bottom: 20),
                      child: Image.asset(
                        'assets/category/ic_3x3.png',
                        height: 100,
                        width: 100,
                      ),
                    )
                  : SizedBox.shrink(),
            ),
          ],
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: Colors.black12,
        ),
      ],
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    shape: const CircleBorder(),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    overlayColor: Colors.black),
                onPressed: () {},
                child: Icon(Icons.more_horiz, color: Colors.black)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 40,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(0),
                          shape: const CircleBorder(),
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          overlayColor: Colors.black),
                      onPressed: () {},
                      child: Icon(Icons.comment_outlined, color: Colors.black)),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 40,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(0),
                          shape: const CircleBorder(),
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          overlayColor: Colors.black),
                      onPressed: () {},
                      child: Icon(Icons.flag_outlined, color: Colors.black)),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}

