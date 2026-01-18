<script>
  // ==================== IMPORTS ====================
  // ✅ WORKING: Core Svelte imports
  import { onMount } from 'svelte';

  // ⚠️ NOTE: Components will be created by students in TODO section
  import SearchBar from '$lib/SearchBar.svelte';
  import GameCard from '$lib/GameCard.svelte';

  // ==================== STATE VARIABLES ====================
  // ✅ WORKING: State management
  let searchQuery = '';
  let games = [];
  let loading = false;
  let error = null;
  // Price filter
  let maxPrice = 15;
  // Reactive filtered list based on `maxPrice`
  $: filteredGames = games.filter(game => (parseFloat(game.salePrice) || Infinity) <= maxPrice);

  // Sample game data for immediate display (students will replace with real API)
  const sampleGames = [
    {
      gameID: "1",
      title: "The Legend of Zelda: Breath of the Wild",
      salePrice: "39.99",
      normalPrice: "59.99",
      thumb: "https://upload.wikimedia.org/wikipedia/en/thumb/c/c6/The_Legend_of_Zelda_Breath_of_the_Wild.jpg/250px-The_Legend_of_Zelda_Breath_of_the_Wild.jpg",
      steamRatingText: "Overwhelmingly Positive",
      metacriticScore: "97"
    },
    {
      gameID: "2",
      title: "God of War",
      salePrice: "29.99",
      normalPrice: "49.99",
      thumb: "https://m.media-amazon.com/images/M/MV5BNjJiNTFhY2QtNzZkYi00MDNiLWEzNGEtNWE1NzBkOWIxNmY5XkEyXkFqcGc@._V1_.jpg",
      steamRatingText: "Very Positive",
      metacriticScore: "94"
    },
    {
      gameID: "3",
      title: "Elden Ring",
      salePrice: "44.99",
      normalPrice: "59.99",
      thumb: "https://m.media-amazon.com/images/M/MV5BMWNlMDBiYzYtMWMyMC00Zjc5LTlhMjItMjRlMzBmYmVkOGM0XkEyXkFqcGc@._V1_QL75_UY281_CR4,0,190,281_.jpg",
      steamRatingText: "Mostly Positive",
      metacriticScore: "96"
    },
    {
      gameID: "4",
      title: "Hollow Knight",
      salePrice: "7.49",
      normalPrice: "14.99",
      thumb: "https://upload.wikimedia.org/wikipedia/en/thumb/0/04/Hollow_Knight_first_cover_art.webp/274px-Hollow_Knight_first_cover_art.webp.png",
      steamRatingText: "Overwhelmingly Positive",
      metacriticScore: "87"
    },
    {
      gameID: "5",
      title: "Stardew Valley",
      salePrice: "6.99",
      normalPrice: "14.99",
      thumb: "https://upload.wikimedia.org/wikipedia/en/f/fd/Logo_of_Stardew_Valley.png",
      steamRatingText: "Very Positive",
      metacriticScore: "89"
    }
  ];

  // ==================== API FUNCTIONS ====================
  // ✅ WORKING: Fetch games from CheapShark API or use sample data
  async function searchGames(query = '') {
    loading = true;
    error = null;
    try {
      const params = new URLSearchParams();
      if (query && query.trim()) {
        params.set('title', query);
      }
      params.set('pageSize', '60');

      const url = `https://www.cheapshark.com/api/1.0/deals?${params.toString()}`;
      const res = await fetch(url);
      if (!res.ok) throw new Error(`HTTP ${res.status}`);
      const data = await res.json();

      // Map API results to the shape used in this component
      games = data.map(g => ({
        gameID: g.dealID || g.title,
        title: g.title,
        salePrice: g.salePrice,
        normalPrice: g.normalPrice || g.retailPrice || '0',
        thumb: g.thumb,
        steamRatingText: g.steamRatingText || '',
        metacriticScore: g.metacriticScore || ''
      }));

      // If query provided but no results, keep games empty (handled in template)
    } catch (err) {
      console.error('Failed to fetch deals:', err);
      // If the API fetch fails (CORS, network, etc.), fall back to using
      // the local `sampleGames` and apply client-side filtering so search works.
      if (query && query.trim()) {
        const q = query.trim().toLowerCase();
        games = sampleGames.filter(g => g.title.toLowerCase().includes(q));
      } else {
        games = [...sampleGames];
      }
      // Keep error silent so fallback data is shown; developers can inspect console.
      error = null;
    } finally {
      loading = false;
    }
  }

  // ==================== LIFECYCLE ====================
  // ✅ WORKING: Load games on component mount
  onMount(() => {
      // Load live deals on mount (falls back to sample data on error)
      searchGames().then(() => {
        if (!games || games.length === 0) {
          games = [...sampleGames];
          // Clear any transient error so the fallback data is displayed
          error = null;
        }
      });
  });

  // ==================== EVENT HANDLERS ====================
  // Handle search events from `SearchBar` component
  function handleSearch(query) {
    searchQuery = query;
    // clear transient errors when starting a new search
    error = null;
    searchGames(query);
  }

  // Clear search and reload default deals
  function handleClear() {
    searchQuery = '';
    error = null;
    searchGames();
  }
</script>

<!-- ==================== TEMPLATE ==================== -->
<div class="container">
  <!-- Header -->
  <div class="header">
    <h1>🎮 Game Searcher</h1>
    <p>Discover great game deals (students will integrate CheapShark API)</p>
  </div>

  <!-- ✅ WORKING: Search Section -->
  <div class="search-section">
    <div class="search-form">
      <SearchBar bind:value={searchQuery} on:search={(e) => handleSearch(e.detail)} on:clear={handleClear} />
    </div>
    <p style="text-align: center; color: #666;">
      <em>Showing live deals from CheapShark (falls back to sample data on error).</em>
    </p>

    <div style="display:flex; justify-content:center; gap:1rem; align-items:center; margin-top:0.5rem;">
      <label for="maxPriceRange" style="font-weight:600;">Max price: $</label>
      <input id="maxPriceRange" type="range" min="0" max="60" step="0.5" bind:value={maxPrice} style="width:220px;" />
      <input type="number" min="0" max="999" step="0.5" bind:value={maxPrice} style="width:80px; padding:6px; border-radius:6px; border:1px solid #ddd;" />
    </div>
  </div>

  <!-- ✅ WORKING: Conditional Rendering -->
  {#if loading}
    <div class="loading-container">
      <div class="spinner"></div>
      <p style="margin-top: 1rem; font-size: 1.2rem;">🔍 Searching for games...</p>
    </div>
  {:else if error && (!games || games.length === 0)}
    <div class="error-container">
      <h3>❌ Error Loading Games</h3>
      <p>{error}</p>
      <button class="btn btn-primary" on:click={() => searchGames()} style="margin-top: 1rem;">
        Try Again
      </button>
    </div>
  {:else if filteredGames.length > 0}
    <!-- ✅ WORKING: Game Grid with Iteration -->
    <div class="game-grid">
      {#each filteredGames as game (game.gameID)}
        <GameCard {game} />
      {/each}
    </div>
  {:else}
    <div class="empty-state">
      <h3>🎮 No games found</h3>
      <p>Try a different search term or increase the max price to see more games.</p>
    </div>
  {/if}

</div>

<style>
  @import url("https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css");

  /* TODO: Style the main container */
  .container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 2rem;
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  }

  /* TODO: Style the header section */
  .header {
    text-align: center;
    margin-bottom: 3rem;
  }

  .header h1 {
    font-size: 3rem;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    background-clip: text;
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    margin-bottom: 0.5rem;
  }

  .search-section {
    max-width: 600px;
    margin: 0 auto 2rem;
  }
  /* SearchBar/button styles live in `src/lib/SearchBar.svelte`. */

  .game-grid {
    display: grid;
    /* smaller cards: reduce min width */
    grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
    gap: 1.25rem;
    margin-top: 1.5rem;
  }

  /* Game card styles moved to `src/lib/GameCard.svelte`. */

  .loading-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    min-height: 400px;
  }

  .spinner {
    width: 50px;
    height: 50px;
    border: 4px solid #f3f4f6;
    border-top-color: #667eea;
    border-radius: 50%;
    animation: spin 0.8s linear infinite;
  }

  @keyframes spin {
    to { transform: rotate(360deg); }
  }

  .error-container {
    background: #fed7d7;
    border: 1px solid #fc8181;
    border-radius: 12px;
    padding: 2rem;
    text-align: center;
  }

  .empty-state {
    text-align: center;
    padding: 4rem 2rem;
    color: #999;
  }
</style>

<!-- ==================== TODO FOR STUDENTS ==================== -->

<!-- ⚠️ TODO FOR STUDENTS: Replace Mock Data with Real CheapShark API -->
<!-- Your task: Integrate the CheapShark API for live game data!

     SUCCESS CRITERIA:
     - Create async function to fetch from: https://www.cheapshark.com/api/1.0/deals?storeID=1&upperPrice=15
     - Use try/catch for error handling
     - Set loading states appropriately
     - Parse JSON response correctly
     - Update games array with API data

     HINTS:
     1. Replace the searchGames() function with real fetch():
        async function searchGames() {
          loading = true;
          error = null;
          try {
            const response = await fetch('https://www.cheapshark.com/api/1.0/deals?storeID=1&upperPrice=15');
            const data = await response.json();
            games = data;
          } catch (err) {
            error = 'Failed to load games. Please try again.';
          } finally {
            loading = false;
          }
        }

     2. Update onMount to call the new fetch function
     3. Test with different API parameters (price range, store ID)
     4. Add search functionality by filtering API results

     EXTENSION CHALLENGES:
     - Create SearchBar and GameCard components in $lib/
     - Add filters (price range, ratings, platform)
     - Implement game detail modal on click
     - Add "Add to Wishlist" functionality with localStorage
     - Create sorting options (price, rating, discount percentage)
-->