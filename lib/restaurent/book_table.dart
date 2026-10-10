import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_cafe_app/controller/all_city_controller.dart';
import 'package:salt_cafe_app/controller/book_table_controller.dart';
import 'package:salt_cafe_app/restaurent/payment_succesfull.dart';
import 'package:intl/intl.dart';

class BookTable extends StatefulWidget {
  const BookTable({super.key});

  @override
  State<BookTable> createState() => _BookTableState();
}

class _BookTableState extends State<BookTable> {
  final BookTableController bookTableController = Get.put(
    BookTableController(),
  );
  List<String> generateTimeSlots(
    String startTime,
    String endTime,
    Duration interval,
  ) {
    final slots = <String>[];
    final format = DateFormat.jm(); // e.g., 12:30 PM

    DateTime start = DateFormat.jm().parse(startTime);
    DateTime end = DateFormat.jm().parse(endTime);

    while (start.isBefore(end) || start.isAtSameMomentAs(end)) {
      slots.add(format.format(start));
      start = start.add(interval);
    }
    return slots;
  }

  final AllCityController allCityController = Get.put(AllCityController());

  final List<int> _numbers = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
  ];
  String? _selectedItem;
  //final TextEditingController _controller = TextEditingController();
 


  DateTime? selectedDate;
  int selectedIndex = 0;
  String selectedTime = "";
  String selectedTimeDinner = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth >= 600; // Tablet breakpoint
          final isDesktop = constraints.maxWidth >= 1024; // Desktop breakpoint

          // Adjust font sizes and paddings based on screen size
          double headingFontSize =
              isDesktop ? 40.sp : (isTablet ? 34.sp : 28.sp);
          double bodyFontSize = isDesktop ? 18.sp : (isTablet ? 16.sp : 14.sp);
          double buttonHeight = isDesktop ? 70.h : 45.h;
          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  "assets/images/themeimg.jpeg",
                  fit: BoxFit.cover,
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 40.h,
                        left: 10.h,
                        right: 10.h,
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 20,
                              child: Icon(Icons.arrow_back_ios,size: 15,),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Book a table",
                      style: GoogleFonts.sen(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xffEEA534),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.02),
                    Text(
                      "The Revolution Bar",
                      style: GoogleFonts.sen(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 15.h,
                        left: 10.w,
                        right: 10.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset("assets/images/line.png"),
                          Padding(
                            padding: EdgeInsets.only(top: 20.h),
                            child: Text(
                              "Select number of guests",
                              style: GoogleFonts.sen(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: Get.height * 0.01),

                          DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Text(
                                _selectedItem ?? 'Select number',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey,
                                ),
                              ),
                              items: [
                                ..._numbers.map(
                                  (number) => DropdownMenuItem<String>(
                                    value: number.toString(),
                                    child: Text(
                                      number.toString(),
                                      style: TextStyle(fontSize: 14.sp),
                                    ),
                                  ),
                                ),
                                const DropdownMenuItem<String>(
                                  value: 'custom',
                                  child: Text(
                                    'Write If More Than 4',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                              value:
                                  _numbers.contains(
                                        int.tryParse(_selectedItem ?? ''),
                                      )
                                      ? _selectedItem
                                      : null,
                              onChanged: (value) {
                                if (value == 'custom') {
                                  _showNumberInputDialog(context, (
                                    enteredValue,
                                  ) {
                                    setState(() {
                                      _selectedItem = enteredValue;
                                      bookTableController.bookNumberTable.text =
                                          enteredValue;
                                      final parsed = int.tryParse(enteredValue);
                                      if (parsed != null &&
                                          !_numbers.contains(parsed)) {
                                        _numbers.add(parsed);
                                        _numbers.sort();
                                      }
                                    });
                                  });
                                } else {
                                  setState(() {
                                    _selectedItem = value!;
                                    bookTableController.bookNumberTable.text =
                                        value;
                                  });
                                }
                              },
                              buttonStyleData: ButtonStyleData(
                                height: 48.h,
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: Colors.white,
                                ),
                              ),
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 200.h,
                                width: MediaQuery.of(context).size.width - 32,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                              ),
                              iconStyleData: const IconStyleData(
                                icon: Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(top: 20.h),
                            child: Text(
                              "Select Date",
                              style: GoogleFonts.sen(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: Get.height * 0.01),
                          GestureDetector(
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100),
                              );

                              if (pickedDate != null) {
                                selectedDate = pickedDate;
                                bookTableController.dateController.text =
                                    "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                                bookTableController.bookingDate.value =
                                    "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                              }
                            },
                            child: AbsorbPointer(
                              child: TextFormField(
                                controller: bookTableController.dateController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                    borderSide: BorderSide.none,
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "DD/MM/YYYY",
                                  hintStyle: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                  suffixIcon: const Icon(
                                    Icons.calendar_month,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20.h),
                            child: Text(
                              "Select time of day",
                              style: GoogleFonts.sen(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: Get.height * 0.01),
                          Container(
                            height: 312.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 10.h),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      // Lunch
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedIndex = 0; // Lunch selected
                                          });
                                        },
                                        child: Container(
                                          height: 44.h,
                                          width: 85.w,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: const Color(0xffEEA534),
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              33.r,
                                            ),
                                            color:
                                                selectedIndex == 0
                                                    ? const Color(0xffEEA534)
                                                    : Colors.transparent,
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Lunch",
                                              style: GoogleFonts.sen(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w700,
                                                color:
                                                    selectedIndex == 0
                                                        ? Colors.black
                                                        : Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(0),
                                        padding: EdgeInsets.all(0),
                                        height: 40,
                                        width: 3,
                                        color: Colors.black,
                                      ),
                                      // Dinner
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedIndex =
                                                1; // Dinner selected
                                          });
                                        },
                                        child: Container(
                                          height: 44.h,
                                          width: 85.w,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              33.r,
                                            ),
                                            border: Border.all(
                                              color: const Color(0xffEEA534),
                                              width: 2,
                                            ),
                                            color:
                                                selectedIndex == 1
                                                    ? const Color(0xffEEA534)
                                                    : Colors.transparent,
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Dinner",
                                              style: GoogleFonts.sen(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w700,
                                                color:
                                                    selectedIndex == 1
                                                        ? Colors.black
                                                        : Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20.h),
                                Image.asset("assets/images/line.png"),
                                // Display different text based on the selected index
                                if (selectedIndex == 0)
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 20.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            buildTimeSlot("12.30 PM"),
                                            buildTimeSlot("01.00 PM"),
                                            buildTimeSlot("01.30 PM"),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 20.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            buildTimeSlot("02.00 PM"),
                                            buildTimeSlot("02.30 PM"),
                                            buildTimeSlot("03.00 PM"),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 20.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            buildTimeSlot("03.30 PM"),
                                            buildTimeSlot("04.00 PM"),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                if (selectedIndex == 1)
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 20.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            buildTimeSlot("07.00 PM"),
                                            buildTimeSlot("07.30 PM"),
                                            buildTimeSlot("08.00 PM"),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 20.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            buildTimeSlot("08.30 PM"),
                                            buildTimeSlot("09.00 PM"),
                                            buildTimeSlot("09.30 PM"),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 20.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            buildTimeSlot("10.00 PM"),
                                            buildTimeSlot("10.30 PM"),
                                            buildTimeSlot("11.00 AM"),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Terms & Conditions:",
                                style: GoogleFonts.sen(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 10),

                              bulletItem(
                                "This offer can't be combined with any other offer or deals available offline at the restaurant.",
                              ),
                              bulletItem(
                                "This offer may not apply to bottled drinks, buffets, pre-discounted platters/combos/thalis, select seasonal or seafood items, tobacco products, or special restaurant menus at the restaurant's discretion.",
                              ),
                              bulletItem(
                                "Government and other taxes will be levied.",
                              ),
                              bulletItem(
                                "Mandatory service charge on the bill.",
                              ),
                              bulletItem("Other T&Cs may apply."),
                            ],
                          ),

                          const SizedBox(height: 15),
                          Obx(
                            () => GestureDetector(
                              onTap: () async {
                                if (bookTableController.isLoading.value)
                                  return; // Prevent double taps

                                final hotelIds = allCityController.hotelList;
                                bookTableController.hotelId.value =
                                    hotelIds[0].id;

                                bookTableController.isLoading.value = true;

                                try {
                                  await bookTableController.getBookTable();

                                  print(
                                    bookTableController.bookNumberTable.text,
                                  );
                                  print(bookTableController.bookingDate.value);
                                  print(bookTableController.timeSlot.value);
                                  print(bookTableController.hotelId.value);

                                  Get.to(() => const PaymentSuccessful());
                                } finally {
                                  bookTableController.isLoading.value = false;
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 55.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: const Color(0xffEEA534),
                                ),
                                child:
                                    bookTableController.isLoading.value
                                        ? SizedBox(
                                          width: 22,
                                          height: 22,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2.5,
                                          ),
                                        )
                                        : Text(
                                          "Proceed",
                                          style: GoogleFonts.sen(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                              ),
                            ),
                          ),

                          SizedBox(height: 30.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildTimeSlot(String time) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTimeDinner = time;
          bookTableController.timeSlot.value = time;
        });
      },
      child: Container(
        height: 46.h,
        width: 100.w,
        decoration: BoxDecoration(
          color:
              selectedTimeDinner == time
                  ? const Color(0xffEEA534) // Selected background color
                  : Colors.white, // Default background color
          border: Border.all(
            color:
                selectedTimeDinner == time
                    ? const Color(0xffEEA534)
                    : const Color(0xffEEA534), // Default border color
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: Text(
            time,
            style: GoogleFonts.sen(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color:
                  selectedTimeDinner == time
                      ? Colors
                          .black // Selected text color
                      : Colors.black, // Default text color
            ),
          ),
        ),
      ),
    );
  }

  void _showNumberInputDialog(BuildContext context, Function(String) onSubmit) {
    final TextEditingController customNumberController =
        TextEditingController();

    showDialog(
      context: context,
      builder:
          (context) => Align(
            alignment: Alignment.center,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 280.w),
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Enter Number',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      TextField(
                        controller: customNumberController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Enter number of guests',
                          border: const OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 14.h,
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          SizedBox(width: 8.w),
                          ElevatedButton(
                            onPressed: () {
                              if (customNumberController.text.isNotEmpty) {
                                final input = customNumberController.text;
                                onSubmit(input); // ← callback
                                Navigator.pop(context);
                              }
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
    );
  }
}

Widget bulletItem(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Icon(Icons.circle, size: 6, color: Colors.white),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.sen(
              fontWeight: FontWeight.w300,
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      ],
    ),
  );
}
