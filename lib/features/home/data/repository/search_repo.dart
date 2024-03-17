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

import 'package:flutter/material.dart';
import 'package:fuzzy/fuzzy.dart';

class SearchRepo {
  final bookList = [
    'Old Man\'s War',
    'The Lock Artist',
    'HTML5',
    'Right Ho Jeeves',
    'The Code of the Wooster',
    'Thank You Jeeves',
    'The DaVinci Code',
    'Angels & Demons',
    'The Silmarillion',
    'Syrup',
    'The Lost Symbol',
    'The Book of Lies',
    'Lamb',
    'Fool',
    'Incompetence',
    'Fat',
    'Colony',
    'Backwards, Red Dwarf',
    'The Grand Design',
    'The Book of Samson',
    'The Preservationist',
    'Fallen',
    'Monster 1959',
  ];
  Map<String, Map<String, String>> tagToServiceMap = {};
  List<String> getSearchableItems() {
    List<String> items = [];

    for (var serviceMap in serviceMapList) {
      for (var service in serviceMap.entries) {
        // Add the subservices
        for (var subservice in service.value['subservices']) {
          items.add(subservice);
          tagToServiceMap[subservice] = {
            'service': service.key,
            'subservice': subservice,
          };
        }

        // Add the tags
        for (var tag in service.value['tags']) {
          items.add(tag);
          tagToServiceMap[tag] = {
            'service': service.key,
            'subservice': '', // There is no subservice associated with the tag
          };
        }
      }
    }

    return items;
  }

  final List<Map<String, dynamic>> serviceMapList = [
    {
      'Electrician': {
        'subservices': ['Wiring', 'Repair', 'Installation'],
        'tags': ['Electrical', 'Bulb', 'Maintenance']
      },
    },
    {
      'Plumber': {
        'subservices': ['Pipe Repair', 'Leak Fixing', 'Drain Cleaning'],
        'tags': ['Plumbing', 'Maintenance']
      },
    },
    {
      'Tree Climber': {
        'subservices': ['Tree Trimming', 'Tree Removal', 'Pruning'],
        'tags': ['Gardening', 'Maintenance']
      },
    }
  ];

  List<String> search(String query) {
    final fuse = Fuzzy(
      getSearchableItems(),
      options: FuzzyOptions(
        findAllMatches: true,
        tokenize: true,
        threshold: 0.5,
      ),
    );
    final result = fuse.search(query);
    List<String> serviceAndSubserviceNames = [];
    for (var r in result) {
      var serviceInfo = tagToServiceMap[r.item];
      String serviceName = serviceInfo?['service'] ?? '';
      String subserviceName = serviceInfo?['subservice'] ?? '';
      String serviceAndSubserviceName = '$serviceName - $subserviceName';
      serviceAndSubserviceNames.add(serviceAndSubserviceName);
    }
    return serviceAndSubserviceNames;
  }
}
