<script setup lang="ts">
import CreateEvent from './components/CreateEvent.vue';
import ResultView from './components/ResultView.vue';

let renderResultView = false;
let event_uuid: string | null = "";

let params = new URLSearchParams(document.location.search);
if (params.has("event_uuid")) {
  event_uuid = params.get("event_uuid");
}
if (params.has("page") && params.get("page") === "results") {
  renderResultView = true;
}
</script>

<template>
  <h1>Converge</h1>
    <ResultView v-if="renderResultView" :eventUuid="event_uuid"/>
    <CreateEvent v-if="!renderResultView"/>
</template>

<style scoped>
</style>
