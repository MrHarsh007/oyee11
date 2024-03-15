import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Homeshimmer extends StatefulWidget {
  const Homeshimmer({Key? key}) : super(key: key);

  @override
  State<Homeshimmer> createState() => _HomeshimmerState();
}

class _HomeshimmerState extends State<Homeshimmer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 100,),
          SliderShimmerWidget(),
          TextHadingShimmer(),
          MatchCardShimmer(),
        ],
      ),
    );
  }
}

class TextHadingShimmer extends StatelessWidget {
  const TextHadingShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0,left: 30.0),
      child: Shimmer.fromColors(
        baseColor: Colors.black,
        highlightColor: Colors.white,
        child: Skelton(
          height: 20.0,
          width: 180.0,
        ),
      ),
    );
  }
}

class SliderShimmerWidget extends StatelessWidget {
  const SliderShimmerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Shimmer.fromColors(
        baseColor: Colors.black,
        highlightColor: Colors.white,
        child: Skelton(
          height: 150.0,
          width: 500.0,
        ),
      ),
    );
  }
}

class MatchCardShimmer extends StatelessWidget {
  const MatchCardShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.black,
                  highlightColor: Colors.white,
                  child: Skelton(
                    height: 20.0,
                    width: 100.0,
                  ),
                ),
              ),
              Divider(thickness: 1,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.black,
                      highlightColor: Colors.white,
                      child: Skelton(
                        height: 10.0,
                        width: 100.0,
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.black,
                      highlightColor: Colors.white,
                      child: Skelton(
                        height: 10.0,
                        width: 100.0,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.black,
                      highlightColor: Colors.white,
                      child: Skelton(
                        height: 30.0,
                        width: 30.0,
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.black,
                      highlightColor: Colors.white,
                      child: Skelton(
                        height: 10.0,
                        width: 70.0,
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.black,
                      highlightColor: Colors.white,
                      child: Skelton(
                        height: 20.0,
                        width: 20.0,
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.black,
                      highlightColor: Colors.white,
                      child: Skelton(
                        height: 10.0,
                        width: 70.0,
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.black,
                      highlightColor: Colors.white,
                      child: Skelton(
                        height: 30.0,
                        width: 30.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}

class Skelton extends StatelessWidget {
  const Skelton({
    Key? key,
    this.height,
    this.width,
  }) : super(key: key);

  final height, width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.04),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
    );
  }
}

