import SwiftUI
import SceneKit

struct MapKitView: UIViewControllerRepresentable {
    var currentMode: MapViewController.MapMode
    var currentFloor: Int
    var path: [String]?
    
    func makeUIViewController(context: Context) -> MapViewController {
        let controller = MapViewController()
        controller.currentMode = currentMode
        controller.currentFloor = currentFloor
        controller.path = path
        return controller
    }
    
    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
        print("Updating MapViewController with path: \(String(describing: path))")
        uiViewController.currentMode = currentMode
        uiViewController.currentFloor = currentFloor
        uiViewController.path = path
        uiViewController.loadData()
        uiViewController.updateViewForCurrentMode()
    }
    
}

struct MapView: View {
    @ObservedObject private var viewModel = MapViewModel()
    @State var currentFloor: Int = 1
    @State var fromRoom: String = ""
    @State var toRoom: String = ""
    @State var fromFloor: Int = 1
    @State var toFloor: Int = 2
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            ScrollView {
            VStack {
                Picker("Режим", selection: $viewModel.currentMode) {
                    Text("2D").tag(MapViewController.MapMode.mode2D)
                    Text("3D").tag(MapViewController.MapMode.mode3D)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                MapKitView(currentMode: viewModel.currentMode, currentFloor: viewModel.currentFloor, path: viewModel.path)
                    .frame(height: 500)
                
                VStack {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                        ForEach(viewModel.floors, id: \.self) { floor in
                            OneFloorView(floor: floor, isSelected: floor == viewModel.currentFloor, currentFloor: $viewModel.currentFloor)
                                .onTapGesture {
                                    viewModel.currentFloor = floor
                                }
                        }
                    }
                    .padding()
                    
                    HStack {
                        Text("Откуда")
                            .frame(width: 80, alignment: .leading)
                        
                        Menu {
                            ForEach(viewModel.officesForFloor(fromFloor), id: \.name) { office in
                                Button(office.name) {
                                    fromRoom = office.name
                                }
                            }
                        } label: {
                            HStack {
                                Text(fromRoom.isEmpty ? "Выберите" : fromRoom)
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                        }
                        
                        Picker("", selection: $fromFloor) {
                            ForEach(viewModel.floors, id: \.self) { floor in
                                Text("\(floor)").tag(floor)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: 50)
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                    
                    HStack {
                        Text("Куда")
                            .frame(width: 80, alignment: .leading)
                        
                        Menu {
                            ForEach(viewModel.officesForFloor(toFloor), id: \.name) { office in
                                Button(office.name) {
                                    toRoom = office.name
                                }
                            }
                        } label: {
                            HStack {
                                Text(toRoom.isEmpty ? "Выберите" : toRoom)
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                        }
                        
                        Picker("", selection: $toFloor) {
                            ForEach(viewModel.floors, id: \.self) { floor in
                                Text("\(floor)").tag(floor)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: 50)
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                    
                    Button(action: {
                        guard !fromRoom.isEmpty, !toRoom.isEmpty else {
                            print("Выберите начальную и конечную точки")
                            return
                        }
                        let fromId = getNodeIdForLocation(fromRoom, floor: fromFloor)
                        let toId = getNodeIdForLocation(toRoom, floor: toFloor)
                        if let fromId = fromId, let toId = toId {
                            viewModel.findPath(from: fromId, to: toId)
                        } else {
                            print("Не удалось определить идентификаторы узлов")
                        }
                    }) {
                        Text("Найти маршрут")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                    .padding(.top, 16)
                    .padding(.bottom, 16)
                    
                    if let path = viewModel.path, !path.isEmpty {
                        ScrollView {
                            VStack(alignment: .leading, spacing: 12) {
                                ForEach(viewModel.routeCalculator?.generateInstructions(path: path) ?? [], id: \.self) { instruction in
                                    Text(instruction)
                                        .padding(.horizontal)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .frame(height: 200)
                    }
                    
                }
                .padding()
                .background(Color(.systemBackground))
                
                }
            
            }
            .navigationTitle("Карта")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.loadData()
            }
        }
    }
    
    
    
    private func getNodeIdForLocation(_ location: String, floor: Int) -> String? {
        if let office = viewModel.offices.first(where: { $0.name == location }) {
            return "office_\(office.name.replacingOccurrences(of: " ", with: "_").lowercased())"
        } else if location == "Лифт" {
            return "elevator_\(floor)"
        } else if location == "Лестница" {
            return "stairs_\(floor)"
        }
        return nil
    }
    
    }



#Preview {
    MapView()
}


