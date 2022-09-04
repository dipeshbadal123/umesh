import 'package:chat_app/services/methods.dart';
import 'package:chat_app/view/Auth/admin_login.dart';
import 'package:chat_app/view/Auth/password/forgot_password.dart';
import 'package:chat_app/view/Auth/register_page.dart';
import 'package:chat_app/view/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  bool isShow = true;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  List sceduleTitle = [
    'Argentina vs Germany',
    'Argentina Vs Germany',
    'India Vs Pakistan',
  ];
  List sceduleDesc = ['Streming Now', '21st Oct 2022', '22nd Oct 2022'];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const AdminLogin();
                }));
              },
              child: Text(
                "Admin Login",
                style: GoogleFonts.aBeeZee(
                    fontSize: 15,
                    color: Colors.cyan,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        drawer: Drawer(
          width: MediaQuery.of(context).size.width * 0.95,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 5),
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.deepOrangeAccent,
                    child: const Text(
                      "Game Schedule",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white),
                    ),
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: sceduleDesc.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(sceduleTitle[index].toString()),
                          subtitle: Text(sceduleDesc[index].toString()),
                        );
                      })
                ],
              ),
            ),
          ),
        ),
        body: Center(
          child: Form(
            key: _formKey,
            child: isLoading
                ? Center(
                    child: SizedBox(
                      height: size.height / 20,
                      width: size.height / 20,
                      child: const CircularProgressIndicator(
                        color: Colors.cyan,
                        strokeWidth: 3,
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0, left: 25),
                          child: Text(
                            "Welcome Back !!\nFun Olympics Games",
                            style: GoogleFonts.aBeeZee(
                                fontSize: 35,
                                color: Colors.cyan,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 70.0),
                          child: Center(
                            child: Text(
                              "Login".toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 25,
                                  color: Colors.cyan,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email can't be empty";
                              }
                              return null;
                            },
                            controller: _emailController,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.email),
                                hintText: 'Email Address',
                                labelText: 'Email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password can't be empty";
                              }
                              return null;
                            },
                            controller: _passwordController,
                            obscureText: isShow,
                            obscuringCharacter: '*',
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.lock),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isShow = !isShow;
                                      });
                                    },
                                    icon: isShow
                                        ? const Icon(Icons.visibility_off)
                                        : const Icon(Icons.visibility)),
                                hintText: 'Password',
                                labelText: 'Password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return const ForgotPassword();
                                  }));
                                },
                                child: const Text(
                                  "Forgot password?",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline),
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18),
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.cyan,
                                borderRadius: BorderRadius.circular(10)),
                            child: MaterialButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  await logIn(_emailController.text.trim(),
                                          _passwordController.text.trim())
                                      .then((user) {
                                    if (user != null) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              backgroundColor: Colors.purple,
                                              content:
                                                  Text('Login Successfull')));
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return const HomeScreen();
                                      }));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Invalid username or password")));
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
                                  });
                                }
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return const RegisterPage();
                                }));
                              },
                              child: const Text(
                                "New to Fun Olympics?  Register",
                                style: TextStyle(
                                    color: Colors.cyan,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
        bottomSheet: SizedBox(
          height: 40,
          child: Align(
              alignment: Alignment.center,
              child: Text("Our Terms & Conditions and Privacy Policy",
                  style: GoogleFonts.aBeeZee(
                      color: Colors.cyan,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      decoration: TextDecoration.underline))),
        ),
      ),
    );
  }
}
