import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:goalkeeper/utils/public.dart';

Widget buildAboutPage(BuildContext context) {
  return Container(
    child: ListView(
      children: <Widget>[
        buildTile(
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      width: 75.0,
                      height: 75.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage("assets/urmil-vector.png")))),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text("</> by",
                        style: TextStyle(color: invertColors(context))),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text("Urmil Shroff",
                        style: TextStyle(
                            color: invertColors(context),
                            fontWeight: FontWeight.w600,
                            fontSize: 20.0)),
                  ),
                ]),
          ),
        ),
        buildTile(
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                    //TODO complete this section
                  Center(
                    child: Text("View on",
                        style: TextStyle(color: invertColors(context))),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text("Twiter | GitHub | Website",
                        style: TextStyle(
                          color: invertColors(context),
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                ]),
          ),
        ),
      ],
    ),
  );
}
