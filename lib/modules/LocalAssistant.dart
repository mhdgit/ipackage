import 'package:flutter/material.dart';
import 'package:ipackage/modules/Country.dart';
import 'package:ipackage/modules/Offer/Day.dart';
import 'package:ipackage/modules/Offer/Hotel/Hotel.dart';
import 'package:ipackage/modules/Offer/Hotel/HotelFacility.dart';
import 'package:ipackage/modules/Offer/Offer.dart';
import 'package:ipackage/modules/Offer/Transportations/Transportation.dart';
import 'package:ipackage/modules/Offer/Trip.dart';
import 'package:ipackage/modules/Package.dart';
import 'package:ipackage/modules/SpecialDomesticOffer.dart';
import 'package:ipackage/modules/SpecialForeignOffer.dart';

import 'Offer/Airport.dart';

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

  String getOfferByLocale(context , Offer offer , String type)
  {
    Locale currentLocale = Localizations.localeOf(context);

    if(currentLocale.languageCode == 'ar')
    {
      switch(type)
      {
        case 'des': return offer.descriptionAR; break;
        case 'country': return offer.countryAR; break;
        case 'package': return offer.packageAR; break;
      }
    }
    else
    {
      switch(type)
      {
        case 'des': return offer.descriptionEN; break;
        case 'country': return offer.countryEN; break;
        case 'package': return offer.packageEN; break;
      }
    }

    return 'empty';
  }

  String getTransportationByLocale(context , Transportation trans)
  {
    Locale currentLocale = Localizations.localeOf(context);

    if(currentLocale.languageCode == 'ar')
      return trans.nameAR;
    else
      return trans.nameEN;

  }

  String getDayCityByLocale(context , Day day)
  {
    Locale currentLocale = Localizations.localeOf(context);

    if(currentLocale.languageCode == 'ar')
      return day.cityAR;
    else
      return day.cityEN;
  }

  String getHotelByLocale(context , Hotel hotel , String type)
  {
    Locale currentLocale = Localizations.localeOf(context);

    if(currentLocale.languageCode == 'ar')
    {
      switch(type)
      {
        case 'name': return hotel.nameAR; break;
        case 'acc': return hotel.accommodationAR; break;
      }
    }
    else
    {
      switch(type)
      {
        case 'name': return hotel.nameEN; break;
        case 'acc': return hotel.accommodationEN; break;
      }
    }

    return 'empty';
  }

  String getHotelFacilityByLocale(context , HotelFacility hf)
  {
    Locale currentLocale = Localizations.localeOf(context);

    if(currentLocale.languageCode == 'ar')
      return hf.nameAR;
    else
      return hf.nameEN;
  }

  String getTripByLocale(context , Trip trip , String type)
  {
    Locale currentLocale = Localizations.localeOf(context);

    if(currentLocale.languageCode == 'ar')
    {
      switch(type)
      {
        case 'name': return trip.nameAR; break;
        case 'trip': return trip.tripAR; break;
      }
    }
    else
    {
      switch(type)
      {
        case 'name': return trip.nameEN; break;
        case 'trip': return trip.tripEN; break;
      }
    }

    return 'empty';
  }

  String getSpecialDomesticOfferByLocale(context , SpecialDomesticOffer sdo , String type)
  {
    Locale currentLocale = Localizations.localeOf(context);

    if(currentLocale.languageCode == 'ar')
    {
      switch(type)
      {
        case 'title': return sdo.descriptionAR; break;
        case 'country': return sdo.countryAR; break;
        case 'package': return sdo.packageAR; break;
        case 'desc': return sdo.descriptionAR; break;
      }
    }
    else
    {
      switch(type)
      {
        case 'title': return sdo.descriptionEN; break;
        case 'country': return sdo.countryEN; break;
        case 'package': return sdo.packageEN; break;
        case 'desc': return sdo.descriptionEN; break;
      }
    }

    return 'empty';
  }

  String getSpecialForeignOfferByLocale(context , SpecialForeignOffer sfo , String type)
  {
    Locale currentLocale = Localizations.localeOf(context);

    if(currentLocale.languageCode == 'ar')
    {
      switch(type)
      {
        case 'title': return sfo.descriptionAR; break;
        case 'country': return sfo.countryAR; break;
        case 'package': return sfo.packageAR; break;
        case 'desc': return sfo.descriptionAR; break;
      }
    }
    else
    {
      switch(type)
      {
        case 'title': return sfo.descriptionEN; break;
        case 'country': return sfo.countryEN; break;
        case 'package': return sfo.packageEN; break;
        case 'desc': return sfo.descriptionEN; break;
      }
    }

    return 'empty';
  }

  String getAirportByLocale(context , Airport airport)
  {
    Locale currentLocale = Localizations.localeOf(context);

    if(currentLocale.languageCode == 'ar')
      return airport.nameAR;
    else
      return airport.nameEN;
  }
}