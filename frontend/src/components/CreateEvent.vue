<script setup lang="ts">
import { Ref, ref } from 'vue';
import VueDatePicker from '@vuepic/vue-datepicker';
import '@vuepic/vue-datepicker/dist/main.css';
import { createEvent } from '../api/api';

const dates: Ref<any[] | undefined> = ref();
const eventName = ref('');
const hostName = ref('');

const createEventFromData = async () => {
    if (eventName.value === '' || hostName.value === '' || dates.value === undefined) {
        // TODO: Show error message
        return;
    }

    const slots = dates.value.map(date => ({ "slot_type": "DAY", "slot_start": new Date(date)}));

    const eventResponse = await createEvent({
        name: eventName.value,
        host_name: hostName.value,
        slots: slots,
    });

    // TODO: Here store this in localStorage or something?
    // or maybe propogate this up somehow.
    console.log(eventResponse.event_uuid);
};
</script>

<template>
    <div class="create-form">
        <input type="text" placeholder="Event Name" v-model="eventName"></input>
        <input type="text" placeholder="Host Name" v-model="hostName"></input>
        <div class="date-picker-container">
            <VueDatePicker class="datepicker" placeholder="Choose Dates" v-model="dates" multi-dates />
        </div>
        <button @click="createEventFromData">Create</button>
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
</style>
