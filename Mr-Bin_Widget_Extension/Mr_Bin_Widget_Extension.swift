//
//  Mr_Bin_Widget_Extension.swift
//  Mr-Bin_Widget_Extension
//
//  Created by Mugurel Moscaliuc on 25/06/2022.
//

import WidgetKit
import SwiftUI
import Intents


struct SlotsEntry: TimelineEntry {
    let date: Date
    let items: [Item]
}

struct Provider: IntentTimelineProvider {
    
    typealias Entry = SlotsEntry
    
    func placeholder(in context: Context) -> SlotsEntry {
        SlotsEntry(date: Date(), items: [])
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SlotsEntry) -> ()) {
        let entry = SlotsEntry(date: Date(), items: [])
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        WidgetCenter.shared.reloadAllTimelines()
        let currentDate = Date()
        let refreshDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
        Task {
            let start = String(Date().timeIntervalSince1970).components(separatedBy: ".").first
            let end = String(Date().addingTimeInterval(604800).timeIntervalSince1970).components(separatedBy: ".").first
            let slots = try await APIService.getData(start!, end!)
            let entry = SlotsEntry(date: Date(), items: slots)
            let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
            completion(timeline)
        }
    }
}

struct Mr_Bin_Widget_ExtensionEntryView : View {
    
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family: WidgetFamily
    
    var gradient: Gradient {
        Gradient(stops:
                    [Gradient.Stop(color: Color("Container"), location: 0),
                     Gradient.Stop(color: Color.gray.opacity(0.60),
                                   location: 0.8)])
    }
    

    var body: some View {
        switch family {
        case .systemSmall:
            SmallWidgetView(items: entry.items, gradient: gradient)
        case .systemMedium:
            MediumWidgetView(items: entry.items, gradient: gradient)
        case .systemLarge:
            MediumWidgetView(items: entry.items, gradient: gradient)
        case .systemExtraLarge:
            MediumWidgetView(items: entry.items, gradient: gradient)
        @unknown default:
            Text("")
        }
    }
}

@main
struct Mr_Bin_Widget_Extension: Widget {
    let kind: String = "Mr_Bin_Widget_Extension"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            Mr_Bin_Widget_ExtensionEntryView(entry: entry)
        }
        .configurationDisplayName("Collection day")
        .description("Bins collection days.")
    }
}
