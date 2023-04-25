    //
    //  TimerViewModel.swift
    //  MockSample
    //
    //  Created by Noye Samuel on 25/04/2023.
    //

import Foundation


class TimeViewModel: ObservableObject {
    
    @Published var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @Published var isRunning: Bool = false
    @Published var secondsElapsed = 0.0
    @Published var totalTime = 1000.0
    
        // format timer to show mm:ss:cc.
    var formattedTime: String {
        let centiseconds = Int((secondsElapsed * 100).truncatingRemainder(dividingBy: 100))
        let seconds = Int(secondsElapsed) % 60
        let minutes = Int(secondsElapsed / 60)
        return String(format: "%02d:%02d:%02d", minutes, seconds, centiseconds)
    }
    
    func controlTimer() {
            // switch between start ans stop
        isRunning.toggle()
        
        if isRunning {
                // start timer
            timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
        } else {
                // stop timer and set to defualt
            timer.upstream.connect().cancel()
            secondsElapsed = 0.0
        }
    }
}
