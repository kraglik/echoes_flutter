import 'package:flutter/material.dart';


class FallBackAvatar extends StatefulWidget {
  final NetworkImage image;
  final String initials;
  final TextStyle textStyle;
  final Color circleBackground;

  FallBackAvatar({@required this.image, @required this.initials, @required this.circleBackground, @required this.textStyle});

  @override
  _FallBackAvatarState createState() => _FallBackAvatarState();
}

class _FallBackAvatarState extends State<FallBackAvatar> {

  bool _checkLoading = true;

  @override
  initState() {
    super.initState();
    // Add listeners to this class
    ImageStreamListener listener = ImageStreamListener(_setImage, onError: _setError);

    widget.image.resolve(ImageConfiguration()).addListener(listener);
  }

  void _setImage(ImageInfo image, bool sync) {
    setState(() => _checkLoading = false);
    //DO NOT DISPOSE IF IT WILL REBUILD (e.g. Sliver/Builder ListView)
    dispose();
  }

  void _setError(dynamic dyn, StackTrace st) {
    setState(() => _checkLoading = true);
    dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _checkLoading == true ? new CircleAvatar(
        radius: 28,
        backgroundColor: widget.circleBackground,
        child: new Text(widget.initials, style: widget.textStyle)) : new CircleAvatar(
      backgroundImage: widget.image,
      radius: 28.0,
      backgroundColor: widget.circleBackground,);
  }
}