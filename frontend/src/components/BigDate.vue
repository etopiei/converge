<script setup lang="ts">
const props = defineProps(['date']);

const monthConverter = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

const dayIndexMap = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];

const getMonth = (date: any) => {
    return monthConverter[new Date(date).getMonth()];
};

const getDate = (date: any) => {
    return new Date(date).getDate();
};
</script>

<template>
    <div v-if="props.date" class="date-container">
        <div class="day-name">{{ dayIndexMap[new Date(props.date).getDay()] }}</div>
        <div>{{ getDate(props.date) }} {{ getMonth(props.date) }}</div>
    </div>
</template>

<style scoped>
.date-container {
    display: flex;
    flex-direction: column;
    justify-content: center;
    height: 6em;
    width: 100px;
}
.date-container > * {
    font-size: 1.2em;
}
.day-name {
    font-size: 0.8em;
}
</style>