# Messy Event JSON Reader

A small SwiftUI app for exploring how to decode inconsistent event data. It reads a bundled JSON export, turns the records it recognizes into Swift models, and displays them as event cards.

The sample data deliberately mixes missing fields, different value types, and extra metadata. The app is a work in progress, with the current behavior and gaps documented below.

## What it does

- Loads the `events` array from a bundled, wrapped JSON file when the app opens.
- Displays each decoded event's title, formatted start date, location, and duration in a scrollable card list.
- Accepts start dates as ISO 8601 strings, Unix timestamps, or numeric timestamp strings. Dates are displayed in the device's locale without a time.
- Accepts durations as strings or numbers, and locations as either a name string or an object with a name, room, and optional coordinates.
- Handles optional fields and ignores extra keys in the export.

The parsing is implemented with custom `Decodable` initializers in [`MessyEventJsonReader/models`](MessyEventJsonReader/models). The interface uses SwiftUI and local asset colors; there is no network service or third-party package to configure.

## Run it

1. Clone this repository and open [`MessyEventJsonReader.xcodeproj`](MessyEventJsonReader.xcodeproj) in Xcode.
2. Select the **MessyEventJsonReader** scheme and an iPhone simulator.
3. Build and run.

The project currently has an **iOS 27.0** deployment target, so use a compatible Xcode and simulator runtime. The app reads its sample data from the bundle; no account or API key is needed.

## Sample data

| File | Purpose |
| --- | --- |
| [`events_wrapped.json`](MessyEventJsonReader/events_wrapped.json) | The fixture the app currently loads. It has a top-level `events` array plus export metadata. |
| [`events_bare.json`](MessyEventJsonReader/events_bare.json) | A second fixture with a top-level array and additional malformed cases. The current reader does not load this format. |

To try another wrapped export, replace the contents of `events_wrapped.json`, or add a bundled JSON file and change the filename passed to `readJSON("events_wrapped")` in [`ContentView.swift`](MessyEventJsonReader/ContentView.swift). The reader expects this shape:

```json
{
  "events": [
    {
      "id": "w01",
      "title": "Opening Keynote",
      "start": "2024-06-10T09:00:00Z",
      "duration": 60,
      "location": "Main Hall"
    }
  ]
}
```

## Project layout

| Path | Role |
| --- | --- |
| [`ContentView.swift`](MessyEventJsonReader/ContentView.swift) | Loads the bundled fixture and renders the event list. |
| [`EventCardView.swift`](MessyEventJsonReader/EventCardView.swift) | Renders each event card. |
| [`JSONReader.swift`](MessyEventJsonReader/models/JSONReader.swift) | Loads JSON from the bundle and decodes the wrapped `events` array. |
| [`models/`](MessyEventJsonReader/models) | Defines the event, location, coordinate, and attendee models. |

## Current limitations

- The decoder expects a wrapped `events` array. It does not yet decode the bare-array fixture or map alternate field names such as `uid`, `name`, and `summary` to event IDs and titles.
- Duration values are converted to display strings, not interpreted as minutes or hours. The circular badge currently labels that value **days**; it is not a calculated countdown.
- Attendees are not shown in the interface, and decoding mixed attendee arrays is incomplete.
- Some malformed event entries, particularly arrays and booleans, are not safely handled by the current reader.

This repository is a compact starting point for improving tolerant JSON decoding and building a richer event view.
