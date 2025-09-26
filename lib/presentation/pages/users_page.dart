import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bot_toast/bot_toast.dart';
import '../../core/config/app_router.dart';
import '../../injection_container.dart';
import '../cubit/auth/auth_cubit.dart';
import '../cubit/users/users_cubit.dart';
import '../widgets/user_tile.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                
                // Create AuthCubit and logout
                final authCubit = AuthCubit(
                  loginUser: sl(),
                  authStorageService: sl(),
                );
                
                await authCubit.logout();
                
                // Navigate to login page
                if (context.mounted) {
                  context.go(AppRouter.login);
                  BotToast.showText(
                    text: 'Logged out successfully',
                    textStyle: const TextStyle(color: Colors.white),
                    contentColor: Colors.green,
                  );
                }
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        backgroundColor: const Color(0xFF667eea),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.video_call),
            onPressed: () => context.go(AppRouter.joinCall),
          ),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'logout',
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 'logout') {
                _showLogoutDialog(context);
              }
            },
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => UsersCubit(
          getUsers: sl(),
          getCachedUsers: sl(),
        )..loadUsers(),
        child: BlocBuilder<UsersCubit, UsersState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF667eea),
                ),
              ),
              loaded: (users) => RefreshIndicator(
                onRefresh: () => context.read<UsersCubit>().loadUsers(),
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return UserTile(user: user);
                  },
                ),
              ),
              error: (message) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      message,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.read<UsersCubit>().loadCachedUsers(),
                      child: const Text('Load Cached Users'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}