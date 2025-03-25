# Pokédex iOS

Pokédex iOS is a SwiftUI-based application that displays a list of Pokémon fetched from the PokéAPI. It allows users to search for Pokémon by name or ID and view detailed information including official artwork, basic stats, weight, height, and more.

## Features
- **Pokémon List:** Display a list of Pokémon with images and IDs.
- **Search Functionality:** Search Pokémon by name or ID.
- **Detail View:** View detailed information for each Pokémon including statistics, official artwork, weight, height, etc.
- **Custom UI:** Modern and responsive design built with SwiftUI.
- **Dark/Light Mode:** Supports custom color themes (default background can be set to F8F8F8 or any color you choose).

## Requirements
- Xcode 16.2 or later
- iOS 15.0 or later
- Swift 5

## Project Structure
- **Models/**: Contains the data models (e.g., `GenerationResponse`, `PokemonDetailResponse`, etc.) used to decode JSON from the PokéAPI.
- **Services/**: Contains the `PokemonService` class responsible for fetching data from the network.
- **ViewModels/**: Contains the `PokemonViewModel` which handles business logic and state management.
- **Views/**: Contains all the SwiftUI views including `PokemonListView` and `PokemonDetailView`.

## Installation and Build Instructions
1. **Clone the Repository:**
   ```bash
   git clone <repository-url>
   ```
2. **Open the Project:**
   Navigate to the project directory and open the `.xcodeproj` file with Xcode:
   ```bash
   cd Pokedex_IOS
   open Pokedex_IOS.xcodeproj
   ```
3. **Build the Project:**
   Select a simulator or a physical device in Xcode and press `Cmd+B` to build the project.
4. **Run the Project:**
   Press `Cmd+R` to run the application.

## Running on a Physical Device
- Connect your iOS device to your Mac.
- Ensure you have trusted your developer certificate on the device (Settings > General > Device Management).
- Select your device in Xcode and run the project.

## Customization

### Fonts
- This project uses the Montserrat font.
- To add your custom fonts, drag the `.ttf` or `.otf` files into your project (ensuring “Copy items if needed” is checked).
- Update your **Info.plist** with a new key **Fonts provided by application** and list your font file names.
- Use the custom fonts in your code via:
  ```swift
  .font(.custom("Montserrat-Regular", size: 24))
  ```

### Colors and UI Adjustments
- Modify the UI elements in the SwiftUI views as needed.
- For instance, change background colors by adjusting the `.background(Color("YourColor"))` modifier.
- You can add custom colors in the **Assets.xcassets** folder.
