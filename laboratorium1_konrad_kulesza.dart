void main() {
  Zarowka zarowka1 = Zarowka();
  Lampka lampka1 = Lampka(zarowka1);
  
  lampka1.wlaczenieLampki();
  lampka1.rozjasnijLampke();
  lampka1.sciemnijLampke();
  lampka1.wylaczenieLampki();
  lampka1.wlaczenieLampki();
  lampka1.sciemnijLampke();
  lampka1.wlaczenieLampki();
  lampka1.rozjasnijLampke();
  lampka1.rozjasnijLampke();
  lampka1.rozjasnijLampke();
  lampka1.rozjasnijLampke();
  lampka1.rozjasnijLampke();
  lampka1.rozjasnijLampke();
  lampka1.rozjasnijLampke();
  lampka1.rozjasnijLampke();
  lampka1.rozjasnijLampke();
  lampka1.rozjasnijLampke();
  lampka1.rozjasnijLampke();
  lampka1.wlaczenieLampki();
  
  Zarowka zarowka2 = Zarowka();
  
  lampka1.wymienZarowke(zarowka2);
  lampka1.wlaczenieLampki();
  lampka1.rozjasnijLampke();
}

class Zarowka {
  bool swieci = false;
  bool spalona = false;
  
  Zarowka(){
    print("Utworzono nową żarówkę");
  }
}

class Lampka {
  late Zarowka aktualnaZarowka;
  int jasnosc = 1;
  
  Lampka(this.aktualnaZarowka){
    print("Utworzono nową lampkę");
  }
  
  void wlaczenieLampki(){
    if(!aktualnaZarowka.spalona){
      aktualnaZarowka.swieci = true;
      print("Lampka została włączona");
    }
    else{
      print("Żarówka jest spalona, nie można włączyć");
    }
  }
  
  void wylaczenieLampki(){
    if(aktualnaZarowka.swieci){
      aktualnaZarowka.swieci = false;
      print("Lampka została wyłączona");
    }
    else{
      print("Lampka już jest zgaszona");
    }
  }
  
  void rozjasnijLampke(){
    if(aktualnaZarowka.swieci){
      if(jasnosc < 10){
        jasnosc++;
        print("Jasnosc zwiekszona do $jasnosc");
      }
      else{
        jasnosc = 0;
        aktualnaZarowka.swieci = false;
        aktualnaZarowka.spalona = true;
        print("Za duża jasność, zarowka spaliła się");
      }
    }
    else{
      print("Lampka musi być włączona żeby zwiększyć jasność");
    }
  }
  
  void sciemnijLampke(){
    if(aktualnaZarowka.swieci){
      if(jasnosc > 1){
        jasnosc--;
        print("Jasnosc zmiejszona do $jasnosc");
      }
      else{
        jasnosc = 0;
        aktualnaZarowka.swieci = false;
        print("Za mała jasność, lampka zgasła");
      }
    }
    else{
      print("Lampka musi być włączona żeby zminiejszyć jasność");
    }
  }
  
  void wymienZarowke(Zarowka zarowkaNaWymiane){
    if(aktualnaZarowka.spalona){
      aktualnaZarowka = zarowkaNaWymiane;
      print("Żarówka została wymieniona");
    }
    else{
      print("Nie można wymienić dobrej żarówki");
    }
  }
}
