import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/movie_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/style/asset_manager.dart';
import '../../shared/style/color_manager.dart';
import '../../shared/style/values_manager.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey =GlobalKey<FormState>();
  RegisterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state){
          if(state is MovieCreateUserSuccess) {
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
          else if(state is MovieCreateUserError){
            showToast(txt: state.error, state: ToastState.ERROR);
          }
        },
        builder: (context,state){
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: const Icon(
                    Icons.arrow_back_ios_rounded
                ),
              ),
            ),
            body: Form(
              key: formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:  const EdgeInsets.all(AppSize.s12),
                    child: Column(
                      children: [
                        Lottie.asset(AssetsManager.registerScreen),
                        textFormFiled(
                            textController: nameController,
                            hintText: 'Name',
                            perfixIcon: Icon(
                              Icons.account_circle,
                              color: ColorManager.darkWhite,
                            ),
                            ValidationText: 'Name',
                            type: TextInputType.name
                        ),
                        const SizedBox(
                          height: AppSize.s12,
                        ),
                        textFormFiled(
                            textController: emailController,
                            hintText: 'Email',
                            perfixIcon: Icon(
                              Icons.email,
                              color: ColorManager.darkWhite,
                            ),
                            ValidationText: 'Email',
                            type: TextInputType.emailAddress
                        ),
                        const SizedBox(
                          height: AppSize.s12,
                        ),
                        textFormFiled(
                            textController: passwordController,
                            hintText: 'Password',
                            perfixIcon: Icon(
                              Icons.lock,
                              color: ColorManager.darkWhite,
                            ),
                            ValidationText: 'Password',
                            secure: cubit.showPassword,
                            type: TextInputType.visiblePassword,
                          suffixIcon: IconButton(
                              onPressed: (){
                                cubit.showPasswordVisibility();
                              },
                              icon: Icon(
                                cubit.suffixIcon,
                                color: ColorManager.darkWhite,
                              )
                          ),
                        ),
                        const SizedBox(
                          height: AppSize.s12,
                        ),
                        textFormFiled(
                            textController: phoneController,
                            hintText: 'Phone',
                            perfixIcon: Icon(
                              Icons.phone,
                              color: ColorManager.darkWhite,
                            ),
                            ValidationText: 'Phone',
                            type: TextInputType.phone
                        ),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        BuildCondition(
                          condition: state is! MovieRegisterLoading,
                          builder: (context){
                            return myButton(
                                txt: 'sign up',
                                width: MediaQuery.of(context).size.width,
                                onpress: (){
                                  if(formKey.currentState!.validate()) {
                                    cubit.userRegister(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name: nameController.text,
                                        phone: phoneController.text
                                    );
                                  }
                                },
                                context: context
                            );
                          },
                          fallback: (context)=> const Center(
                            child: CircularProgressIndicator(
                              backgroundColor: ColorManager.primary,color: ColorManager.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
