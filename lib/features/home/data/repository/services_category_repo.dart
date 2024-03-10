// import 'package:quikhyr/features/home/data/data_provider/services_category_data_provider.dart';
import 'package:quikhyr/models/service_category_model.dart';

class ServicesCategoryRepo {
  // final ServicesCategoryDataProvider _servicesCategoryDataSource;

  // ServicesCategoryRepo(this._servicesCategoryDataSource);

  Future<List<ServiceCategoryModel>> getServicesCategory() async {
    //FOR INITIAL PROTOTYPE TAKING STATIC DATA
    return [
      const ServiceCategoryModel(
        id: '1',
        title: 'Plumbing',
        iconPath: 'assets/icons/plumbing.svg',
      ),
      const ServiceCategoryModel(
        id: '2',
        title: 'Auto Repair',
        iconPath: 'assets/icons/auto_repair.svg',
      ),
      const ServiceCategoryModel(
        id: '3',
        title: 'Electricals',
        iconPath: 'assets/icons/electricals.svg',
      ),
      const ServiceCategoryModel(
        id: '4',
        title: 'Tree Climbing',
        iconPath: 'assets/icons/tree_climbing.svg',
      ),
      const ServiceCategoryModel(
        id: '5',
        title: 'Cleaning',
        iconPath: 'assets/icons/cleaning.svg',
      ),
      const ServiceCategoryModel(
        id: '6',
        title: 'Home Care',
        iconPath: 'assets/icons/home_care.svg',
      ),
      const ServiceCategoryModel(
        id: '7',
        title: 'Lawn Management',
        iconPath: 'assets/icons/lawn_management.svg',
      ),

    ];
  }
}
