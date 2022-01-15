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
    private var exhaustPackageDisabled: Bool {
        get { return !exhaustPackage && money < 300}
    }
    @State private var tiresPackage = false
    private var tiresPackageDisabled: Bool {
        get { return !tiresPackage && money < 400}
    }
    @State private var nitrusPackage = false
    private var nitrusPackageDisabled: Bool {
        get { return !nitrusPackage && money < 500}
    }
    @State private var paintJob = false
    private var paintJobDisabled: Bool {
        get { return !paintJob && money < 1000}
    }
    
    @State private var money = 1000
    
    var body: some View {
        
        let exhaustPackageBinding = Binding<Bool> (
            get: {self.exhaustPackage},
            set: {newValue in
                if newValue == true {
                    starterCars.cars[selectedCar].topSpeed += 5
                    money -= 300
                }
                else if self.exhaustPackage == true {
                    starterCars.cars[selectedCar].topSpeed -= 5
                    money += 300
                }
                self.exhaustPackage = newValue
            }
        )
        
        let tiresPackageBinding = Binding<Bool> (
            get: {self.tiresPackage},
            set: {newValue in
                if newValue == true {
                    starterCars.cars[selectedCar].handling += 2
                    money -= 400
                }
                else if self.tiresPackage == true{
                    starterCars.cars[selectedCar].handling -= 2
                    money += 400
                }
                self.tiresPackage = newValue
            }
        )
        
        let nitrusPackageBinding = Binding<Bool> (
            get: {self.nitrusPackage},
            set: {newValue in
                if newValue == true {
                    starterCars.cars[selectedCar].acceleration -= 0.2
                    money -= 500
                }
                else if self.nitrusPackage == true{
                    starterCars.cars[selectedCar].acceleration += 0.2
                    money += 500
                }
                self.nitrusPackage = newValue
            }
        )
        
        let paintJobBinding = Binding<Bool> (
            get: {self.paintJob},
            set: {newValue in
                if newValue == true {
                    starterCars.cars[selectedCar].model = "swaggy " + starterCars.cars[selectedCar].model
                    money -= 1000
                }
                else if self.paintJob == true {
                    starterCars.cars[selectedCar].model = String(starterCars.cars[selectedCar].model.dropFirst(7))
                    money += 1000
                    
                }
                self.paintJob = newValue
            }
        )
        
        Form {
            Text("$\(money)")
            
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
                Toggle("Exhaust Package ($300)", isOn: exhaustPackageBinding).disabled(exhaustPackageDisabled)
                Toggle("Tires Package ($400)", isOn: tiresPackageBinding).disabled(tiresPackageDisabled)
                Toggle("Nitrus Package ($500)", isOn: nitrusPackageBinding).disabled(nitrusPackageDisabled)
                Toggle("Paint Job ($1000)", isOn: paintJobBinding).disabled(paintJobDisabled)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
