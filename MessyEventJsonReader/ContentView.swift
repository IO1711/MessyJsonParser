import SwiftUI
import Playgrounds

struct ContentView: View {
    
    @State var allEvents: AllEvents?
    
    var body: some View {
        
        ScrollView {
            ForEach(allEvents?.events ?? [], id: \.?.identifier) { event in
                EventCardView(event: event)
            }
        }
        .onAppear{
            allEvents = readJSON("events_wrapped")
        }
        
        /*Text("Hello, world!")
            .padding()
            .onAppear{
                allEvents = readJSON("events_wrapped")
                print(allEvents)
            }*/
    }
}

#Preview {
    ContentView()
}
