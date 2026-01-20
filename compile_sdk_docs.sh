#!/bin/bash

# compile_sdk_docs.sh
# Script to compile SDK documentation for all platforms
# Usage: ./compile_sdk_docs.sh [platform]
# Platforms: android, ios, react-native, flutter, cordova, all

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Function to print colored output
print_info() {
    echo -e "${BLUE}ℹ ${NC}$1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

# Function to generate prompt for a platform
generate_prompt() {
    local platform=$1
    local platform_upper=$(echo "$platform" | tr '[:lower:]' '[:upper:]')
    local output_file="${platform}.md"

    cat > "compile_${platform}_prompt.txt" << EOF
Create a comprehensive ${platform_upper} SDK documentation file following the SDK_COMPILATION_PROCESS.md guidelines.

TASK: Create ${output_file}

PLATFORM: ${platform_upper}

PROCESS TO FOLLOW:
1. Read SDK_COMPILATION_PROCESS.md to understand the complete compilation process
2. Follow the step-by-step process documented there
3. Extract all ${platform}-specific code from the documentation files
4. Compile into a single ${output_file} file using the standard structure

STANDARD STRUCTURE (from SDK_COMPILATION_PROCESS.md):
1. Requirements
2. Installation
3. SDK Initialization
4. Displaying Paywalls
5. Processing Transactions
6. Paywall Action Interceptor
7. User Identification
8. Subscription Status & Entitlements
9. Custom User Attributes
10. Event Listeners
11. Pre-fetching Screens
12. Deeplinks Management
13. Platform-Specific Features (if applicable)
14. Troubleshooting
15. Additional Resources

KEY REQUIREMENTS:
- Include ONLY ${platform}-specific code examples
- Extract code blocks marked with the appropriate language identifier
- Follow the checklist in SDK_COMPILATION_PROCESS.md
- Ensure all code is syntactically correct
- Use the same quality standards as android.md

SOURCE DIRECTORIES (from SDK_COMPILATION_PROCESS.md):
- docs/🚀 Getting Started/sdk-quick-start/sdk-installation/
- docs/Onboarding/sdk_initialisation/
- docs/Onboarding/sdk_paywall_action_interceptor/
- docs/Onboarding/sdk_deeplinks/
- docs/📱 Screens & Paywalls/displaying-screens/
- docs/✈️ GOING FURTHER/
- docs/👤 Users/
- docs/📈 Growth guidances/segmenting-your-user-base/
- custom_blocks/

REFERENCE:
- Check android.md as a reference for structure and quality
- Follow the platform-specific notes in SDK_COMPILATION_PROCESS.md
- Use the code block identifiers documented in the process file

OUTPUT:
Create ${output_file} in /Users/kevin/Purchasely/Documentation/

Please proceed with the compilation process.
EOF

    print_success "Generated prompt file: compile_${platform}_prompt.txt"
}

# Function to compile documentation for a platform
compile_platform() {
    local platform=$1

    print_info "Starting compilation for ${platform}..."

    # Check if already exists
    if [ -f "${platform}.md" ]; then
        print_warning "${platform}.md already exists. Skipping..."
        return
    fi

    # Generate prompt file
    generate_prompt "$platform"

    print_info "Prompt file created. To compile, run:"
    echo "    cat compile_${platform}_prompt.txt"
    echo ""
}

# Main script
main() {
    local platform=${1:-}

    echo ""
    print_info "Purchasely SDK Documentation Compiler"
    echo ""

    # Check if SDK_COMPILATION_PROCESS.md exists
    if [ ! -f "SDK_COMPILATION_PROCESS.md" ]; then
        echo "Error: SDK_COMPILATION_PROCESS.md not found!"
        exit 1
    fi

    # Check if CLAUDE.md exists
    if [ ! -f "CLAUDE.md" ]; then
        echo "Error: CLAUDE.md not found!"
        exit 1
    fi

    case "$platform" in
        android)
            compile_platform "android"
            ;;
        ios)
            compile_platform "ios"
            ;;
        react-native)
            compile_platform "react-native"
            ;;
        flutter)
            compile_platform "flutter"
            ;;
        cordova)
            compile_platform "cordova"
            ;;
        all)
            print_info "Compiling all platforms..."
            compile_platform "ios"
            compile_platform "react-native"
            compile_platform "flutter"
            compile_platform "cordova"
            echo ""
            print_success "All prompt files generated!"
            echo ""
            print_info "Next steps:"
            echo "  1. Use these prompts to compile each platform's documentation"
            echo "  2. Or run: ./compile_sdk_docs.sh interactive"
            ;;
        interactive)
            print_info "Interactive mode - Compiling all platforms sequentially..."
            echo ""

            # Create a master instruction file
            cat > "COMPILE_ALL_PLATFORMS.md" << 'EOF'
# Compile All Platform SDKs

Please compile SDK documentation for all remaining platforms following the process in `SDK_COMPILATION_PROCESS.md`.

## Platforms to Compile

### 1. iOS (ios.md)
- Language: Swift
- Code identifiers: swift, Swift, objectivec, Objective-C
- Special considerations: StoreKit 1 vs 2, CocoaPods/SPM installation
- Reference: android.md for structure

### 2. React Native (react-native.md)
- Language: JavaScript/TypeScript
- Code identifiers: typescript React Native, javascript React Native, ReactNative
- Special considerations: iOS pod install, Android gradle, storeKit1 parameter, androidStores parameter
- Reference: android.md for structure

### 3. Flutter (flutter.md)
- Language: Dart
- Code identifiers: typescript Flutter, dart, Flutter
- Special considerations: pub.dev installation, iOS pod install, Android gradle
- Reference: android.md for structure

### 4. Cordova (cordova.md)
- Language: JavaScript
- Code identifiers: javascript Cordova, Cordova
- Special considerations: Plugin installation, platform-specific setup, config.xml
- Reference: android.md for structure

## Process for Each Platform

1. Read SDK_COMPILATION_PROCESS.md for the complete process
2. Follow the step-by-step instructions
3. Use the standard 13-section structure
4. Extract platform-specific code from source files
5. Follow the quality checklist
6. Create the {platform}.md file

## Quality Standards

- Match the quality and completeness of android.md
- All code must be syntactically correct
- No placeholder values except intentional ones
- Consistent formatting throughout
- Complete table of contents
- Links verified

Please proceed to compile all four platforms.
EOF

            print_success "Created COMPILE_ALL_PLATFORMS.md"
            print_info "This file contains instructions to compile all remaining platforms."
            echo ""
            print_info "To execute, provide this file to Claude Code."
            ;;
        check)
            print_info "Checking compilation status..."
            echo ""

            platforms=("android" "ios" "react-native" "flutter" "cordova")
            for plat in "${platforms[@]}"; do
                if [ -f "${plat}.md" ]; then
                    size=$(wc -l < "${plat}.md")
                    print_success "${plat}.md - COMPLETE (${size} lines)"
                else
                    print_warning "${plat}.md - PENDING"
                fi
            done
            echo ""
            ;;
        clean)
            print_info "Cleaning up generated prompt files..."
            rm -f compile_*_prompt.txt
            rm -f COMPILE_ALL_PLATFORMS.md
            print_success "Cleanup complete"
            ;;
        *)
            echo "Usage: $0 {android|ios|react-native|flutter|cordova|all|interactive|check|clean}"
            echo ""
            echo "Commands:"
            echo "  android        Generate prompt for Android documentation"
            echo "  ios            Generate prompt for iOS documentation"
            echo "  react-native   Generate prompt for React Native documentation"
            echo "  flutter        Generate prompt for Flutter documentation"
            echo "  cordova        Generate prompt for Cordova documentation"
            echo "  all            Generate prompts for all platforms"
            echo "  interactive    Create master instruction file for all platforms"
            echo "  check          Check compilation status"
            echo "  clean          Remove generated prompt files"
            echo ""
            echo "Example:"
            echo "  $0 ios"
            echo "  $0 all"
            echo "  $0 interactive"
            exit 1
            ;;
    esac

    echo ""
}

main "$@"
