  #include <stdio.h>
  #include <math.h>
  #include <windows.h>
// ------------ main --------------------
  int _export func(char*str)
  {
    printf( str );
    return 0;
  }
  double _export DegToRad( double x )
  {
    return x*M_PI/180;
  }
  double _export RadToDeg( double x )
  {
    return x*180/M_PI;
  }
  double _export firstatan( double x , double y , double xxx , double yyy )
  {
//    if ( ( (yyy - y) + (xxx - x) ) == 0)
//       return RadToDeg( atan2( 1+rand()%3 , 1+rand()%3 ) );
    return RadToDeg( atan2( yyy - y , xxx - x ) );
  }
/*
  def DegToRad x
    x*Math::PI/180
  end
  def RadToDeg x
    x*180/Math::PI
  end
  def firstatan x , y, xxx, yyy
     return RadToDeg( Math.atan2( yyy - y , xxx - x ))
  end
*/
