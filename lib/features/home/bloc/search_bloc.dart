import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../data/repository/search_repo.dart';

part 'search_event.dart';
part 'search_state.dart';

final List<Map<String, dynamic>> subservices = [
    {
      "name": "Pet Care",
      "id": "1csXQgOUaTKAWOudxQnU",
      "serviceId": "iC6zTNS2DRPvuxNXhOIn",
      "serviceName": "Home Care",
      "tags": ["dog walking", "pet sitting", "pet grooming"]
    },
    {
      "name": "Lighting Installation",
      "id": "5FKICuJoiqrHs58wxUJY",
      "serviceId": "R017IiQFnszLS36UoGyM",
      "serviceName": "Electrical",
      "tags": [
        "light fixture installation",
        "LED lighting installation",
        "recessed lighting installation"
      ]
    },
    {
      "name": "Grout Cleaning and Sealing",
      "id": "5IW5mim3MPRV7awjJSyS",
      "serviceId": "z6OWxmt6j19xHI6lE360",
      "serviceName": "Cleaning",
      "tags": ["grout cleaning", "grout sealing", "tile and grout restoration"]
    },
    {
      "name": "Floor Cleaning",
      "id": "5mUPcR4AgMahezdeAsRI",
      "serviceId": "z6OWxmt6j19xHI6lE360",
      "serviceName": "Cleaning",
      "tags": [
        "hardwood floor cleaning",
        "tile floor cleaning",
        "carpet cleaning",
        "vaccum cleaning"
      ]
    },
    {
      "name": "Elder Care",
      "id": "FbqdY9Y5ibENS1RcdfZe",
      "serviceId": "iC6zTNS2DRPvuxNXhOIn",
      "serviceName": "Home Care",
      "tags": ["old care", "elderly", "hotspice"]
    },
    {
      "name": "Fertilization and Aeration",
      "serviceId": "5rELnxaLZrYNoj9AhWre",
      "serviceName": "Lawn Maintenance",
      "tags": ["lawn fertilization", "lawn aeration", "soil aeration"],
      "id": "LEEX4nUquIgkDjqd9Lcn"
    },
    {
      "name": "Weeding and Edging",
      "serviceName": "Lawn Maintenance",
      "tags": ["weed removal", "lawn edging", "lawn border"],
      "serviceId": "5rELnxaLZrYNoj9AhWre",
      "id": "Ubti9EvUltv4bv8DAk8I"
    },
    {
      "name": "Tire Replacement",
      "serviceId": "4fUH4KZIZ9ZnetRvaqxp",
      "serviceName": "Auto Repair",
      "tags": ["tire replacement", "tire service", "wheel alignment"],
      "id": "X5MtcJpbcGnuY2VYtqfX"
    },
    {
      "name": "Engine Oil Replacement",
      "serviceId": "4fUH4KZIZ9ZnetRvaqxp",
      "serviceName": "Auto Repair",
      "tags": ["engine oil", "oil", "oil replacement"],
      "id": "aRzcx5MG5UvuhZ3cqmKU"
    },
    {
      "name": "Tree Removal",
      "id": "b1cppylRjMZBtFbDe1JZ",
      "serviceId": "8ulfjEuW6VPA1I5bbzNC",
      "serviceName": "Tree Care",
      "tags": ["tree cutting", "tree felling", "stump removal"]
    },
    {
      "name": "Lawn Mowing",
      "serviceId": "5rELnxaLZrYNoj9AhWre",
      "serviceName": "Lawn Maintenance",
      "tags": ["lawn mow", "grass cutting", "garden trimming"],
      "id": "bjXZIYvs31M9LrwP13vy"
    },
    {
      "name": "Water Heater Repair",
      "serviceId": "lEogXW2uujgwOW2xYtr8",
      "serviceName": "Plumbing",
      "tags": [
        "hot water heater",
        "water heater maintenance",
        "water heater troubleshooting"
      ],
      "id": "gKfDXlClIK00wVOJNdUB"
    },
    {
      "name": "Outlet and Switch Repair",
      "id": "h57va3v3DSoilGm4jkqv",
      "serviceId": "R017IiQFnszLS36UoGyM",
      "serviceName": "Electrical",
      "tags": [
        "outlet repair",
        "switch repair",
        "electrical socket replacement"
      ]
    },
    {
      "name": "Fruit Picking",
      "id": "i1astnleqXvc7wzE05DM",
      "serviceId": "8ulfjEuW6VPA1I5bbzNC",
      "serviceName": "Tree Care",
      "tags": ["mango picking", "coconut picking", "jackfruit picking"]
    },
    {
      "name": "Pruning and Trimming",
      "id": "k5E0Wg4BBlr03UPImhoT",
      "serviceId": "8ulfjEuW6VPA1I5bbzNC",
      "serviceName": "Tree Care",
      "tags": ["tree pruning", "tree trimming", "branch cutting"]
    },
    {
      "name": "Childcare",
      "id": "ld95iZUj8YAUVpH5hgL5",
      "serviceId": "iC6zTNS2DRPvuxNXhOIn",
      "serviceName": "Home Care",
      "tags": ["babysitting", "child supervision", "daycare services"]
    },
    {
      "name": "AC Service",
      "id": "meJgan6XIWjLHlu0MdlT",
      "serviceId": "R017IiQFnszLS36UoGyM",
      "serviceName": "Electrical",
      "tags": ["ac repair", "air conditioning", "freon replacement"]
    },
    {
      "name": "Polishing and Waxing",
      "id": "nIGC4CTfBzcB00p2MmEh",
      "serviceId": "z6OWxmt6j19xHI6lE360",
      "serviceName": "Cleaning",
      "tags": ["floor polishing", "floor waxing", "floor maintenance"]
    },
    {
      "name": "Brake Service",
      "serviceId": "4fUH4KZIZ9ZnetRvaqxp",
      "serviceName": "Auto Repair",
      "tags": ["brake service", "brake maintenance", "brake repair"],
      "id": "pHVsgvusoxbxk6q9eYhp"
    },
    {
      "name": "Drain Cleaning",
      "serviceId": "lEogXW2uujgwOW2xYtr8",
      "serviceName": "Plumbing",
      "tags": ["clogged drain", "drain blockage", "drain unclogging"],
      "id": "sUKedRATZQnsvjy4GXhG"
    }
  ];

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepo searchRepo;
  SearchBloc({required this.searchRepo}) : super(SearchInitial()) {
    on<SearchStarted>(_onSearchStarted);
    on<SearchCleared>(_onSearchCleared);
  }

  FutureOr<void> _onSearchStarted(
      SearchStarted event, Emitter<SearchState> emit) {
    emit(SearchLoading());
    try {
      final results = searchRepo.search(event.query, subservices);
      if (results.isEmpty) {
        emit(SearchEmpty());
      } else {
        emit(SearchLoaded(results: results));
      }
    } catch (e) {
      emit(SearchError());
    }
  }

  FutureOr<void> _onSearchCleared(
      SearchCleared event, Emitter<SearchState> emit) {
    emit(SearchInitial());
  }
}
