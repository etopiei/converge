<script setup lang="ts">
import CreateEvent from './components/CreateEvent.vue';
import ResultView from './components/ResultView.vue';
import GuestView from './components/GuestView.vue';

let renderResultView = false;
let guestCreationView = false;
let eventCreationView = false;

let event_uuid: string | null = "";

let params = new URLSearchParams(document.location.search);
if (params.has("event_uuid")) {
  event_uuid = params.get("event_uuid");
}

if (params.has("page") && params.get("page") === "results") {
  renderResultView = true;
} else if (event_uuid) {
  guestCreationView = true;
} else {
  eventCreationView = true;
}
</script>

<template>
  <h1>Converge</h1>
    <ResultView v-if="renderResultView" :eventUuid="event_uuid"/>
    <CreateEvent v-if="eventCreationView"/>
    <GuestView v-if="guestCreationView" :eventUuid="event_uuid"/>
</template>

<style scoped>
</style>
