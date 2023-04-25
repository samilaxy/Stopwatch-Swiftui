//
//  StopwatchView.swift
//  MockSample
//
//  Created by Noye Samuel on 25/04/2023.
//

import SwiftUI
import Combine

struct StopwatchView: View {
    @State private var secondsElapsed = 0.1
    @State private var isRunning = false
    @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text(String(format: "%.1f", secondsElapsed))
                .font(.largeTitle)
                .padding()
                .onReceive(timer) { _ in
                    self.secondsElapsed += 0.1
                }
            
            if isRunning {
                Button(action: stop) {
                    Text("Stop")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(10)
                }
            } else {
                Button(action: start) {
                    Text("Start")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(10)
                }.onReceive(timer) { _ in
                    if isRunning {
                        secondsElapsed += 0.1
                    }
                }
            }
        }
    }
    
    func start() {
        isRunning = true
        timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
        
        print(isRunning)
    }
    
    func stop() {
        isRunning = false
        timer.upstream.connect().cancel()
        self.secondsElapsed = 0.0
    }
    private func onReceiveTimer(_ time: Publishers.Autoconnect<Timer.TimerPublisher>) {
        self.secondsElapsed += 0.1
    }
 
}


struct StopwatchView_Previews: PreviewProvider {
    static var previews: some View {
        StopwatchView()
    }
}
