import 'package:flutter/material.dart';
import 'package:lock_words/providers/animation_state.dart';
import 'package:provider/provider.dart';

class DialLetter extends StatefulWidget {
  final Offset offset;
  final double angle;
  final double tileSize;
  final Border border;
  final String body;
  final AnimationController scrollBackController;
  const DialLetter({
    super.key,
    required this.offset,
    required this.angle,
    required this.tileSize,
    required this.border,
    required this.body,
    required this.scrollBackController
  });

  @override
  State<DialLetter> createState() => _DialLetterState();
}

class _DialLetterState extends State<DialLetter> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeAnimations();
  }

  void initializeAnimations() {


  }

  @override
  Widget build(BuildContext context) {
    // late AnimationState animationState = Provider.of<AnimationState>(context, listen: false);
    return Consumer<AnimationState>(
      builder: (context,animationState,child) {
        return Transform.translate(
          offset: widget.offset,
          child: Transform(
            transform: Matrix4.rotationX(widget.angle),
            child: Container(
              width: widget.tileSize,
              height: widget.tileSize,
              child: Center(
                child: Container(
                  width: widget.tileSize*0.9,
                  height: widget.tileSize*0.9,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Color.fromARGB(255, 228, 195, 146),
                        Color.fromARGB(255, 238, 232, 178)
                      ]
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    border: widget.border,
                  ),
                  child: Center(
                    child: Text(
                      widget.body,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: widget.tileSize*0.5
                      ),
                    ),
                  ),
                ),
              ),                    
            )               
          )
        );
      }
    );  
  }
}