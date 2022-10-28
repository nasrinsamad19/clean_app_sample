import 'package:clean_app_sample/features/users/presentation/bloc/users_bloc.dart';
import 'package:clean_app_sample/features/users/presentation/widgets/users_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UsersList extends StatelessWidget {
  const UsersList(
      {super.key, required this.scrollController, required this.state});

  final ScrollController scrollController;
  final LoadedUsersState state;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount:
            state.hasReachedMax ? state.users.length : state.users.length + 1,
        controller: scrollController,
        itemBuilder: (context, index) {
          if (index >= state.users.length)
            return const CircularProgressIndicator();

          return UersCard(
            user: state.users[index],
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(
          color: Color.fromARGB(255, 17, 13, 1),
          thickness: 1,
        ),
      ),
    );
  }
}
