import UIKit
import Combine

let url = URL(string: "https://www.google.com")!

print("=== handleEvents ===")

let subscrition = URLSession.shared.dataTaskPublisher(for: url)
    .print("[handle events]")
    .handleEvents(receiveSubscription: { _ in
        print("handleEvents - subscription")
    }, receiveOutput: { _ in
        print("handleEvents - output")
    }, receiveCompletion: { _ in
        print("handleEvents - completion")
    }, receiveCancel: {
        print("handleEvents - cancel")
    }, receiveRequest: { _ in
        print("handleEvents - request")
    })
    .sink { completion in
        print(completion)
    } receiveValue: { (data: Data, response: URLResponse) in
        print("data count: \(data.count)")
    }
