import 'package:flutter/material.dart';


class DrawerScreen extends StatelessWidget{
const DrawerScreen({super.key});
@override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
          color: Theme.of(context).colorScheme.surface,
          child: ListView(
            children: [
              DrawerHeader(child: Text('L O G O of the App',style: TextStyle(color: Theme.of(context).colorScheme.onSurface),)),
               ListTile(
                leading:  const Icon(
                    Icons.info_outline,
                    size: 35,
                  ),
                  title: const Text('Explore the App'),
                  onTap: () {
                    
                  },
              ),
              SizedBox(height: 20,),
              ListTile(
                leading: const Icon(
                  Icons.language_outlined,
                  size: 35),
                  title: const Text('Language'),
                  onTap: () {
                    
                  },
              ),
              SizedBox(height: 20,),
              ListTile(
                leading: const Icon(
                  Icons.person_2_rounded,
                  size: 35),
                  title: const Text('Developer Info'),
                  onTap: () {
                 
                  },
              ),
             
              const SizedBox(
                height: 20,
              ),
             
              
            ],
          ),
        ),
      );
    
  }

}