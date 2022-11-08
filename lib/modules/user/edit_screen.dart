import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie_app/layout/cubit/cubit.dart';
import 'package:my_movie_app/layout/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/style/color_manager.dart';
import '../../shared/style/values_manager.dart';

class EditScreen extends StatelessWidget {
  var nameController =TextEditingController();
  var phoneController =TextEditingController();

  EditScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieCubit,MovieStates>(
      listener: (context,state){
        if(state is GetUserDataSuccess) {
          Navigator.pop(context);
          MovieCubit.get(context).getMovies();
        }
      },
      builder: (context,state){
        var cubit = MovieCubit.get(context);
        var profileImage =cubit.profileImage;
        nameController.text = cubit.userModel!.name!;
        phoneController.text = cubit.userModel!.phone!;
        return Scaffold(
          appBar: AppBar(
            leading:  IconButton(
                onPressed: (){
                  Navigator.pop(context);
                }
                , icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: ColorManager.white,
            )
            ),
            title: const Text(
              'Edit Profile',
              style: TextStyle(
                  color: ColorManager.primary,
                  fontSize: AppSize.s20
              ),
            ),
            actions: [
              TextButton(
                onPressed:(){
                  cubit.updateUser(name: nameController.text, phone: phoneController.text);
                } ,
                child: const Text(
                  'UPDATE',
                  style: TextStyle(
                    color: ColorManager.white,
                  ),
                ),
              ),
              const SizedBox(
                width: AppSize.s14,
              ),
            ],
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.white,
                        child:
                        cubit.profileImage == null?  CircleAvatar(
                          radius: 68,
                          backgroundImage:   NetworkImage(
                              cubit.userModel!.image!
                          ),
                        )
                            :CircleAvatar(
                          radius: 68,
                          backgroundImage: FileImage(profileImage!),
                        ) ,
                      ),
                      CircleAvatar(
                        radius: 19,
                        backgroundColor: ColorManager.lightPrimary,
                        child: IconButton(
                            icon:  const Icon(
                              EvaIcons.cameraOutline,
                              color: ColorManager.white,
                              size: AppSize.s16,
                            )
                            , onPressed: (){
                          cubit.getProfileImage();
                        }
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  if(cubit.profileImage!=null)
                    Padding(
                      padding: const EdgeInsets.all(AppSize.s12),
                      child: Row(
                        children: [
                          if(cubit.profileImage!=null)
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: ColorManager.lightPrimary,
                                  borderRadius:  BorderRadius.circular(AppSize.s12),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: TextButton(
                                  onPressed: (){
                                    cubit.uploadProfileImage(name: nameController.text, phone: phoneController.text);
                                  },
                                  child: const Text(
                                    'UPLOAD PROFILE',
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          const SizedBox(
                            width: AppSize.s4,
                          ),

                        ],
                      ),
                    ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSize.s12),
                    child: textFormFiled(
                        textController:nameController ,
                        hintText: 'Name',
                        perfixIcon: const Icon(
                            EvaIcons.person,
                          color: ColorManager.grey,
                        ),
                        ValidationText: 'Name',
                        type: TextInputType.name
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s12,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSize.s12),
                    child: textFormFiled(
                        textController:phoneController ,
                        hintText: 'Phone',
                        perfixIcon: const Icon(
                            EvaIcons.phoneCall,
                          color: ColorManager.grey,
                        ),
                        ValidationText: 'Phone',
                        type: TextInputType.phone
                    ),
                  ),
                  if(state is MovieUpdateProfileLoadingState)
                    const SizedBox(
                      height: AppSize.s16,
                    ),
                  if(state is MovieUpdateProfileLoadingState)
                    const LinearProgressIndicator(backgroundColor: ColorManager.primary,color: ColorManager.white),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
