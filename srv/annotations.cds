using CatalogService as service from './cat-service';

// ========== BOOKS — List Report (Tablo) ==========
annotate service.Books with @(

  // --- Tablo Sütunları ---
  UI.LineItem: [
    { Value: ID,     Label: 'ID'     },
    { Value: title,  Label: 'Kitap Adı' },
    { Value: author, Label: 'Yazar'  },
    { Value: stock,  Label: 'Stok',
      Criticality: criticality       },   // yeşil/sarı/kırmızı renklendirme
    { Value: price,  Label: 'Fiyat'  },
  ],

  // --- Üstteki Seçim Alanları (Filter Bar) ---
  UI.SelectionFields: [
    author,
    price,
  ],

  // --- Detay Sayfası (Object Page) Header ---
  UI.HeaderInfo: {
    TypeName      : 'Kitap',
    TypeNamePlural: 'Kitaplar',
    Title         : { Value: title  },
    Description   : { Value: author },
  },

  // --- Object Page İçerik ---
  UI.FieldGroup #General: {
    Label: 'Genel Bilgiler',
    Data : [
      { Value: title,  Label: 'Kitap Adı' },
      { Value: author, Label: 'Yazar'     },
    ]
  },

  UI.FieldGroup #Stock: {
    Label: 'Stok ve Fiyat',
    Data : [
      { Value: stock, Label: 'Stok Adedi' },
      { Value: price, Label: 'Fiyat'      },
    ]
  },

  // --- Object Page Facet (Sekme) Yapısı ---
  UI.Facets: [
    {
      $Type : 'UI.ReferenceFacet',
      Label : 'Genel Bilgiler',
      Target: '@UI.FieldGroup#General',
    },
    {
      $Type : 'UI.ReferenceFacet',
      Label : 'Stok ve Fiyat',
      Target: '@UI.FieldGroup#Stock',
    },
  ],
);
