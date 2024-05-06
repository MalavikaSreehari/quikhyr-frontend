// import 'package:flutter/material.dart';
// import 'package:fuzzy/fuzzy.dart';

// class SearchRepo {
//   final List<String> services = ['Electrician', 'Plumber', 'Tree Climber'];

//   final List<String> electricianSubservices = [
//     'Wiring',
//     'Repair',
//     'Installation'
//   ];
//   final List<String> plumberSubservices = [
//     'Pipe Repair',
//     'Leak Fixing',
//     'Drain Cleaning'
//   ];
//   final List<String> treeClimberSubservices = [
//     'Tree Trimming',
//     'Tree Removal',
//     'Pruning'
//   ];

//   void search(String query) {
//     final fuse = Fuzzy([
//       {'Electrician': electricianSubservices},
//       {'Plumber': plumberSubservices},
//       {'Tree Climber': treeClimberSubservices}
//     ]);
//     final result = fuse.search(query);
//     for (var element in result) {
//       debugPrint(element.item.toString());
//     }
//   }
// }

import 'package:fuzzy/fuzzy.dart';

class SearchRepo {
  // final bookList = [
  //   'Old Man\'s War',
  //   'The Lock Artist',
  //   'HTML5',
  //   'Right Ho Jeeves',
  //   'The Code of the Wooster',
  //   'Thank You Jeeves',
  //   'The DaVinci Code',
  //   'Angels & Demons',
  //   'The Silmarillion',
  //   'Syrup',
  //   'The Lost Symbol',
  //   'The Book of Lies',
  //   'Lamb',
  //   'Fool',
  //   'Incompetence',
  //   'Fat',
  //   'Colony',
  //   'Backwards, Red Dwarf',
  //   'The Grand Design',
  //   'The Book of Samson',
  //   'The Preservationist',
  //   'Fallen',
  //   'Monster 1959',
  // ];
  Map<String, Map<String, String>> tagToServiceMap = {};

  List<String> getSearchableItems(List<Map<String, dynamic>> subservices) {
    List<String> items = [];

    for (var subservice in subservices) {
      // Add the service name to the items
      items.add(subservice['serviceName']);
      tagToServiceMap[subservice['serviceName']] = {
        'service': subservice['serviceName'],
        'subservice': '',
      };

      // Add the subservice name to the items
      items.add(subservice['name']);
      tagToServiceMap[subservice['name']] = {
        'service': subservice['serviceName'],
        'subservice': subservice['name'],
      };

      // Extract the tags
      for (var tag in subservice['tags']) {
        items.add(tag);
        tagToServiceMap[tag] = {
          'service': subservice['serviceName'],
          'subservice': subservice['name'],
        };
      }
    }

    return items;
  }

  

  List<Map<String, String>> search(
      String query, List<Map<String, dynamic>> subservices) {
    final fuse = Fuzzy(
      getSearchableItems(subservices),
      options: FuzzyOptions(
        findAllMatches: true,
        tokenize: true,
        threshold: 0.5,
      ),
    );
    final result = fuse.search(query);
    List<Map<String, String>> serviceAndSubserviceNames = [];
    for (var r in result) {
      var serviceInfo = tagToServiceMap[r.item];
      String serviceName = serviceInfo?['service'] ?? '';
      String subserviceName = serviceInfo?['subservice'] ?? '';
      String matchedTag = r.item;
      serviceAndSubserviceNames.add({
        'service': serviceName,
        'subservice': subserviceName,
        'tag': matchedTag,
      });
    }
    return serviceAndSubserviceNames;
  }
}
