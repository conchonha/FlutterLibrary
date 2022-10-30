import 'package:floor/floor.dart';

abstract class BaseDao<T> {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertItem(T item);

  @delete
  Future<void> deleteItem(T item);

  @update
  Future<void> updateItem(T item);

  @insert
  Future<void> insertTasks(List<T> tasks);
}
