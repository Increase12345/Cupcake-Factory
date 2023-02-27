//
//  CheckOutView.swift
//  CupcakeCorner
//
//  Created by Nick Pavlov on 2/24/23.
//

import SwiftUI

struct CheckOutView: View {
    @ObservedObject var order: Order
    @State private var confirmationMessage = ""
    @State private var confirmationTitle = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .padding()
                    
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                VStack {
                    Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                        .font(.title)
                    
                    Button("Place Order") {
                        Task {
                            await placeOrder()
                        }
                    }
                    .padding()
                    .background(.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.top)
                }
                .frame(minWidth: 300, minHeight: 300)
                .background(.thickMaterial)
                .cornerRadius(10)
                .padding(.top, 50)
            }
            
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .background(Image("background").opacity(0.5))
        .alert(confirmationTitle, isPresented: $showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
    }
    
    func placeOrder() async {
        
        // 1. Convert our current order into JSON data that can be sent.
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        // 2. Prepare a URLRequest to send our encoded data as JSON.
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            
            // 3. Sending data
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            // 4. Recieving data
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationTitle = "Thank you!"
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on it's way!"
            showingConfirmation = true
        } catch {
            confirmationTitle = "Oops"
            confirmationMessage = "There was an error, no internet connection"
            showingConfirmation = true
        }
    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CheckOutView(order: Order())
        }
    }
}
