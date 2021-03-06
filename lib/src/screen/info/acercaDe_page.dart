import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:storePlace/src/utils/responsive.dart';
import 'package:storePlace/src/urls/urls.dart' as urls;


class AcercaDePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Acerca de Nosotros'),
      ),
      body: SingleChildScrollView(
              child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(size.dp(2.0)),
              // color: Colors.red,
              width: size.wp(100),
              height: size.hp(20),
              child: Container(
                width: size.wp(40),
                height: size.hp(40),
                child: Image.asset(
                  'assets/imgs/logo_neitor.png',
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                  horizontal: size.dp(2.0), vertical: size.dp(1.0)),
              // color: Colors.blue,
              width: size.wp(100),
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                         margin: EdgeInsets.symmetric(
                  horizontal: size.dp(2.0), vertical: size.dp(1.0)),
                        child: Text(
                          'Versión. 1.0.0',
                          style: GoogleFonts.roboto(
                              fontSize: size.dp(2.0),
                              color: Colors.black87,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      Container(
                         margin: EdgeInsets.symmetric(
                  vertical: size.dp(1.0)),
                        child: Text(
                          'NeitorSGA, está diseñado por 2JL Soluciones Integrales. Somos una empresa de tegnología e innovadores a la hora de realizar un proyecto.',
                          style: GoogleFonts.roboto(
                              fontSize: size.dp(2.0),
                              color: Colors.black45,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                  Container(
                     margin: EdgeInsets.symmetric(
                  horizontal: size.dp(2.0), vertical: size.dp(1.0)),
                    child: Text(
                      'Contáctenos:',
                      style: GoogleFonts.roboto(
                          fontSize: size.dp(2.0),
                          color: Colors.black87,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  SelectableText(
                            '0980290473',
                            style: GoogleFonts.roboto(
                                fontSize: size.dp(2.0),
                                color: Color(0xFF4064AD),
                                fontWeight: FontWeight.bold),
                          ),
                  Container(
                     margin: EdgeInsets.symmetric(
                   vertical: size.dp(1.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          child: Text(
                            'soporte@2jl.ec',
                            style: GoogleFonts.roboto(
                                fontSize: size.dp(2.0),
                                color: Color(0xFF4064AD),
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: ()=>urls.abrirPagina2Jl(),
                        ),
                        GestureDetector(
                                                child: Text(
                            'neitor2jl@gmail.com',
                            style: GoogleFonts.roboto(
                                fontSize: size.dp(2.0),
                                color: Color(0xFF4064AD),
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: ()=>urls.abrirPaginaNeitor(),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                         margin: EdgeInsets.symmetric(
                  horizontal: size.dp(2.0), vertical: size.dp(1.0)),
                        child: Text(
                          'Visita nuestra web',
                          style: GoogleFonts.roboto(
                              fontSize: size.dp(2.0),
                              color: Colors.black87,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      GestureDetector(
                                              child: Container(
                           margin: EdgeInsets.symmetric(
                  horizontal: size.dp(0.0), vertical: size.dp(0.5)),
                          child: Text(
                            'https://neitor.com',
                            style: GoogleFonts.roboto(
                                fontSize: size.dp(2.5),
                                color: Color(0xFF51C1E1),
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                         onTap: ()=>urls.abrirPaginaNeitor(),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                   
                       //INSTAGRAM
                _ItemsSocials(
                  size: size,
                  icon: FontAwesomeIcons.instagram,
                  color: Color(0xFFD04768),
                  onTap: () => urls.abrirPaginaNeitor(),
                ),
                //FACEBOOK
                _ItemsSocials(
                  size: size,
                  icon: FontAwesomeIcons.facebookF,
                  color: Color(0xFF4064AD),
                  onTap: () => urls.abrirPaginaNeitor(),
                ),

                //TWITTER
                _ItemsSocials(
                  size: size,
                  icon: FontAwesomeIcons.twitter,
                  color: Color(0xFF00B1EA),
                  onTap: () => urls.abrirPaginaNeitor(),
                ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemsSocials extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Function onTap;

  _ItemsSocials({
    @required this.size,
    @required this.icon,
    @required this.color,
    this.onTap,
  });

  final Responsive size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: size.dp(1.0), vertical: size.dp(2.0)),
          padding: EdgeInsets.all(size.dp(1.2)),
          decoration: BoxDecoration(
              color: this.color, borderRadius: BorderRadius.circular(100.0)),
          child: Icon(
            this.icon,
            size: size.dp(4.0),
            color: Colors.white,
          )),
      onTap: this.onTap,
    );
  }
}
