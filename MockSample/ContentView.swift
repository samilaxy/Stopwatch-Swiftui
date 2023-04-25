    //
    //  ContentView.swift
    //  MockSample
    //
    //  Created by Noye Samuel on 25/04/2023.
    //

import SwiftUI
import Combine

struct ContentView: View {
    
    @ObservedObject var viewModel = TimerViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                
                Spacer()
                ZStack {
                    Circle()
                        .stroke(lineWidth: 10.0)
                        .opacity(0.3)
                        .foregroundColor(.gray)
                    
                        // not part of requiredment, kept it here for reference
                    Circle()
                        .trim(from: 0.0, to: CGFloat(viewModel.secondsElapsed / viewModel.totalTime))
                        .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                        .foregroundColor(.green)
                        .rotationEffect(Angle(degrees: -90))
                    
                    Text(viewModel.formattedTime)
                        .font(.largeTitle)
                        .padding()
                }
                
                Spacer()
                Button(action: viewModel.controlTimer) {
                    Text(viewModel.isRunning ? "Stop" : "Start")
                        .padding()
                        .foregroundColor(.white)
                        .background(viewModel.isRunning ? Color.red : Color.green)
                        .cornerRadius(10)
                }
                .padding(16)
                .navigationBarTitle("Stopwatch", displayMode: .inline)
            }
            .padding(60)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
