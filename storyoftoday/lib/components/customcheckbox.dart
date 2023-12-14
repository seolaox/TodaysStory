import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CustomCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState(value); // 변경된 부분
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  late bool _isChecked;

  _CustomCheckboxState(this._isChecked);

  @override
  void initState() {
    super.initState();
    _isChecked = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onChanged(!_isChecked);
        setState(() {
          _isChecked = !_isChecked;
        });
      },
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: _isChecked
            ? const Icon(
                Icons.check,
                size: 20,
                color: Colors.blue,
              )
            : null,
      ),
    );
  }
}
