import 'dart:convert';

List<Pojazd> listaWszystkichPojazdow = [];

void main() {
  String pojazdy = '''<pojazdy>
    <samochod>
        <nazwa>Honda Civic</nazwa>
        <rodzajPaliwa>3</rodzajPaliwa>
    </samochod>
    <motorowka>
        <nazwa>Super motorowka</nazwa>
        <rodzajPaliwa>0</rodzajPaliwa>
    </motorowka>
    <samochod>
        <nazwa>Mercedes CLK</nazwa>
        <rodzajPaliwa>5</rodzajPaliwa>
    </samochod>
    <rower>
        <nazwa>Giant</nazwa>
    </rower>
    <hulajnoga>
        <nazwa>Najfajniejsza hulajnoga</nazwa>
    </hulajnoga>
</pojazdy>''';
  
    var xmlDoc = XmlDocument.parse(pojazdy);
  var pojazdyList = xmlDoc.findAllElements('pojazdy').expand((p) => p.children);
  var wypozyczalnia = Wypozyczalnia();

  pojazdyList.forEach((pojazd) {
    var nazwa = pojazd.findElements('nazwa').single.text;

    if (pojazd.tagName == 'samochod') {
      var rodzajPaliwa = int.parse(pojazd.findElements('rodzajPaliwa').single.text);
      var samochod = Samochod(nazwa, rodzajPaliwa);
      wypozyczalnia.dodajPojazd(samochod);
    } else if (pojazd.tagName == 'motorowka') {
      var rodzajPaliwa = int.parse(pojazd.findElements('rodzajPaliwa').single.text);
      var motorowka = Motorowka(nazwa, rodzajPaliwa);
      wypozyczalnia.dodajPojazd(motorowka);
    } else if (pojazd.tagName == 'rower') {
      var rower = Rower(nazwa);
      wypozyczalnia.dodajPojazd(rower);
    } else if (pojazd.tagName == 'hulajnoga') {
      var hulajnoga = Hulajnoga(nazwa);
      wypozyczalnia.dodajPojazd(hulajnoga);
    }
  });

  print(wypozyczalnia);
  
//   Samochod samochod1 = new Samochod("Renault", "Benzyna");
//   print(samochod1.id);
  
//   Samochod samochod2 = new Samochod("Toyota", "Diesel");
//   print(samochod2.id);
  
//   Samochod samochod3 = new Samochod("Volvo", "Diesel");
//   print(samochod3.id);
}

class Wypozyczalnia{
  List<Garaz> _garaze;
  List<Pojazd> _pojazdy = [];
  
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

// klasy abstrakcyjne

abstract class Pojazd{
  late int id;
  late String nazwaPojazdu;
  
  Pojazd(String nazwaPojazdu){
    this.nazwaPojazdu = nazwaPojazdu;
    
    int dlugosc = listaWszystkichPojazdow.length;
    
    if(dlugosc == 0){
      id = 0;
    }
    else{
     id = listaWszystkichPojazdow[dlugosc - 1].id + 1; 
    } 
    
    listaWszystkichPojazdow.add(this);
  }
}

class Samochod extends Pojazd implements Spalinowy, Parkowalny{
  
  late String _rodzajPaliwa;
  
  String get rodzajPaliwa => _rodzajPaliwa;
  set rodzajPaliwa(String value) => _rodzajPaliwa = value;
  
  late Garaz aktualnyGaraz;
  int iloscPaliwa = 0;
  
  Samochod(String nazwaPojazdu, rodzajPaliwa)
    :super(nazwaPojazdu);
  
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
  
  void zaparkujPojazd(Garaz wybranyGaraz){
    if(aktualnyGaraz.czyPusty){
      aktualnyGaraz = wybranyGaraz;
      wybranyGaraz.aktualnyPojazd = this;
      print("Pojazd został zaparkowany");
    }
    print("Pojazd nie został zaparkowany, garaż nie jest pusty");
  }
  
  void wyparkujPojazd(){
    print("Samochod został wyparkowany");
  }
  
}

class Motorowka extends Pojazd implements Spalinowy{
  
  late String rodzajPaliwa;
  int iloscPaliwa = 0;
  
  Motorowka(String nazwaPojazdu, rodzajPaliwa)
    :super(nazwaPojazdu);
  
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

class Rower extends Pojazd implements Parkowalny{
  late Garaz aktualnyGaraz;
  
  Rower(String nazwaPojazdu, this.aktualnyGaraz)
    :super(nazwaPojazdu);
  
  void zaparkujPojazd(Garaz wybranyGaraz){
    if(aktualnyGaraz.czyPusty){
      aktualnyGaraz = wybranyGaraz;
      wybranyGaraz.aktualnyPojazd = this;
      print("Pojazd został zaparkowany");
    }
    print("Pojazd nie został zaparkowany, garaż nie jest pusty");
  }
  
  void wyparkujPojazd(){
    print("Samochod został wyparkowany");
  }
}

class Hulajnoga extends Pojazd{
  Hulajnoga(String nazwaPojazdu)
    :super(nazwaPojazdu);
}

// interfejsy

abstract class Spalinowy{
  String get rodzajPaliwa;
  set rodzajPaliwa(String value);
  
  void tankowanie(int litry, String rodzajPaliwa);
  
  void jakiePaliwo();
}

abstract class Parkowalny{
  void zaparkujPojazd(Garaz wybranyGaraz);
  
  void wyparkujPojazd();
}