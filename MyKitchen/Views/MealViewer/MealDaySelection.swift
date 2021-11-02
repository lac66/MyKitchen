//
//  MealDaySelection.swift
//  MyKitchen
//
//  Created by egarci26 on 11/2/21.
//

import SwiftUI

struct MealDaySelection: View {
    init() {
       UITableView.appearance().separatorStyle = .none
       UITableViewCell.appearance().backgroundColor = .green
       UITableView.appearance().backgroundColor = UIColor(named: "OxfordBlue")
    }
    
    @State var days: [DayOfWeek] =
        [DayOfWeek(name: "Sunday"),
        DayOfWeek(name: "Monday"),
        DayOfWeek(name: "Tuesday"),
        DayOfWeek(name: "Wednesday"),
         DayOfWeek(name: "Thursday"),
         DayOfWeek(name: "Friday"),
         DayOfWeek(name: "Saturday")]
    
    
    var body: some View {
        ZStack(alignment: .bottom){
            Color("OxfordBlue").ignoresSafeArea()

            VStack{
                List{
                    ForEach(0..<days.count){ index in
                        HStack {
                            Button(action: {
                                days[index].isSelected = days[index].isSelected ? false : true
                            }) {
                                HStack{
                                    if days[index].isSelected {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.green)
                                            .animation(.easeIn)
                                    } else {
                                        Image(systemName: "circle")
                                            .foregroundColor(.primary)
                                            .animation(.easeOut)
                                    }
                                    Text(days[index].name)
                                }
                            }.buttonStyle(BorderlessButtonStyle())
                        }
                    }
                }
                
                Button("Done") {
           
                }
                .frame(width: 350, height: 40)
                .foregroundColor(Color("MintCream"))
                .font(.system(size: 30, weight: .black, design: .monospaced))
                .background(Color("Camel"))
                .cornerRadius(24)
                
                
            }
        }
    }
    
}


struct MealDaySelection_Previews: PreviewProvider {
    static var previews: some View {
        MealDaySelection()
    }
}

struct DayOfWeek{
    var id = UUID()
    var name: String
    var isSelected: Bool = false
}
