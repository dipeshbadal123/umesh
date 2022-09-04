import 'package:flutter/material.dart';

class MatchDetails extends StatefulWidget {
  final String name;
  final String description;
  const MatchDetails({Key? key, required this.name, required this.description})
      : super(key: key);

  @override
  State<MatchDetails> createState() => _MatchDetailsState();
}

class _MatchDetailsState extends State<MatchDetails> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
