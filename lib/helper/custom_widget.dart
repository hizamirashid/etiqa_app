import 'package:flutter/material.dart';

class CustomWidget extends StatelessWidget {
  CustomWidget({
    Key key,
    this.title,
    this.sub1,
    this.sub2,
    this.delete,
    this.trailing,
    this.status,
  }) : super(key: key);

  final String title;
  final String sub1;
  final String sub2;
  final Widget delete;
  final Widget trailing;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      '$title',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(children: <Widget>[
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  'Start Date',
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontFamily: 'Lato',
                                      fontStyle: FontStyle.normal,
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  '$sub1',
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontFamily: 'Lato',
                                      fontStyle: FontStyle.normal,
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  'End Date',
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontFamily: 'Lato',
                                      fontStyle: FontStyle.normal,
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  '$sub2',
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontFamily: 'Lato',
                                      fontStyle: FontStyle.normal,
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  'Time Left',
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontFamily: 'Lato',
                                      fontStyle: FontStyle.normal,
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  '1 hour',
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontFamily: 'Lato',
                                      fontStyle: FontStyle.normal,
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ), //Column
                    ),
                    delete,
                    trailing,
                  ]),
                ],
              )),
          Container(
            decoration: BoxDecoration(
                color: Colors.yellow[100],
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0))),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          'Status: ',
                          maxLines: 1,
                          style: TextStyle(
                              fontFamily: 'Lato',
                              fontStyle: FontStyle.normal,
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        '$status',
                        maxLines: 1,
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontStyle: FontStyle.normal,
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          'Tick if completed: ',
                          maxLines: 1,
                          style: TextStyle(
                              fontFamily: 'Lato',
                              fontStyle: FontStyle.normal,
                              color: Colors.black,
                              fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  } //build()

}
