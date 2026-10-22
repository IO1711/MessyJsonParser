import SwiftUI
import Playgrounds

struct ContentView: View {
    
    @State var allEvents: AllEvents?
    
    var body: some View {
        NavigationStack{
            ScrollView {
                ForEach(allEvents?.events ?? [], id: \.?.identifier) { event in
                    EventCardView(event: event)
                }
            }
            .navigationTitle("Events")
            .onAppear{
                allEvents = readJSON("events_wrapped")
            }
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
