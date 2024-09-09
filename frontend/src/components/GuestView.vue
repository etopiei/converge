<script setup lang="ts">
import { Ref, onMounted, ref } from 'vue';
import { ResponseValue, SlotWithResponses, getEventData, getGuestList, registerGuest, sendResponses } from '../api/api';
import BigDate from './BigDate.vue';
import TapResponse from './TapResponse.vue';

const props = defineProps(['eventUuid'])

const guestName = ref('');
const guestId = ref(0);
const guestError = ref('');
const eventData = ref();
const slotData: Ref<Record<number, ResponseValue>> = ref({});
const modeSelected = ref(false);
const mode = ref('');
const guestOptions: Ref<{text: string, value: string}[]> = ref([]);
const buttonClicked = ref(false);

onMounted(async () => {
    if (props.eventUuid) {
        eventData.value = await getEventData(props.eventUuid);
    }
});

const setSlotDataForGuest = () => {
    eventData.value.slots.forEach((slot: SlotWithResponses) => {
        let guestResponse: ResponseValue;
        let currentResponseForSlot = slot.responses.find(response => response.guest.id === Number(guestId.value));
        if (currentResponseForSlot) {
            guestResponse = currentResponseForSlot.response;
        } else {
            guestResponse = "yes";
        }
        slotData.value[slot.id] = guestResponse;
    });
};

const setButtonClicked = () => {
    buttonClicked.value = true;
    setSlotDataForGuest();
};

const setMode = async (newMode: string) => {
    mode.value = newMode;
    modeSelected.value = true;
    if (newMode === 'returnUser') {
        const response = await getGuestList(props.eventUuid);
        guestOptions.value = response.map(guest => ({text: guest.name, value:guest.id.toString()}));
    }
};

const createGuest = async () => {
    guestError.value = '';
    const response = await registerGuest(guestName.value, props.eventUuid);

    if ("message" in response) {
        guestError.value = "Name has already been used for this event.";
    } else {
        guestId.value = response.guest_id
        setButtonClicked();
    }
};

const submit = async () => {
    const responses = Object.entries(slotData.value).map(([slotId, response]) => {
        return {
            slot_id: Number(slotId),
            response: response.toUpperCase() as ResponseValue,
        };
    });
    const guestResponses = { guest_id: Number(guestId.value), responses };
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
    <div v-if="!guestId || !buttonClicked" class="guest-reg">
        <h3>Guest</h3>
        <p>You have been invited to
            <span :class="{eventName: eventData}">{{ eventData ? eventData.name : ' an event' }}</span>
            {{ eventData && ' by ' }}<span :class="{hostName: eventData}">{{ eventData && eventData.host_name }}</span>
        </p>
        <div v-if="!modeSelected">
            <button class="mode-select" @click="setMode('newUser')">Set Responses</button>
            <button class="mode-select" @click="setMode('returnUser')">Edit Responses</button>
        </div>
        <div v-if="modeSelected && mode === 'newUser'" class="input-container">
            <input :class="{ inError: guestError !== ''}" type="text" placeholder="Name" v-model="guestName">
            <p class="errorText" v-if="guestError"> {{ guestError }} </p>
            <button @click="createGuest">Select Days Available</button>
        </div>
        <div v-if="modeSelected && mode === 'returnUser'">
            <div class="input">
                Choose name
                <select v-model="guestId">
                    <option disabled :value="0">Select your name</option>
                    <option v-for="option in guestOptions" :value="option.value">
                        {{ option.text }}
                    </option>
                </select>
            </div>
            <button @click="setButtonClicked">Edit Days Available</button>
        </div>
    </div>
    <div v-else-if="buttonClicked" class="response-view">
        <button class="all-buttons yes" @click="selectAll(true)">Select 'Yes' For All</button>
        <button class="all-buttons no" @click="selectAll(false)">Select 'No' For All</button>
        <p>Click coloured tiles to change response.</p>
        <div class="slots">
            <div class="slot-row" v-if="guestId && slotData && Object.keys(slotData).length === eventData.slots.length" v-for="slot in eventData.slots">
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
    <a :href="`/?page=results&event_uuid=${props.eventUuid}`">Check responses</a>
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
.mode-select {
    margin-left: 4px;
    margin-right: 4px;
}
.input {
    margin-bottom: 8px;
}
.inError {
    border: 2px solid red;
}
.errorText {
    color: red;
}
.slots {
    display: flex;
    flex-direction: column;
    align-items: center;
}
.all-buttons {
    margin-left: 4px;
    margin-right: 4px;
}
.yes {
    background-color: #68ac52;
}
.no {
    background-color: red;
}
</style>