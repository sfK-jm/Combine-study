import SwiftUI
import Combine
import PlaygroundSupport

struct ContentView: View {
    @State var value = 0
    
    var body: some View {
        VStack {
            Text("Count: \(value)")
            Button("1 증가 버튼") {
                value += 1
            }
        }
    }
}

PlaygroundPage.current.setLiveView(ContentView())
