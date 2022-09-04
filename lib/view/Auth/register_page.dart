import 'package:chat_app/services/methods.dart';
import 'package:chat_app/view/Auth/login_page.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool isLoading = false;
  bool isShow = true;
  String? selectedValue;
  final _dropdownFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Nepal", child: Text("Nepal")),
      const DropdownMenuItem(value: "India", child: Text("India")),
      const DropdownMenuItem(value: "Pakistan", child: Text("Pakistan")),
      const DropdownMenuItem(value: "England", child: Text("England")),
    ];
    return menuItems;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 25.0),
                          child: Center(
                            child: Text(
                              "Fun Olympic Games",
                              style: TextStyle(
                                  fontSize: 35,
                                  color: Colors.cyan,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 70.0),
                          child: Center(
                            child: Text(
                              "Register".toUpperCase(),
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
                                return "Name can't be empty";
                              }
                              return null;
                            },
                            controller: _nameController,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.person),
                                hintText: 'Username',
                                labelText: 'Username',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            width: MediaQuery.of(context).size.width,
                            //height: 60,
                            child: DropdownButtonFormField(
                                hint: const Text("Select your country"),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.cyan, width: 2),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 2),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                validator: (value) =>
                                    value == null ? "Select a country" : null,
                                dropdownColor: Colors.white,
                                value: selectedValue,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedValue = newValue!;
                                  });
                                },
                                items: dropdownItems),
                          ),
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
                            obscureText: isShow,
                            obscuringCharacter: '*',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password can't be empty";
                              }
                              return null;
                            },
                            controller: _passwordController,
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
                          padding: const EdgeInsets.all(18),
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.cyan,
                                borderRadius: BorderRadius.circular(10)),
                            child: MaterialButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  createAccount(
                                          _nameController.text.trim(),
                                          _emailController.text.trim(),
                                          _passwordController.text.trim(),
                                          selectedValue.toString())
                                      .then((user) {
                                    if (user != null) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Account has been Created Successfully')));
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return const AuthPage();
                                      }));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Something went wrong")));
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
                                  });
                                }
                              },
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return const AuthPage();
                              }));
                            },
                            child: const Text(
                              "Already have an account?  Login",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
