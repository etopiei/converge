<script setup lang="ts">
import { Ref, onMounted, ref } from 'vue';
import { ResponseValue, SlotWithResponses, getEventData, registerGuest, sendResponses } from '../api/api';
import BigDate from './BigDate.vue';
import TapResponse from './TapResponse.vue';

const props = defineProps(['eventUuid'])

const guestName = ref('');
const guestId = ref(0);
const eventData = ref();
const slotData: Ref<Record<number, ResponseValue>> = ref({});

onMounted(async () => {
    if (props.eventUuid) {
        eventData.value = await getEventData(props.eventUuid);
        eventData.value.slots.forEach((slot: SlotWithResponses) => {
            let guestResponse: ResponseValue;
            let currentResponseForSlot = slot.responses.find(response => response.guest.id === guestId.value);
            if (currentResponseForSlot) {
                guestResponse = currentResponseForSlot.response;
            } else {
                guestResponse = "yes";
            }
            slotData.value[slot.id] = guestResponse;
        });
    }
    // TODO: Consider here if we should also get guest info, this way the 'login' field can be
    // auto-filled with valid guest names to avoid mistakes in spelling.
});

const createGuest = async () => {
    const response = await registerGuest(guestName.value, props.eventUuid);
    guestId.value = response.guest_id
};

const submit = async () => {
    const responses = Object.entries(slotData.value).map(([slotId, response]) => {
        return {
            slot_id: Number(slotId),
            response: response.toUpperCase() as ResponseValue,
        };
    });
    const guestResponses = { guest_id: guestId.value, responses };
    const response = await sendResponses(props.eventUuid, guestResponses);
    if (response.ok) {
        window.location.href = `${window.location.protocol}//${window.location.hostname}${(location.port ? ':'+location.port: '')}/?page=results&event_uuid=${props.eventUuid}`;
    }
};

const setYes = (slotId: number) => {
    console.log('Setting yes');
    slotData.value[slotId] = "yes";
};

const setMaybe = (slotId: number) => {
    console.log('Setting maybe');
    slotData.value[slotId]  = "maybe";
};

const setNo = (slotId: number) => {
    console.log('Setting no');
    slotData.value[slotId] = "no";
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
        <!-- TODO: Make buttons for select going/not going all
        -->
        <div class="slot-row" v-if="guestId && slotData && Object.keys(slotData).length === eventData.slots.length" v-for="slot in eventData.slots">
            <BigDate :date=slot.start />
            <TapResponse
                @yes="setYes(slot.id)"
                @no="setNo(slot.id)"
                @maybe="setMaybe(slot.id)"
                :response=slotData[slot.id]
                /> 
        </div>
        <button @click="submit">Submit Responses</button>
    </div>
</template>

<style scoped>
.slot-row {
    display: flex;
    gap: 16px;
    margin-top: 8px;
    margin-bottom: 8px;
}
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