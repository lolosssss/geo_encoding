<script lang="ts">
export default {
  data() {
    return {
      selected: 0,
      tokens: '',
    };
  },
  mounted() {},
  methods: {
    load() {
      // emit selected and tokens
      this.$emit('load', {
        selected: this.selected,
        tokens: this.tokens,
      });
    },
  },
};
</script>

<template>
  <div>
    <div class="h-full w-full bg-white/80 flex flex-col p-8">
      <!-- Radio group for ['GeoJSON', 'S2', 'H3'] -->
      <div>
        <div class="flex justify-between">
          <div class="flex-1">
            <label class="block text-gray-700 text-sm font-bold mb-2">
              <input type="radio" name="layer" v-model="selected" :value="0" class="form-radio" />
              GeoJSON
            </label>
          </div>
          <div class="flex-1">
            <label class="block text-gray-700 text-sm font-bold mb-2">
              <input type="radio" name="layer" v-model="selected" :value="1" class="form-radio" />
              S2
            </label>
          </div>
          <div class="flex-1">
            <label class="block text-gray-700 text-sm font-bold mb-2">
              <input type="radio" name="layer" v-model="selected" :value="2" class="form-radio" />
              H3
            </label>
          </div>
        </div>
      </div>

      <div class="flex flex-col items-start">
        <div><label>Token</label></div>
        <input type="text" v-model="tokens" class="w-full" />
      </div>
      <div>
        <button class="rounded-md bg-sky-500 text-white px-4 py-2 mt-2" @click="load">Load Data</button>
      </div>
    </div>
  </div>
</template>

<style scoped></style>
