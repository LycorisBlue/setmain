import 'package:flutter/material.dart';
import 'package:setmain/widgets/home.view.dart';
import '../functions/post.function.dart';

class SignupDriver extends StatefulWidget {
  const SignupDriver({super.key});

  @override
  State<SignupDriver> createState() => _SignupDriverState();
}

class _SignupDriverState extends State<SignupDriver> {
  final GlobalKey<FormState> _formKey = GlobalKey();


  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerMarque = TextEditingController();
  final TextEditingController _controllerModel = TextEditingController();
  final TextEditingController _controllerColor = TextEditingController();
  final TextEditingController _controllerCode = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 253, 220, 253),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 100),
              Text(
                "Parlez",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 10),
              Text(
                "Nous de votre vehicule",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 35),
              TextFormField(
                controller: _controllerEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: const Icon(Icons.mail_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter Email.";
                  } else if ((value.contains(' ') || !value.contains('.') || !value.contains('@'))) {
                    return "Invalid Mail";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _controllerMarque,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Marque",
                  prefixIcon: const Icon(Icons.calendar_view_month_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter Marque.";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _controllerModel,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Model",
                  prefixIcon: const Icon(Icons.car_crash),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter Model.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _controllerColor,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Couleur",
                  prefixIcon: const Icon(Icons.format_paint),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter Color.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _controllerCode,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Immatriculation",
                  prefixIcon: const Icon(Icons.code_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter Immatriculation.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                maxLines: 3,
                controller: _controllerDescription,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Description",
                  prefixIcon: const Icon(Icons.edit_note_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Une description de votre vehicule svp ...";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                          registerDriver(email: _controllerEmail.text, marque: _controllerMarque.text, model: _controllerModel.text, couleur: _controllerColor.text, code: _controllerCode.text, description: _controllerDescription.text, context: context);
                      }
                    },
                    child: const Text("Let's start"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Voulez vous revenir a la page"),
                      TextButton(
                        onPressed: () => Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => new homePage())),
                        child: const Text("d'acceuil ?"),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerMarque.dispose();
    _controllerModel.dispose();
    _controllerColor.dispose();
    _controllerCode.dispose();
    super.dispose();
  }
}
