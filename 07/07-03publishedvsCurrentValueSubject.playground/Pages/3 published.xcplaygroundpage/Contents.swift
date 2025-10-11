import SwiftUI
import Combine
import PlaygroundSupport

class ViewModel: ObservableObject {
    @Published var value = 0
}

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Text("Count: \(viewModel.value)")
            Button("1 증가 버튼") {
                viewModel.value += 1
            }
        }
    }
}

PlaygroundPage.current.setLiveView(ContentView())
