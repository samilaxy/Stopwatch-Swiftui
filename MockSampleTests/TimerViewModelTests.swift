    //
    //  TimerViewModelTests.swift
    //  MockSampleTests
    //
    //  Created by Noye Samuel on 25/04/2023.
    //



import XCTest
@testable import MockSample

class TimeViewModelTests: XCTestCase {
    
    var viewModel: TimerViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = TimerViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testFormattedTime() {
            // Test initial formatted time
        XCTAssertEqual(viewModel.formattedTime, "00:00:00")
        
            // Test formatted time after 1 second
        viewModel.secondsElapsed = 1.0
        XCTAssertEqual(viewModel.formattedTime, "00:00:10")
        
            // Test formatted time after 1 minute
        viewModel.secondsElapsed = 60.0
        XCTAssertEqual(viewModel.formattedTime, "01:00:00")
        
            // Test formatted time after 1 hour
        viewModel.secondsElapsed = 3600.0
        XCTAssertEqual(viewModel.formattedTime, "60:00:00")
    }
    
    func testControlTimer() {
            // Test starting the timer
        viewModel.controlTimer()
        XCTAssertTrue(viewModel.isRunning)
        
            // Wait for 1 second to ensure timer has started
        let expectation = self.expectation(description: "Wait for timer to start")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.5)
        
            // Test stopping the timer
        viewModel.controlTimer()
        XCTAssertFalse(viewModel.isRunning)
        XCTAssertEqual(viewModel.secondsElapsed, 0.0)
    }
    
}
