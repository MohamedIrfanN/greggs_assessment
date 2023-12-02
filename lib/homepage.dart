import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greggs/sausage_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  EatOption selectedEatOption = EatOption.eatOut;
  SausageRoll sausageRoll = SausageRoll(
      articleCode: "1000446",
      articleName: "Sausage Roll",
      eatOutPrice: 1.05,
      eatInPrice: 1.15,
      imageUri: "https://articles.greggs.co.uk/images/1000446-thumb.png",
      description: "The Nation’s favourite Sausage Roll.Much like Elvis was hailed the King of Rock, many have appointed Greggs as the(unofficial) King of Sausage Rolls.Freshly baked in our shopsthroughout the day, this British classic is made from seasoned sausage meatwrapped in layers of crisp, golden puff pastry, as well as a large dollopof TLC. It’s fair to say, we’re proper proud of them.And that’s it. Noclever twist. No secret ingredient. It’s how you like them, so that’s howwe make them.",
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SausageRollBloc, SausageRollBasketState>(
      builder: (context, state) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey)
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: Image.network(sausageRoll.imageUri,fit: BoxFit.cover),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(sausageRoll.articleName,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                      const SizedBox(height: 5,),
                      SizedBox(
                          width: 250,
                          child: Text(
                            sausageRoll.description,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            softWrap: true,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[600]
                            ),
                          )),
                      Row(
                        children: [
                          DropdownButtonHideUnderline(
                            child: DropdownButton<EatOption>(
                              value: selectedEatOption,
                              onChanged: (EatOption? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    selectedEatOption = newValue;
                                  });
                                }
                              },
                              items: const [
                                DropdownMenuItem<EatOption>(
                                  value: EatOption.eatOut,
                                  child: Text('Eat Out',style: TextStyle(fontSize: 13),),
                                ),
                                DropdownMenuItem<EatOption>(
                                  value: EatOption.eatIn,
                                  child: Text('Eat In',style: TextStyle(fontSize: 13),),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 70,),
                          ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    )
                                )
                            ),
                            onPressed: () {
                              context.read<SausageRollBloc>().add(AddToBasketEvent(selectedEatOption));
                            },
                            child: const Text('Add to Basket',style: TextStyle(fontSize: 12)),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}