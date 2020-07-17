class Task {
  int _id;
  String _task, _date, _date_end, _status;

  Task(this._task, this._date, this._date_end, this._status);
  Task.withId(this._id, this._task, this._date, this._date_end, this._status);

  int get id => _id;
  String get task => _task;
  String get date => _date;
  String get date_end => _date_end;
  String get status => _status;

  set task(String newTask) {
    if (newTask.length <= 255) {
      this._task = newTask;
    }
  }

  set date(String newDate) => this._date = newDate;

  set date_end(String newDateEnd) => this._date_end = newDateEnd;

  set status(String newStatus) => this._status = newStatus;

  //Convert Task object into MAP object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) map['id'] = _id;
    map['task'] = _task;
    map['date'] = _date;
    map['date_end'] = _date_end;
    map['status'] = _status;
    return map;
  }

  //Extract Task object from MAP object
  Task.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._task = map['task'];
    this._date = map['date'];
    this._date_end = map['date_end'];
    this._status = map['status'];
  }
}
