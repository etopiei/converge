type Slot = {
    slot_type: string,
    slot_start: Date
};

export type ResponseValue = "yes" | "no" | "maybe";

type Response = {
    response: ResponseValue
    guest: {
        name: string
        id: number
    }
};

export type SlotWithResponses = {
    id: number,
    type: string,
    start: Date,
    responses: Response[]
};

type EventData = {
    name: string,
    host_name: string,
    slots: Slot[],
};

type EventCreateResponse = {
    name: string,
    host_name: string,
    event_uuid: string
};

type GuestCreateResponse = {
    guest_id: number
};

export type EventResponse = {
    name: string,
    host_name: string,
    slots: SlotWithResponses[]
};

type CreateResponse = {
    response: ResponseValue,
    slot_id: number
};

type GuestResponses = {
    guest_id: number,
    responses: CreateResponse[]
};

type OkResponse = {
    ok: true
};

const API_BASE = "http://localhost:3000"

export const createEvent: (eventData: EventData) => Promise<EventCreateResponse> = async (eventData: EventData) => {
    const response = await fetch(API_BASE + "/api/events", {method: "POST", headers: {"Content-Type": "application/json"}, body: JSON.stringify(eventData)});
    return await response.json();
};

export const registerGuest: (guestName: string, eventUuid: string) => Promise<GuestCreateResponse> = async (guestName: string, eventUuid: string) => {
    const response = await fetch(API_BASE + `/api/events/${eventUuid}/guest/`, {method: "POST", headers: {"Content-Type": "application/json"}, body: JSON.stringify({name: guestName})});
    return await response.json();
};

export const getEventData: (eventUuid: string) => Promise<EventResponse> = async (eventUuid: string) => {
    const response = await fetch(API_BASE + `/api/events/${eventUuid}`);
    return await response.json();
};

export const sendResponses: (eventUuid: string, guestResponses: GuestResponses) => Promise<OkResponse> = async (eventUuid: string, guestResponses: GuestResponses) => {
    const response = await fetch(API_BASE + `/api/events/${eventUuid}/responses`, {method: "POST", headers: {"Content-Type": "application/json"}, body: JSON.stringify(guestResponses)});
    return await response.json();
};