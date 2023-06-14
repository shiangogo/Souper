<template>
  <div>
    <h1>{{ title }}</h1>
    <input
      type="text"
      class="title-input"
      v-model="title"
      placeholder="Title"
    />
    <input
      type="text"
      class="body-input"
      v-model="description"
      placeholder="Description"
    />
    <input
      type="text"
      class="body-input"
      v-model="wholeStory"
      placeholder="Whole story"
    />
    <label
      >難度：<input type="number" v-model="difficulty" min="1" max="3"
    /></label>
    <button v-if="isEditing" @click="updateGame">Update</button>
    <button v-if="isEditing" @click="cancelEdit">Cancel</button>
    <button v-else @click="createGame">Create</button>

    <div v-for="game in games" :key="game.id">
      <div>
        <h2>[{{ game.id }}] 標題： {{ game.title }}</h2>
        <p>故事片段：{{ game.description }}</p>
        <p>完整故事：{{ game.whole_story }}</p>

        <button @click="updateGame(game.id)">Edit this game</button>
        <button @click="deleteGame(game.id, game.title)">
          Delete this game
        </button>
      </div>
    </div>
  </div>
</template>

<script>
// import { ref, onMounted } from "vue";
export default {
  name: "Games",
  data() {
    return {
      games: [],
      title: "",
      description: "",
      wholeStory: "",
      difficulty: 0,
      isEditing: false,
      API_URL: "http://localhost:3000/games",
    };
  },
  methods: {
    async updateGame() {
      return true;
    },

    cancelEdit() {
      return true;
    },
    async deleteGame(id, title) {
      if (confirm(`你確定要刪除「${title}」嗎？`)) {
        await fetch(`${this.API_URL}/${id}`, {
          method: "DELETE",
        });
        this.games = this.games.filter((game) => {
          return game.id !== id;
        });
      }
    },
    async createGame() {
      const response = await fetch(this.API_URL, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          title: this.title,
          description: this.description,
          whole_story: this.wholeStory,
          difficulty: this.difficulty,
        }),
      });

      const data = await response.json();
      this.games.push(data);

      this.title = "";
      this.description = "";
      this.wholeStory = "";
    },
  },
  async mounted() {
    const response = await fetch(this.API_URL);
    this.games = await response.json();
  },
};
</script>

<style scoped>
.title-input {
  width: 100%;
  padding: 12px 20px;
  margin: 8px 0;
  box-sizing: border-box;
  bottom: -2px solid #ccc;
  background-color: #f8f8f8;
  color: #111;
  border-radius: 4px;
  resize: vertical;
}

.body-input {
  width: 100%;
  padding: 12px 20px;
  margin: 8px 0;
  box-sizing: border-box;
  bottom: -2px solid #ccc;
  background-color: #f8f8f8;
  color: #111;
  border-radius: 4px;
  resize: vertical;
}
</style>
