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
            'tags': ['electrical', 'wiring', 'install', 'fix', 'maintenance']
          },
          {
            'name': 'Appliance Repair',
            'tags': ['electrical', 'appliance', 'repair', 'fix']
          },
          {
            'name': 'Lighting Installation',
            'tags': ['electrical', 'light', 'lighting', 'install']
          },
          {
            'name': 'Smart Home Electrical',
            'tags': ['electrical', 'smart home', 'automation', 'install']
          },
          {
            'name': 'Generator Installation',
            'tags': ['electrical', 'generator', 'install', 'power']
          },
          {
            'name': 'Safety Inspection',
            'tags': ['electrical', 'safety', 'inspect', 'check']
          },
        ],
      },
    },
    {
      'Plumber': {
        'subservices': [
          {
            'name': 'Pipe Installation & Repair',
            'tags': ['plumbing', 'pipe', 'install', 'repair', 'leak']
          },
          {
            'name': 'Leak Detection & Repair',
            'tags': ['plumbing', 'leak', 'detect', 'fix', 'repair']
          },
          {
            'name': 'Drain Cleaning & Clog Removal',
            'tags': ['plumbing', 'drain', 'clean', 'clog', 'remove']
          },
          {
            'name': 'Fixture Installation & Repair',
            'tags': [
              'plumbing',
              'fixture',
              'install',
              'repair',
              'faucet',
              'tap',
              'shower'
            ]
          },
          {
            'name': 'Water Heater Installation & Repair',
            'tags': [
              'plumbing',
              'water heater',
              'install',
              'repair',
              'hot water'
            ]
          },
          {
            'name': 'Water Softener Installation',
            'tags': ['plumbing', 'water softener', 'install', 'water treatment']
          },
        ],
      },
    },
    {
      'Tree Care': {
        'subservices': [
          {
            'name': 'Tree Trimming & Pruning',
            'tags': ['tree', 'trim', 'prune', 'cut', 'maintain', 'shape']
          },
          {
            'name': 'Tree Removal',
            'tags': ['tree', 'remove', 'cut down', 'yard']
          },
          {
            'name': 'Stump Grinding',
            'tags': ['tree', 'stump', 'grind', 'remove']
          },
          {
            'name': 'Tree Disease Diagnosis & Treatment',
            'tags': ['tree', 'disease', 'diagnose', 'treat', 'health']
          },
          {
            'name': 'Planting & Landscaping',
            'tags': ['garden', 'plant', 'tree', 'landscape', 'install']
          },
          {
            'name': 'Lawn Care & Maintenance',
            'tags': ['lawn', 'yard', 'care', 'maintain', 'grass']
          },
        ],
      },
    },
    {
      'Auto Repair': {
        'subservices': [
          {
            'name': 'Oil Change & Filter Replacement',
            'tags': [
              'car',
              'vehicle',
              'oil',
              'change',
              'filter',
              'engine',
              'maintenance'
            ]
          },
          {
            'name': 'Tire Repair & Replacement',
            'tags': ['car', 'vehicle', 'tire', 'fix', 'replace', 'wheel']
          },
          {
            'name': 'Brake Repair & Replacement',
            'tags': ['car', 'vehicle', 'brake', 'fix', 'replace', 'safety']
          },
          {
            'name': 'Engine Diagnostics & Repair',
            'tags': ['car', 'vehicle', 'engine', 'diagnose', 'fix', 'repair']
          },
          {
            'name': 'Transmission Repair',
            'tags': ['car', 'vehicle', 'transmission', 'fix', 'repair']
          },
          {
            'name': 'Battery Replacement',
            'tags': ['car', 'vehicle', 'battery', 'replace', 'electrical']
          },
        ],
      },
    },
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
