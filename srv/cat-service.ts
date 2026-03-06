import cds from '@sap/cds';

export default class CatalogService extends cds.ApplicationService {

  override async init() {
    const { Books } = this.entities;

    // ===== READ sonrası: Criticality hesapla =====
    this.after('READ', Books, (results: any) => {
      const books = Array.isArray(results) ? results : [results];
      for (const book of books) {
        if (!book) continue;
        if (book.stock < 10)      book.criticality = 1;  // kırmızı
        else if (book.stock < 50) book.criticality = 2;  // turuncu
        else                      book.criticality = 3;  // yeşil
      }
    });

    // ===== CREATE öncesi: Validasyon =====
    this.before('CREATE', Books, (req: any) => {
      const { title, price, stock } = req.data;

      if (!title) return req.error(400, 'Kitap adı zorunludur!');
      if (price <= 0) return req.error(400, 'Fiyat sıfırdan büyük olmalıdır!');
      if (stock < 0) return req.error(400, 'Stok negatif olamaz!');
    });

    // ===== Custom Action: Stok güncelle =====
    this.on('addStock', async (req: any) => {
      const { id, amount } = req.data;
      const book = await SELECT.one.from(Books).where({ ID: id });

      if (!book) return req.error(404, `Kitap bulunamadı: ${id}`);

      await UPDATE(Books).set({
        stock: book.stock + amount
      }).where({ ID: id });

      return await SELECT.one.from(Books).where({ ID: id });
    });

    return super.init();
  }
}
