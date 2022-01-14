//
//  CarCustomiserTests.swift
//  CarCustomiserTests
//
//  Created by Wreford, Barnaby (PGW) on 14/01/2022.
//

import XCTest

class CarCustomiserTests: XCTestCase {

    func testNewCarGivesMeACarWithAllAttributesSet() {
        //arrange
        //act
        let car = Car(make: "Mazda", model: "MX-5", topSpeed:125, acceleration: 7.7, handling: 5)
        
        //assert
        XCTAssertEqual(car.make, "Mazda")
        XCTAssertEqual(car.model, "MX-5")
        XCTAssertEqual(car.topSpeed, 125)
        XCTAssertEqual(car.acceleration, 7.7)
        XCTAssertEqual(car.handling, 5)

        XCTAssertEqual(car.displayStats(), "Make: Mazda\nModel: MX-5\nTop Speed: 125mph\nAcceleration: (0-60): 7.7s\nHandling: 5")
    }

}
