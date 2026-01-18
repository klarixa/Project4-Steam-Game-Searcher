# Project 4: Steam Game Searcher - Discovery Challenge

> **W3 Server-Side Development & Authentication - Lesson 13**

## 🎯 Project Overview

Build a Steam game search application using SvelteKit and external API integration. This project introduces you to full-stack routing, API calls with `fetch()`, and managing asynchronous data in a modern web framework.

## 📚 Learning Objectives

By completing this project, you will:
- Master SvelteKit routing and page structure
- Integrate external APIs (CheapShark API) using `fetch()`
- Handle asynchronous data with async/await
- Implement search functionality and result filtering
- Create reusable Svelte components
- Manage loading states and error handling
- Work with JSON data from APIs

## 🔗 GitHub Source

This template is from: [Web-3-Project-4-Steam-Game-Searcher](https://github.com/academic-telebort/Web-3-Project-4-Steam-Game-Searcher)

## 🚀 Getting Started

### ⚡ Quick Start (See Results in 30 Seconds!)

**IMPORTANT: This template includes a WORKING foundation with 70% pre-built!**

1. **Navigate to this folder** in your terminal:
   ```bash
   cd "Paid Courses/W3 Server-Side Development & Authentication/Templates/project-04-game-searcher"
   ```

2. **Install dependencies:**
   ```bash
   npm install
   ```

3. **Start development server:**
   ```bash
   npm run dev
   ```

4. **Open your browser** to: http://localhost:5173

5. **You'll see immediately:**
   - A styled page with TODO-guided template
   - Clear structure for implementing game search
   - CSS styling already applied

### Prerequisites
- Node.js v18+ installed
- VS Code with Svelte extension
- Completed Lessons 1-12 (Svelte + SvelteKit fundamentals)
- Basic understanding of APIs and JSON

### 🎯 What's Already Working (65% Complete)

**65-70% of the code is implemented for you:**

- ✅ **SvelteKit Project**: Complete project structure with routing
- ✅ **State Management**: Working variables for games, loading, error
- ✅ **Sample Game Data**: 4 pre-loaded games with complete info
- ✅ **Search Functionality**: Working search with filter logic
- ✅ **Loading States**: Animated spinner and loading messages
- ✅ **Error Handling**: Error display with retry button
- ✅ **Game Grid Display**: Responsive grid layout with cards
- ✅ **Conditional Rendering**: Loading, error, results, empty states
- ✅ **onMount Lifecycle**: Auto-loads games on page open
- ✅ **Complete Styling**: Professional CSS with animations
- ⚠️ **Real API Integration**: TODO - Replace mock data with CheapShark API
- ⚠️ **Component Extraction**: TODO - Create SearchBar and GameCard components in $lib/

## 📂 Project Structure

```
project-04-game-searcher/
├── src/
│   ├── lib/                    # ⚠️ YOU NEED TO CREATE THIS FOLDER
│   │   ├── GameCard.svelte     # TODO: Create game card component
│   │   └── SearchBar.svelte    # TODO: Create search component
│   ├── routes/
│   │   └── index.svelte        # ✅ TODO-guided template (starter code)
│   └── app.html                # ✅ HTML shell (provided)
├── package.json
└── svelte.config.js
```

**Important Notes:**
- The `src/lib/` folder does NOT exist yet - you will create it!
- `src/routes/index.svelte` contains TODO comments guiding your implementation
- Follow the TODOs step-by-step to build the complete application

## 📋 Tasks to Complete

### TODO 1: Create src/lib/ Folder and Components (Medium)

Set up the component folder structure.

**Success Criteria:**
- [ ] Created `src/lib/` directory
- [ ] Created `SearchBar.svelte` component file
- [ ] Created `GameCard.svelte` component file
- [ ] Files are in correct location for `$lib` imports

**Code Location:** Create folder at `src/lib/`

**Hint:** Use VS Code's file explorer or terminal: `mkdir src/lib`

### TODO 2: Build SearchBar Component (Medium)

Create a search component that dispatches custom events.

**Success Criteria:**
- [ ] Input field for search query
- [ ] Search button
- [ ] Uses `createEventDispatcher()` to send events
- [ ] Dispatches 'search' event with query value
- [ ] Shows loading state while searching

**Code Location:** `src/lib/SearchBar.svelte`

**Example:**
```svelte
<script>
  import { createEventDispatcher } from 'svelte';
  const dispatch = createEventDispatcher();

  let query = '';

  function handleSearch() {
    dispatch('search', { query });
  }
</script>

<input bind:value={query} />
<button on:click={handleSearch}>Search</button>
```

### TODO 3: Build GameCard Component (Easy)

Create a component to display game information.

**Success Criteria:**
- [ ] Accepts `game` prop with game data
- [ ] Displays game thumbnail image
- [ ] Shows title, price, and rating
- [ ] Styled as a card with hover effects
- [ ] Handles missing data gracefully

**Code Location:** `src/lib/GameCard.svelte`

**Hint:** Use `export let game` to accept the prop, then access `game.title`, `game.thumb`, etc.

### TODO 4: Implement API Integration (Hard)

Fetch game data from CheapShark API.

**Success Criteria:**
- [ ] `fetchGames()` function uses async/await
- [ ] Fetches from: `https://www.cheapshark.com/api/1.0/deals?storeID=1&upperPrice=15`
- [ ] Parses JSON response correctly
- [ ] Updates `games` array with results
- [ ] Handles errors with try/catch
- [ ] Sets loading states appropriately

**Code Location:** `src/routes/index.svelte` - Follow TODOs in script section

**Example:**
```javascript
async function fetchGames() {
  loading = true;
  error = null;
  try {
    const response = await fetch('https://www.cheapshark.com/api/1.0/deals?storeID=1&upperPrice=15');
    const data = await response.json();
    games = data;
  } catch (err) {
    error = 'Failed to load games';
  } finally {
    loading = false;
  }
}
```

### TODO 5: Add onMount Lifecycle Hook (Medium)

Load games automatically when page loads.

**Success Criteria:**
- [ ] Imports `onMount` from 'svelte'
- [ ] Calls `fetchGames()` inside `onMount`
- [ ] Games load automatically on page visit
- [ ] No manual button click needed for initial load

**Code Location:** `src/routes/index.svelte` - Script section

**Example:**
```javascript
import { onMount } from 'svelte';

onMount(() => {
  fetchGames();
});
```

### TODO 6: Implement Conditional Rendering (Medium)

Show different UI based on loading/error/results states.

**Success Criteria:**
- [ ] Shows loading spinner when `loading === true`
- [ ] Shows error message when `error` exists
- [ ] Shows game grid when `games.length > 0`
- [ ] Uses `{#if}`, `{:else if}`, `{:else}` blocks
- [ ] User-friendly messages for each state

**Code Location:** `src/routes/index.svelte` - Template section

**Example:**
```svelte
{#if loading}
  <p>Loading games...</p>
{:else if error}
  <p>Error: {error}</p>
{:else if games.length > 0}
  {#each games as game}
    <GameCard {game} />
  {/each}
{:else}
  <p>No games found</p>
{/if}
```

## 💡 Implementation Guide

### Step 1: Follow TODOs in `src/routes/index.svelte`

The main template file contains comprehensive TODO comments that guide you through:
1. **Imports**: What to import from Svelte and your components
2. **State Variables**: What variables you need to track
3. **API Integration**: How to fetch data from CheapShark API
4. **Lifecycle**: When to load data
5. **Event Handlers**: How to handle user interactions
6. **Conditional Rendering**: How to show different UI states

**Start by reading all the TODOs** - they explain exactly what you need to implement!

### Step 2: Create the `src/lib/` Folder and Components

You need to create two components:

#### SearchBar.svelte
This component should:
- Accept user search input
- Dispatch a custom event when user searches
- Show loading state while searching
- Clear input functionality (optional)

**Key Concepts**:
- Use `createEventDispatcher()` from Svelte
- Form handling with `on:submit`
- Custom events for parent-child communication

#### GameCard.svelte
This component should:
- Accept a `game` prop with game data
- Display game thumbnail, title, price, and rating
- Be styled as a card with hover effects
- Show platform icons (optional)

**Key Concepts**:
- Component props with `export let`
- Conditional rendering for missing data
- Image fallback handling

### Step 3: Implement API Integration

Use the **CheapShark API** (no authentication required):
```javascript
const API_URL = 'https://www.cheapshark.com/api/1.0/deals?storeID=1&upperPrice=15';

async function fetchGames() {
  const response = await fetch(API_URL);
  const data = await response.json();
  return data;
}
```

**API Response Structure**:
```json
[
  {
    "title": "Game Name",
    "thumb": "https://...",
    "salePrice": "9.99",
    "normalPrice": "29.99",
    "steamRatingText": "Very Positive"
  }
]
```

### Step 4: Complete the Implementation Checklist

Follow this order for best results:
1. ✅ Read all TODOs in `index.svelte`
2. ✅ Create `src/lib/` folder
3. ✅ Create `SearchBar.svelte` component
4. ✅ Create `GameCard.svelte` component
5. ✅ Implement state variables in `index.svelte`
6. ✅ Implement `fetchGames()` function
7. ✅ Add `onMount()` to load games on page load
8. ✅ Add conditional rendering for loading/error/results states
9. ✅ Test the complete application

## 🌐 Game API Resources

### Primary API: CheapShark (Used in Template)
- **API**: https://www.cheapshark.com/api
- **No API Key Required**: ✅ Perfect for learning!
- **Endpoint Used**: `https://www.cheapshark.com/api/1.0/deals?storeID=1&upperPrice=15`
- **What it returns**: Steam game deals under $15

### Alternative APIs (Optional):
- **RAWG API**: https://rawg.io/apidocs (requires free API key)
- **IGDB API**: https://api-docs.igdb.com (requires registration)

### Example API Call:
```javascript
// CheapShark API - No auth needed!
const fetchGames = async () => {
  const response = await fetch(
    'https://www.cheapshark.com/api/1.0/deals?storeID=1&upperPrice=15'
  );
  const data = await response.json();
  return data; // Array of game deals
};
```

## ✅ Overall Success Criteria

Your project is complete when:
- ✅ Created `src/lib/` folder with SearchBar and GameCard components
- ✅ SearchBar component accepts input and dispatches search events
- ✅ GameCard component displays game info (title, image, price, rating)
- ✅ Games load automatically when page loads (using onMount)
- ✅ Search results display in a grid format
- ✅ Loading state shows while fetching data
- ✅ Error handling displays user-friendly messages
- ✅ Conditional rendering works ({#if}, {#each} blocks)
- ✅ Code uses proper async/await patterns
- ✅ All TODOs in `index.svelte` are completed

## 🧪 Testing Your Implementation

Test these scenarios:
1. **Initial Load**: Games should load automatically when page opens
2. **Loading State**: Should see loading spinner while fetching
3. **Game Display**: All games should show in a grid with images
4. **Search Functionality**: SearchBar should accept input and trigger searches
5. **Error Handling**: Test offline mode to see error messages
6. **Responsive Grid**: Resize browser to see grid adapt
7. **Console**: No errors in browser console

## 🚀 Extension Challenges

Ready for more? Try these bonus features:

### Beginner Extensions
- **Search Functionality**: Implement live search filtering
- **Sort Options**: Sort by price, rating, or name
- **Favorites**: Add games to a favorites list (localStorage)

### Advanced Extensions
- **Price Filter**: Add slider to filter by price range
- **Genre Tags**: Display and filter by game genres
- **Pagination**: Add "Load More" button or pagination
- **Game Details Modal**: Click card to see more details

### Creative Extensions
- **Wishlist with Notifications**: Track price drops
- **Comparison Tool**: Compare multiple games side-by-side
- **Steam Integration**: Link directly to Steam store pages
- **Dark Mode**: Theme switcher with smooth transitions

## 📖 Resources

- **SvelteKit Routing**: [https://kit.svelte.dev/docs/routing](https://kit.svelte.dev/docs/routing)
- **Fetch API**: [https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API)
- **Async/Await**: [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/async_function](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/async_function)
- **CheapShark API**: [https://www.cheapshark.com/api](https://www.cheapshark.com/api)

## 🎨 Grading Rubric

| Criteria | Points | Description |
|----------|--------|-------------|
| **Component Creation** | 30 | SearchBar and GameCard components work correctly |
| **API Integration** | 30 | Successful API calls, data parsing with fetch() |
| **State Management** | 20 | Proper use of reactive variables and onMount |
| **Conditional Rendering** | 10 | Loading, error, and results states display correctly |
| **Code Quality** | 10 | Clean code, async patterns, follows TODOs |
| **Total** | 100 | |

## 🐛 Common Issues & Solutions

**Issue**: "Cannot find module '$lib/SearchBar.svelte'"
**Solution**: Make sure you created the `src/lib/` folder and the component file

**Issue**: Games not displaying after fetch
**Solution**: Check that you're updating the `games` variable and using `{#each}` correctly

**Issue**: CORS errors when calling API
**Solution**: The CheapShark API is CORS-enabled - make sure you're using the exact URL from the TODOs

**Issue**: Images not loading
**Solution**: Check the `thumb` property from API response, use fallback if missing

**Issue**: onMount not firing
**Solution**: Make sure you imported onMount from 'svelte' and called it correctly

**Issue**: Loading state stays true forever
**Solution**: Ensure you set `loading = false` in the `finally` block of your fetch function

## 📦 Build for Production

When ready to deploy:
```bash
npm run build
npm run preview  # Preview production build
```

## 🔗 Related Course Materials

- **Concept 08**: SvelteKit
- **Concept 09**: Application Programming Interface
- **Activity 08**: SvelteKit Exercises
- **Activity 09**: API Integration Exercises
- **Lesson**: 13
- **Project Specification**: `../../Project/Project 04- Steam Game Searcher.mdx`

---

**Remember**: APIs are the backbone of modern web apps. Focus on proper async patterns and error handling—these skills transfer to every web project!
