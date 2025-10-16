import SwiftUI
import Combine

// https://picsum.photos/id/100/300/300

var uiImage: UIImage?

func getImgae(url: URL) -> AnyPublisher<UIImage?, Never> {
    URLSession.shared
        .dataTaskPublisher(for: url)
        .map { data, _ in UIImage(data: data)}
        .replaceError(with: nil)
        .eraseToAnyPublisher()
}

let subscription = Timer.publish(every: 3, on: .main, in: .common)
    .autoconnect()
    .map { _ in
        let randomId = Int.random(in: 1...100)
        return URL(string: "https://picsum.photos/id/\(randomId)/300/300")!
    }
    .flatMap { url in
        return getImgae(url: url)
    }
    .sink { image in
        uiImage = image
    }
