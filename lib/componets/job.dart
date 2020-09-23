class Note {
  String _id;
  String _uid;
  String _name;
  String _address;
  String _contact;
  String _jobstatus;
  String _jobtype;
  String _jobdetails;
  String _jobaskdate;
  String _jobasktime;
  String _jobdate;
  String _jobtime;
  String _jtimestamp;

  Note(
      this._id,
      this._uid,
      this._name,
      this._address,
      this._contact,
      this._jobstatus,
      this._jobtype,
      this._jobdetails,
      this._jobaskdate,
      this._jobasktime,
      this._jobdate,
      this._jobtime,
      this._jtimestamp);

  Note.map(dynamic obj) {
    this._id = obj['id'];
    this._uid = obj['uid'];
    this._name = obj['name'];
    this._address = obj['address'];
    this._contact = obj['contact'];
    this._jobstatus = obj['jobstatus'];
    this._jobtype = obj['jobtype'];
    this._jobdetails = obj['jobdetails'];
    this._jobaskdate = obj['jobaskdate'];
    this._jobasktime = obj['jobasktime'];
    this._jobdate = obj['jobdate'];
    this._jobtime = obj['jobtime'];
    this._jtimestamp = obj['jobtimestamp'];
  }

  String get id => _id;
  String get uid => _uid;
  String get name => _name;
  String get address => _address;
  String get contact => _contact;
  String get jobstatus => _jobstatus;
  String get jobtype => _jobtype;
  String get jobdetails => _jobdetails;
  String get jobaskdate => _jobaskdate;
  String get jobasktime => _jobasktime;
  String get jobdate => _jobdate;
  String get jobtime => _jobtime;
  String get jobtimestamp => _jtimestamp;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }

    map['uid'] = _uid;
    map['name'] = _name;
    map['address'] = _address;
    map['contact'] = _contact;
    map['jobstatus'] = _jobstatus;
    map['jobtype'] = _jobtype;
    map['jobdetails'] = _jobdetails;
    map['jobaskdate'] = _jobaskdate;
    map['jobasktime'] = _jobasktime;
    map['jobdate'] = _jobdate;
    map['jobtime'] = _jobtime;
    map['jobtimestamp'] = _jtimestamp;

    return map;
  }

  Note.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._uid = map['uid'];
    this._name = map['name'];
    this._address = map['address'];
    this._contact = map['contact'];
    this._jobstatus = map['jobstatus'];
    this._jobtype = map['jobtype'];
    this._jobdetails = map['jobdetails'];
    this._jobaskdate = map['jobaskdate'];
    this._jobasktime = map['jobasktime'];
    this._jobdate = map['jobdate'];
    this._jobtime = map['jobtime'];
    this._jtimestamp = map['jobtimestamp'];
  }
}
