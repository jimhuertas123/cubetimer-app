import 'package:cube_timer_2/presentation/providers/providers.dart';
import 'package:cube_timer_2/presentation/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimesContainer extends ConsumerStatefulWidget {
  const TimesContainer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TimesContainerState();
}

class _TimesContainerState extends ConsumerState<TimesContainer> {
  final Set<int> selectedIndices = <int>{};

  @override
  Widget build(BuildContext context) {
    final textThemeColor = ref.watch(themeNotifierProvider).actualThemeIndex;
    final Orientation oritation = MediaQuery.of(context).orientation;
    //checks if the actual text color of global theme is black color so the entire
    // content will be rendered with a black background
    bool isBlackThemeColor = textThemeColor == 1 || textThemeColor == 13;

    return SafeArea(
      child: Column(children: <Widget>[
        selectedIndices.isEmpty
            ? _searchTimesBar(isBlackThemeColor)
            : DeleteTimesNavigation(
                indexLenght: selectedIndices.length,
                isBlackThemeColor: isBlackThemeColor,
                onPressed: () => setState(() {
                  selectedIndices.clear();
                }),
              ),
        Expanded(
          child: StretchingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            child: GridView.builder(
              physics: const BouncingScrollPhysics(
                decelerationRate: ScrollDecelerationRate.normal,
              ),
              padding: const EdgeInsets.only(top: 10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 66,
                crossAxisCount: oritation == Orientation.portrait ? 3 : 6,
                childAspectRatio: 3 / 1,
              ),
              itemCount: 100,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () {
                    if (selectedIndices.contains(index)) {
                      setState(() {
                        selectedIndices.remove(index);
                      });
                    } else {
                      setState(() {
                        selectedIndices.add(index);
                      });
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: isBlackThemeColor
                          ? selectedIndices.contains(index)
                              ? Color(0xff4F4F4F)
                              : Color(0xff1F1F1F)
                          : selectedIndices.contains(index)
                              ? Color(0xffEFEFEF)
                              : Color(0xFFFFFEFF),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: selectedIndices.contains(index)
                            ? Colors.black
                            : Colors.transparent,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(30),
                          spreadRadius: 0.3,
                          blurRadius: 2.5,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        shape: const BeveledRectangleBorder(),
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: () {
                        selectedIndices.isEmpty
                            ? showDialog(
                                context: context,
                                builder: (context) => ShowTimerRecordedDialog(
                                    context: context, index: index))
                            // ) showTimeRecordedDialog(context, index)
                            : (selectedIndices.contains(index))
                                ? setState(() {
                                    selectedIndices.remove(index);
                                  })
                                : setState(() {
                                    selectedIndices.add(index);
                                  });
                      },
                      child: Column(children: [
                        SizedBox(height: 5),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 8),
                            Text(
                              "${index + 1}${index + 1}/${index + 1}${index + 1}",
                              style: TextStyle(
                                fontSize: 11,
                                height: 1,
                                color: isBlackThemeColor
                                    ? Color(0XFFFFFFEF)
                                    : Colors.black,
                              ),
                            ),
                            Expanded(child: Container()),
                            Text(
                              "+${index + 1}",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                height: 1,
                              ),
                            ),
                            SizedBox(width: 8),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '1:23',
                              style: TextStyle(
                                color: !isBlackThemeColor
                                    ? Colors.black
                                    : Colors.white70,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ".10",
                              style: TextStyle(
                                  color: !isBlackThemeColor
                                      ? Colors.black
                                      : Colors.white70,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                  height: 1.7),
                            )
                          ],
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 8),
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.comment_outlined,
                              size: 13,
                              color: !isBlackThemeColor
                                  ? Colors.black
                                  : Colors.white70,
                            ))
                      ]),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ]),
    );
  }

  // Future<dynamic> showTimeRecordedDialog(BuildContext context, int index) {
  //   bool showImage = false;
  //   return showDialog(
  //     context: context,
  //     builder: (context) =>
  // }

  Container _searchTimesBar(bool isBlackThemeColor) => Container(
        margin: const EdgeInsets.only(top: 10.0, left: 8.0, right: 8.0),
        height: 35,
        decoration: BoxDecoration(
          color: isBlackThemeColor ? Color(0xff1F1F1F) : Color(0xFFFFFEFF),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(30),
              spreadRadius: 0.3,
              blurRadius: 2.5,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            GestureDetector(
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  height: 35,
                  child: Icon(
                    Icons.alarm_add,
                    size: 18,
                    color: !isBlackThemeColor ? Colors.black : Colors.white70,
                  )),
              onTap: () => print('Add new time'),
            ),
            Container(
              height: 35,
              width: 1,
              color: Colors.black38,
            ),
            SizedBox(width: 20),
            Expanded(
              child: TextField(
                maxLines: 1,
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  hintText: 'Search comments',
                  hintStyle: TextStyle(
                    color: !isBlackThemeColor ? Colors.black : Colors.white70,
                    fontSize: 15,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.only(
                      right: 60, top: 0, bottom: 10, left: 0),
                ),
                style: TextStyle(
                  fontSize: 15,
                  color: !isBlackThemeColor ? Colors.black : Colors.white70,
                ),
                cursorColor: Colors.red, // Customize the cursor color
              ),
            ),
            SizedBox(
              width: 35,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                  shape: const CircleBorder(),
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                child: Icon(
                  Icons.archive_outlined,
                  color: !isBlackThemeColor ? Colors.black : Colors.white70,
                  size: 20,
                ),
                onPressed: () {},
              ),
            ),
            SizedBox(
              width: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                  shape: const CircleBorder(),
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                child: Icon(
                  Icons.more_vert,
                  color: !isBlackThemeColor ? Colors.black : Colors.white70,
                  size: 20,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      );
}

class ShowTimerRecordedDialog extends StatefulWidget {
  final BuildContext context;
  final int index;

  const ShowTimerRecordedDialog(
      {super.key, required this.context, required this.index});

  @override
  State<ShowTimerRecordedDialog> createState() =>
      _ShowTimerRecordedDialogState();
}

class _ShowTimerRecordedDialogState extends State<ShowTimerRecordedDialog> {
  bool showImage = false;

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);

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
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text(
                  "36",
                  style: TextStyle(
                      fontSize: 26, fontWeight: FontWeight.bold, height: 1.45),
                )
              ],
            ),

            //date recorded
            Row(
              children: [
                Icon(Icons.date_range_outlined, size: 20),
                SizedBox(width: 5),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("22 Feb 2025", style: TextStyle(fontSize: 11)),
                    Text("14:44", style: TextStyle(fontSize: 11)),
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
                visible: widget.index == 1,
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 10),
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      Icon(Icons.comment_outlined, size: 20),
                      SizedBox(width: 15),
                      Text("Comments", style: TextStyle(fontSize: 15)),
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
                padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    Icon(Icons.casino_outlined, size: 20),
                    SizedBox(width: 15),
                    SizedBox(
                      width:  MediaQuery.of(context).size.width > 450 
                        ? MediaQuery.of(context).size.width - 680
                        : MediaQuery.of(context).size.width - 170,
                      child: Text(
                        "R' U 2F M 2F 2B 2R L R F' 2B 2R L R F' asdasd",
                        style: TextStyle(fontSize: 15),
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    SizedBox(width: 20),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 20,
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
                overlayColor: Colors.black
              ),
              onPressed: () {}, child: Icon(Icons.more_horiz, color: Colors.black)),
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
                      overlayColor: Colors.black
                    ),
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
                      overlayColor: Colors.black
                    ),
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

class DeleteTimesNavigation extends StatefulWidget {
  final bool isBlackThemeColor;
  final int indexLenght;
  final void Function() onPressed;

  const DeleteTimesNavigation({
    super.key,
    required this.isBlackThemeColor,
    required this.indexLenght,
    required this.onPressed,
  });

  @override
  State<DeleteTimesNavigation> createState() => _DeleteTimesNavigationState();
}

class _DeleteTimesNavigationState extends State<DeleteTimesNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      height: 35,
      decoration: BoxDecoration(
        color: Color(0xFFFFFEFF),
        border: Border(
          bottom: BorderSide(
            color: widget.isBlackThemeColor ? Colors.red : Colors.green,
            width: 2,
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          ElevatedButton(
              onPressed: widget.onPressed,
              style: ElevatedButton.styleFrom(
                iconColor: Colors.black,
                padding: const EdgeInsets.all(0),
                iconSize: 20.0,
                shape: const CircleBorder(),
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
              child: Icon(Icons.close)),
          Expanded(
              child: Text(
            "${widget.indexLenght} solve selected",
            // textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          )),
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                iconColor: Colors.black,
                padding: const EdgeInsets.all(0),
                iconSize: 20.0,
                shape: const CircleBorder(),
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
              child: Icon(Icons.delete_sweep_outlined)),
        ],
      ),
    );
  }
}
