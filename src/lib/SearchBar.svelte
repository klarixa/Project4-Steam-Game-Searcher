<script>
  import { createEventDispatcher } from 'svelte';
  export let value = '';
  const dispatch = createEventDispatcher();

  function submit(e) {
    e.preventDefault();
    dispatch('search', value);
  }

  function clear() {
    value = '';
    dispatch('clear');
  }
</script>

<form class="search-form" on:submit|preventDefault={submit}>
  <input
    type="text"
    class="search-input"
    bind:value
    placeholder="Search for games..."
    aria-label="Search games"
  />
  <button type="submit" class="btn btn-primary">🔍 Search</button>
  <button type="button" class="btn btn-secondary" on:click={clear}>Clear</button>
</form>

<style>
  .search-form {
    display: flex;
    gap: 1rem;
    margin-bottom: 1rem;
    align-items: center;
  }

  .search-input {
    flex: 1;
    padding: 12px 16px;
    font-size: 1.1rem;
    border: 2px solid #e0e0e0;
    border-radius: 8px;
    transition: border-color 0.2s;
  }

  .search-input:focus {
    outline: none;
    border-color: #667eea;
  }

  .btn {
    padding: 12px 20px;
    border: none;
    border-radius: 8px;
    font-size: 1rem;
    font-weight: 600;
    cursor: pointer;
  }

  .btn-primary { background: #667eea; color: white; }
  .btn-secondary { background: #6c757d; color: white; }
</style>
