//
//  FruitsApp.swift
//  UITutorials
//
//  Created by Esma Koçak on 4.08.2024.
//

import SwiftUI

struct FruitsApp: View {
    var body: some View {
        Home()
    }
}

struct Home: View {
    @State var width = UIScreen.main.bounds.width
    
    // Sample data
    @State var data = [
        
        DataType(name: "Banana", price: "$5 / Dozen", content: "Bananas are high in potassium and contain goog levels of protien and dietary fiber.One medium-sized banana contains 422 milligrams of potassium.", calories: "89", expand: ["0.3 g","23 g","1.1 g"],color: Color(hue: 0.126, saturation: 0.314, brightness: 1.002),image: "ban"),
        
        DataType(name: "Avacado", price: "$25 / Kg", content: "Avocodo contributes nearly 20 vitamins and minerals,making it a great nutrient-dense food choice.", calories: "160", expand: ["15 g","9 g","2 g"],color: Color(hue: 0.461, saturation: 0.317, brightness: 1.0),image: "ava"),
            
        DataType(name: "Strawberry", price: "$100 / Kg", content: "They're an excellent source of vitamin C and manganese and also contain decent amounts of folate(vitamin B9) and potassium.", calories: "33", expand: ["0.3 g","8 g","0.7 g"],color: Color(hue: 1.0, saturation: 0.367, brightness: 0.986),image: "sta")

    ]
    
    @State var index = 0
    
    var body: some View {
        
        ZStack(alignment: .top) {
            
            VStack {
                HStack {
            
                    // MARK: Back Button
                    Button {
                        
                    } label: {
                        HStack (spacing: 10) {
                            Image("back")
                                .renderingMode(.original)
                            Text("Back")
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                        }
                    }
                    
                    Spacer()
                    
                    // MARK: Shopping Bag Button
                    Button {
                        
                    } label: {
                        Image("bag")
                            .renderingMode(.original)
                        
                    }
                    
                }
                .padding()
                
                HStack {
                    
                    Button {
                        
                        if self.index != 0{
                            self.index -= 1
                        }
                        
                    } label: {
                        Image("left")
                            .renderingMode(.original)
                        
                    }
                    .opacity(self.index != 0 ? 1 : 0.5)
                    .disabled(self.index != 0 ? false : true)
                    
                    Image(self.data[self.index].image)
                    
                    Button {
                        
                        if self.index != self.data.count - 1 {
                            self.index += 1
                        }
                        
                    } label: {
                        Image("right")
                            .renderingMode(.original)
                        
                    }
                    .opacity(self.index != self.data.count - 1 ? 1 : 0.5) //disabling the button at the end
                    .disabled(self.index != self.data.count - 1 ? false : true)

                    
                }
                .padding(.top, 50)
                
                VStack (spacing: 20){
                    Text(self.data[self.index].name)
                        .fontWeight(.bold)
                        .font(.title)
                    
                    Text(self.data[self.index].price)
                        .fontWeight(.bold)
                    
                    Text(self.data[self.index].content)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(.gray)
                    
                    Text("Nutrution Value")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.top)
                    
                    HStack{
                        Image(systemName: "flame.fill")
                            .resizable()
                            .frame(width: 25, height: 35)
                            .foregroundColor(.white)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            
                            Text(self.data[self.index].calories)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                            
                            Text("Calories")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                        }
                        .padding(.leading, 15)
                    }
                    .padding()
                    .background(Color.purple)
                    .cornerRadius(15)
                    
                    HStack{
                        VStack(alignment: .center, spacing: 5) {
                            Text(self.data[self.index].expand[0])
                                .fontWeight(.bold)
                            
                            Text("Fat")
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        
                        VStack(alignment: .center, spacing: 10) {
                            
                            Text(self.data[self.index].expand[1])
                                .fontWeight(.bold)
                            
                            Text("Carbohydrade")
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .center, spacing: 10) {
                            
                            Text(self.data[self.index].expand[2])
                                .fontWeight(.bold)
                            
                            Text("Protien")
                                .foregroundColor(.gray)
                        }

                    }
                    .padding(.horizontal)
                    .padding()
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                // MARK: Add To Cart Button
                Button(action: {
                    
                }) {
                    
                    Text("Add to Cart")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: self.width - 50)
                        .background(Color.purple)
                        .clipShape(Capsule())
                }
                .padding(.bottom, 25)
                
            }
            .zIndex(1)
            
            // MARK: Top Curve
            Circle()
                .fill(self.data[self.index].color)
                .frame(width: self.width + 200, height: self.width + 200)
                .padding(.horizontal, -100)
                .offset(y: -self.width) //move circle up
            
        }
    }
}

#Preview {
    FruitsApp()
}



struct DataType {
    var name : String
    var price : String
    var content : String
    var calories : String
    var expand : [String]
    var color : Color
    var image : String
}

