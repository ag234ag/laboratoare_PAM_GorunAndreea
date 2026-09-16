import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const GemStoreApp());
}

class GemStoreApp extends StatelessWidget {
  const GemStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GemStore',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'ProductSans',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = MediaQuery.sizeOf(context).width / 375;
    return Scaffold(
      backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            height: 1800 * scale,
            child: Stack(
        children: [
          // Antetul: meniu, GemStore și notificare
        Positioned(
        top: 63 * scale,
        left: 32 * scale,
        child: Transform.scale(
          scale: scale,
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: 312,
            height: 26,
            child: SizedBox(
              height: 26,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 0,
                    top: 3.5,
                    child: SvgPicture.asset(
                      'vectors/meniu.svg',
                      width: 20,
                      height: 19,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Center(
                    child: Text(
                      'GemStore',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        height: 1,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: SvgPicture.asset(
                      'vectors/notification.svg',
                      width: 25,
                      height: 26,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ),

          // Blocul cu cele patru categorii
          Positioned(
            top: 125 * scale,
            left: 35 * scale,
            child: Transform.scale(
              scale: scale,
              alignment: Alignment.topLeft,
              child: const CategoryMenu(),
            ),
          ),
          Positioned(
            top: 215 * scale,
            left: 32 * scale,
            child: Transform.scale(
              scale: scale,
              alignment: Alignment.topLeft,
              child: const AutumnBanner(),
            ),
          ),
          Positioned(
            top: 418 * scale,
            left: 32 * scale,
            child: Transform.scale(
              scale: scale,
              alignment: Alignment.topLeft,
              child: const SectionHeader(),
            ),
          ),
          Positioned(
            top: 464 * scale,
            left: 35 * scale,
            child: Transform.scale(
              scale: scale,
              alignment: Alignment.topLeft,
              child: const ProductsList(),
            ),
          ),
          Positioned(
            top: 719 * scale,
            left: 0,
            child: Transform.scale(
              scale: scale,
              alignment: Alignment.topLeft,
              child: const NewCollectionBanner(),
            ),
          ),
          Positioned(
            top: 913 * scale,
            left: 32 * scale,
            child: Transform.scale(
              scale: scale,
              alignment: Alignment.topLeft,
              child: const RecommendedSection(),
            ),
          ),
          Positioned(
            top: 1070 * scale,
            left: 32 * scale,
            child: Transform.scale(
              scale: scale,
              alignment: Alignment.topLeft,
              child: const TopCollectionHeader(),
            ),
          ),
          Positioned(
            top: 1121 * scale,
            left: 32 * scale,
            child: Transform.scale(
              scale: scale,
              alignment: Alignment.topLeft,
              child: const SlimBeautyBanner(),
            ),
          ),
          Positioned(
            top: 1258 * scale,
            left: 32 * scale,
            child: Transform.scale(
              scale: scale,
              alignment: Alignment.topLeft,
              child: const FabulousDesignBanner(),
            ),
          ),
          Positioned(
            top: 1503 * scale,
            left: 32 * scale,
            child: Transform.scale(
              scale: scale,
              alignment: Alignment.topLeft,
              child: const OfficeDressCards(),
            ),
          ),
        ],
      ),
          ),
        ),
    );
  }
}

class CategoryMenu extends StatelessWidget {
  const CategoryMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 306,
      height: 60,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CategoryItem(
            iconPath: 'vectors/1.svg',
            label: 'Women',
            iconLeft: 3,
            labelWidth: 44,
            textColor: Color(0xFF3A2C27),
            hasCircle: true,
          ),
          CategoryItem(
            iconPath: 'vectors/2.svg',
            label: 'Men',
            iconLeft: 93,
            labelWidth: 22,
            textColor: Color(0xFF9D9D9D),
          ),
          CategoryItem(
            iconPath: 'vectors/3.svg',
            label: 'Accessories',
            iconLeft: 183,
            labelWidth: 58,
            textColor: Color(0xFF9D9D9D),
          ),
          CategoryItem(
            iconPath: 'vectors/4.svg',
            label: 'Beauty',
            iconLeft: 273,
            labelWidth: 34,
            textColor: Color(0xFF9D9D9D),
          ),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String iconPath;
  final String label;
  final double iconLeft;
  final double labelWidth;
  final Color textColor;
  final bool hasCircle;

  const CategoryItem({
    super.key,
    required this.iconPath,
    required this.label,
    required this.iconLeft,
    required this.labelWidth,
    required this.textColor,
    this.hasCircle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: iconLeft,
          top: 0,
          child: hasCircle
              ? SizedBox(
            width: 42,
            height: 42,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  iconPath,
                  width: 34,
                  height: 34,
                ),
                SvgPicture.asset(
                  'vectors/circle.svg',
                  width: 42,
                  height: 42,
                ),
              ],
            ),
          )
              : SvgPicture.asset(
            iconPath,
            width: 38,
            height: 36,
            fit: BoxFit.contain,
          ),
        ),
        Positioned(
          left: iconLeft + 19 - labelWidth / 2,
          top: 48,
          width: labelWidth,
          height: 12,
          child: Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            style: TextStyle(
              fontFamily: 'ProductSans',
              fontWeight: FontWeight.w300,
              fontSize: 10,
              height: 1.2,
              letterSpacing: 0.06,
              color: textColor,
            ),
          ),
        ),
      ],
    );
  }
}

class AutumnBanner extends StatelessWidget {
  const AutumnBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 312,
      height: 168,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Image.asset(
              'vectors/imagine1.png',
              width: 312,
              height: 168,
              fit: BoxFit.cover,
            ),
            const Positioned(
              left: 188,
              top: 19,
              width: 116,
              height: 93,
              child: Text(
                'Autumn\nCollection\n2021',
                style: TextStyle(
                  fontFamily: 'ProductSans',
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  height: 1.41,
                  color: Colors.white,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 17),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 14,
                      height: 14,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                          Container(
                            width: 5.5,
                            height: 5.5,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 14),
                    const BannerDot(),
                    const SizedBox(width: 14),
                    const BannerDot(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BannerDot extends StatelessWidget {
  const BannerDot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 311,
      height: 26,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Feature Products',
            style: TextStyle(
              fontFamily: 'ProductSans',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              height: 1,
              color: Colors.black,
            ),
          ),
          Text(
            'Show all',
            style: TextStyle(
              fontFamily: 'ProductSans',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              height: 20 / 13,
              letterSpacing: -0.13,
              color: Color(0xFF9B9B9B),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductsList extends StatelessWidget {
  const ProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340,
      height: 227,
      child: ListView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        children: const [
          ProductCard(
            imagePath: 'vectors/imagine2.png',
            title: 'Turtleneck Sweater',
            price: '\$ 39.99',
          ),
          SizedBox(width: 20),
          ProductCard(
            imagePath: 'vectors/imagine3.png',
            title: 'Long Sleeve Dress',
            price: '\$ 45.00',
          ),
          SizedBox(width: 20),

          // Ultimul produs: imagine4 este fundalul,
          // iar imagine5 se pune peste ea.
          ProductCard(
            imagePath: 'vectors/imagine4.png',
            overlayImagePath: 'vectors/imagine5.png',
            title: 'Sportswear',
            price: '\$ 80.00',
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String imagePath;
  final String? overlayImagePath;
  final String title;
  final String price;

  const ProductCard({
    super.key,
    required this.imagePath,
    this.overlayImagePath,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 126,
      height: 227,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 126,
              height: 172,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    imagePath,
                    width: 126,
                    height: 172,
                    fit: BoxFit.cover,
                  ),
                  if (overlayImagePath != null)
                    Positioned(
                      left: 16,
                      bottom: 0,
                      width: 110,
                      height: 172,
                      child: Image.asset(
                        overlayImagePath!,
                        fit: BoxFit.contain,
                        alignment: Alignment.bottomCenter,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 20,
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.clip,
              style: const TextStyle(
                fontFamily: 'ProductSans',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                height: 1,
                letterSpacing: -0.12,
                color: Color(0xFF1D1F22),
              ),
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 19,
            child: Text(
              price,
              style: const TextStyle(
                fontFamily: 'ProductSans',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                height: 19 / 16,
                color: Color(0xFF1D1F22),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class NewCollectionBanner extends StatelessWidget {
  const NewCollectionBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 375,
      height: 168,
      child: ClipRect(
        child: Stack(
          children: [
            // Fundalul bannerului
            Image.asset(
              'vectors/banner1.png',
              width: 375,
              height: 168,
              fit: BoxFit.cover,
            ),

            // Cercul mare, din spate
            Positioned(
              left: 251,
              top: 6,
              child: Opacity(
                opacity: 0.5,
                child: Image.asset(
                  'vectors/ellipse2.png',
                  width: 132,
                  height: 132,
                ),
              ),
            ),

            // Cercul mic, peste cercul mare
            Positioned(
              left: 266,
              top: 21,
              child: Image.asset(
                'vectors/ellipse1.png',
                width: 102,
                height: 102,
              ),
            ),

            // imagine – peste ambele cercuri
            Positioned(
              left: 257,
              bottom: 0,
              width: 119,
              height: 158,
              child: Image.asset(
                'vectors/imagine6.png',
                fit: BoxFit.cover,
              ),
            ),

            // Textele din stânga
            Positioned(
              left: 79,
              top: 36,
              width: 166,
              height: 91,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 0.8,
                        height: 12,
                        color: const Color(0xFF777E90),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'NEW COLLECTION',
                        style: TextStyle(
                          fontFamily: 'ProductSans',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: 16 / 12,
                          color: Color(0xFF777E90),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 23),
                  const Text(
                    'HANG OUT\n& PARTY',
                    style: TextStyle(
                      fontFamily: 'ProductSans',
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      height: 1,
                      color: Color(0xFF353945),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class RecommendedSection extends StatelessWidget {
  const RecommendedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 311,
      height: 150,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recommended',
                style: TextStyle(
                  fontFamily: 'ProductSans',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  height: 1,
                  color: Colors.black,
                ),
              ),
              Text(
                'Show all',
                style: TextStyle(
                  fontFamily: 'ProductSans',
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  height: 20 / 13,
                  letterSpacing: -0.13,
                  color: Color(0xFF9B9B9B),
                ),
              ),
            ],
          ),
          Positioned(
            top: 46,
            left: 0,
            child: RecommendedProducts(),
          ),
        ],
      ),
    );
  }
}

class RecommendedProducts extends StatelessWidget {
  const RecommendedProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340,
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        children: const [
          RecommendedProductCard(
            imagePath: 'vectors/imaginea7.png',
            title: 'White fashion hoodie',
            price: '\$ 29.00',
            imageWidth: 87,
            imageHeight: 129,
            imageLeft: -9,
            imageTop: -59,
          ),
          SizedBox(width: 20),
          RecommendedProductCard(
            imagePath: 'vectors/imaginea8.png',
            title: 'Cotton T-shirt',
            price: '\$ 30.00',
            imageWidth: 74,
            imageHeight: 110,
            imageLeft: -4,
            imageTop: -30,
          ),
        ],
      ),
    );
  }
}

class RecommendedProductCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String price;
  final double imageWidth;
  final double imageHeight;
  final double imageLeft;
  final double imageTop;

  const RecommendedProductCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.price,
    required this.imageWidth,
    required this.imageHeight,
    required this.imageLeft,
    required this.imageTop,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 213,
      height: 66,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Dreptunghiul alb din spate
          Positioned(
            left: 10,
            top: 0,
            width: 203,
            height: 66,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFFF9F9F9),
                  width: 1,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x26000000),
                    offset: Offset(0, 6),
                    blurRadius: 14,
                    spreadRadius: -12,
                  ),
                ],
              ),
            ),
          ),

          // Imaginea – rămâne puțin în afara dreptunghiului
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 68,
              height: 66,
              child: Stack(
                children: [
                  Positioned(
                    left: imageLeft,
                    top: imageTop,
                    child: Image.asset(
                      imagePath,
                      width: imageWidth,
                      height: imageHeight,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            left: 75,
            top: 8,
            width: 134,
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.clip,
              style: const TextStyle(
                fontFamily: 'ProductSans',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                height: 1,
                letterSpacing: -0.12,
                color: Color(0xFF1D1F22),
              ),
            ),
          ),

          Positioned(
            left: 75,
            top: 35,
            child: Text(
              price,
              style: const TextStyle(
                fontFamily: 'ProductSans',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                height: 19 / 16,
                color: Color(0xFF1D1F22),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TopCollectionHeader extends StatelessWidget {
  const TopCollectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 311,
      height: 26,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Top Collection',
            style: TextStyle(
              fontFamily: 'ProductSans',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              height: 1,
              color: Colors.black,
            ),
          ),
          Text(
            'Show all',
            style: TextStyle(
              fontFamily: 'ProductSans',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              height: 20 / 13,
              letterSpacing: -0.13,
              color: Color(0xFF9B9B9B),
            ),
          ),
        ],
      ),
    );
  }
}

class SlimBeautyBanner extends StatelessWidget {
  const SlimBeautyBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 312,
      height: 141,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            // Fundal
            Image.asset(
              'vectors/banner2.png',
              width: 312,
              height: 141,
              fit: BoxFit.cover,
            ),

            // Cercul din spatele femeii
            Positioned(
              left: 194,
              top: 25,
              child: Image.asset(
                'vectors/ellipse3.png',
                width: 86,
                height: 86,
              ),
            ),

            Positioned(
              left: 181,
              top: -59.8,
              width: 128.62,
              height: 229.04,
              child: Image.asset(
                'vectors/imagine10.png',
                fit: BoxFit.cover,
              ),
            ),

            // Textul mic
            Positioned(
              left: 20,
              top: 23,
              child: Row(
                children: [
                  Container(
                    width: 0.8,
                    height: 12,
                    color: const Color(0xFF777E90),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Sale up to 40%',
                    style: TextStyle(
                      fontFamily: 'ProductSans',
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      height: 16 / 12,
                      color: Color(0xFF777E90),
                    ),
                  ),
                ],
              ),
            ),

            // Textul principal
            const Positioned(
              left: 20,
              top: 63,
              child: Text(
                'FOR SLIM\n& BEAUTY',
                style: TextStyle(
                  fontFamily: 'ProductSans',
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  height: 1,
                  color: Color(0xFF777E90),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FabulousDesignBanner extends StatelessWidget {
  const FabulousDesignBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 312,
      height: 229,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            // Fundalul
            Image.asset(
              'vectors/banner3.png',
              width: 312,
              height: 229,
              fit: BoxFit.cover,
            ),

            // Cercul din spatele femeii
            Positioned(
              left: 165,
              top: 41,
              child: Image.asset(
                'vectors/ellipse4.png',
                width: 114,
                height: 114,
              ),
            ),

            // Femeia
            Positioned(
              left: 160,
              top: 0,
              width: 152,
              height: 229,
              child: Image.asset(
                'vectors/imagine11.png',
                fit: BoxFit.cover,
              ),
            ),

            // Linia decorativă
            Positioned(
              left: 23,
              top: 34,
              child: Container(
                width: 0.79,
                height: 12,
                color: const Color(0xFF777E90),
              ),
            ),

            // Textul mic
            const Positioned(
              left: 32,
              top: 35,
              width: 145,
              height: 12,
              child: Text(
                'Summer Collection 2021',
                style: TextStyle(
                  fontFamily: 'ProductSans',
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  height: 16 / 12,
                  color: Color(0xFF777E90),
                ),
              ),
            ),

            // Textul principal
            const Positioned(
              left: 24,
              top: 74,
              width: 187,
              height: 81,
              child: Text(
                'Most sexy\n& fabulous\ndesign',
                style: TextStyle(
                  fontFamily: 'ProductSans',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  height: 1.48,
                  color: Color(0xFF353945),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OfficeDressCards extends StatelessWidget {
  const OfficeDressCards({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 324,
      height: 194,
      child: Row(
        children: [
          ElegantDesignCard(),
          SizedBox(width: 12),
          OfficeLifeCard(),
        ],
      ),
    );
  }
}

class OfficeLifeCard extends StatelessWidget {
  const OfficeLifeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset(
        'vectors/banner4.png',
        width: 156,
        height: 194,
        fit: BoxFit.cover,
      ),
    );
  }
}

class ElegantDesignCard extends StatelessWidget {
  const ElegantDesignCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset(
        'vectors/banner5.png',
        width: 148,
        height: 194,
        fit: BoxFit.cover,
      ),
    );
  }
}