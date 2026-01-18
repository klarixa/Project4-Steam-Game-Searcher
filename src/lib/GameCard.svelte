<script>
  export let game;

  // Guard against missing numeric parsing
  const sale = parseFloat(game.salePrice) || 0;
  const normal = parseFloat(game.normalPrice) || 0;
  const discount = normal > 0 ? Math.round((1 - sale / normal) * 100) : 0;
</script>

<div class="game-card">
  <img src={game.thumb} alt={game.title} />
  <div class="game-info">
    <h3>{game.title}</h3>
    <div class="game-price">
      <span class="current-price">${game.salePrice}</span>
      <span class="original-price">${game.normalPrice}</span>
      <span style="color: #48bb78; font-weight: bold;">{discount}% OFF</span>
    </div>
    <div class="game-rating">
      <span class="rating-badge">⭐ {game.steamRatingText}</span>
      {#if game.metacriticScore}
        <span style="color: #667eea; font-weight: bold;">Metacritic: {game.metacriticScore}</span>
      {/if}
    </div>
  </div>
</div>

<style>
  .game-card {
    background: white;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    transition: transform 0.2s, box-shadow 0.2s;
  }

  .game-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 16px rgba(0,0,0,0.15);
  }

  .game-card img {
    display: block;
    width: 100%;
    /* keep a consistent card aspect ratio and make images fill it */
    aspect-ratio: 2 / 3;
    object-fit: cover;
    /* center the important part of the image */
    object-position: center center;
    background: #f3f4f6;
  }

  .game-info { padding: 1rem; }

  .game-info h3 { font-size: 1.3rem; margin: 0 0 0.5rem 0; color: #333; }

  .game-price { display: flex; gap: 0.5rem; align-items: center; margin: 0.5rem 0; }

  .current-price { font-size: 1.5rem; font-weight: bold; color: #48bb78; }

  .original-price { font-size: 1rem; text-decoration: line-through; color: #999; }

  .game-rating { display: flex; align-items: center; gap: 0.5rem; margin-top: 0.5rem; }

  .rating-badge { background: #667eea; color: white; padding: 4px 8px; border-radius: 4px; font-size: 0.85rem; }
</style>
