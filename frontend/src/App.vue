<script setup lang="ts">
import CreateEvent from './components/CreateEvent.vue';
import GuestView from './components/GuestView.vue';
import ResultView from './components/ResultView.vue';
import SelectView from './components/SelectView.vue';

let renderResultView = false;
let guestCreationView = false;
let eventCreationView = false;
let selectView = false;

let event_uuid: string | null = "";
let guest_id: string | null = "";

let params = new URLSearchParams(document.location.search);
if (params.has("event_uuid")) {
  event_uuid = params.get("event_uuid");
}

if (params.has("guest_id")) {
  guest_id = params.get("guest_id");
}

if (params.has("page") && params.get("page") === "results") {
  renderResultView = true;
} else if (event_uuid && guest_id) {
  selectView = true;
} else if (event_uuid) {
  guestCreationView = true;
} else {
  eventCreationView = true;
}
</script>

<template>
  <h1>Converge</h1>
    <p class="tag">Find the best day to host your event</p>
    <hr>
    <ResultView v-if="renderResultView" :eventUuid="event_uuid"/>
    <CreateEvent v-if="eventCreationView"/>
    <GuestView v-if="guestCreationView" :eventUuid="event_uuid"/>
    <SelectView v-if="selectView" :eventUuid="event_uuid" :guestId="guest_id"/>
</template>

<style scoped>
.tag {
  font-style: italic;
}
</style>
