import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartItemContainer extends StatelessWidget {
  final dynamic imagePath;
  final dynamic productName;
  final dynamic quantity;
  final dynamic price;

  const CartItemContainer({
    Key? key,
  this.imagePath,
   this.productName,
    this.quantity,
     this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
     // width: 350,
   //   height: 100,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black12,
          width: 2,
        ),
      ),
      padding: const EdgeInsets.all(0.0),
      child: Row(
        children: [
          Image.network(imagePath, width: 90, height: 100), // Adjust as needed
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Aligns text to the start
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text(productName,style: TextStyle(fontSize: 17),),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      Icon(Icons.remove, color: Colors.red),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          width: 30,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black45, width: 2),
                          ),
                          child:

                          Text('$quantity'),
                        ),
                      ),
                      Icon(Icons.add, color: Colors.green),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.delete, color: Colors.red),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Rs.$price', style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}