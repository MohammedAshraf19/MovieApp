import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:my_movie_app/layout/cubit/cubit.dart';
import '../../layout/movie_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/style/asset_manager.dart';
import '../../shared/style/color_manager.dart';
import '../../shared/style/values_manager.dart';
import '../register_screen/register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey =GlobalKey<FormState>();
    return  BlocProvider(
      create: (BuildContext context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state){
          if(state is MovieLoginError){
            showToast(txt: state.error.toString(), state: ToastState.ERROR);
          }
          if(state is MovieLoginSuccess) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              showToast(txt: 'Access Login', state: ToastState.SUCCESS);
              uId = CacheHelper.getData(key: 'uId');
              MovieCubit.get(context).getUserData();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context)=>const MovieLayout())
              );
            });
          }
        },
        builder: (context,state){
          var cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.only(left: AppSize.s8),
                child: Image.asset(AssetsManager.logo2),
              ),
            ),
            body:Form(
              key: formKey,
              child: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSize.s12),
                    child: Column(
                      children: [
                        Lottie.asset(AssetsManager.loginScreen),
                        textFormFiled(
                          textController:emailController ,
                          hintText: 'Email',
                          perfixIcon:  Icon(
                            Icons.email,
                            color: ColorManager.darkWhite,
                          ),
                          ValidationText: 'Email',
                          type: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: AppSize.s12,
                        ),
                        textFormFiled(
                          textController:passwordController ,
                          hintText: 'Password',
                          perfixIcon:  Icon(
                            Icons.lock,
                            color: ColorManager.darkWhite,
                          ),
                          ValidationText: 'Password',
                          secure: cubit.showPassword,
                          suffixIcon: IconButton(
                            onPressed: (){
                              cubit.showPasswordVisibility();
                            },
                            icon:  Icon(
                              cubit.suffixIcon,
                              color: ColorManager.darkWhite,
                            ),
                          ),
                          type: TextInputType.visiblePassword,
                        ),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        BuildCondition(
                          condition: state is! MovieLoginLoading,
                          builder: (context){
                            return myButton(
                                txt: 'sign in',
                                width: MediaQuery.of(context).size.width,
                                onpress: (){
                                  if(formKey.currentState!.validate()){
                                    cubit.userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                context: context
                            );
                          },
                          fallback: (context)=>const Center(child:  CircularProgressIndicator(
                            backgroundColor: ColorManager.primary,color: ColorManager.white,
                          )
                          ),
                        ),
                        const SizedBox(
                          height: AppSize.s8,
                        ),
                        TextButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterScreen()));
                            },
                            child: Text(
                              'New to Netflix? Sign up now.',
                              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  color: ColorManager.darkWhite
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ) ,
          );
        },
      ),
    );
  }
}
