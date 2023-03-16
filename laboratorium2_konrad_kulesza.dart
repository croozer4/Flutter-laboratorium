void main() {
  
}

class Wypozyczalnia{
  List garaze = [];
  List pojazdy = [];
  
  void usunPojazd(int idDoUsuniecia){
    pojazdy.removeWhere((element) => element['id'] == idDoUsuniecia);
  }
  
  void dodajPojazd(Pojazd pojazdDoDodania){
    pojazdy.add(pojazdDoDodania);
  }
  
  void wypiszWszystkiePojazdy(){
    print(pojazdy);
  }
  
  
}

class Garaz{
  bool czyPusty = true;
  late Pojazd aktualnyPojazd;
  
}

abstract class Pojazd{
  late int id;
  late String nazwaPojazdu;
  
  Pojazd(String nazwaPojazdu){
    this.nazwaPojazdu = nazwaPojazdu;
    
    int maxId = 0;
    
    listaWszystkichPojazdow.forEach( (pojazd){
      if(pojazd.id > maxId){
        maxId = pojazd.id;
      }
    });
    
    id = maxId + 1; 
  }
}

abstract class Samochod extends Pojazd implements Spalinowy, Parkowalny{
  
  late String _rodzajPaliwa;
  
  String get rodzajPaliwa => _rodzajPaliwa;
  set rodzajPaliwa(String value) => _rodzajPaliwa = value;
  
  late Garaz aktualnyGaraz;
  int iloscPaliwa = 0;
  
  Samochod(String nazwaPojazdu, this.rodzajPaliwa)
    :super(nazwaPojazdu);
  
}

abstract class Motorowka extends Pojazd implements Spalinowy{
  
  late String rodzajPaliwa;
  int iloscPaliwa = 0;
  
  Motorowka(String nazwaPojazdu, this.rodzajPaliwa)
    :super(nazwaPojazdu);
}

abstract class Rower extends Pojazd implements Parkowalny{
  late Garaz aktualnyGaraz;
  
  Rower(String nazwaPojazdu, this.aktualnyGaraz)
    :super(nazwaPojazdu);
}

abstract class Hulajnoga extends Pojazd{
  Hulajnoga(String nazwaPojazdu)
    :super(nazwaPojazdu);
}

class Spalinowy{
  String get rodzajPaliwa;
  set rodzajPaliwa(String value);
  
  void tankowanie(int litry, String rodzajPaliwa){
    if(this.rodzajPaliwa == rodzajPaliwa){
      print("Zatankowano pojazd");
    }
    else{
      print("To nie jest właściwy rodzaj paliwa");
    }
  }
  
  void jakiePaliwo(){
    print("Pojazd korzysta z paliwa: $rodzajPaliwa");
  }
}

class Parkowalny{
  void zaparkujPojazd(Garaz wybranyGaraz){
    if(aktualnyGaraz.czyPusty){
      aktualnyGaraz = wybranyGaraz;
      print("Pojazd został zaparkowany");
    }
    print("Pojazd nie został zaparkowany, garaż nie jest pusty");
  }
  
  void wyparkujPojazd(){
    print("Samochod został wyparkowany");
  }
}