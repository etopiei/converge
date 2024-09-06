<script setup lang="ts">
const props = defineProps(['count'])
</script>

<template>
    <div v-if="props.count > 0">
        🔴 {{ props.count }}
    </div>
</template>