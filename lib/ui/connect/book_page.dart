import 'package:bisa_app/animation/fade_animation.dart';
// import 'package:bisa_app/models/connect_res.dart';
import 'package:bisa_app/models/models.dart';
import 'package:bisa_app/providers/current_user_provider.dart';
import 'package:bisa_app/services/api_service.dart';
import 'package:bisa_app/ui/chat/start_question.dart';
import 'package:bisa_app/ui/widgets/popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:bisa_app/utils/date_formatter.dart';
// import 'package:paystack_manager/paystack_pay_manager.dart';

class BookPage extends StatefulWidget {
  BookPage({Key? key, required this.doctor}) : super(key: key);
  final Doctor doctor;

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> with SingleTickerProviderStateMixin{
  @override
  void initState() {
    selectedId = 0;
    _tabController = TabController(vsync: this, length: 6);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  // var selectedDay = DateTime.now().weekday != 7? DateTime.now():DateTime.now().add(Duration(days: 1));
  var selectedTime;
  late CurrentUser currentUser;

  var selectedColor = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromRGBO(0, 139, 123, 0.73),
      Color.fromRGBO(128, 190, 50, 0.4891),
    ],
    tileMode: TileMode.decal
  );

  var unselectedColor = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.white,
      Colors.white
    ],
    tileMode: TileMode.decal
  );

  var unselectedBtn = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.grey.shade200,
      Colors.grey.shade200
    ],
    tileMode: TileMode.decal
  );

  var selectedText = Colors.white;
  var unSelectedText = Color.fromRGBO(107, 107, 107, 1);
  var unSelectedBtnText = Colors.grey;

  // ignore: unused_field
  bool _saving = false;

  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    
    currentUser = context.read<CurrentUserProvider>().currentUser!;
    var daysList=[];
    var mondays = widget.doctor.days!.where((element) => element.day=="monday").toList();
    daysList.add({
      'id':1,
      'name':'Mon',
      'list':mondays
      });
    var tus = widget.doctor.days!.where((element) => element.day=="tuesday").toList();
    daysList.add({'id':2,'name':'Tue','list':tus});
    var weds = widget.doctor.days!.where((element) => element.day=="wednesday").toList();
    daysList.add({'id':3,'name':'Wed','list':weds});
    var thur = widget.doctor.days!.where((element) => element.day=="thursday").toList();
    daysList.add({'id':4,'name':'Thur','list':thur});
    var fri = widget.doctor.days!.where((element) => element.day=="friday").toList();
    daysList.add({'id':5,'name':'Fri','list':fri});
    var sat = widget.doctor.days!.where((element) => element.day=="saturday").toList();
    daysList.add({'id':6,'name':'Sat','list':sat});

    var now = DateTime.now();
    if(now.weekday != 7){
      daysList.firstWhere((element)=> element['id'] == now.weekday)['day'] = now.day;
      daysList.firstWhere((element)=> element['id'] == now.weekday)['dateTime'] = now;
    }
    if(now.weekday+1 != 7){
      if(now.weekday+1 < 7){
        daysList.firstWhere((element)=> element['id'] == now.weekday+1)?['day'] = now.add(Duration(days: 1)).day;
        daysList.firstWhere((element)=> element['id'] == now.weekday+1)?['dateTime'] = now.add(Duration(days: 1));
      }
      else{
        daysList.firstWhere((element)=> element['id'] == (now.weekday+1)%7)['day'] = now.add(Duration(days: 1)).day;
        daysList.firstWhere((element)=> element['id'] == (now.weekday+1)%7)['dateTime'] = now.add(Duration(days: 1));
      }
    }
    if(now.weekday+2 != 7){
      if(now.weekday+2 < 7){
        daysList.firstWhere((element)=> element['id'] == now.weekday+2)?['day'] = now.add(Duration(days: 2)).day;
        daysList.firstWhere((element)=> element['id'] == now.weekday+2)?['dateTime'] = now.add(Duration(days: 2));
      }
      else{
        daysList.firstWhere((element)=> element['id'] == (now.weekday+2)%7)['day'] = now.add(Duration(days: 2)).day;
        daysList.firstWhere((element)=> element['id'] == (now.weekday+2)%7)['dateTime'] = now.add(Duration(days: 2));
      }
    }
    if(now.weekday+3 != 7){
      if(now.weekday+3 < 7){
        daysList.firstWhere((element)=> element['id'] == now.weekday+3)?['day'] = now.add(Duration(days: 3)).day;
        daysList.firstWhere((element)=> element['id'] == now.weekday+3)?['dateTime'] = now.add(Duration(days: 3));
      }
      else{
        daysList.firstWhere((element)=> element['id'] == (now.weekday+3)%7)['day'] = now.add(Duration(days: 3)).day;
        daysList.firstWhere((element)=> element['id'] == (now.weekday+3)%7)['dateTime'] = now.add(Duration(days: 3));
      }
    }
    if(now.weekday+4 != 7){
      if(now.weekday+4 < 7){
        daysList.firstWhere((element)=> element['id'] == now.weekday+4)?['day'] = now.add(Duration(days: 4)).day;
        daysList.firstWhere((element)=> element['id'] == now.weekday+4)?['dateTime'] = now.add(Duration(days: 4));
      }
      else{
        daysList.firstWhere((element)=> element['id'] == (now.weekday+4)%7)['day'] = now.add(Duration(days: 4)).day;
        daysList.firstWhere((element)=> element['id'] == (now.weekday+4)%7)['dateTime'] = now.add(Duration(days: 4));
      }
    }
    if(now.weekday+5 != 7){
      if(now.weekday+5 < 7){
        daysList.firstWhere((element)=> element['id'] == now.weekday+5)?['day'] = now.add(Duration(days: 5)).day;
        daysList.firstWhere((element)=> element['id'] == now.weekday+5)?['dateTime'] = now.add(Duration(days: 5));
      }
      else{
        daysList.firstWhere((element)=> element['id'] == (now.weekday+5)%7)['day'] = now.add(Duration(days: 5)).day;
        daysList.firstWhere((element)=> element['id'] == (now.weekday+5)%7)['dateTime'] = now.add(Duration(days: 5));
      }
    }
    if(now.weekday+6 != 7){
      if(now.weekday+6 < 7){
        daysList.firstWhere((element)=> element['id'] == now.weekday+6)?['day'] = now.add(Duration(days: 6)).day;
        daysList.firstWhere((element)=> element['id'] == now.weekday+6)?['dateTime'] = now.add(Duration(days: 6));
      }
      else{
        daysList.firstWhere((element)=> element['id'] == (now.weekday+6)%7)['day'] = now.add(Duration(days: 6)).day;
        daysList.firstWhere((element)=> element['id'] == (now.weekday+6)%7)['dateTime'] = now.add(Duration(days: 6));
      }
    }

    daysList.sort((a,b){
      DateTime aDate = a['dateTime'];
      DateTime bDate = b['dateTime'];
      return aDate.compareTo(bDate);
    });

    // print(selectedDay);

    var nowD = daysList[selectedId]['dateTime'];
    print(nowD);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.98),
        title: Text('Book Appointment',
          style: TextStyle(
            fontFamily: 'Lato',
            fontSize: 25.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              tag: '${widget.doctor.image}${widget.doctor.id}',
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      color: Colors.white,
                      height: 120.h,
                      width: 118.w,
                      child: FadeInImage.assetNetwork(
                        placeholder:'assets/imgs/manager1.png',
                        image: '${widget.doctor.image}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Dr. ${widget.doctor.firstName}',
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 23.sp,
                            fontWeight: FontWeight.w600,
                            // letterSpacing: 2,
                            height: 0.99,
                            color: Color.fromRGBO(0, 0, 0, 1)),
                        maxLines: 2,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        'Heart Specialist',
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(108, 108, 108, 1)),
                        // maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      // Row(
                      //   children: [
                      //     Container(
                      //       width: 40.w,
                      //       height: 50.h,
                      //       decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(6.r),
                      //           gradient: LinearGradient(
                      //               begin: Alignment.topLeft,
                      //               end: Alignment.bottomRight,
                      //               colors: [
                      //                 Color.fromRGBO(0, 139, 123, 0.73),
                      //                 Color.fromRGBO(128, 190, 50, 0.4891),
                      //               ],
                      //               tileMode: TileMode.decal),
                      //           boxShadow: [
                      //             BoxShadow(
                      //                 offset: Offset(0, 4),
                      //                 blurRadius: 27,
                      //                 spreadRadius: 0,
                      //                 color: Color.fromRGBO(0, 139, 123, 0.19))
                      //           ]),
                      //       child: Center(
                      //         child: Column(
                      //           mainAxisSize: MainAxisSize.min,
                      //           children: [
                      //             Icon(
                      //               Icons.phone_forwarded_outlined,
                      //               color: Colors.white,
                      //               size: 18,
                      //             ),
                      //             SizedBox(
                      //               height: 6.h,
                      //             ),
                      //             Text(
                      //               'Call',
                      //               style: TextStyle(
                      //                   fontFamily: 'Lato',
                      //                   fontWeight: FontWeight.w600,
                      //                   fontSize: 13.sp,
                      //                   color: Colors.white),
                      //             )
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 8.w,
                      //     ),
                      //     Container(
                      //       width: 40.w,
                      //       height: 50.h,
                      //       decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(6.r),
                      //           color: Colors.white,
                      //           boxShadow: [
                      //             BoxShadow(
                      //                 offset: Offset(0, 4),
                      //                 blurRadius: 27,
                      //                 spreadRadius: 0,
                      //                 color: Color.fromRGBO(0, 139, 123, 0.19))
                      //           ]),
                      //       child: Center(
                      //         child: Column(
                      //           mainAxisSize: MainAxisSize.min,
                      //           children: [
                      //             Image.asset('assets/imgs/visit_icon.png'),
                      //             SizedBox(
                      //               height: 6.h,
                      //             ),
                      //             Text(
                      //               'Visit',
                      //               style: TextStyle(
                      //                   fontFamily: 'Lato',
                      //                   fontWeight: FontWeight.w600,
                      //                   fontSize: 13.sp,
                      //                   color:
                      //                       Color.fromRGBO(147, 198, 63, 0.71)),
                      //             )
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            // FadeAnimation(1.2,-10,0,
            //   Text(
            //     'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse habitasse.Lorem ipsum dolor sit amet, consectetur adipiscing elit. SuspendisseLorem ipsum dolor sit amet.',
            //     style: TextStyle(
            //       fontFamily: 'Lato',
            //       fontSize: 15.sp,
            //       fontWeight: FontWeight.w400,
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 48.h,
            // ),
            FadeAnimation(1.2,-10,0,Row(
              children: [
                Text(
                  '${DateFormatter().getMonth(nowD.month)} ${nowD.year}',
                  style: TextStyle(
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w700,
                      fontSize: 18.sp),
                ),
                SizedBox(
                  width: 8.w,
                ),
                // Icon(Icons.keyboard_arrow_down_rounded)
              ],
            ),),
            SizedBox(
              height: 8.h,
            ),
            FadeAnimation(1.2,-10,0,Container(
              height: 70.h,
              child: buildDays(days:daysList),
            ),),
            SizedBox(
              height: 30.h,
            ),
            FadeAnimation(1.2,-10,0,
            Container(
              height: 100,
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  buildTimes(daysList[0]['list']),
                  buildTimes(daysList[1]['list']),
                  buildTimes(daysList[2]['list']),
                  buildTimes(daysList[3]['list']),
                  buildTimes(daysList[4]['list']),
                  buildTimes(daysList[5]['list']),
                ],
              ),
            ),
            ),
            SizedBox(
              height: 30.h,
            ),
            FadeAnimation(1.2,-10,0,Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    if(selectedTime != null){
                      //  _processPayment();
                       showConfirmation();
                    }
                  },
                  child: Container(
                    width: 183.w,
                    height: 38.h,
                    decoration: BoxDecoration(
                      gradient: selectedTime != null ? selectedColor :  unselectedBtn,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 139, 123, 0.19),
                          offset: Offset(0, 4),
                          blurRadius: 30,
                          spreadRadius: 0
                        )
                      ]
                    ),
                    child: Center(
                      child: Text(
                        'Confirm Appointment',
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp,
                          color: selectedTime != null? selectedText : unSelectedBtnText
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),)
          ],
        ),
      ),
    );
  }

  Widget buildTimes(List<Day> times) {
    if(times.length > 0){
      return Wrap(
        spacing: 4,
        runSpacing: 8,
        children: times.map((e){
          return InkWell(
            onTap: (){
              setState(() {
                selectedTime = e.id;
              });
              print(selectedTime);
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: 83.w,
              height: 30.h,
              decoration: BoxDecoration(
                gradient: selectedTime == e.id ? selectedColor : unselectedColor,
                borderRadius: BorderRadius.circular(26.r),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(108, 104, 104, 0.15),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: Offset(0, 8)
                  )
                ]
              ),
              child: Center(
                child: Text(
                  '${e.time?.split(' ')[0]}',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w600,
                    fontSize: 13.sp,
                    color: selectedTime == e.id ? selectedText : unselectText,
                  ),
                )
              ),
            ),
          );
        }).toList()
      );
    }else{
      return Text('Doctor will not be available. Please select another day',
        style: TextStyle(
          fontFamily: 'Lato',
          fontWeight: FontWeight.w600,
          fontSize: 13.sp,
          color: unSelectedText,
        ),
      );
    }
    
  }

  Widget buildDays({required List<dynamic> days}) {

    // days.firstWhere((element)=> element['id'] == now.weekday+3)?['day'] = now.weekday+3;
    // days.firstWhere((element)=> element['id'] == now.weekday+4)?['day'] = now.weekday+4;
    // days.firstWhere((element)=> element['id'] == now.weekday+5)?['day'] = now.weekday+5;
    // days.firstWhere((element)=> element['id'] == now.weekday+6)?['day'] = now.weekday+6;
    return Container(
      decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          offset: Offset(0, 4),
          blurRadius: 5,
          spreadRadius: 0,
          // color: Color.fromRGBO(0, 139, 123, 0.19),
          color: Color.fromRGBO(108, 104, 104, 0.15),
        )
      ]
    ),
      child: ListView.separated(
        itemCount: days.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index){
          return SizedBox(
            width: 8.w,
          );
        },
        itemBuilder: (context, index){
          
          return Padding(
            padding: EdgeInsets.all(2.0),
            child: InkWell(
              onTap: (){
                setState(() {
                  // selectedDay = days[index]['id'];
                  selectedId = index;
                  selectedTime = null;
                });
                _tabController.animateTo(selectedId);
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: 55.w,
                height: 60.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  // gradient: selectedDay == days[index]['id']?selectedColor:unselectedColor,
                  gradient: selectedId == index?selectedColor:unselectedColor,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 8,
                      spreadRadius: 0,
                      // color: Color.fromRGBO(0, 139, 123, 0.19),
                      color: Color.fromRGBO(108, 104, 104, 0.15),
                    )
                  ]
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      '${days[index]['name']}',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp,
                        // color: selectedDay == days[index]['id']? selectedText:unSelectedText
                        color: selectedId == index? selectedText:unSelectedText
                      ),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Text(
                      '${days[index]['day']}',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w600,
                        fontSize: 28.sp,
                        color: selectedId == index? selectedText:unSelectedText
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        // children: [
        //   Container(
        //     width: 55.w,
        //     height: 55.h,
        //     decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(6.r),
        //         color: Colors.white,
        //         boxShadow: [
        //           BoxShadow(
        //               offset: Offset(0, 4),
        //               blurRadius: 27,
        //               spreadRadius: 0,
        //               color: Color.fromRGBO(0, 139, 123, 0.19))
        //         ]),
        //     child: Center(
        //       child: Column(
        //         mainAxisSize: MainAxisSize.min,
        //         children: [
        //           Text(
        //             'Fri',
        //             style: TextStyle(
        //                 fontFamily: 'Lato',
        //                 fontWeight: FontWeight.w600,
        //                 fontSize: 12.sp,
        //                 color: Color.fromRGBO(158, 155, 155, 1)),
        //           ),
        //           SizedBox(
        //             height: 6.h,
        //           ),
        //           Text(
        //             '17',
        //             style: TextStyle(
        //                 fontFamily: 'Lato',
        //                 fontWeight: FontWeight.w600,
        //                 fontSize: 28.sp,
        //                 color: Color.fromRGBO(107, 107, 107, 1)),
        //           )
        //         ],
        //       ),
        //     ),
        //   ),
        // ],
      ),
    );
  }

  void _processPayment() {
    try {
      // PaystackPayManager(context: context)
      //   // Don't store your secret key on users device.
      //   // Make sure this is retrive from your server at run time
      //   ..setSecretKey("sk_test_4bc1809fcd590182ee672518e204a0a796acd48b")
      //   //accepts widget
      //   ..setCompanyAssetImage(Image(
      //     image: AssetImage("assets/imgs/bisa_icon.png"),
      //   ))
      //   ..setAmount(1000)
      //   // ..setReference("your-unique-transaction-reference")
      //   ..setReference(DateTime.now().millisecondsSinceEpoch.toString())
      //   ..setCurrency("GHS")
      //   ..setEmail(currentUser.email ?? "Unkown")
      //   ..setFirstName(currentUser.fname ?? "Ambrose")
      //   ..setLastName(currentUser.lname ?? "Bako")
      //   ..setMetadata(
      //     {
      //       "custom_fields": [
      //         {
      //           "value": "Bisa Connect",
      //           "display_name": "Payment to",
      //           "variable_name": "payment_to"
      //         }
      //       ]
      //     },
      //   )
      //   ..onSuccesful(_onPaymentSuccessful)
      //   ..onPending(_onPaymentPending)
      //   ..onFailed(_onPaymentFailed)
      //   ..onCancel(_onPaymentCancelled)
      //   ..initialize();
    } catch (error) {
      print("Payment Error ==> $error");
    }
  }

  // void _onPaymentSuccessful(Transaction transaction) {
  //   print("Transaction was successful");
  //   print("Transaction Message ===> ${transaction.message}");
  //   print("Transaction Refrence ===> ${transaction.refrenceNumber}");
  //   submitBooking();
  // }

  // void _onPaymentPending(Transaction transaction) {
  //   print("Transaction is pendinng");
  //   print("Transaction Refrence ===> ${transaction.refrenceNumber}");
  // }

  // void _onPaymentFailed(Transaction transaction) {
  //   print("Transaction failed");
  //   print("Transaction Message ===> ${transaction.message}");
  // }

  // void _onPaymentCancelled(Transaction transaction) {
  //   print("Transaction was cancelled");
  // }

  void showConfirmation() {
    print(selectedTime);
    // var slt;
    Day slt = widget.doctor.days!.firstWhere((element) => element.id == selectedTime);
    showModalBottomSheet(
      context: context, 
      builder: (BuildContext context){
        return Container(
          height: 400.h,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(

              children: [
                SizedBox(height: 20.h,),
                Text('Confirm Appointment',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w600,
                    fontSize: 22.sp,
                    color: Color.fromRGBO(0, 0, 0, 1)
                  ),
                ),
                SizedBox(height: 20.h,),
                Text('Please confirm the details of your appointment',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                    color: Color.fromRGBO(158, 155, 155, 1)
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Doctor:',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp,
                        color: Colors.black54
                      ),
                    ),
                    Text('Dr. ${widget.doctor.firstName}',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp,
                        color: Colors.black
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Day:',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp,
                        color: Colors.black54
                      ),
                    ),
                    Text('${slt.day!.toUpperCase()}',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp,
                        color: Colors.black
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Time:',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp,
                        color: Colors.black54
                      ),
                    ),
                    Text('${slt.time}',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp,
                        color: Colors.black
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h,),
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                    _processPayment();
                    
                  },
                  child: Container(
                    width: 183.w,
                    height: 38.h,
                    decoration: BoxDecoration(
                      gradient: selectedColor,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 139, 123, 0.19),
                          offset: Offset(0, 4),
                          blurRadius: 30,
                          spreadRadius: 0
                        )
                      ]
                    ),
                    child: Center(
                      child: Text(
                        'Proceed to Payment',
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp,
                          color: selectedText
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h,),
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Text('Cancel',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w600,
                      fontSize: 20.sp,
                      color: Colors.black
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }

  void submitBooking() {

    // setState(() {
    //   _saving = true;
    // });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 5,
          child: Container(
            height: 200.h,
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator.adaptive(),
                  Text('Processing...')
                ],
              ),
            ),
          ),
        );
      }
    );
    Day slt = widget.doctor.days!.firstWhere((element) => element.id == selectedTime);

    Map<String, dynamic> dataMap = {
      "doctorId": slt.doctorId,
      "day":slt.day,
      "time":slt.time,
      "token": currentUser.token
    };

    sendBooking(dataMap)
    .then((value){
      if (value['status'] == 'success'){
        Navigator.pop(context);
        return showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
              backgroundColor: Colors.transparent,
              child: Container(
                padding: EdgeInsets.all(18),
                width: 0.7.sw,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/imgs/booking.png',
                        height: 90.h,
                      ),
                    ),
                    SizedBox(height: 18.h),
                    // SizedBox(height: 20.h),
                    Text(
                      'Appointment Completed Successfuly.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          ?.copyWith(fontSize: 18.sp),
                    ),
                    SizedBox(height: 30.h),
                    SizedBox(
                      width: 0.4.sw,
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Color.fromRGBO(181, 226, 85, 1),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, .25),
                                blurRadius: 20,
                                offset: Offset(0, 10)
                              )
                            ]
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 15, right: 25, left: 25, bottom: 15.0
                              ),
                              child: Text('Okay',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400
                                )
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        );
       
      }else {
        // setState(() {
        //   _saving = false;
        // });
        Navigator.pop(context);
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            return Popup(
              msg: value.message,
            );
          }
        );
      }
    })
    .catchError((onError){
      setState(() {
        _saving = false;
      });
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Popup(
            msg: onError,
          );
        }
      );
    });
  }
}
