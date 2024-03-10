import 'package:dartz/dartz.dart';
// import 'package:quikhyr/features/home/data/data_provider/most_rated_workers_data_provider.dart';
import 'package:quikhyr/models/worker_model.dart';

class MostRatedWorkersRepo {
  // final MostRatedWorkersDataProvider _mostRatedWorkersDataSource;

  // MostRatedWorkersRepo(this._mostRatedWorkersDataSource);

  Future<Either<String, List<WorkerModel>>> getMostRatedWorkers() async {
    // try {
    //   final workers = await _mostRatedWorkersDataSource.getMostRatedWorkers();
    //   return Right(workers);
    // } on ServerException {
    //   return Left(ServerFailure());
    // }
    try {
      return const Right([
      WorkerModel(
          id: "1",
          name: "John Burke",
          profileImageUrl: "assets/images/ratedWorker1.png",
          isVerified: true,
          category: "Mechanic",
          rating: 4.5),
      WorkerModel(
          id: "2",
          name: "Kenny Kirk",
          profileImageUrl: "assets/images/ratedWorker2.png",
          isVerified: true,
          category: "Cleaner",
          rating: 4.3),
      WorkerModel(
          id: "3",
          name: "Henry Kal",
          profileImageUrl: "assets/images/ratedWorker3.png",
          isVerified: false,
          category: "Plumber",
          rating: 4.25),
    ]);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
