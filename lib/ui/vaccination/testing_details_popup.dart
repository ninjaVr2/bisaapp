import 'package:bisa_app/models/testing_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPopUp extends StatefulWidget {
  DetailsPopUp({Key? key, required this.center}) : super(key: key);
  final Testingcenters center;
  @override
  State<DetailsPopUp> createState() => _DetailsPopUpState();
}

class _DetailsPopUpState extends State<DetailsPopUp> with SingleTickerProviderStateMixin{
  late TabController _tabController;

  // ignore: unused_field
  Future<void>? _launched;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 19,vertical: 10),
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 44, 85, 1),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(67, 67, 67, 0.25),
                    offset: Offset(0,2),
                    blurRadius: 4,
                    spreadRadius: 0
                  )
                ]
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text("${widget.center.name}",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w700,
                            fontSize: 19.sp
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        
                      ),
                      InkWell(
                        onTap:(){
                          Navigator.pop(context);
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.close,color: Color.fromRGBO(0, 44, 85, 1),),
                        ),
                      )
                    ],
                  ),
                  TabBar(
                    controller: _tabController,
                    labelStyle: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    labelColor: Colors.white,
                    indicatorColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorWeight: 2,
                    tabs: [
                      Tab(
                        child: Text(
                          'Contact',
                          ),
                      ),
                      Tab(child: Text('Pricing')),
                    ],
                  
                  ),  
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 19),
              height: 160.h,
              color: Colors.white,
              child: TabBarView(
                controller: _tabController,
                children: [
                  contactPage(widget.center),
                  pricePage(widget.center)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  contactPage(Testingcenters center) {
    var phones = center.contact?.split('/');
    var phone1 = phones?[0].trim();
    print("tel:$phone1");
    // var phone2 = phones?[1].trim();
    // print(phones?[1].trim());
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 8,),
        InkWell(
          onTap: (){
            print("start call");
            // setState(() {
            //   _launched = _makePhoneCall('tel:0232323345');
            // });
            launch("tel:$phone1");
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            height: 55.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(192, 189, 189, 0.23),
                  offset: Offset(0,6),
                  blurRadius: 5,
                )
              ]
            ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${phones?[0].trim()}',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: Color.fromRGBO(0, 44, 85, 1)
                    ),
                  ),
                  Icon(Icons.phone_outlined,color: Color.fromRGBO(0, 44, 85, 1),)
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 8,),
        phones!.length >1?
        InkWell(
          onTap: (){
            var phone2 = phones[1].trim();
            print("tel:$phone2");
            launch('tel:$phone2');
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            height: 55.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(192, 189, 189, 0.23),
                  offset: Offset(0,6),
                  blurRadius: 5,
                )
              ]
            ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${phones[1].trim()}',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: Color.fromRGBO(0, 44, 85, 1)
                    ),
                  ),
                  Icon(Icons.phone_outlined,color: Color.fromRGBO(0, 44, 85, 1),)
                ],
              ),
            ),
          ),
        )
        :SizedBox.shrink()
      ],
    );
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  pricePage(Testingcenters center) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 8,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          height: 55.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(192, 189, 189, 0.23),
                offset: Offset(0,6),
                blurRadius: 5,
              )
            ]
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Standard',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                        color: Color.fromRGBO(0, 44, 85, 1)
                      ),
                    ),
                    Text('Get results within ${center.duration}.',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w500,
                        fontSize: 10.sp,
                        color: Color.fromRGBO(139, 139, 139, 1)
                      ),
                    ),
                  ],
                ),
                Text('GHS ${center.standardPrice}',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                    color: Color.fromRGBO(0, 44, 85, 1)
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8,),
        center.premiumPrice == null?
        SizedBox.shrink()
        :
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          height: 55.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(192, 189, 189, 0.23),
                offset: Offset(0,6),
                blurRadius: 5,
              )
            ]
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Premium',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                        color: Color.fromRGBO(0, 44, 85, 1)
                      ),
                    ),
                    Text('Get results within ${center.duration}.',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w500,
                        fontSize: 10.sp,
                        color: Color.fromRGBO(139, 139, 139, 1)
                      ),
                    ),
                  ],
                ),
                Text('GHS ${center.premiumPrice}',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                    color: Color.fromRGBO(0, 44, 85, 1)
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}