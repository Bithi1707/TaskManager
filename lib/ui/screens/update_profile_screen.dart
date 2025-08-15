import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_project/ui/widgets/screen_background.dart';
import '../../data/models/user_models.dart';
import '../../data/service/network_caller.dart';
import '../../data/urls.dart';
import '../controller/auth_controller.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/taskManagerAppBar.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _selectedImage;

  bool _updateProfileInProgress = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController.text = AuthController.userModel?.email ?? '';
    _firstNameController.text = AuthController.userModel?.firstName ?? '';
    _lastNameController.text = AuthController.userModel?.lastName ?? '';
    _phoneController.text = AuthController.userModel?.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TaskManagerAppBar(),
      body: ScreenBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Text("Update Profile", style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                _buildPhotoPicker(),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _emailController,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.always,
                  enabled: false,
                  decoration: const InputDecoration(hintText: 'Email'),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _firstNameController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: 'First name'),
                  validator: (value) =>
                  (value?.trim().isEmpty ?? true) ? "Enter your first name" : null,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _lastNameController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: 'Last name'),
                  validator: (value) =>
                  (value?.trim().isEmpty ?? true) ? "Enter your last name" : null,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _phoneController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: 'Mobile'),
                  validator: (value) =>
                  (value?.trim().isEmpty ?? true) ? "Enter your mobile number" : null,
                ),
                TextFormField(
                  obscureText: true,
                  controller: _passController,
                  decoration: const InputDecoration(hintText: 'Password'),
                  validator: (value) =>
                  (value != null && value.length > 6) ? null : "Enter a valid password",
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _onTapSubmitButton,
                  child: const Icon(Icons.arrow_circle_right),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector _buildPhotoPicker() {
    return GestureDetector(
      onTap: _onTapPhotoPicker,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 100,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              alignment: Alignment.center,
              child: const Text(
                "Photo",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                _selectedImage == null ? "Select Image" : _selectedImage!.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _onTapPhotoPicker() async {
    final XFile? pickedImage = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() => _selectedImage = pickedImage);
    }
  }

  void _onTapSubmitButton() {
    if (_formKey.currentState!.validate()) {
      _updateProfile();
    }
  }

  Future<void> _updateProfile() async {
    setState(() => _updateProfileInProgress = true);

    Uint8List? imageBytes;

    Map<String, String> requestBody = {
      "email": _emailController.text,
      "firstName": _firstNameController.text.trim(),
      "lastName": _lastNameController.text.trim(),
      "mobile": _phoneController.text.trim(),
    };

    if (_passController.text.isNotEmpty) {
      requestBody['password'] = _passController.text;
    }

    if (_selectedImage != null) {
      imageBytes = await _selectedImage!.readAsBytes();
      requestBody['photo'] = base64Encode(imageBytes);
    }

    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.updateProfileUrl,
      body: requestBody,
    );

    setState(() => _updateProfileInProgress = false);

    if (response.isSuccess) {
      UserModel userModel = UserModel(
        id: AuthController.userModel!.id,
        email: _emailController.text,
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        mobile: _phoneController.text.trim(),
        photo: imageBytes == null
            ? AuthController.userModel?.photo
            : base64Encode(imageBytes),
      );

      await AuthController.updateUserData(userModel);
      _passController.clear();
      if (mounted) showSnackBarMessage(context, 'Profile updated');
    } else {
      if (mounted) showSnackBarMessage(context, response.errorMessage!);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _passController.dispose();
    super.dispose();
  }
}
