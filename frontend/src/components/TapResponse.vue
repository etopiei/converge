<script setup lang="ts">
import { computed } from 'vue';

const props = defineProps(['response']);
const emit = defineEmits(['yes', 'maybe', 'no'])

const isGreen = computed(() => props.response == "yes");
const isOrange = computed(() => props.response == "maybe");
const isRed = computed(() => props.response == "no");

const emitEvent = () => {
    if (isGreen.value) {
        emit('maybe');
        return;
    }

    if (isOrange.value) {
        emit('no');
        return;
    }

    if (isRed.value) {
        emit('yes');
        return;
    }

};
</script>

<template>
    <div v-if="props.response" @click="emitEvent" :class="{ green: isGreen, orange: isOrange, red: isRed }">
        <span v-if="isGreen">Yes</span>
        <span v-if="isOrange">Maybe</span>
        <span v-if="isRed">No</span>
    </div>
</template>

<style scoped>
div {
    min-width: 120px;
    display: flex;
    justify-content: center;
    align-items: center;
}
span {
    user-select: none;
}
.green {
    background-color: #68ac52;
}
.orange {
    background-color: orange;
}
.red {
    background-color: red;
}
</style>