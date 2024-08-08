//
//  HomeView.swift
//  UITutorials
//
//  Created by Esma Koçak on 8.08.2024.
//

import SwiftUI

struct HomeView: View {
    @State var midY: CGFloat = 0
    @State var selected = "Shakes"
    @State var search = ""
    
    var filteredItems: [Item] {
        items.filter { $0.category == selected }
    }
    
    var body: some View {
        

        HStack(spacing: 0){
            
            // MARK: Tab Bar
            VStack{
                
                Button {
                    
                } label: {
                    Image(systemName: "line.horizontal.3")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding(.top, 8)
                    
                }
                
                Spacer()
                
                ForEach(tabs, id: \.self){name in
                    
                    ZStack {
                        
                        Circle()
                            .fill(Color.orange)
                            .frame(width: 13, height: 13)
                            .offset(x: selected == name ? 28 : -80)
                        
                        Color("tab")
                            .frame(width: 150, height: 110)
                            .rotationEffect(.init(degrees: -90))
                            .offset(x: -50)

                        
                        GeometryReader { reader in
                            
                            Button {
                                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.65, blendDuration: 0.65)) {
                                    
                                    self.midY = reader.frame(in: .global).midY
                                    self.selected = name
                                }
                            } label: {
                                Text(name)
                                    .fontWeight(.heavy)
                                    .foregroundColor(.white)
                            }
                            .frame(width: 150, height: 110)
                            
                            //default frame
                            .rotationEffect(.init(degrees: -90))
                            
                            //initial curve position
                            .onAppear(perform: {
                                if name == tabs.first{
                                    self.midY = reader.frame(in: .global).midY
                                }
                            })
                            .offset(x: -7)
                            
                        }
                        .frame(width: 150, height: 110)
                    }
                    
                    
                }
                
                Spacer()
                
                
            }
            .frame(width: 70)
            .background(
                Color("tab")
                    .clipShape(Curve(midY: midY))
                    .ignoresSafeArea()
            )
            
            VStack{
                
                // MARK: Shopping Icon
                HStack{
                    
                    Spacer(minLength: 0)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "cart")
                            .font(.title2)
                            .foregroundColor(.black)
                    }

                }
                .padding(.horizontal)
                
                // MARK: Titles for Drinks
                HStack{
                    VStack (alignment: .leading, spacing: 4) {
                        Text("Smoothie King")
                            .font(.title)
                            .fontWeight(.heavy)
                        
                        Text("Shakes")
                            .font(.title)
                    } .foregroundColor(.black)
                    
                    Spacer()
                    
                }
                .padding(.top)
                .padding(.horizontal)
                
                // MARK: Search Bar
                HStack(spacing: 15){
                    TextField("Search", text: $search)
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(Color.black.opacity(0.06))
                .clipShape(Capsule())
                .padding(.horizontal)
                .padding(.top)
                
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 25){
                        // Items
                        ForEach(filteredItems) { item in
                            ItemView(item: item)
                        }
                    }
                    .padding()
                    .padding(.top)
                }
            }
            .padding(.leading)
            Spacer()
            
        }
    }
}

#Preview {
    HomeView()
}

// MARK: Item View
struct ItemView: View {
    var item: Item
    var body: some View{
        
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .center)){
            
            // MARK: Item Card
            VStack{
                
                HStack{
                    VStack(alignment: .leading, spacing: 4){
                        Text(item.title)
                            .fontWeight(.heavy)
                        
                        Text(item.cost)
                            .fontWeight(.heavy)
                    }
                    .foregroundColor(.white)
                    
                    Spacer(minLength: 0)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "suit.heart")
                            .font(.title2)
                            .foregroundColor(.white)
                    }

                }
                .padding([.horizontal, .top])
                .padding(.bottom, -15)
                
                Image(item.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                    .frame(height: 300)
                    .offset(x: -30, y: 40)
                                    
            }
            .background(
                Color(item.image)
                    .cornerRadius(35)
                    .padding(.bottom, 35)
                    .clipShape(ItemCurve())
            )
            
            Button {
                
            } label: {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color(item.image))
                    .clipShape(Circle())
            }
            .offset(x: 8)

        }
        
    }
}

// MARK: Tabs
var tabs = ["Shakes","Coffees","Drinks","Cocktails"]


// MARK: Custom Curve
struct Curve: Shape {
    
    var midY: CGFloat
    
    //animating
    var animatableData: CGFloat {
        get {return midY}
        set {midY = newValue}
    }
    
    
    
    func path(in rect: CGRect) -> Path {
        return Path{ path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            // Curve.
            let width = rect.width
            
            path.move (to: CGPoint (x: width, y: midY - 40))
            
            let to = CGPoint(x: width - 25, y: midY)
            let control1 = CGPoint(x: width, y: midY - 20)
            let control2 = CGPoint(x: width - 25, y: midY - 20)
            
            path.addCurve(to: to, control1: control1, control2: control2)
            
            let to1 = CGPoint (x: width, y: midY + 40)
            let control3 = CGPoint(x: width - 25, y: midY + 20)
            let control4 = CGPoint(x: width, y: midY + 20)
            
            path.addCurve(to: to1, control1: control3, control2: control4)
        }
    }
}

// MARK: Curve for Item View
struct ItemCurve: Shape {
    
    func path(in rect: CGRect) -> Path {
        return Path{ path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            // Curve.
            let width = rect.width
            let midY = rect.height / 2
            
            path.move (to: CGPoint (x: width, y: midY - 60))
            
            let to = CGPoint(x: width - 40, y: midY)
            let control1 = CGPoint(x: width, y: midY - 30)
            let control2 = CGPoint(x: width - 40, y: midY - 30)
            
            path.addCurve(to: to, control1: control1, control2: control2)
            
            let to1 = CGPoint (x: width, y: midY + 60)
            let control3 = CGPoint(x: width - 40, y: midY + 30)
            let control4 = CGPoint(x: width, y: midY + 30)
            
            path.addCurve(to: to1, control1: control3, control2: control4)
        }
    }
}

// MARK: Item Model and Data
struct Item: Identifiable {
    var id = UUID().uuidString
    var title: String
    var cost: String
    var image: String
    var category: String
}

var items = [
    Item(title: "Strawberry Shake", cost: "$6", image: "shake1", category: "Shakes"),
    Item(title: "Blueberry Juice Shake", cost: "$10", image: "shake2", category: "Shakes"),
    Item(title: "Juice Shake", cost: "$10", image: "shake3", category: "Shakes"),
    Item(title: "Caramel Latte", cost: "$5", image: "coffee1", category: "Coffees"),
    Item(title: "Chocolate Mocha", cost: "$7", image: "coffee2", category: "Coffees"),
]
