import 'package:bisa_app/models/current_user.dart';
import 'package:bisa_app/models/testing_res.dart';
import 'package:bisa_app/providers/current_user_provider.dart';
import 'package:bisa_app/services/api_service.dart';
import 'package:bisa_app/ui/vaccination/testing_centers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_animation_transition/animations/right_to_left_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:provider/src/provider.dart';

class TestingRegion extends StatefulWidget {
  TestingRegion({Key? key}) : super(key: key);

  @override
  State<TestingRegion> createState() => _TestingRegionState();
}

class _TestingRegionState extends State<TestingRegion> {
  late CurrentUser currentUser;

  @override
  Widget build(BuildContext context) {
    currentUser = context.read<CurrentUserProvider>().currentUser!;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Select a Region',
          style: TextStyle(
            fontFamily: 'Lato',
            fontWeight: FontWeight.w700,
            fontSize: 28.sp,
            color: Color.fromRGBO(36, 52, 99, 0.98)
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: loadTesting(currentUser.token),
          builder: (context,AsyncSnapshot<TestingRes> snapshot){
            if(snapshot.hasData){
              List<Data> regions = snapshot.data!.data!;
              
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: regions.map((e){
                    e.testingcenters!.sort((a,b)=>a.name!.compareTo(b.name!));
                    return InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          PageAnimationTransition(
                            pageAnimationType: RightToLeftTransition(),
                            page: TestingCenters(centers:e.testingcenters!)
                          )
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight:Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10) 
                          ),
                          gradient: LinearGradient(
                            colors: [Color.fromRGBO(191, 207, 146, 1), Color.fromRGBO(141, 199, 96, 0.37)],
                          ),
                        ),
                        padding: EdgeInsets.all(1),
                        child: Container(
                          width: 1.sw - 16,
                          height: 60.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight:Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10) 
                            ),
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromRGBO(178, 159, 159, 0.25),
                                offset: Offset(0,4),
                                blurRadius: 32,
                                spreadRadius: 4
                              )
                            ]
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal:12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text("${e.name}",
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22.sp,
                                    color: Color.fromRGBO(36, 52, 99, 1)
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.black,
                                ),
                                
                              ],
                            ),
                          )),
                      ),
                    );
                  }).toList(),
                ),
              );
            }
            else{
              return Container(
                width: 1.sw,
                height: 1.sh,
                alignment: Alignment.center,
                child: CircularProgressIndicator.adaptive(),
              );
            }
            
          }
        ),
      ),
    );
  }
}