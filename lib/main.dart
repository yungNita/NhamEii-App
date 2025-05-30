import 'package:flutter/material.dart';
import 'screens/login-screen.dart'; // ✅ Import login screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NhamEii App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Sans',
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
      ),
      home: const EditProfileScreen(), // Initial screen
    );
  }
}

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: "Jameson");
    final emailController = TextEditingController(text: "jamesonstephenson@gmail.com");

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE3DFFF), Color(0xFFFDE4F8)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.purple),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                        );
                      },
                    ),
                    const Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.purple,
                      ),
                    )
                  ],
                ),
              ),
              // Avatar
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person, size: 40, color: Colors.white),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.purple,
                      ),
                      padding: const EdgeInsets.all(4),
                      child: const Icon(Icons.camera_alt, size: 16, color: Colors.white),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text("Name", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.purple)),
                      const SizedBox(height: 4),
                      TextFormField(controller: nameController),
                      const SizedBox(height: 16),
                      const Text("Email", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.purple)),
                      const SizedBox(height: 4),
                      TextFormField(controller: emailController),
                      const SizedBox(height: 16),
                      const Text("Password", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.purple)),
                      const SizedBox(height: 8),
                      TextFormField(obscureText: true, decoration: const InputDecoration(hintText: "Enter old password")),
                      const SizedBox(height: 12),
                      TextFormField(obscureText: true, decoration: const InputDecoration(hintText: "Enter new password")),
                      const SizedBox(height: 12),
                      TextFormField(obscureText: true, decoration: const InputDecoration(hintText: "Confirm new password")),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFF2EBB),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                elevation: 3,
                                shadowColor: Colors.pink.shade200,
                              ),
                              child: const Text('Save Changes', style: TextStyle(color: Colors.white, fontSize: 14)),
                            ),
                          ),
                          const SizedBox(width: 12),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cancel", style: TextStyle(fontSize: 14)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 4,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.black54,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.videogame_asset), label: "Game"),
          BottomNavigationBarItem(icon: Icon(Icons.question_answer), label: "Q&A"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
        ],
      ),
    );
  }
}
