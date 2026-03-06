namespace my.bookshop;

entity Books {
  key ID     : Integer;
  title      : String(111);
  author     : String(111);
  stock      : Integer;
  price      : Decimal(9,2);
  currency   : String(3) default 'TRY';
  description: String(1000);
  criticality: Integer;    // 0=gri, 1=kırmızı, 2=sarı/turuncu, 3=yeşil
}
