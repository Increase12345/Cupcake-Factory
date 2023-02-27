//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Nick Pavlov on 2/24/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var order = Order()
    @State private var cakeOpacity = false
    @State private var disableButton = true
    
    var body: some View {
        NavigationStack {
            VStack {
                
                TextModel(text: "Welcome\nTo Cupcake Factory")
                    .padding()
                    .background(.thinMaterial)
                    .cornerRadius(10)
                   
                
                Spacer()
                
                VStack {
                    Text("Choose your cake")
                    HStack {
                        ForEach(0..<4) { number in
                            Button(action: {
                                withAnimation {
                                    tappedCake(number)
                                    disableButton.toggle()
                                }
                            }, label: {
                                VStack {
                                    Image(Order.images[number])
                                        .resizable()
                                        .scaledToFit()
                                        .opacity(cakeOpacity && order.type != number ? 0.25: 1)
                                        .cornerRadius(10)
                                    Text(Order.types[number])
                                        .font(.caption)
                                        .foregroundColor(.black)
                                }
                            })
                        }
                    }
                    
                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 1...20)
                        .padding(.top, 30)
                    
                    Toggle("Any special requests?", isOn: $order.specialRequestEnabled.animation())
                        .padding(.top)
                    
                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                    }
                }
                .padding()
                .background(.thinMaterial)
                .cornerRadius(10)
                
                Spacer()
                
                NavigationLink {
                    AdressView(order: order)
                } label: {
                    Text("Delivery details")
                        .padding()
                        .background(disableButton ? .gray: .green)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }
                .disabled(disableButton)
            }
            .background(Image("background"))
            .shadow(radius: 7)
            .padding()
        }
    }
    
    func tappedCake(_ number: Int) {
        order.type = number
        cakeOpacity.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
