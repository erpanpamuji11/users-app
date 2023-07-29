import 'package:flutter/material.dart';
import 'package:users_app/controllers/user_controller.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final UserController state = Get.put(UserController());
    state.getUser();

    Future onRefresh() async {
      state.refreshData();
    }

    void onScroll() {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;

      if (maxScroll == currentScroll && state.hasMore.value) {
        state.getUser();
      }
    }

    scrollController.addListener(onScroll);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: Obx(() => ListView.builder(
          controller: scrollController,
          itemCount: state.hasMore.value ? state.users.length + 1 : state.users.length,
            itemBuilder: (context, index) {
              if (index < state.users.length) {
                return GestureDetector(
                  onLongPress: (){
                    showDialog(
                        context: context,
                        builder: (context) {
                          return SimpleDialog(
                            title: Text("Action"),
                            children: [
                              ElevatedButton(
                                  onPressed: (){
                                    state.deleteUser(state.users[index].id ?? "");
                                  },
                                  child: Text("Hapus")
                              )
                            ],
                          );
                        });
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(state.users[index].avatar ?? ''),
                    ),
                    title: Text(state.users[index].name ?? ''),
                    subtitle: Text(state.users[index].email ?? ''),
                  ),
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.all(15),
                  child: Center(
                    child: CircularProgressIndicator(

                      color: Colors.black,
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
