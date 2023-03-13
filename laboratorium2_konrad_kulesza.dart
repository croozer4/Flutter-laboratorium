void main() {
  for (int i = 0; i < 5; i++) {
    print('hello ${i + 1}');
  }
}

class Wypozyczalnia{
  List garaze = [];
  List pojazdy = [];
  
  void usunPojazd(int id){
    
  }
  
  void dodajPojazd(){
    
  }
  
  void wypiszWszystkiePojazdy(){
    
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
  }
}

abstract class Samochod extends Pojazd implements Spalinowy, Parkowalny{
  
  late String rodzajPaliwa;
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
