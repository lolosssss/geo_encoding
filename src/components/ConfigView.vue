<script lang="ts">
export default {
  data() {
    return {
      selected: 0,
    };
  },
  mounted() {},
};
</script>

<template>
  <div>
    <div class="h-full w-full bg-white/80 flex flex-col p-8">
      <div class="w-full flex flex-row border-2 rounded-md border-sky-500">
        <div class="flex-1 border-r-2 border-sky-500">GeoJSON</div>
        <div class="flex-1 border-r-2 border-sky-500">S2</div>
        <div class="flex-1">H3</div>
      </div>
    </div>
  </div>
</template>

<style scoped></style>
