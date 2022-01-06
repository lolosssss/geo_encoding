<script lang="ts">
import { ref, defineComponent } from 'vue';
import { Deck } from '@deck.gl/core';
import { BitmapLayer } from '@deck.gl/layers';
import { S2Layer, TileLayer } from '@deck.gl/geo-layers';
import ConfigView from './ConfigView.vue';

export default {
  setup() {
    return {
      deck: null,
      viewState: ref({
        // 西湖区
        longitude: 120.142116,
        latitude: 30.245532,
        zoom: 12,
        bearing: 0,
        pitch: 0,
      }),
    };
  },
  mounted() {
    this.initMap();
  },
  methods: {
    initMap() {
      const tilelayer = new TileLayer({
        data: 'https://c.tile.openstreetmap.org/{z}/{x}/{y}.png',
        minZoom: 0,
        maxZoom: 26,
        tileSize: 256,
        renderSubLayers: (props) => {
          const {
            bbox: { west, south, east, north },
          } = props.tile;
          return new BitmapLayer(props, {
            data: null,
            image: props.data,
            bounds: [west, south, east, north],
          });
        },
      });
      this.deck = new Deck({
        canvas: 'map-container',
        width: '100%',
        height: '100%',
        initialViewState: this.viewState,
        controller: true,
        layers: [tilelayer],
      });
    },
  },
  components: {
    ConfigView,
  },
};
</script>

<template>
  <div>
    <canvas id="map-container" class="fixed inset-0"></canvas>
    <ConfigView class="h-full w-1/5 absolute top-0 right-0" />
  </div>
</template>

<style scoped>
a {
  color: #42b983;
}

label {
  margin: 0 0.5em;
  font-weight: bold;
}

code {
  background-color: #eee;
  padding: 2px 4px;
  border-radius: 4px;
  color: #304455;
}
</style>
