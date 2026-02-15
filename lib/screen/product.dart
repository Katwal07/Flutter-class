// import 'package:digital_pathshala_batch/controller/product_controller.dart';
// import 'package:digital_pathshala_batch/screen/product_desc_screen.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_instance/get_instance.dart';
// import 'package:get/route_manager.dart';
// import 'package:get/state_manager.dart';

// /// List of pages -> Screen

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final ProductController _productController = Get.put(ProductController());

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _productController.fetchProducts();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       if (_productController.isLoading.value) {
//         return const Center(child: CupertinoActivityIndicator());
//       }
//       return ListView.builder(
//         itemCount: _productController.product.length,
//         itemBuilder: (context, index) {
//           final product = _productController.product[index];
//           return ListTile(
//             leading: Image.network(
//               product.images.first,
//               errorBuilder: (context, error, stackTrace) {
//                 return Container(
//                   width: 50,
//                   height: 50,
//                   color: Colors.green,
//                   child: Icon(Icons.image),
//                 );
//               },
//             ),
//             title: Text(product.title ?? 'No Title'),
//             subtitle: Text(product.description ?? 'No Description'),
//             onTap: () =>
//                 Get.to(() => ProductDescriptionScreen(productId: product.id!)),
//             trailing: Container(
//               width: 50,
//               height: 50,
//               decoration: BoxDecoration(color: Colors.green),
//             ),
//           );
//         },
//       );
//     });
//   }
// }

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 200,
            backgroundColor: Colors.teal,
            flexibleSpace: FlexibleSpaceBar(title: Text("Flutter App")),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(18),
                children: [
                  BannerWidget(text: "Rohan", color: Colors.orange),
                  BannerWidget(text: "Katwal", color: Colors.orange),
                  BannerWidget(text: "PU", color: Colors.orange),
                  BannerWidget(text: "Katwal", color: Colors.orange),
                  BannerWidget(text: "Rohan", color: Colors.orange),
                  BannerWidget(text: "Sharthal", color: Colors.orange),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            sliver: SliverGrid(
              delegate: SliverChildListDelegate([
                BannerWidget(text: "Rohan", color: Colors.red),
                BannerWidget(text: "Katwal", color: Colors.red),
                BannerWidget(text: "PU", color: Colors.red),
                BannerWidget(text: "Katwal", color: Colors.red),
                BannerWidget(text: "Rohan", color: Colors.red),
                BannerWidget(text: "Sharthal", color: Colors.red),
              ]),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 0,
                childAspectRatio: 0.9,
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 500,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(18),
                children: [
                  BannerWidget(text: "Rohan", color: Colors.orange),
                  BannerWidget(text: "Katwal", color: Colors.orange),
                  BannerWidget(text: "PU", color: Colors.orange),
                  BannerWidget(text: "Katwal", color: Colors.orange),
                  BannerWidget(text: "Rohan", color: Colors.orange),
                  BannerWidget(text: "Sharthal", color: Colors.orange),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BannerWidget extends StatelessWidget {
  final Color? color;
  final String text;
  const BannerWidget({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(text, style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
    );
  }
}
