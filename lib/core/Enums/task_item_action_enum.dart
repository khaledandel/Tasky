enum TaskItemActionEnum {
  markAsDone(name: 'Mark As Done'),
  edit(name: 'Edit'),
  delete(name: 'Delete');

  final String name;
  const TaskItemActionEnum({required this.name});
}
