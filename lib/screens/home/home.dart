import 'package:flutter_trabalho4_opta1/commons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Vars
  bool isLogin = true;
  bool showPassword = false;
  static const double _formPadding = 3.0;

  //Controlers
  final _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.secondary,
                    AppColors.primary,
                  ]
                ),
              ),
            ),


            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 550.0),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                                      
                //LOGO
                            Image.asset("assets/flutterlogo.png",
                              height: 200,
                            ),

                            const Text(
                              AppLabels.appName,
                              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),

                            const Text(
                              AppLabels.appSubName,
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),

                            const SizedBox(height: 30),
                //FORMS
                //USERNAME - SINGUP 
                            Visibility(
                              visible: !isLogin,
                              child: Padding(
                                padding: const EdgeInsets.all(_formPadding),
                                child: createTextFormField(
                                  label: AppLabels.userName,
                                  controller: userNameController,
                                  textInputType: TextInputType.name,
                                  validator: validateEmpty,
                                  icon: const Icon(Icons.person_2_outlined),
                                ),
                              )
                            ),
                //EMAIL
                            Padding(
                              padding: const EdgeInsets.all(_formPadding),
                              child: createTextFormField(
                                  label: AppLabels.email,
                                  controller: emailController,
                                  textInputType: TextInputType.emailAddress,
                                  validator:  validateEmpty,
                                  icon: const Icon(Icons.mail_outline),
                              ),
                            ),
                //PASSWORD
                            Padding(
                              padding: const EdgeInsets.all(_formPadding),
                              child: createTextFormField(
                                label: AppLabels.password,
                                controller: passwordController,
                                textInputType: TextInputType.text,
                                validator: validateEmpty,
                                icon: const Icon(Icons.lock),
                                obscureText: !showPassword,
                              ),
                            ),
                //PASSWORD CONFIRMATION 
                            Visibility(
                                visible: !isLogin,
                                child: Padding(
                                  padding: const EdgeInsets.all(_formPadding),
                                  child: createTextFormField(
                                    label: AppLabels.passwordConfirm,
                                    controller: passwordConfirmController,
                                    textInputType: TextInputType.text,
                                    validator: validateEmpty,
                                    icon: const Icon(Icons.lock),
                                    obscureText: !showPassword,
                                  ),
                                ),
                            ),
                
                //SHOW PASSWORD         
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:[
                                Row(
                                  children:[
                                    Checkbox(
                                      activeColor: AppColors.text,
                                      checkColor: AppColors.textButton,
                                      value: showPassword,
                                      onChanged: (newValue){
                                        setState((){
                                          showPassword = newValue!;
                                        });
                                      }
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        //alignment: Alignment.centerLeft,
                                      ),
                                      onPressed: (){
                                        setState((){
                                          showPassword = !showPassword;
                                        });
                                      },
                                      child: const Text(AppLabels.showPassword),
                                    ),
                                  ],
                                ),
                
                //FORGOT PASSWORD
                                Visibility(
                                  visible: isLogin,
                                  child: TextButton(
                                    style: const ButtonStyle(alignment: Alignment.centerRight),
                                    onPressed: (){
                                      // TODO: CHANGE PASSWORD
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const TipsList()),
                                      );
                                    },
                                    child: const Text(AppLabels.forgotPassword),
                                  ),
                                ),
                              ],
                            ),
                        
                //BUTTON - ENTER
                            const SizedBox(height: 60),
                            ElevatedButton(
                              onPressed: (){
                                if (_formKey.currentState!.validate()) {
                                  //TODO: CHECK LOGIN - CHECK SINGUP
                                  userNameController.clear();
                                  emailController.clear();
                                  passwordController.clear();
                                  passwordConfirmController.clear();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const TipsList()),
                                  );
                                }
                              },
                
                              style: ElevatedButton.styleFrom(
                                foregroundColor: AppColors.textButton,
                                backgroundColor: Colors.black,
                                textStyle: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                fixedSize: const Size(165, 45),
                              ),
                              child: Text(isLogin ? AppLabels.enter : AppLabels.singup),
                            ),
                        
                            const SizedBox(height: 5),
                            const Divider(color: AppColors.textButton),
                            const SizedBox(height: 3),
                        
                //BUTTON - SWITCH
                            TextButton(
                              onPressed: (){
                                setState((){
                                  isLogin = !isLogin;
                                });
                              },
                              child: Text(isLogin ? AppLabels.toSingup : AppLabels.toLogin),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
    );
  }
}