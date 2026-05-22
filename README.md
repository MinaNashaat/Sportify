# Sportify

Sportify is a native iOS app for following live sports across **Football, Tennis, Basketball, and Cricket**. Browse leagues, drill into a league's fixtures and teams, view team rosters and recent results, and keep your favourite leagues one tap away — even when you're offline.

The app is powered by [AllSportsAPI](https://allsportsapi.com/) and is built with **UIKit + Storyboards**, **async/await networking**, and a clean **MVP + Clean Architecture** layering.

---

## Features

- **Onboarding flow** — a 3-page intro built on `UIPageViewController` with animated Lottie illustrations and a custom page indicator.
- **Home / Sports selector** — pick a sport (Football, Tennis, Basketball, Cricket) and see a live-score carousel of currently in-progress matches at the top.
- **Live matches** — horizontally paged cards showing kickoff time, status, both teams (with crests), live score, and a per-goal breakdown.
- **League list** — every league for the selected sport, with country and logo.
- **League details** — upcoming fixtures, recent results, and all teams competing in the league. Tap the heart to favourite a league.
- **Team details** — segmented control for **Upcoming events**, **Recent events**, and **Players** (with positions and jersey numbers).
- **Favourites** — leagues are persisted locally with **Core Data**. Swipe to delete; tap to open league details.
- **Offline awareness** — actions that require the network show a "No Internet Connection" alert instead of failing silently.
- **Pull-to-refresh** on the home feed.
- **Image caching** via Kingfisher.

---

## Screens

| Module | Purpose |
| --- | --- |
| `onBoarding/` | First-run intro (3 pages + Lottie). |
| `home/` | Sport type grid + live scores carousel, tab bar root. |
| `league list/` | All leagues for the selected sport. |
| `leagueDetails/` | Fixtures, results, and teams for a league; favourite toggle. |
| `teamDetails/` | Upcoming / Recent events and Players for a team. |
| `favourites/` | Locally saved leagues (Core Data); empty-state view when none. |

---

## Architecture

Sportify follows a **Clean Architecture** split with an **MVP** presentation layer.

```
Sportify/
├── Core/
│   ├── Network/         # APIService, Endpoint protocol, SportifyEndpoints
│   ├── local/           # CacheService backed by Core Data
│   ├── navigation/      # AppRouter — centralized navigation & DI wiring
│   └── utils/           # NetworkManager (reachability), DateHelper, SportType
├── data/
│   ├── Dto/             # Decodable DTOs + MappingHelpers (DTO → domain model)
│   ├── datasource/
│   │   ├── remote/      # Calls APIService with SportifyEndpoints
│   │   └── local/       # Calls CacheService for favourites
│   ├── entity/          # FavouriteLeague (Core Data-backed entity)
│   └── repository/      # *RepositoryImpl — coordinates remote + local
├── domain/
│   ├── Model/           # League, Team, Player, LiveMatch, MatchEvent, …
│   └── repository/      # Repository protocols consumed by presenters
├── presentation/
│   └── <feature>/
│       ├── view/        # UIViewController + xibs + custom cells
│       └── presenter/   # *Presenter protocol + *PresenterImpl
└── view/                # Shared cells/views (LiveResult cell, LoadingView)
```

**Key conventions**

- **Presenters** own state and orchestrate work. Views are passive (`HomeView`, `FavouritesView`, etc. are protocols implemented by the view controllers).
- **Repositories** are the only entry point presenters use to reach data. Implementations live in `data/repository/` and depend on the `*DataSource` protocols.
- **DTOs** in `data/Dto/` decode raw API JSON; `MappingHelpers.swift` converts them into the framework-agnostic domain models in `domain/Model/`.
- **AppRouter** is the single navigation seam — view controllers never instantiate or push other view controllers directly; they call `router.navigateTo…`. The router also constructs each module's dependency graph (data source → repository → presenter).
- **Networking** is async/await on top of Alamofire (`APIServiceImpl.request<T: Decodable>`), with `Endpoint` / `SportifyEndpoints` describing each request as a value.

---

## Tech Stack

- **Language**: Swift 5.0
- **UI**: UIKit, Storyboards, Auto Layout, `UICollectionViewCompositionalLayout`
- **Concurrency**: Swift `async` / `await` with `Task` and `MainActor`
- **Persistence**: Core Data (`Sportify.xcdatamodeld`, entity `FavouriteLeagues`)
- **iOS deployment target**: 15.2
- **Bundle identifier**: `Yotta-Codes.Sportify`

### Dependencies (Swift Package Manager)

| Package | Version | Used for |
| --- | --- | --- |
| [Alamofire](https://github.com/Alamofire/Alamofire) | 5.6.4 | HTTP requests + reachability |
| [Kingfisher](https://github.com/onevcat/Kingfisher) | 7.11.0 | Async image loading & caching |
| [Lottie](https://github.com/airbnb/lottie-spm) | 4.2.0 | Onboarding / loading animations |

### Data source

All sports data comes from **[AllSportsAPI](https://allsportsapi.com/)** (`https://apiv2.allsportsapi.com/`). The app currently consumes five endpoints:

| Endpoint | Method param | Notes |
| --- | --- | --- |
| Leagues | `met=Leagues` | All leagues for a sport. |
| Live score | `met=Livescore` | Live matches (`timezone=Africa/Cairo`). |
| Teams | `met=Teams` | Teams in a league. |
| League fixtures | `met=Fixtures` | Past + upcoming for a league. |
| Team fixtures | `met=Fixtures` | Past + upcoming for a team. |

---

## Getting Started

### Requirements

- macOS with **Xcode 14+**
- iOS Simulator or device running **iOS 15.2** or later
- An [AllSportsAPI](https://allsportsapi.com/) key

### Run

1. Clone the repo:
   ```sh
   git clone <repo-url>
   cd Sportify
   ```
2. Open the project:
   ```sh
   open Sportify.xcodeproj
   ```
3. Xcode will resolve Swift Package Manager dependencies (Alamofire, Kingfisher, Lottie) automatically.
4. Set your **AllSportsAPI key** in `Sportify/Core/Network/ApiServiceImpl.swift` (`apiKey`). For anything beyond local development, move this out of source and read it from a config file / environment / Keychain.
5. Select a simulator (iPhone, iOS 15.2+) and **Run** (`⌘R`).

### Tests

Test targets are scaffolded:

- `SportifyTests` — unit tests (XCTest)
- `SportifyUITests` — UI tests

Run them with `⌘U` in Xcode.

---

## Project Conventions

- **Adding a new feature** → create a `presentation/<feature>/` folder with `view/` and `presenter/` subfolders, define the `*View` and `*Presenter` protocols, and wire the module in `AppRouterImpl`.
- **Adding a new endpoint** → add a case to `SportifyEndpoints`, expose it on the `SportifyRemoteDataSource` protocol, then surface it through the relevant repository.
- **Adding a new persisted entity** → extend `Sportify.xcdatamodeld`, add a struct in `data/entity/`, and expose CRUD on `CacheService` + `SportifyLocalDataSource`.
- **Navigation always goes through `AppRouter`** — view controllers do not push other view controllers directly.
- **Don't block the main thread** — repository calls are `async` and presenters hop back to `MainActor` before touching the view.



