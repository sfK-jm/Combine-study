import SwiftUI
import Combine
import PlaygroundSupport

class ViewModel {
    var subject = CurrentValueSubject<Int, Never>(0)
}

struct ContentView: View {
    var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Text("Count: \(viewModel.subject.value)")
            Button("1 증가 버튼") {
                viewModel.subject.send(viewModel.subject.value + 1)
                print(viewModel.subject.value)
            }
        }
    }
}

PlaygroundPage.current.setLiveView(ContentView())
