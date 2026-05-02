# Appetize.io Kurulum Rehberi - Mental Concierge Bodrum

Bu rehber, iOS uygulamanızı tarayıcı üzerinden canlı olarak önizleyebilmeniz için gerekli olan Appetize.io entegrasyonunu nasıl tamamlayacağınızı adım adım açıklamaktadır.

## 1. Simülatör Build'i Oluşturma
Appetize.io gerçek bir iPhone cihazı değil, bir simülatör kullanır. Bu nedenle uygulamanızı "Simulator" hedefiyle derlemeniz gerekir. Bir Mac bilgisayarda terminali açın ve proje kök dizininde şu komutu çalıştırın:

```bash
xcodebuild -scheme MentalConcierge -target MentalConcierge -configuration Debug -sdk iphonesimulator -derivedDataPath build
```

## 2. Uygulamayı Paketleme (Zip)
Derleme işlemi bittiğinde, oluşan `.app` dosyasını bulup zip formatına getirmeniz gerekir:

```bash
cd build/Build/Products/Debug-iphonesimulator
zip -r MentalConcierge.zip MentalConcierge.app
```

## 3. Appetize.io'ya Yükleme
1. [Appetize.io/upload](https://appetize.io/upload) adresine gidin.
2. Oluşturduğunuz `MentalConcierge.zip` dosyasını yükleyin.
3. Yükleme bittiğinde size bir **Public Key** verilecek (Örn: `86m729...`). Bu anahtarı kopyalayın.

## 4. Kodu Güncelleme
Web projenizdeki `src/App.jsx` dosyasını açın ve `publicKey="demo"` kısmını kendi anahtarınızla değiştirin:

```jsx
// src/App.jsx içinde ilgili satırı bulun:
{demoMode === 'native' ? (
  <AppetizeEmulator publicKey="KOPYALADIGINIZ_ANAHTAR" />
) : (
  ...
)}
```

## 5. Test Etme
1. Web uygulamasını çalıştırın (`npm run dev`).
2. "Explore Interactive Demo" butonuna basın.
3. Ekranın altındaki panelden **Native Preview** seçeneğini seçin.
4. "Tap to Start" diyerek gerçek iOS uygulamanızı tarayıcıda deneyimleyin.

---
## 🪟 Windows Kullanıcıları İçin: GitHub Actions ile Build Alma

Windows kullandığınız için yerel olarak iOS build'i alamazsınız. Bunun yerine GitHub Actions kullanarak ücretsiz bir şekilde bulut üzerinde build alabilir ve oluşan dosyayı Appetize'a yükleyebilirsiniz.

### 1. GitHub Actions Workflow Dosyası Oluşturun
Projenizin kök dizininde `.github/workflows/build-ios.yml` adında bir dosya oluşturun ve içine şu kodları yapıştırın:

```yaml
name: Build iOS for Appetize
on: [push, workflow_dispatch]

jobs:
  build:
    runs-on: macos-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Build for Simulator
        run: |
          xcodebuild -scheme MentalConcierge \
            -target MentalConcierge \
            -configuration Debug \
            -sdk iphonesimulator \
            -derivedDataPath build

      - name: Zip App Bundle
        run: |
          cd build/Build/Products/Debug-iphonesimulator
          zip -r MentalConcierge.zip MentalConcierge.app

      - name: Upload Artifact
        uses: actions/upload-artifact@v4
        with:
          name: ios-sim-build
          path: build/Build/Products/Debug-iphonesimulator/MentalConcierge.zip
```

### 2. GitHub'a Push Edin
Bu dosyayı oluşturup GitHub'a push ettiğinizde, GitHub otomatik olarak bir Mac sunucusu üzerinde uygulamanızı derlemeye başlayacaktır.

### 3. Build Dosyasını İndirin
1. GitHub deponuzda **Actions** sekmesine gidin.
2. Son başarılı "Build iOS for Appetize" işlemini seçin.
3. Sayfanın altındaki **Artifacts** kısmından `ios-sim-build` dosyasını indirin.
4. İnen zip dosyasının içindeki `MentalConcierge.zip` dosyasını [Appetize.io/upload](https://appetize.io/upload) adresine yükleyin.

### 💡 Alternatif: Codemagic
Eğer GitHub Actions karmaşık gelirse, [Codemagic.io](https://codemagic.io) adresine ücretsiz üye olup GitHub deponuzu bağlayarak "Simulator Build" seçeneğiyle tek tuşla build alabilirsiniz.
