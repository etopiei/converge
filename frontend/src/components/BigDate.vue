<script setup lang="ts">
const props = defineProps(['date']);

const monthConverter = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

const getMonth = (date: any) => {
    return monthConverter[new Date(date).getMonth()];
};

const getDate = (date: any) => {
    return new Date(date).getDate();
};
</script>

<template>
    <div v-if="props.date" class="date-container">
        <div>{{ getDate(props.date) }}</div>
        <div>{{ getMonth(props.date) }}</div>
    </div>
</template>

<style scoped>
.date-container {
    display: flex;
    flex-direction: column;
}
.date-container > * {
    font-size: 2em;
}
</style>