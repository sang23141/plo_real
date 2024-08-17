// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shimmer/shimmer.dart';

// class LoadingExpandedCommentsWidget extends ConsumerWidget {
//   const LoadingExpandedCommentsWidget({super.key});
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Container(
//         height: 30,
//         padding: const EdgeInsets.all(10),
//         child: Row(
//           children: [
//             Container(
//               child: Shimmer.fromColors(
//                   baseColor: Colors.grey[200]!,
//                   highlightColor: Colors.grey[50]!,
//                   child: Container(
//                       decoration: BoxDecoration(color: Colors.grey[200]))),
//             ),
//             const SizedBox(width: 10),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: Shimmer.fromColors(
//                       baseColor: Colors.grey[200]!,
//                       highlightColor: Colors.grey[50]!,
//                       child: Container(
//                         decoration: BoxDecoration(color: Colors.grey[200]!),
//                       )),
//                 ),
//                 const SizedBox(height: 5),
//                 Expanded(
//                   child: SizedBox(
//                     width: 100,
//                     child: Shimmer.fromColors(
//                         baseColor: Colors.grey[200]!,
//                         highlightColor: Colors.grey[50]!,
//                         child: Container(
//                           decoration: BoxDecoration(color: Colors.grey[200]!),
//                         )),
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 Expanded(
//                   child: Shimmer.fromColors(
//                       baseColor: Colors.grey[200]!,
//                       highlightColor: Colors.grey[50]!,
//                       child: Container(
//                         decoration: BoxDecoration(color: Colors.grey[200]!),
//                       )),
//                 ),
//                 const SizedBox(height: 5),
//               ],
//             ),
//           ],
//         ));
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

class LoadingExpandedCommentsWidget extends ConsumerWidget {
  const LoadingExpandedCommentsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 80, // Adjust the height as needed for your design
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          // First Shimmer Block
          Container(
            width: 50, // Fixed width for the profile shimmer block
            height: 50, // Fixed height for the profile shimmer block
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(25), // Circle shape
            ),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[200]!,
              highlightColor: Colors.grey[50]!,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200]!,
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Column of Shimmer Blocks for Text
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Shimmer Line
                Container(
                  width: double.infinity,
                  height: 15, // Fixed height for the text line
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[200]!,
                    highlightColor: Colors.grey[50]!,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200]!,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                // Middle Shimmer Line
                Container(
                  width: 100,
                  height: 15, // Fixed height for the text line
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[200]!,
                    highlightColor: Colors.grey[50]!,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200]!,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                // Bottom Shimmer Line
                Container(
                  width: double.infinity,
                  height: 15, // Fixed height for the text line
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[200]!,
                    highlightColor: Colors.grey[50]!,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200]!,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
