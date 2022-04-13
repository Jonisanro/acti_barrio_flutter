import 'package:flutter/material.dart';


class CustomBottonBar extends StatefulWidget {
  const CustomBottonBar({Key? key}) : super(key: key);

  @override
  State<CustomBottonBar> createState() => _CustomBottonBarState();
}

class _CustomBottonBarState extends State<CustomBottonBar> {
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      color: const Color.fromARGB(255, 156, 138, 138),
      width: double.infinity,
     height: _screenSize.height * 0.15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           IconButton(onPressed: (){}, icon: const Icon(Icons.padding_outlined,size: 40, )),
           IconButton(onPressed: (){}, icon: const Icon(Icons.padding_outlined,size: 40, )),
           IconButton(onPressed: (){}, icon: const Icon(Icons.padding_outlined,size: 40, )),
           IconButton(onPressed: (){}, icon: const Icon(Icons.padding_outlined,size: 40, )),
           IconButton(onPressed: (){}, icon: const Icon(Icons.padding_outlined,size: 40, )),
          
           

        ],
        
      ),
    );
  }
}