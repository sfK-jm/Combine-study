# Stream 이란?

```swift
import Foundation
import Combine

let timerPublisher = Timer.publish(every: 1.0, on: .main, in: .common)
    .autoconnect()

let subscriber = timerPublisher
    .map { date in
        let formetter = DateFormatter()
        formetter.dateFormat = "HH:mm:ss:SS"
        return formetter.string(from: date)
    }
    .sink { date in
        print("date: \(date)")
    }
```
