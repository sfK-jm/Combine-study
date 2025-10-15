import SwiftUI
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let subject = CurrentValueSubject<Int, Never>(0)

let subscription = subject
    .throttle(for: .seconds(2), scheduler: DispatchQueue.main, latest: true)
    .sink { completion in
        print(completion)
    } receiveValue: { num in
        print(num)
    }

struct ContentView: View {
    var body: some View {
        Button("Publish") {
            let value = subject.value + 1
            subject.send(value)
            print("sent value: ", value)
        }
    }
}

PlaygroundPage.current.setLiveView(ContentView())
