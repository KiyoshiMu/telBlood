import 'dart:collection';
class FixedQueue<E> extends ListQueue<E>{
  int size;
  FixedQueue(this.size) : super(size);
  @override
  void add(value) {    
    if (this.length > size) {
      this.removeFirst();
    }
    super.add(value);
  }
}