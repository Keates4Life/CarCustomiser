//
//  CarCustomiserUITests.swift
//  CarCustomiserUITests
//
//  Created by Wreford, Barnaby (PGW) on 14/01/2022.
//

import XCTest

class CarCustomiserUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWhenBoughtTiresAndExhaustPackageOtherTwoUpgradesAreDisabled() throws {
        // arrange
        let app = XCUIApplication()
        app.launch()

        //act
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.switches["Exhaust Package ($300)"]/*[[".cells[\"Exhaust Package ($300)\"].switches[\"Exhaust Package ($300)\"]",".switches[\"Exhaust Package ($300)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.switches["Tires Package ($400)"]/*[[".cells[\"Tires Package ($400)\"].switches[\"Tires Package ($400)\"]",".switches[\"Tires Package ($400)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        // assert
        XCTAssertEqual(tablesQuery/*@START_MENU_TOKEN@*/.switches["Nitrus Package ($500)"]/*[[".cells[\"Nitrus Package ($500)\"].switches[\"Nitrus Package ($500)\"]",".switches[\"Nitrus Package ($500)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.isEnabled, false)
        XCTAssertEqual(tablesQuery/*@START_MENU_TOKEN@*/.switches["Paint Job ($1000)"]/*[[".cells[\"Paint Job ($1000)\"].switches[\"Paint Job ($1000)\"]",".switches[\"Paint Job ($1000)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.isEnabled, false)
                
    }
    
    func testNextCarSwitchesOffToggles() throws {
        // arrange
        let app = XCUIApplication()
        app.launch()

        //act
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.switches["Exhaust Package ($300)"]/*[[".cells[\"Exhaust Package ($300)\"].switches[\"Exhaust Package ($300)\"]",".switches[\"Exhaust Package ($300)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.switches["Nitrus Package ($500)"]/*[[".cells[\"Nitrus Package ($500)\"].switches[\"Nitrus Package ($500)\"]",".switches[\"Nitrus Package ($500)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Next Car"]/*[[".cells[\"Make: Mazda\\nModel: MX-5\\nTop Speed: 125mph\\nAcceleration: (0-60): 7.5s\\nHandling: 5, Next Car\"].buttons[\"Next Car\"]",".buttons[\"Next Car\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        // assert
        XCTAssertEqual(tablesQuery.switches["Exhaust Package ($300)"].isSelected, false)
        XCTAssertEqual(tablesQuery/*@START_MENU_TOKEN@*/.switches["Nitrus Package ($500)"]/*[[".cells[\"Nitrus Package ($500)\"].switches[\"Nitrus Package ($500)\"]",".switches[\"Nitrus Package ($500)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.isSelected, false)
    }
    
    func testNextCarRemovesBonusStatsFromActiveToggles() throws {
        // arrange
        let app = XCUIApplication()
        app.launch()

        //act
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.switches["Exhaust Package ($300)"]/*[[".cells[\"Exhaust Package ($300)\"].switches[\"Exhaust Package ($300)\"]",".switches[\"Exhaust Package ($300)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.switches["Nitrus Package ($500)"]/*[[".cells[\"Nitrus Package ($500)\"].switches[\"Nitrus Package ($500)\"]",".switches[\"Nitrus Package ($500)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Next Car"]/*[[".cells[\"Make: Mazda\\nModel: MX-5\\nTop Speed: 125mph\\nAcceleration: (0-60): 7.5s\\nHandling: 5, Next Car\"].buttons[\"Next Car\"]",".buttons[\"Next Car\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Next Car"]/*[[".cells[\"Make: Mazda\\nModel: MX-5\\nTop Speed: 125mph\\nAcceleration: (0-60): 7.5s\\nHandling: 5, Next Car\"].buttons[\"Next Car\"]",".buttons[\"Next Car\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Next Car"]/*[[".cells[\"Make: Mazda\\nModel: MX-5\\nTop Speed: 125mph\\nAcceleration: (0-60): 7.5s\\nHandling: 5, Next Car\"].buttons[\"Next Car\"]",".buttons[\"Next Car\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Next Car"]/*[[".cells[\"Make: Mazda\\nModel: MX-5\\nTop Speed: 125mph\\nAcceleration: (0-60): 7.5s\\nHandling: 5, Next Car\"].buttons[\"Next Car\"]",".buttons[\"Next Car\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        // assert
        XCTAssertNotNil(app.staticTexts.index(ofAccessibilityElement: "Make: Mazda\nModel: MX-5\nTop Speed: 125mph\nAcceleration: (0-60): 7.7s\nHandling: 5"))
    }
    
    func testButtonsDisabledAfter30Seconds() throws {
        // arrange
        let app = XCUIApplication()
        app.launch()

        //act
        do { sleep(31) }
        
        // assert
        let tablesQuery = app.tables
        XCTAssertEqual(tablesQuery.switches["Exhaust Package ($300)"].isEnabled, false)
        XCTAssertEqual(tablesQuery/*@START_MENU_TOKEN@*/.switches["Nitrus Package ($500)"]/*[[".cells[\"Nitrus Package ($500)\"].switches[\"Nitrus Package ($500)\"]",".switches[\"Nitrus Package ($500)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.isEnabled, false)
        XCTAssertEqual(tablesQuery/*@START_MENU_TOKEN@*/.switches["Paint Job ($1000)"]/*[[".cells[\"Paint Job ($1000)\"].switches[\"Paint Job ($1000)\"]",".switches[\"Paint Job ($1000)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.isEnabled, false)
        XCTAssertEqual(tablesQuery.switches["Tires Package ($400)"].isEnabled, false)
        XCTAssertEqual(tablesQuery.buttons["Next Car"].isEnabled, false)
    }
    
    func testNextCarResetsMoney() throws {
        // arrange
        let app = XCUIApplication()
        app.launch()

        //act
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.switches["Exhaust Package ($300)"]/*[[".cells[\"Exhaust Package ($300)\"].switches[\"Exhaust Package ($300)\"]",".switches[\"Exhaust Package ($300)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.switches["Nitrus Package ($500)"]/*[[".cells[\"Nitrus Package ($500)\"].switches[\"Nitrus Package ($500)\"]",".switches[\"Nitrus Package ($500)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Next Car"]/*[[".cells[\"Make: Mazda\\nModel: MX-5\\nTop Speed: 125mph\\nAcceleration: (0-60): 7.5s\\nHandling: 5, Next Car\"].buttons[\"Next Car\"]",".buttons[\"Next Car\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        // assert
        XCTAssertNotNil(app.staticTexts.index(ofAccessibilityElement: "$1,000"))
    }
    
    func testBuyingUpgradesChangesMoney() throws {
        // arrange
        let app = XCUIApplication()
        app.launch()

        //act
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.switches["Exhaust Package ($300)"]/*[[".cells[\"Exhaust Package ($300)\"].switches[\"Exhaust Package ($300)\"]",".switches[\"Exhaust Package ($300)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.switches["Nitrus Package ($500)"]/*[[".cells[\"Nitrus Package ($500)\"].switches[\"Nitrus Package ($500)\"]",".switches[\"Nitrus Package ($500)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        // assert
        XCTAssertNotNil(app.staticTexts.index(ofAccessibilityElement: "$200"))
    }
    
    func testSellingUpgradesResetsUpgrades() throws {
        // arrange
        let app = XCUIApplication()
        app.launch()

        //act
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.switches["Exhaust Package ($300)"]/*[[".cells[\"Exhaust Package ($300)\"].switches[\"Exhaust Package ($300)\"]",".switches[\"Exhaust Package ($300)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.switches["Nitrus Package ($500)"]/*[[".cells[\"Nitrus Package ($500)\"].switches[\"Nitrus Package ($500)\"]",".switches[\"Nitrus Package ($500)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.switches["Exhaust Package ($300)"]/*[[".cells[\"Exhaust Package ($300)\"].switches[\"Exhaust Package ($300)\"]",".switches[\"Exhaust Package ($300)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        // assert
        XCTAssertNotNil(app.staticTexts.index(ofAccessibilityElement: "$500"))
        XCTAssertNotNil(app.staticTexts.index(ofAccessibilityElement: "Make: Mazda\nModel: MX-5\nTop Speed: 125mph\nAcceleration: (0-60): 7.5s\nHandling: 5"))
    }

    

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
