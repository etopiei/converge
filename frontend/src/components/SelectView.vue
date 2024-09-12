<script setup lang="ts">
import BigDate from './BigDate.vue';
import TapResponse from './TapResponse.vue';
import { sendResponses, ResponseValue, getEventData, SlotWithResponses } from '../api/api';
import { Ref, onMounted, ref } from 'vue';

const props = defineProps(['eventUuid', 'guestId'])

const eventData = ref();
const slotData: Ref<Record<number, ResponseValue>> = ref({});

onMounted(async () => {
    if (props.eventUuid) {
        eventData.value = await getEventData(props.eventUuid);
        setSlotDataForGuest();
    }
});

const setSlotDataForGuest = () => {
    eventData.value.slots.forEach((slot: SlotWithResponses) => {
        let guestResponse: ResponseValue;
        let currentResponseForSlot = slot.responses.find(response => response.guest.id === Number(props.guestId));
        if (currentResponseForSlot) {
            guestResponse = currentResponseForSlot.response;
        } else {
            guestResponse = "yes";
        }
        slotData.value[slot.id] = guestResponse;
    });
};

const submit = async () => {
    const responses = Object.entries(slotData.value).map(([slotId, response]) => {
        return {
            slot_id: Number(slotId),
            response: response.toUpperCase() as ResponseValue,
        };
    });
    const guestResponses = { guest_id: Number(props.guestId), responses };
    const response = await sendResponses(props.eventUuid, guestResponses);
    if (response.ok) {
        window.location.href = `${window.location.protocol}//${window.location.hostname}${(location.port ? ':'+location.port: '')}/?page=results&event_uuid=${props.eventUuid}`;
    }
};

const setYes = (slotId: number) => {
    slotData.value[slotId] = "yes";
};

const setMaybe = (slotId: number) => {
    slotData.value[slotId]  = "maybe";
};

const setNo = (slotId: number) => {
    slotData.value[slotId] = "no";
};

const selectAll = (going: boolean) => {
    const funcToCall = going ? setYes : setNo;
    Object.keys(slotData.value).forEach(slotId => funcToCall(Number(slotId)));
};
</script>

<template>
    <div v-if="eventData">
        <button class="all-buttons yes" @click="selectAll(true)">Select 'Yes' For All</button>
        <button class="all-buttons no" @click="selectAll(false)">Select 'No' For All</button>
        <p>Click coloured tiles to change response.</p>
        <div class="slots">
            <div class="slot-row" v-if="props.guestId && slotData && Object.keys(slotData).length === eventData.slots.length" v-for="slot in eventData.slots">
                <BigDate :date=slot.start />
                <TapResponse
                    @yes="setYes(slot.id)"
                    @no="setNo(slot.id)"
                    @maybe="setMaybe(slot.id)"
                    :response=slotData[slot.id]
                    /> 
            </div>
        </div>
        <button @click="submit">Submit Responses</button>
    </div>
    <div v-else>
        ... Loading ...
    </div>
</template>

<style scoped>
.slot-row {
    display: flex;
    gap: 16px;
    margin-top: 8px;
    margin-bottom: 8px;
}
.all-buttons {
    margin: 4px;
}
.yes {
    background-color: #68ac52;
}
.no {
    background-color: red;
}
.slots {
    display: flex;
    flex-direction: column;
    align-items: center;
}
</style>