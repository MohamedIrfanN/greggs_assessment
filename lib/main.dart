import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greggs/sausage_bloc.dart';


import 'cart_page.dart';
import 'homepage.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SausageRollBloc(),
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Greggs'),
            actions: [
              CartIcon()
            ],
          ),
          body: const HomePage(),
        ),
      ),
    );
  }
}

class CartIcon extends StatelessWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SausageRollBloc, SausageRollBasketState>(
      builder: (context, state) {
        int itemCount = state.basket.length;

        return Stack(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  const CartPage()),
                );
              },
              icon: const Icon(Icons.shopping_cart),
            ),
            if (itemCount > 0)
              Positioned(
                right: 20,
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 10,
                  child: Text(
                    itemCount.toString(),
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
