import 'dart:io';

class ToDo {
  var title;
  var startdate;
  var enddate;
  var status;
  var lefttime;
  
  ToDo(this.title, this.startdate, this.enddate, this.status, this.lefttime);

  ToDo.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        startdate = json['startdate'],
        enddate = json['enddate'],
        status = json['status'],
        lefttime = json['lefttime'];

  Map<String, dynamic> toJson() =>
    {
      'title': title,
      'startdate': startdate,
      'enddate': enddate,
      'status': status,
      'lefttime': lefttime,
    };
}
