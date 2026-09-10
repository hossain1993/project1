# Driftwell iOS portfolio captures

The numbered PNG files are direct iPhone 17 Pro simulator captures used to verify and present the fictional Driftwell SwiftUI prototype. The `gallery` folder contains the three 1280×769 images prepared for Fiverr.

- `01-home.png`: home and service discovery
- `02-provider.png`: specialist selection
- `03-time.png`: date and time selection
- `04-review.png`: booking review
- `05-confirmation.png`: explicit demo confirmation
- `06-bookings.png`: in-session booking state

Rebuild the gallery images with:

```sh
python3 scripts/make-driftwell-gallery.py
```

The script requires Pillow. Codex Desktop’s bundled workspace Python includes it.
