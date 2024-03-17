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
  List<String> getSearchableItems() {
  List<String> items = [];

  for (var serviceMap in serviceMapList) {
    for (var service in serviceMap.entries) {
      // Add the service name to the items
      items.add(service.key);
      tagToServiceMap[service.key] = {
        'service': service.key,
        'subservice': '',
      };

      // Extract the subservices
      for (var subserviceMap in service.value['subservices']) {
        String subservice = subserviceMap['name'];
        items.add(subservice);
        tagToServiceMap[subservice] = {
          'service': service.key,
          'subservice': subservice,
        };

        // Extract the tags
        for (var tag in subserviceMap['tags']) {
          items.add(tag);
          tagToServiceMap[tag] = {
            'service': service.key,
            'subservice': subservice,
          };
        }
      }
    }
  }

  return items;
}

  final List<Map<String, dynamic>> serviceMapList = [
    {
      'Electrician': {
        'subservices': [
          {
            'name': 'Wiring',
            'tags': ['Electrical', 'Bulb', 'Maintenance']
          },
          {
            'name': 'Repair',
            'tags': ['Electrical', 'Maintenance']
          },
          {
            'name': 'Installation',
            'tags': ['Electrical', 'Maintenance']
          },
          {
            'name': 'Fan Installation',
            'tags': ['Electrical', 'Maintenance']
          },
          {
            'name': 'Inverter Installation',
            'tags': ['Electrical', 'Maintenance']
          },
          {
            'name': 'AC Installation',
            'tags': ['Electrical', 'Maintenance']
          },
        ],
      },
    },
    {
      'Plumber': {
        'subservices': [
          {
            'name': 'Pipe Repair',
            'tags': ['Plumbing', 'Maintenance']
          },
          {
            'name': 'Leak Fixing',
            'tags': ['Plumbing', 'Maintenance']
          },
          {
            'name': 'Drain Cleaning',
            'tags': ['Plumbing', 'Maintenance']
          },
          {
            'name': 'Tap Repair',
            'tags': ['Plumbing', 'Maintenance']
          },
          {
            'name': 'Toilet Repair',
            'tags': ['Plumbing', 'Maintenance']
          },
          {
            'name': 'Bathroom Fittings',
            'tags': ['Plumbing', 'Maintenance']
          },
        ],
      },
    },
    {
      'Tree Climber': {
        'subservices': [
          {
            'name': 'Tree Trimming',
            'tags': ['Gardening', 'Maintenance']
          },
          {
            'name': 'Tree Removal',
            'tags': ['Gardening', 'Maintenance']
          },
          {
            'name': 'Pruning',
            'tags': ['Gardening', 'Maintenance']
          },
          {
            'name': 'Garden Maintenance',
            'tags': ['Gardening', 'Maintenance']
          },
          {
            'name': 'Lawn Mowing',
            'tags': ['Gardening', 'Maintenance']
          },
          {
            'name': 'Hedge Trimming',
            'tags': ['Gardening', 'Maintenance']
          },
        ],
      },
    }
  ];

  List<Map<String, String>> search(String query) {
    final fuse = Fuzzy(
      getSearchableItems(),
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
