<script setup lang="ts">
import { Ref, ref } from 'vue';
import VueDatePicker from '@vuepic/vue-datepicker';
import '@vuepic/vue-datepicker/dist/main.css';
import { createEvent } from '../api/api';

const dates: Ref<any[] | undefined> = ref();
const eventName = ref('');
const hostName = ref('');
const eventUuid = ref('');
const hostId = ref(0);
const loading = ref(false);
const copiedFlash = ref(false);

const LINK_BASE = "https://converge.etopiei.net/?event_uuid=";

const createEventFromData = async () => {
    if (eventName.value === '' || hostName.value === '' || dates.value === undefined) {
        // TODO: Show error message
        return;
    }

    const slots = dates.value.map(date => ({ "slot_type": "DAY", "slot_start": new Date(date)}));

    loading.value = true;
    const eventResponse = await createEvent({
        name: eventName.value,
        host_name: hostName.value,
        slots: slots,
    });

    eventUuid.value = eventResponse.event_uuid;
    hostId.value = eventResponse.host_id;
    loading.value = false;
};

const goToResponseSelectionPage = () => {
    window.location.href = `/?event_uuid=${eventUuid.value}&guest_id=${hostId.value}`;
};

const copyLink = async () => {
    await navigator.clipboard.writeText(LINK_BASE + eventUuid.value);
    copiedFlash.value = true;
    setTimeout(() => {
        copiedFlash.value = false;
    }, 1000);
};
</script>

<template>
    <div v-if="!eventUuid" class="create-form">
        <input type="text" placeholder="Event Name" v-model="eventName"></input>
        <input type="text" placeholder="Host Name" v-model="hostName"></input>
        <div class="date-picker-container">
            <VueDatePicker class="datepicker" placeholder="Choose Dates" v-model="dates" multi-dates :enable-time-picker="false"/>
        </div>
        <button @click="createEventFromData">Create</button>
    </div>
    <div v-else>
        <h4>Event Created!</h4>
        <p>Share the following link with your guests:</p>
        <p class=link-text>{{ LINK_BASE + eventUuid }}</p>
        <button :class="{ flashGreen: copiedFlash }" @click=copyLink>
            {{ copiedFlash ? "Copied ✅" : "Copy Link" }}
        </button>
        <p>
        Once you've shared the link, set your own availability:
        </p>
        <button @click="goToResponseSelectionPage">Set Responses</button>
    </div>
</template>

<style scoped>
.create-form {
    display: flex;
    flex-direction: column;
}
.create-form > input {
    padding: 8px;
}
.create-form > * {
    margin-top: 8px;
    margin-bottom: 8px;
}
.link-text {
    background-color: white;
    color: black;
    padding: 4px;
    font-size: 0.8em;
}
.flashGreen {
    background-color: #68ac52;
}
</style>
