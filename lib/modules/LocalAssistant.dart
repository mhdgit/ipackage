import 'package:flutter/material.dart';
import 'package:ipackage/modules/Country.dart';
import 'package:ipackage/modules/Package.dart';

class LocalAssistant {


  String getCountryByLocale(context , Country country)
  {
    Locale currentLocale = Localizations.localeOf(context);

    if(currentLocale.languageCode == 'ar')
        return country.nameAR;
    else
        return country.nameEN;

  }

  String getPackageByLocale(context , Package package)
  {
    Locale currentLocale = Localizations.localeOf(context);

    if(currentLocale.languageCode == 'ar')
      return package.nameAR;
    else
      return package.nameEN;

  }

  // String getCountryByLocale(context , Country coupon , String type)
  // {
  //   Locale currentLocale = Localizations.localeOf(context);
  //
  //   if(currentLocale.languageCode == 'ar')
  //   {
  //     switch(type)
  //     {
  //       case 'name': return coupon.arName; break;
  //       case 'des': return coupon.arDescription; break;
  //     }
  //   }
  //   else
  //   {
  //     switch(type)
  //     {
  //       case 'name': return coupon.enName; break;
  //       case 'des': return coupon.enDescription; break;
  //     }
  //   }
  //
  //   return 'empty';
  //
  // }
}