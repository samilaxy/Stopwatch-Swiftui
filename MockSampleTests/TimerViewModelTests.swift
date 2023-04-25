    //
    //  TimerViewModelTests.swift
    //  MockSampleTests
    //
    //  Created by Noye Samuel on 25/04/2023.
    //



import XCTest
import Combine
@testable import MockSample

class TimerViewModelTests: XCTestCase {
    
    var viewModel: TimerViewModel!
    var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        viewModel = TimerViewModel()
    }
    
    override func tearDown() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
    
    func testControlTimer_Start() {
            // Given the timer is not running
        XCTAssertFalse(viewModel.isRunning)
        
            // When the timer is started
        viewModel.controlTimer()
        
            // Then the timer should be running
        XCTAssertTrue(viewModel.isRunning)
        
            // Wait for 0.2 seconds to allow the timer to update
        let expectation = XCTestExpectation(description: "Timer updates")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
        
            // The seconds elapsed should be greater than 0.0
        XCTAssertGreaterThan(viewModel.secondsElapsed, 0.0)
    }
    
    func testControlTimer_Stop() {
            // Given the timer is running
        viewModel.isRunning = true
        
            // When the timer is stopped
        viewModel.controlTimer()
        
            // Then the timer should not be running
        XCTAssertFalse(viewModel.isRunning)
        
            // The seconds elapsed should be set to 0.0
        XCTAssertEqual(viewModel.secondsElapsed, 0.0)
    }
    
    func testFormattedTime() {
            // Given the seconds elapsed is 123.456
        viewModel.secondsElapsed = 123.456
        
            // Then the formatted time should be "02:03:45"
        XCTAssertEqual(viewModel.formattedTime, "02:03:45")
    }
    
}
