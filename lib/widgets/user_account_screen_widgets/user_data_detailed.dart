import 'package:flutter/material.dart';

class MobileNumberDetailed extends StatelessWidget {
  const MobileNumberDetailed({Key? key, required this.mobileNumber})
      : super(key: key);
  final String mobileNumber;
  @override
  Widget build(BuildContext context) {
    return Text(
      'Mobile Number:  $mobileNumber',
      style: const TextStyle(
          fontSize: 17, fontFamily: 'Anton', fontWeight: FontWeight.w500),
    );
  }
}

class UserLocationDetailed extends StatelessWidget {
  const UserLocationDetailed({Key? key, required this.location})
      : super(key: key);
  final String location;
  @override
  Widget build(BuildContext context) {
    return Text(
      'Address: $location',
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    );
  }
}

class UserEmailDetailed extends StatelessWidget {
  const UserEmailDetailed({Key? key, required this.email}) : super(key: key);
  final String email;
  @override
  Widget build(BuildContext context) {
    return Text(
      'email: $email',
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
    );
  }
}

class UsernameDetailed extends StatelessWidget {
  const UsernameDetailed({Key? key, required this.username}) : super(key: key);
  final String username;
  @override
  Widget build(BuildContext context) {
    return Text(
      'Username: $username',
      style: const TextStyle(
          fontSize: 22, fontFamily: 'Anton', fontWeight: FontWeight.w500),
    );
  }
}

class UserDetailedImage extends StatelessWidget {
  const UserDetailedImage({Key? key, required this.userImageUrl})
      : super(key: key);
  final String userImageUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FadeInImage(
          placeholder: const AssetImage('assets/person.png'),
          image: NetworkImage(
            userImageUrl,
          ),
          fit: BoxFit.cover,
        ),
      ),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
    );
  }
}
