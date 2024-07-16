// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:very_simple_online_shop_cubit/cubit/online_shop/product_cubit.dart';
// import 'package:very_simple_online_shop_cubit/cubit/online_shop/product_state.dart';
// import 'package:very_simple_online_shop_cubit/cubit/theme/theme_cubit.dart';
// import 'package:very_simple_online_shop_cubit/data/models/product.dart';
// import 'package:very_simple_online_shop_cubit/logic/blocs/product/product_bloc.dart';
// import 'package:very_simple_online_shop_cubit/ui/screens/favorite_screen.dart';
// import 'package:very_simple_online_shop_cubit/ui/widgets/manage_product.dart';
// import 'package:very_simple_online_shop_cubit/ui/widgets/product_container.dart';
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final ThemeCubit themeCubit = context.read<ThemeCubit>();
//     final ProductBloc productBloc = context.watch<ProductBloc>();
//     productBloc.add(GetProductEvent());
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Online shop CUBIT'),
//         actions: [
//           IconButton(
//             onPressed: () => Navigator.push(
//               context,
//               CupertinoPageRoute(
//                 builder: (BuildContext context) => const FavoriteScreen(),
//               ),
//             ),
//             icon: const Icon(Icons.favorite),
//           ),
//         ],
//       ),
//       drawer: Drawer(
//         child: Column(
//           children: [
//             const DrawerHeader(
//               decoration: BoxDecoration(color: Colors.amber),
//               child: Row(
//                 children: [
//                   Text(
//                     "Settings",
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//                   ),
//                 ],
//               ),
//             ),
//             SwitchListTile(
//               title: const Text('Dark mode'),
//               value: themeCubit.state,
//               onChanged: (value) => themeCubit.toggleTheme(),
//             ),
//           ],
//         ),
//       ),
//       body: BlocBuilder<ProductCubit, ProductState>(
//         builder: (BuildContext context, ProductState state) {
//           if (state is InitialState) {
//             return const Center(child: Text('Add products!'));
//           } else if (state is LoadingState) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is ErrorState) {
//             return Center(child: Text('error: ${state.message}'));
//           } else {
//             final List<Product> products = (state as LoadedState).products;
//             return ListView.builder(
//               itemCount: products.length,
//               itemBuilder: (BuildContext context, int index) =>
//                   ProductContainer(
//                 isFavoriteScreen: false,
//                 product: products[index],
//               ),
//             );
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.amber,
//         onPressed: () => showDialog(
//           context: context,
//           builder: (BuildContext context) => const ManageProduct(isEdit: false),
//         ),
//         child: const Icon(Icons.add, color: Colors.white),
//       ),
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_simple_online_shop_cubit/cubit/theme/theme_cubit.dart';
import 'package:very_simple_online_shop_cubit/data/models/product.dart';
import 'package:very_simple_online_shop_cubit/logic/blocs/product/product_bloc.dart';
import 'package:very_simple_online_shop_cubit/ui/screens/cart_screen.dart';
import 'package:very_simple_online_shop_cubit/ui/screens/favorite_screen.dart';
import 'package:very_simple_online_shop_cubit/ui/screens/order_screen.dart';
import 'package:very_simple_online_shop_cubit/ui/widgets/manage_product.dart';
import 'package:very_simple_online_shop_cubit/ui/widgets/product_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int increment = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeCubit themeCubit = context.read<ThemeCubit>();
    // final ProductBloc productBloc = context.read<ProductBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Online shop BLOC'),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (BuildContext context) => const FavoriteScreen(),
              ),
            ),
            icon: const Icon(Icons.favorite),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.amber),
              child: Row(
                children: [
                  Text(
                    "Settings",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SwitchListTile(
              title: const Text('Dark mode'),
              value: themeCubit.state,
              onChanged: (value) => themeCubit.toggleTheme(),
            ),
            ListTile(
              title: const Text('Cart'),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const CartScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Order'),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const OrderScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (BuildContext context, ProductState state) {
          if (state is InitialProductState) {
            return const Center(child: Text('Add products!'));
          } else if (state is LoadingProductState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ErrorProductState) {
            return Center(child: Text('error: ${state.errorMessage}'));
          } else if (state is LoadedProductState) {
            final List<Product> products = state.products;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) =>
                  ProductContainer(
                isFavoriteScreen: false,
                product: products[index],
              ),
            );
          } else {
            return const Center(child: Text('Unexpected state'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) => const ManageProduct(isEdit: false),
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
