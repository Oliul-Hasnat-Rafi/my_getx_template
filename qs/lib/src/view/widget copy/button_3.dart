import 'package:flutter/material.dart';
import 'package:on_process_button_widget/on_process_button_widget.dart';

class Button3 extends StatelessWidget {
  const Button3({super.key, this.child, this.onTap, this.padding});
  final Widget? child;
  final Function()? onTap;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      // child: Material(
      //   clipBehavior: Clip.antiAlias,
      //   color: Colors.transparent,
      //   borderRadius: BorderRadius.circular(Theme.of(context).buttonTheme.height * 2),
      //   child: Stack(
      //     children: [
      //       Container(
      //         alignment: Alignment.center,
      //         clipBehavior: Clip.antiAlias,
      //         margin: padding,
      //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(Theme.of(context).buttonTheme.height * 2)),
      //         child: child,
      //       ),
      //       Positioned.fill(
      //         child: InkWell(
      //           onTap: onTap,
      //         ),
      //       )
      //     ],
      //   ),
      // ),
      child: SizedBox(
        height: Theme.of(context).buttonTheme.height,
        child: AspectRatio(
          aspectRatio: 1,
          child: OnProcessButtonWidget(
            contentPadding: EdgeInsets.zero,
            iconColor: Theme.of(context).colorScheme.onBackground,
            backgroundColor: Colors.transparent,
            constraints: BoxConstraints(),
            borderRadius: BorderRadius.circular(Theme.of(context).buttonTheme.height * 2),
            onTap: () async {
              if (onTap != null) await onTap!();
              return;
            },
            child: Container(
              alignment: Alignment.center,
              clipBehavior: Clip.antiAlias,
              margin: padding,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(Theme.of(context).buttonTheme.height * 2)),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
