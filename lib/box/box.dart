import 'package:objectbox/objectbox.dart';

abstract class MyBox<T> {
  late final Box<T> box;

  MyBox(Store store) {
    box = Box<T>(store);
  }

  Future<void> add(T data) => box.putAsync(data);

  Future<void> removeByID(int id) => box.removeAsync(id);

  Future<void> removeAll() => box.removeAllAsync();

  Future<void> addAll(List<T> dataList) => box.putManyAsync(dataList);

  // Method to get all data
  Future<List<T>> getAllData() async {
    return box.getAll();
  }
}
