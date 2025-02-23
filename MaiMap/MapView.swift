//
//  ContentView.swift
//  MaiMap
//
//  Created by Михаил Рахимов on 04.02.2025.
//

import SwiftUI
import SceneKit

struct MapKitView: UIViewControllerRepresentable {
    var currentMode: MapViewController.MapMode
    var currentFloor: Int
    
    func makeUIViewController(context: Context) -> MapViewController {
        let controller = MapViewController()
        controller.currentMode = currentMode
        controller.currentFloor = currentFloor
        return controller
    }
    
    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
        uiViewController.currentMode = currentMode
        uiViewController.currentFloor = currentFloor
        uiViewController.loadData() 
        uiViewController.updateViewForCurrentMode()
    }
}


struct MapView: View {
    @State private var currentMode: MapViewController.MapMode = .mode2D
    @State private var currentFloor: Int = 1
    @State private var floors: [Int] = [1, 2, 3, 4, 5, 6]
    var body: some View {
        ScrollView{
            VStack {
                Picker("Режим", selection: $currentMode) {
                    Text("2D").tag(MapViewController.MapMode.mode2D)
                    Text("3D").tag(MapViewController.MapMode.mode3D)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                MapKitView(currentMode: currentMode, currentFloor: currentFloor)
                    .frame(width: 400, height: 500)
                
                VStack {
                    Text("Этаж: \(currentFloor)")
                        .font(.headline)
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(8)
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                        ForEach(floors, id: \.self) { floor in
                            OneFloorView(floor: floor,
                                         isSelected: floor == currentFloor, currentFloor: $currentFloor
                                        )
                                .onTapGesture {
                                    currentFloor = floor
                            }
                        }
                    }
                    .padding()
                    Spacer()
                    
                    
                }
                .padding()
                .background(Color(.systemBackground))
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}


//#Preview {
//    ContentView()
//}
