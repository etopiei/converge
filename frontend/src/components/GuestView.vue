<script setup lang="ts">
import { Ref, onMounted, ref } from 'vue';
import { getEventData, getGuestList, registerGuest } from '../api/api';

const props = defineProps(['eventUuid'])

const guestName = ref('');
const guestId = ref(0);
const guestError = ref('');
const eventData = ref();
const modeSelected = ref(false);
const mode = ref('');
const guestOptions: Ref<{text: string, value: string}[]> = ref([]);

onMounted(async () => {
    if (props.eventUuid) {
        eventData.value = await getEventData(props.eventUuid);
    }
});


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
        goToSelectView();
    }
};

const goToSelectView = () => {
    window.location.href = `/?event_uuid=${props.eventUuid}&guest_id=${guestId.value}`;
};

</script>

<template>
    <div class="guest-reg">
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
            <button @click="goToSelectView">Edit Days Available</button>
        </div>
    </div>
    <a :href="`/?page=results&event_uuid=${props.eventUuid}`">Check responses</a>
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
</style>