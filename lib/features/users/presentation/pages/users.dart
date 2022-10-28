import 'package:clean_app_sample/features/users/presentation/bloc/users_bloc.dart';
import 'package:clean_app_sample/features/users/presentation/widgets/users_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  initState() {
    super.initState();
    BlocProvider.of<UsersBloc>(context).add(RefreshUsersEvent(
      context: context,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return UsersBody();
  }
}

class UsersBody extends StatefulWidget {
  const UsersBody({super.key});

  @override
  State<UsersBody> createState() => _UsersBodyState();
}

class _UsersBodyState extends State<UsersBody> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Expanded(
        child: BlocBuilder<UsersBloc, UsersState>(
          builder: (context, state) {
            print("state is $state");
            if (state is UsersInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ErrorUserState) {
              return const Center(child: Text('Error'));
            }

            if (state is LoadedUsersState) {
              if (state.users.isEmpty) {
                return const Center(
                  child: Text("No devices"),
                );
              }
              return UsersList(
                scrollController: scrollController,
                state: state,
              );
            }
            return const Center(child: Text("Error"));
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;
    if (currentScroll == maxScroll) {
      BlocProvider.of<UsersBloc>(context).add(GetUsersEvent(
        context: context,
      ));
    }
  }
}
