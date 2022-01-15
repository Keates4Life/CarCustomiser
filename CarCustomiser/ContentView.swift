//
//  ContentView.swift
//  CarCustomiser
//
//  Created on 14/01/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var starterCars = StarterCars()
    @State private var selectedCar:Int = 0
    @State private var exhaustPackage = false
    @State private var tiresPackage = false
    @State private var nitrusPackage = false
    @State private var paintJob = false
    
    var body: some View {
        
        let exhaustPackageBinding = Binding<Bool> (
            get: {self.exhaustPackage},
            set: {newValue in
                if newValue == true {
                    starterCars.cars[selectedCar].topSpeed += 5
                }
                else if self.exhaustPackage == true {
                    starterCars.cars[selectedCar].topSpeed -= 5
                }
                self.exhaustPackage = newValue
            }
        )
        
        let tiresPackageBinding = Binding<Bool> (
            get: {self.tiresPackage},
            set: {newValue in
                if newValue == true {
                    starterCars.cars[selectedCar].handling += 2
                }
                else if self.tiresPackage == true{
                    starterCars.cars[selectedCar].handling -= 2
                }
                self.tiresPackage = newValue
            }
        )
        
        let nitrusPackageBinding = Binding<Bool> (
            get: {self.nitrusPackage},
            set: {newValue in
                if newValue == true {
                    starterCars.cars[selectedCar].acceleration -= 0.2
                }
                else if self.nitrusPackage == true{
                    starterCars.cars[selectedCar].acceleration += 0.2
                }
                self.nitrusPackage = newValue
            }
        )
        
        let paintJobBinding = Binding<Bool> (
            get: {self.paintJob},
            set: {newValue in
                if newValue == true {
                    starterCars.cars[selectedCar].model = "swaggy " + starterCars.cars[selectedCar].model
                }
                else if self.paintJob == true {
                    starterCars.cars[selectedCar].model = String(starterCars.cars[selectedCar].model.dropFirst(7))
                    
                }
                self.paintJob = newValue
            }
        )
        
        Form {
            VStack (alignment: .leading, spacing: 20){
                Text("\(starterCars.cars[selectedCar].displayStats())")
                    .padding()
                Button("Next Car", action: {
                    exhaustPackageBinding.wrappedValue = false
                    tiresPackageBinding.wrappedValue = false
                    nitrusPackageBinding.wrappedValue = false
                    paintJobBinding.wrappedValue = false
                        selectedCar = (selectedCar + 1) % starterCars.cars.count
                    })
            }
            Section {
                Toggle("Exhaust Package", isOn: exhaustPackageBinding)
                Toggle("Tires Package", isOn: tiresPackageBinding)
                Toggle("Nitrus Package", isOn: nitrusPackageBinding)
                Toggle("Paint Job", isOn: paintJobBinding)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
