#!/bin/bash

# Project 4: Steam Game Searcher - Local Development Setup
# W3 Server-Side Development & Authentication

echo "🎮 Steam Game Searcher - SvelteKit Project Setup"
echo "================================================="
echo ""

# Check if script is run from correct directory
if [ ! -f "package.json" ]; then
    echo "❌ Error: Please run this script from the project-04-game-searcher directory"
    echo "   Expected: cd Templates/project-04-game-searcher && ./setup.sh"
    exit 1
fi

echo "🎓 DISCOVERY LEARNING OBJECTIVES:"
echo "   • Integrate external APIs with fetch()"
echo "   • Handle asynchronous operations"
echo "   • Implement search and filtering"
echo "   • Manage loading states and errors"
echo ""

echo "📚 Key Concepts (Lesson 13):"
echo "   → Steam Web API integration"
echo "   → Async/await patterns in Svelte"
echo "   → Error handling and user feedback"
echo "   → Search/filter implementation"
echo ""

# Check for node_modules
if [ ! -d "node_modules" ]; then
    echo "📦 Installing dependencies..."
    echo ""
    npm install

    if [ $? -ne 0 ]; then
        echo "❌ npm install failed"
        echo "   Try running: npm install --legacy-peer-deps"
        exit 1
    fi

    echo "✅ Dependencies installed successfully!"
    echo ""
else
    echo "✅ Dependencies already installed"
    echo ""
fi

echo "📁 Project Structure:"
echo "   • Entry point: src/routes/+page.svelte"
echo "   • API integration: Implement Steam API calls"
echo "   • Search logic: Filter and display results"
echo ""

echo "🚀 Starting SvelteKit development server..."
echo ""
echo "   → Server will start at: http://localhost:5173"
echo "   → Press Ctrl+C to stop the server"
echo ""
echo "================================================="
echo ""

# Start the development server
npm run dev
