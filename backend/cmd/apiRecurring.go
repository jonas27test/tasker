package main

import (
	"encoding/json"
	"log"
	"net/http"
)

type Recurrings struct {
	ID                string
	RecurringPurpose  []Recurring `json:"recurringPurpose"`
	RecurringPleasure []Recurring `json:"recurringPleasure"`
}

func (c *Controller) getRecurring(w http.ResponseWriter, r *http.Request) {
	user := c.verifyJWT(r.Header.Get("Authorization"))
	coll := Collection{Coll: c.collection(user)}
	rec, err := json.Marshal(coll.getRecurrings())
	if err != nil {
		log.Panicln(err)
	}
	w.Write(rec)
}

func (c *Controller) setRecurringPurpose(w http.ResponseWriter, r *http.Request) {
	user := c.verifyJWT(r.Header.Get("Authorization"))
	tasks := unmarshalRecurring(w, r)
	coll := Collection{Coll: c.collection(user)}
	coll.setRecurringPurpose(tasks)
}

func (c *Controller) setRecurringPleasure(w http.ResponseWriter, r *http.Request) {
	user := c.verifyJWT(r.Header.Get("Authorization"))
	tasks := unmarshalRecurring(w, r)
	coll := Collection{Coll: c.collection(user)}
	coll.setRecurringPleasure(tasks)
}

func unmarshalRecurring(w http.ResponseWriter, r *http.Request) []Recurring {
	var t []Recurring
	err := json.NewDecoder(r.Body).Decode(&t)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		log.Println(err)
		return []Recurring{}
	}
	return t
}
