//
//  AdressView.swift
//  CupcakeCorner
//
//  Created by Nick Pavlov on 2/24/23.
//

import SwiftUI

struct AdressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
      
        VStack {
            VStack(spacing: 20) {
                TextField("Name", text: $order.name)
                TextField("Street Adress", text: $order.streetAdress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
                Spacer()
                
                NavigationLink {
                    CheckOutView(order: order)
                } label: {
                    Text("Check out")
                        .frame(width: 150, height: 50)
                        .foregroundColor(.white)
                        .background(order.hasValidAdress ? .gray: .green)
                        .cornerRadius(10)
                }
                .disabled(order.hasValidAdress)
            }
            .multilineTextAlignment(.center)
            .textFieldStyle(.roundedBorder)
            .frame(maxWidth: 300, maxHeight: 300)
            .padding(30)
            .background(.thinMaterial)
            .cornerRadius(10)
            
        }
        .shadow(radius: 7)
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
        .background(Image("background"))
        
    }
}

struct AdressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AdressView(order: Order())
        }
    }
}
