import 'package:flutter_bloc/flutter_bloc.dart';


enum EatOption {
  eatOut ("Eat Out"),
  eatIn ("Eat In");
  const EatOption(this.value);
  final String value;
}

class SausageRoll {
  String articleCode;
  String articleName;
  double eatOutPrice;
  double eatInPrice;
  String imageUri;
  String description;
  EatOption eatOption;

  SausageRoll({
    required this.articleCode,
    required this.articleName,
    required this.eatOutPrice,
    required this.eatInPrice,
    required this.imageUri,
    required this.description,
    this.eatOption = EatOption.eatOut
  });
}

class AddToBasketEvent {
  final EatOption eatOption;

  AddToBasketEvent(this.eatOption);
}

class SausageRollBasketState {
  final List<SausageRoll> basket;
  final double total;

  SausageRollBasketState(this.basket, this.total,);
}

class SausageRollBloc extends Bloc<AddToBasketEvent, SausageRollBasketState> {
  SausageRollBloc() : super(SausageRollBasketState([], 0,)) {
    on<AddToBasketEvent>(_addToBasket);
  }

  void _addToBasket(AddToBasketEvent event, Emitter<SausageRollBasketState> emit) {

    SausageRoll sausageRoll = SausageRoll(
      articleCode: "1000446",
      articleName: "Sausage Roll",
      eatOutPrice: 1.05,
      eatInPrice: 1.15,
      imageUri: "https://articles.greggs.co.uk/images/1000446-thumb.png",
      description: "The Nation’s favourite Sausage Roll.Much like Elvis was hailed the King of Rock, many have appointed Greggs as the(unofficial) King of Sausage Rolls.Freshly baked in our shopsthroughout the day, this British classic is made from seasoned sausage meatwrapped in layers of crisp, golden puff pastry, as well as a large dollopof TLC. It’s fair to say, we’re proper proud of them.And that’s it. Noclever twist. No secret ingredient. It’s how you like them, so that’s howwe make them.",
      eatOption: event.eatOption
    );

    final eatPrice = event.eatOption == EatOption.eatOut ? sausageRoll.eatOutPrice : sausageRoll.eatInPrice;

    final updatedBasket = List<SausageRoll>.from(state.basket)..add(sausageRoll);

    final updatedTotal = state.total + eatPrice;

    emit(SausageRollBasketState(updatedBasket, updatedTotal,));
  }
}