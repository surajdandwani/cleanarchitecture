import 'package:cleanarchtitecturedemo/utils/routes/routes_names.dart';
import 'package:cleanarchtitecturedemo/viewModel/home_view_model.dart';
import 'package:cleanarchtitecturedemo/viewModel/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/response/status.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  HomeViewModel homeViewModel = HomeViewModel();

  @override
  void initState() {
    // TODO: implement initState
    homeViewModel.fetchPostalCodeAPi();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final userPreferences = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Home Screen'),
        actions: [
          InkWell(
              onTap: (){
                userPreferences.remove().then((value){
                  Navigator.pushNamed(context, RoutesNames.login);
                });
              },
              child: Center(
                child: Text('Logout'),
              ),
          ),
          SizedBox(width: 20,)
        ],
      ),
      body: ChangeNotifierProvider<HomeViewModel>(
        create: (BuildContext context) =>homeViewModel,
        child: Consumer<HomeViewModel>(builder: (context,value,_){
          switch (value.postalList.status) {
            case Status.LOADING:
              return CircularProgressIndicator();
            case Status.ERROR:
              return Text('Error');
            case Status.COMPLETED:
              return ListView.builder(
                itemCount: value.postalList.data!.places!.length,
                  itemBuilder: (context,index){
                return Card(
                  child: ListTile(
                    title: Text(value.postalList.data!.places![index].placeName.toString()),
                    subtitle: Text(value.postalList.data!.places![index].latitude.toString()),
                    trailing: Text(value.postalList.data!.places![index].state.toString()),

                  ),
                );
              });
            default:
            // Handle any other cases if needed
              return Container();
          }
        }),
      )
    );
  }
}
