// // ignore_for_file: depend_on_referenced_packages

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:plastic_eliminator/features/Home/school_pages/schooldetails.dart';

// class SchoolListPage extends StatelessWidget {
//   const SchoolListPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance.collection('schools').snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (!snapshot.hasData) {
//             return Center(child: Text('No schools available'));
//           }

//           var schools = snapshot.data!.docs;

//           return ListView.builder(
//             itemCount: schools.length,
//             itemBuilder: (context, index) {
//               var schoolData = schools[index].data() as Map<String, dynamic>;

//               return GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => SchoolDetailPage(
//                         schoolName: schoolData['name'] ?? 'No Name',
//                         schoolCode: schoolData['school_code'] ?? 'No Code',
//                         activities: schoolData['activities_done_by_school'] ??
//                             'No Activities',
//                         ngoInvolved: schoolData['ngo_involved'] ?? 'No NGO',
//                         clerkName: schoolData['clerk_name'] ?? 'No Clerk Name',
//                         ngoHeadOfSchool:
//                             schoolData['ngo_head_of_school'] ?? 'No Head',
//                         phoneNumber:
//                             schoolData['phone_number'] ?? 'No Phone Number',
//                         address: schoolData['address'] ?? 'No Address',
//                         socialMedia: Map<String, String>.from(
//                             schoolData['social_media'] ?? {}),
//                       ),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   // padding: EdgeInsets.all(8.0),
//                   margin: EdgeInsets.symmetric(vertical: 4.0),
//                   child: Row(
//                     children: [
//                       Container(
//                         width: 50.0,
//                         height: 50.0,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Theme.of(context).colorScheme.secondary,
//                         ),
//                         child: Center(
//                           child: Icon(
//                             Icons.school_outlined,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                           width: 16.0), // Space between circle and text
//                       Expanded(
//                      child: Text(
//                           '${schoolData['name'] ?? 'No Name'}, ${schoolData['school_code'] ?? 'No Code'}',
//                           // style: Theme.of(context).textTheme.bodyText1,
//                         ),                      ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plastic_eliminator/features/Home/school_pages/schooldetails.dart';

class SchoolListPage extends StatelessWidget {
  const SchoolListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('schools').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return Center(child: Text('No schools available'));
          }

          var schools = snapshot.data!.docs;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(schools.length, (index) {
                var schoolData = schools[index].data() as Map<String, dynamic>;

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SchoolDetailPage(
                          schoolName: schoolData['name'] ?? 'No Name',
                          schoolCode: schoolData['school_code'] ?? 'No Code',
                          activities: schoolData['activities_done_by_school'] ??
                              'No Activities',
                          ngoInvolved: schoolData['ngo_involved'] ?? 'No NGO',
                          clerkName:
                              schoolData['clerk_name'] ?? 'No Clerk Name',
                          ngoHeadOfSchool:
                              schoolData['ngo_head_of_school'] ?? 'No Head',
                          phoneNumber:
                              schoolData['phone_number'] ?? 'No Phone Number',
                          address: schoolData['address'] ?? 'No Address',
                          socialMedia: Map<String, String>.from(
                              schoolData['social_media'] ?? {}),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    margin: EdgeInsets.symmetric(
                        horizontal: 4.0), // Horizontal spacing
                    width: MediaQuery.of(context).size.width *
                        0.8, // Adjust width to fit within the screen
                    child: Row(
                      children: [
                        Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.school_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                            width: 16.0), // Space between circle and text
                        Expanded(
                          child: Text(
                            '${schoolData['name'] ?? 'No Name'}, ${schoolData['school_code'] ?? 'No Code'}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
