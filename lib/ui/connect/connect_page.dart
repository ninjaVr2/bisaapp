import 'package:bisa_app/animation/fade_animation.dart';
// import 'package:bisa_app/models/connect_res.dart';
import 'package:bisa_app/models/models.dart';
import 'package:bisa_app/providers/current_user_provider.dart';
import 'package:bisa_app/services/api_service.dart';
// import 'package:bisa_app/ui/chat/start_question.dart';
import 'package:bisa_app/ui/connect/book_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_animation_transition/animations/right_to_left_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:provider/provider.dart';

class ConnectPage extends StatefulWidget {
  ConnectPage({Key? key}) : super(key: key);

  @override
  _ConnectPageState createState() => _ConnectPageState();
}

var selectedId;
late CurrentUser currentUser;
late TabController _tabController;

var selectedColor = [
  Color.fromRGBO(0, 139, 123, 0.73),
  Color.fromRGBO(128, 190, 50, 0.4891),
];
var unselectedColor = [Colors.white, Colors.white];

var selectText = Color.fromRGBO(255, 255, 255, 1);
var unselectText = Color.fromRGBO(92, 94, 86, 1);

var selectedShadow = BoxShadow(
  color: Color.fromRGBO(0, 139, 123, 0.19),
  blurRadius: 30,
  spreadRadius: 0,
  offset: Offset(0, 4)
);
var unSelectedShadow = BoxShadow(
  color: Color.fromRGBO(0, 0, 0, 0.1),
  blurRadius: 30,
  spreadRadius: 0,
  offset: Offset(0, 4)
);
// Color.fromRGBO(0, 0, 0, 0.1);

class _ConnectPageState extends State<ConnectPage> with SingleTickerProviderStateMixin{
  @override
  void initState() {
    selectedId = 1;
    _tabController = TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    currentUser = context.read<CurrentUserProvider>().currentUser!;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.98),
        title: Text('Find a doctor',
          style: TextStyle(
            fontFamily: 'Lato',
            fontSize: 25.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.98),
      body: Padding(
        padding: EdgeInsets.all(12.w),
        child: FutureBuilder(
          future: getBooking(currentUser.token),
          builder: (context, AsyncSnapshot<ConnectRes> snapshot) {
            if(snapshot.hasData){
              // print(snapshot.data);
              List<Doctor>? cdoctors = snapshot.data?.data?.specialties?.where((element) => element.id == 1).first.doctors;
              List<Doctor>? fdoctors = snapshot.data?.data?.specialties?.where((element) => element.id == 2).first.doctors;
              List<Doctor>? hdoctors = snapshot.data?.data?.specialties?.where((element) => element.id == 3).first.doctors;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w700,
                      fontSize: 27.sp,
                      color: Color.fromRGBO(85, 80, 80, 0.98)
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Container(
                    height: 120.h,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, .21),
                          blurRadius: 100,
                          offset: Offset(0, 5)
                        )
                      ]
                    ),
                    // width: double.infinity,
                    child: buildCategories(),
                  ),
                  SizedBox(
                    height: 48.h,
                  ),
                  Text(
                    'Specialists',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w700,
                      fontSize: 27.sp,
                      color: Color.fromRGBO(85, 80, 80, 0.98)
                    ),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: [
                        buildSpecialists(context,docs:cdoctors?? []),
                        buildSpecialists(context,docs:fdoctors?? []),
                        buildSpecialists(context,docs:hdoctors?? []),
                      ],
                    ),
                  )
                ],
              );
            }else{
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
          }
        ),
      ),
    );
  }

  ListView buildSpecialists(BuildContext context, {required List<Doctor> docs}) {
    // print(docs.length);
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: docs.length,
      itemBuilder: (context,index){
        Doctor doctor = docs[index];
        return FadeAnimation(
          (1.0 + (index) / 10),
          -30,
          0,
          InkWell(
          onTap: () {
            Navigator.push(
              context,
              PageAnimationTransition(
                pageAnimationType: RightToLeftTransition(), page: BookPage(doctor:doctor)
              )
            );
          },
          child: Hero(
            tag: '${doctor.image}${doctor.id}',
            child: Container(
              height: 80.h,
              width: 1.sw - 25.w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(176, 167, 167, 0.17),
                        blurRadius: 30,
                        offset: Offset(0, 2),
                        spreadRadius: 10)
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/imgs/manager1.png',
                      image: '${doctor.image}',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 23.w,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dr. ${doctor.firstName}',
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 21.sp,
                            fontWeight: FontWeight.w600,
                            // letterSpacing: 2,
                            height: 0.99,
                            color: Color.fromRGBO(0, 0, 0, 1)),
                        maxLines: 2,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      // Html(
                      //   data:'${e['content'].split('>')[2]}',
                      //   shrinkWrap: true,
                      // ),
                      Text(
                        'Heart Specialist',
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(108, 108, 108, 1)
                        ),
                        // maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        tileMode: TileMode.decal,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromRGBO(0, 139, 123, 0.73),
                          Color.fromRGBO(128, 190, 50, 0.4891),
                        ]
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.calendar_today_rounded,
                        color: Colors.white,
                      ),
                    )
                  ),
                  SizedBox(
                    width: 15.w,
                  )
                ],
              ),
            ),
          ),
        ));
      },
      separatorBuilder: (context, index){
        return SizedBox(height: 10.h);
      },
      
    );
  }

  ListView buildCategories() {
    return ListView(             
      scrollDirection: Axis.horizontal,
      children: [
        FadeAnimation(1.2,-30,0,InkWell(
          onTap: (){
            selectCat(1);
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: 85.w,
            height: 100.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isSelected(1) ? selectedColor : unselectedColor,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                tileMode: TileMode.decal
              ),
              borderRadius: BorderRadius.circular(10),
              // boxShadow: [
              //   isSelected(1) ? selectedShadow : unSelectedShadow,
              // ]
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/imgs/stethoscope1.png',
                  height: 40.h,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'Cancer',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                      color: isSelected(1) ? selectText : unselectText),
                )
              ],
            ),
          ),
        ),),
        SizedBox(
          width: 8.w,
        ),
        FadeAnimation(1.4,-30,0,InkWell(
          onTap: (){
            selectCat(2);
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: 85.w,
            height: 100.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors:
                      isSelected(2) ? selectedColor : unselectedColor,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(10),
              // boxShadow: [
              //   isSelected(2) ? selectedShadow : unSelectedShadow
              // ]
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/imgs/stethoscope1.png',
                  height: 40.h,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'Fibroid',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                      color: isSelected(2) ? selectText : unselectText),
                )
              ],
            ),
          ),
        ),),
        SizedBox(
          width: 8.w,
        ),
        FadeAnimation(1.6,-30,0,InkWell(
          onTap: (){
            selectCat(3);
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: 85.w,
            height: 100.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors:
                      isSelected(3) ? selectedColor : unselectedColor,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(10),
              // boxShadow: [
              //   isSelected(3) ? selectedShadow : unSelectedShadow
              // ]
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/imgs/stethoscope1.png',
                  height: 40.h,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'Hepatisis',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                      color: isSelected(3) ? selectText : unselectText),
                )
              ],
            ),
          ),
        ),),
        SizedBox(
          width: 8.w,
        ),
      ],
    );
  }

  void selectCat(int i) {
    setState(() {
      selectedId = i;    
    });
    _tabController.animateTo(i-1);
  }

  bool isSelected(int i) {
    return selectedId == i ? true : false;
  }
}
