<script setup lang="ts">
import { onMounted, ref } from 'vue';
import { getEventData, registerGuest } from '../api/api';

const props = defineProps(['eventUuid'])

const guestName = ref('');
const guestId = ref(0);
const eventData = ref();

onMounted(async () => {
    if (props.eventUuid) {
        eventData.value = await getEventData(props.eventUuid);
    }
});

const createGuest = async () => {
    const response = await registerGuest(guestName.value, props.eventUuid);
    guestId.value = response.guest_id
};
</script>

<template>
    <div v-if="!guestId" class="guest-reg">
        <h3>Guest</h3>
        <p>You have been invited to
            <span :class="{eventName: eventData}">{{ eventData ? eventData.name : ' an event' }}</span>
            {{ eventData && ' by ' }}<span :class="{hostName: eventData}">{{ eventData && eventData.host_name }}</span>
        </p>
        <div class="input-container">
            <input type="text" placeholder="Name" v-model="guestName">
            <button @click="createGuest">Select Days Available</button>
        </div>
    </div>
    <div v-else class="response-view">
        <!-- TODO: Loop through event info here to build responses -->
        Event Info Here
    </div>
</template>

<style scoped>
.input-container {
    display: inline-flex;
    flex-direction: column;
}
.input-container input {
    padding: 8px;
    margin-bottom: 8px;
}
.eventName {
    color: #cfacf2;
}
.hostName {
    color: #ff7fe5;;
}
</style>