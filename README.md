# Ara’s Fiverr portfolio

Three fictional small-business landing pages and one native iOS prototype, built as portfolio concepts.

| Project | Folder | Private preview |
| --- | --- | --- |
| BrightNest Cleaning | `sites/brightnest` | https://brightnest-cleaning-ara.hossain1993.chatgpt.site |
| Steel & Oak Barbershop | `sites/steel-oak` | https://steel-oak-ara.hossain1993.chatgpt.site |
| Sunday Crumb Bakery | `sites/sunday-crumb` | https://sunday-crumb-ara.hossain1993.chatgpt.site |

## Native iOS portfolio

**Driftwell** is a fictional SwiftUI wellness-booking prototype in `ios/Driftwell`. It includes a complete user journey from service discovery through specialist and time selection, review, demo confirmation, and the Bookings tab. All content is local sample data; the app sends, stores, books, and charges nothing.

Open `ios/Driftwell/Driftwell.xcodeproj` in Xcode, or build from the command line:

```sh
xcodebuild -project ios/Driftwell/Driftwell.xcodeproj \
  -scheme Driftwell \
  -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' \
  CODE_SIGNING_ALLOWED=NO build
```

Fiverr-ready gallery assets are in `outputs/driftwell-ios/gallery`. The complete second-gig copy and scope are in `fiverr/IOS-PROTOTYPE-GIG.md`.

## Development

Requires Node.js 22.13 or newer. Each site is an independent npm project using React and Vinext. Run commands inside the site folder:

```sh
cd sites/brightnest
npm ci
npm run dev
```

Production build: `npm run build`. Type check: `npx tsc --noEmit`.
For parallel previews, use `npm run dev -- --port 3001` and a different port per site.

## Codex Cloud setup

Select this repository and the `master` branch in the existing environment.
Use `bash scripts/cloud-setup.sh` as the setup script to install all three sites.
The environment must allow package installation during setup.
Read `HANDOFF.md` before continuing work.

GitHub stores the editable source. A GitHub push does not automatically update the deployed Sites previews. Publishing requires the authorized Sites tools and the existing project IDs in each `.openai/hosting.json`. Do not create replacement Sites. If those tools are unavailable in Cloud, commit changes here and publish from the desktop task.
