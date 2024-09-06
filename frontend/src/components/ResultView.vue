<script setup lang="ts">
import { Ref, onMounted, ref } from 'vue';
import { getEventData, EventResponse } from '../api/api';
import Yes from './Yes.vue';
import No from './No.vue';
import Maybe from './Maybe.vue';

const eventData: Ref<EventResponse | null> = ref(null);
let props = defineProps(['eventUuid']);

onMounted(async () => {
    if (props.eventUuid) {
        eventData.value = await getEventData(props.eventUuid);
    }
});

const monthConverter = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
</script>

<template>
    <h2>Responses</h2>
    <div v-if="eventData">
        <h3>{{ eventData.name }}</h3>
        <div v-for="eSlot in eventData.slots">
            <details>
                <summary>
                    <div class="summary-content">
                        <span class="date-item">
                            {{ monthConverter[new Date(eSlot.start).getMonth()] }} {{ new Date(eSlot.start).getDate() }}
                        </span>
                        <!-- Summarise responses here -->
                        <Yes :count="eSlot.responses.filter((r: any) => r.response === 'yes').length"/>
                        <Maybe :count="eSlot.responses.filter((r: any) => r.response === 'maybe').length"/>
                        <No :count="eSlot.responses.filter((r: any) => r.response === 'no').length"/>
                    </div>
                </summary>
                <!-- Render details of who said what to the event here -->
                <div v-if="eSlot.responses.length > 0">
                    <p v-for="response in eSlot.responses">
                        {{ response.guest.name }} - {{ response.response }}
                    </p>
                </div>
                <div v-else>
                    No responses yet.
                </div>
            </details>
        </div>
    </div>
    <div v-else>
        ... Loading ...
    </div>
</template>

<style scoped>
details {
    margin-top: 8px;
    margin-bottom: 8px;
}
.summary-content {
    font-size: 1.2em;
    display: inline-flex;
    flex-direction: row;
    flex-wrap: nowrap;
}
.date-item {
    margin-right: 8px;
}
</style>