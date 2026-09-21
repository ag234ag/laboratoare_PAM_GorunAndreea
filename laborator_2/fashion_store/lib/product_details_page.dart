import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = MediaQuery.sizeOf(context).width / 375;
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xFF333333),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      backgroundColor: const Color(0xFFFFFCFA),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          height: 1942 * scale,
          child: Transform.scale(
            scale: scale,
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 375,
              height: 1942,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const SizedBox(
                    width: 375,
                    height: 451,
                    child: ColoredBox(
                      color: Color(0xFFFFFCFA),
                    ),
                  ),
                  Positioned(
                    left: 81,
                    top: 93,
                    child: Opacity(
                      opacity: .50,
                      child: Image.asset(
                        'vectors/ellipse5.png',
                        width: 234,
                        height: 234,
                      ),
                    ),
                  ),

                  Positioned(
                    left: 20,
                    top: 12,
                    width: 355,
                    height: 532,
                    child: Image.asset(
                      'vectors/imagine14.png',
                      fit: BoxFit.cover,
                    ),
                  ),

                  Positioned(
                    left: 30,
                    top: 59,
                    width: 36,
                    height: 36,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Image.asset(
                        'vectors/buton1.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  Positioned(
                    left: 311,
                    top: 61,
                    width: 32,
                    height: 32,
                    child: Image.asset(
                      'vectors/buton2.png',
                      fit: BoxFit.contain,
                    ),
                  ),

                  Positioned(
                    left: 167,
                    top: 384,
                    width: 41,
                    height: 10.5,
                    child: Image.asset(
                      'vectors/buton3.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 406,
                    child: Container(
                      width: 375,
                      height: 1536,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x40000000),
                            blurRadius: 10,
                            spreadRadius: -2,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Positioned(
                    left: 32,
                    top: 463,
                    width: 231,
                    height: 20,
                    child: Text(
                      'Sportwear Set',
                      style: TextStyle(
                        fontFamily: 'ProductSans',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        height: 1,
                        color: Color(0xFF1D1F22),
                      ),
                    ),
                  ),

                  const Positioned(
                    left: 254,
                    top: 457,
                    width: 129,
                    height: 37,
                    child: Text(
                      '\$ 80.00',
                      style: TextStyle(
                        fontFamily: 'ProductSans',
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        height: 1.41,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  Positioned(
                    left: 34,
                    top: 499,
                    width: 119,
                    height: 16,
                    child: Image.asset(
                      'vectors/stelute.png',
                      fit: BoxFit.contain,
                    ),
                  ),

                  const Positioned(
                    left: 157,
                    top: 502,
                    width: 23,
                    height: 16,
                    child: Text(
                      '(83)',
                      style: TextStyle(
                        fontFamily: 'ProductSans',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 16 / 12,
                        color: Color(0xFF1D1F22),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 31,
                    top: 536,
                    width: 313,
                    height: 1,
                    child: ColoredBox(
                      color: Color(0xFFF3F3F6),
                    ),
                  ),
                  const Positioned(
                    left: 32,
                    top: 558,
                    width: 39,
                    height: 20,
                    child: Text(
                      'Color',
                      style: TextStyle(
                        fontFamily: 'ProductSans',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 20 / 14,
                        color: Color(0xFF777E90),
                      ),
                    ),
                  ),

                  const Positioned(
                    left: 228,
                    top: 558,
                    width: 28,
                    height: 20,
                    child: Text(
                      'Size',
                      style: TextStyle(
                        fontFamily: 'ProductSans',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 20 / 14,
                        color: Color(0xFF777E90),
                      ),
                    ),
                  ),

                  Positioned(
                    left: 8,
                    top: 590,
                    width: 115,
                    height: 33,
                    child: Image.asset(
                      'vectors/culori.png',
                      fit: BoxFit.contain,
                    ),
                  ),

                  Positioned(
                    left: 228,
                    top: 590,
                    width: 115,
                    height: 33,
                    child: Image.asset(
                      'vectors/marimi.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Positioned(
                    left: 31,
                    top: 649,
                    width: 313,
                    height: 1,
                    child: ColoredBox(
                      color: Color(0xFFF3F3F6),
                    ),
                  ),

                  const Positioned(
                    left: 32,
                    top: 667,
                    child: Text(
                      'Description',
                      style: TextStyle(
                        fontFamily: 'ProductSans',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        height: 1.41,
                        color: Color(0xFF33302E),
                      ),
                    ),
                  ),

                  Positioned(
                    left: 312,
                    top: 672,
                    width: 24,
                    height: 24,
                    child: SvgPicture.asset(
                      'vectors/expand_down.svg',
                      fit: BoxFit.contain,
                    ),
                  ),

                  const Positioned(
                    left: 31,
                    top: 713,
                    width: 313,
                    height: 1,
                    child: ColoredBox(
                      color: Color(0xFFF3F3F6),
                    ),
                  ),

                  const Positioned(
                    left: 35,
                    top: 738,
                    width: 305,
                    child: Text(
                      'Sportswear is no longer under culture, it is no '
                          'longer indie or cobbled together as it once was. '
                          'Sport is fashion today. The top is oversized in fit '
                          'and style, may need to size down.',
                      style: TextStyle(
                        fontFamily: 'ProductSans',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 20 / 12,
                        color: Color(0xFF1D1F22),
                      ),
                    ),
                  ),

                  const Positioned(
                    left: 145,
                    top: 798,
                    child: Text(
                      'Read more',
                      style: TextStyle(
                        fontFamily: 'ProductSans',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 20 / 12,
                        color: Color(0xFF508A7B),
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFF508A7B),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 32,
                    top: 858,
                    child: Text(
                      'Reviews',
                      style: TextStyle(
                        fontFamily: 'ProductSans',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        height: 1.41,
                        color: Color(0xFF33302E),
                      ),
                    ),
                  ),

                  Positioned(
                    left: 320,
                    top: 857,
                    width: 24,
                    height: 24,
                    child: SvgPicture.asset(
                      'vectors/expand_down.svg',
                      fit: BoxFit.contain,
                    ),
                  ),

                  const Positioned(
                    left: 31,
                    top: 897,
                    width: 313,
                    height: 1,
                    child: ColoredBox(
                      color: Color(0xFFF3F3F6),
                    ),
                  ),
                  const Positioned(
                    left: 31,
                    top: 930,
                    child: Text(
                      '4.9',
                      style: TextStyle(
                        fontFamily: 'ProductSans',
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        height: 45 / 40,
                        letterSpacing: 0.48,
                        color: Color(0xFF231F20),
                      ),
                    ),
                  ),

                  const Positioned(
                    left: 111,
                    top: 946,
                    child: Text(
                      'OUT OF 5',
                      style: TextStyle(
                        fontFamily: 'ProductSans',
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        height: 13 / 11,
                        letterSpacing: 0.07,
                        color: Color(0xFF8A8A8F),
                      ),
                    ),
                  ),

                  Positioned(
                    left: 238,
                    top: 936,
                    width: 104.3,
                    height: 18.55,
                    child: Image.asset(
                      'vectors/stelute.png',
                      fit: BoxFit.contain,
                    ),
                  ),

                  const Positioned(
                    left: 287,
                    top: 960,
                    child: Text(
                      '83 ratings',
                      style: TextStyle(
                        fontFamily: 'ProductSans',
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        height: 12 / 10,
                        letterSpacing: 0.06,
                        color: Color(0xFF8A8A8F),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 32,
                    top: 982,
                    width: 311,
                    height: 134,
                    child: Image.asset(
                      'vectors/stars.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Positioned(
                    left: 32,
                    top: 1158,
                    child: Text(
                      '47 Reviews',
                      style: TextStyle(
                        fontFamily: 'ProductSans',
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        height: 17 / 11,
                        letterSpacing: -0.055,
                        color: Color(0xFF8A8A8F),
                      ),
                    ),
                  ),

                  const Positioned(
                    left: 245,
                    top: 1158,
                    child: Text(
                      'WRITE A REVIEW',
                      style: TextStyle(
                        fontFamily: 'ProductSans',
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        height: 17 / 11,
                        letterSpacing: -0.055,
                        color: Color(0xFF8A8A8F),
                      ),
                    ),
                  ),

                  const Positioned(
                    left: 331,
                    top: 1159,
                    width: 16,
                    height: 16,
                    child: Icon(
                      Icons.edit,
                      size: 16,
                      color: Color(0xFFC8C7CC),
                    ),
                  ),

                  Positioned(
                    left: 34,
                    top: 1205,
                    width: 36,
                    height: 36,
                    child: ClipOval(
                      child: Image.asset(
                        'vectors/imagine15.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const Positioned(
                    left: 82,
                    top: 1205,
                    child: Text(
                      'Jennifer Rose',
                      style: TextStyle(
                        fontFamily: 'ProductSans',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF33302E),
                      ),
                    ),
                  ),

                  const Positioned(
                    left: 306,
                    top: 1205,
                    child: Text(
                      '5m ago',
                      style: TextStyle(
                        fontFamily: 'ProductSans',
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        height: 17 / 11,
                        color: Color(0x4033302E),
                      ),
                    ),
                  ),

                  Positioned(
                    left: 82,
                    top: 1230,
                    width: 70,
                    height: 9,
                    child: Image.asset(
                      'vectors/stelute.png',
                      fit: BoxFit.contain,
                    ),
                  ),

                  const Positioned(
                    left: 34,
                    top: 1250,
                    width: 313,
                    child: Text(
                      'I love it. Awesome customer service!! Helped me out with '
                          'adding an additional item to my order. Thanks again!',
                      style: TextStyle(
                        fontFamily: 'ProductSans',
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        height: 17 / 11,
                        letterSpacing: -0.055,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 34,
                    top: 1330,
                    width: 36,
                    height: 36,
                    child: ClipOval(
                      child: Image.asset(
                        'vectors/imagine16.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const Positioned(
                    left: 82,
                    top: 1330,
                    child: Text(
                      'Kelly Rihana',
                      style: TextStyle(
                        fontFamily: 'ProductSans',
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        height: 1.41,
                        color: Color(0xFF33302E),
                      ),
                    ),
                  ),

                  const Positioned(
                    left: 306,
                    top: 1330,
                    child: Text(
                      '9m ago',
                      style: TextStyle(
                        fontFamily: 'ProductSans',
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        height: 17 / 11,
                        letterSpacing: -0.055,
                        color: Color(0x4033302E),
                      ),
                    ),
                  ),

                  Positioned(
                    left: 82,
                    top: 1352,
                    width: 70,
                    height: 9,
                    child: Image.asset(
                      'vectors/stelute.png',
                      fit: BoxFit.contain,
                    ),
                  ),

                  const Positioned(
                    left: 34,
                    top: 1375,
                    width: 313,
                    child: Text(
                      "I'm very happy with order, It was delivered on and good "
                          'quality. Recommended!',
                      style: TextStyle(
                        fontFamily: 'ProductSans',
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        height: 17 / 11,
                        letterSpacing: -0.055,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 32,
                    top: 1440,
                    child: Text(
                      'Similar Product',
                      style: TextStyle(
                        fontFamily: 'ProductSans',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        height: 1.41,
                        color: Color(0xFF33302E),
                      ),
                    ),
                  ),

                  Positioned(
                    left: 320,
                    top: 1440,
                    width: 24,
                    height: 24,
                    child: SvgPicture.asset(
                      'vectors/expand_down.svg',
                      fit: BoxFit.contain,
                    ),
                  ),

                  const Positioned(
                    left: 31,
                    top: 1480,
                    width: 313,
                    height: 1,
                    child: ColoredBox(
                      color: Color(0xFFF3F3F6),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 1515,
                    width: 355,
                    height: 245,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 126,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    'vectors/imagine17.png',
                                    width: 126,
                                    height: 192,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Rise Crop Hoodie',
                                  style: TextStyle(
                                    fontFamily: 'ProductSans',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    height: 1,
                                    letterSpacing: -0.12,
                                    color: Color(0xFF1D1F22),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  '\$ 43.00',
                                  style: TextStyle(
                                    fontFamily: 'ProductSans',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    height: 1.41,
                                    color: Color(0xFF1D1F22),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 16),
                          SizedBox(
                            width: 126,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    'vectors/imagine18.png',
                                    width: 126,
                                    height: 192,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Gym Crop Top',
                                  style: TextStyle(
                                    fontFamily: 'ProductSans',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    height: 1,
                                    letterSpacing: -0.12,
                                    color: Color(0xFF1D1F22),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  '\$ 39.99',
                                  style: TextStyle(
                                    fontFamily: 'ProductSans',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    height: 1.41,
                                    color: Color(0xFF1D1F22),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 16),
                          SizedBox(
                            width: 126,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    'vectors/imagine19.png',
                                    width: 126,
                                    height: 192,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Sport Sweatshirt',
                                  style: TextStyle(
                                    fontFamily: 'ProductSans',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    height: 1,
                                    letterSpacing: -0.12,
                                    color: Color(0xFF1D1F22),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  '\$ 47.99',
                                  style: TextStyle(
                                    fontFamily: 'ProductSans',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    height: 1.41,
                                    color: Color(0xFF1D1F22),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Positioned(
                    left: 0,
                    top: 1830,
                    width: 375,
                    height: 112,
                    child: ColoredBox(
                      color: Color(0xFF333333),
                    ),
                  ),

                  Positioned(
                    left: 0,
                    top: 1810,
                    width: 375,
                    height: 82,
                    child: Image.asset(
                      'vectors/oval.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    left: 120,
                    top: 1850,
                    width: 24,
                    height: 24,
                    child: Image.asset(
                      'vectors/cos.png',
                      fit: BoxFit.contain,
                    ),
                  ),

                  const Positioned(
                    left: 160,
                    top: 1850,
                    child: Text(
                      'Add To Cart',
                      style: TextStyle(
                        fontFamily: 'ProductSans',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        height: 1.41,
                        color: Colors.white,
                      ),
                    ),
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