import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/provider/firebase_auth_provider.dart';
import 'package:todo/provider/firebase_storage_provider.dart';
import 'package:todo/view/add_modal_sheet.dart';
import 'package:todo/view/splash_view.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Todos"),
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: () => ref.read(signOutProvider).then((value) {
                ref.refresh(currentUserProvider);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SplashView()));
              }),
              icon: const Icon(Icons.exit_to_app_rounded),
              tooltip: "sign out",
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: const AddModalSheet())),
          child: const Icon(Icons.add),
        ),
        body: ref.watch(getTodoProvider).when(
              data: (value) {
                final data =
                    value.map((e) => TodoModel.fromJson(e.data())).toList();

                return RefreshIndicator.adaptive(
                  onRefresh: () {
                    return Future.value(ref.refresh(getTodoProvider));
                  },
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = data.elementAt(index);
                      return Opacity(
                        opacity: item.done == true ? 0.5 : 1,
                        child: Container(
                          padding: 16.verticalP,
                          color: index % 2 == 0
                              ? Colors.grey.shade200
                              : Colors.white,
                          width: double.infinity,
                          child: ListTile(
                            title: Text(item.todo ?? ""),
                            trailing: Checkbox(
                              value: item.done ?? false,
                              onChanged: (newValue) => ref
                                  .read(doneToggleProvider(DoneToggleModel(
                                      id: value.elementAt(index).id,
                                      done: newValue ?? false)))
                                  .then((value) => setState(
                                      () => ref.refresh(getTodoProvider))),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stackTrace) {
                print("Error:" + error.toString());

                return const Center(
                  child: Icon(
                    Icons.warning,
                    color: Colors.red,
                  ),
                );
              },
            ));
  }
}
