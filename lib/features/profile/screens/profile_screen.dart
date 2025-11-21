import 'package:car_rental_app/auth/cubit/auth_cubit.dart';
import 'package:car_rental_app/features/profile/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showStatusDialog(
      BuildContext context, String login, String? currentStatus) {
    final controller = TextEditingController(text: currentStatus);
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Update Status'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Enter your status'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.read<ProfileCubit>().clearStatus(login);
                Navigator.pop(dialogContext);
              },
              child: const Text('Clear', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<ProfileCubit>().setStatus(login, controller.text);
                Navigator.pop(dialogContext);
              },
              child: const Text('Save'),
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, authState) {
            final login = authState.login ?? 'john.doe@example.com';

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                const CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      NetworkImage('https://i.pravatar.cc/150?img=68'),
                ),
                const SizedBox(height: 16),
                const Text(
                  'John Doe',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  login,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                BlocBuilder<ProfileCubit, Map<String, String>>(
                  builder: (context, statuses) {
                    final status = statuses[login];
                    return Center(
                      child: GestureDetector(
                        onTap: () => _showStatusDialog(context, login, status),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                status != null && status.isNotEmpty
                                    ? status
                                    : 'Set Status',
                                style: TextStyle(
                                  fontStyle: status != null
                                      ? FontStyle.normal
                                      : FontStyle.italic,
                                  color: status != null
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.edit,
                                  size: 16, color: Colors.grey),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const Spacer(flex: 2),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.error,
                    foregroundColor: Theme.of(context).colorScheme.onError,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    context.read<AuthCubit>().logout();
                    context.go('/login');
                  },
                  child: const Text('Logout'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
