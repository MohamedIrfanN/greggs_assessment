import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greggs/sausage_bloc.dart';


class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: BlocBuilder<SausageRollBloc, SausageRollBasketState>(
        builder: (context, state) {
          return ListView(
            children: [
              for (var item in state.basket)
                ListTile(
                  title: Text(item.articleName),
                  subtitle: Row(
                    children: [
                      Text(item.eatOption.value),
                      const Spacer(),
                      Text(item.eatOption == EatOption.eatIn ? "\$${item.eatInPrice.toString()}" : "\$${item.eatOutPrice.toString()}")
                    ],
                  ),
                  leading: Image.network(item.imageUri),
                ),
              const SizedBox(height: 30,),
              ListTile(
                title: Text('Total: \t\$ ${state.total.toStringAsFixed(2)}',style: const TextStyle(color: Colors.green,fontWeight: FontWeight.w600),),
              ),
            ],
          );
        },
      ),
    );
  }
}
