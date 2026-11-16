# Mini Katalog

Flutter ile hazırlanmış basit bir ürün katalog uygulaması. Ürünler yerel bir JSON dosyasından (`assets/products.json`) okunur; kullanıcı ürünleri arayabilir, kategoriye göre süzebilir, ürün detayına bakabilir ve sepete ekleyebilir.

Projede yalnızca Flutter'ın kendi `material.dart` kütüphanesi kullanılmıştır, ek paket yoktur.

## Ekranlar

- **Ana sayfa:** başlık, arama kutusu, kampanya banner'ı ve öne çıkan ürünler
- **Ürün listesi:** `GridView.builder` ile ürün kartları (görsel, ad, fiyat), arama ve kategori filtresi
- **Ürün detayı:** görsel, ad, fiyat, açıklama ve "Sepete Ekle" butonu
- **Sepet:** ürün adedini artırma/azaltma, toplam tutar ve siparişi tamamlama (`setState` ile)

## Kullanılan yapılar

- Model sınıfı: `Product` (`fromJson` / `toJson`)
- `ListView.builder` ve `GridView.builder`
- `Navigator.pushNamed` / `Navigator.pop`
- Named routes ve route arguments (arama metni ve seçilen ürün ekranlar arasında argüman olarak taşınır)
- `Image.asset` ile yerel görseller
- Basit arama ve kategori filtreleme

## Klasör yapısı

```
lib/
  main.dart        Uygulama ve route tanımları
  models/          Product, CartItem
  screens/         Ana sayfa, ürün listesi, ürün detayı, sepet
  widgets/         Ürün kartı, banner, sepet butonu
  data/            JSON okuma servisi ve sepet
assets/
  products.json    Ürün verileri
  images/          Ürün görselleri
```

## Flutter sürümü

- Flutter 3.50.0 (stable kanal)
- Dart 3.14.0

Not: Bu Flutter sürümünde `package:flutter/material.dart` için "material_ui paketine geçin" uyarısı bulunuyor. Projede ek paket kullanılmaması istendiği için `material.dart` ile devam edildi ve bu uyarı `analysis_options.yaml` içinde kapatıldı.

## Ekran görüntüleri

`screenshots/` klasöründe: ana sayfa, ürün listesi, ürün detayı ve sepet.

## Çalıştırma

```bash
git clone <repo-adresi>
cd mini-katalog-flutter
flutter pub get
flutter run
```

Tarayıcıda çalıştırmak için: `flutter run -d chrome`
