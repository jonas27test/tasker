package main

import (
	"context"
	"log"

	"go.mongodb.org/mongo-driver/bson"
)

type Recurring struct {
	Name string `json:"name"`
	Mon  bool   `json:"mon"`
	Tue  bool   `json:"tue"`
	Wed  bool   `json:"wed"`
	Thu  bool   `json:"thu"`
	Fri  bool   `json:"fri"`
	Sat  bool   `json:"sat"`
	Sun  bool   `json:"sun"`
}

// sets the pleasureList for the the day
func (coll *Collection) setRecurringPleasure(recurringPleasure []Recurring) {
	coll.getRecurrings()
	filter := bson.D{{"id", "recurrings"}}
	var err error
	_, err = coll.Coll.UpdateOne(context.Background(), filter, bson.M{"$set": bson.M{"recurringPleasure": recurringPleasure}})
	if err != nil {
		log.Println(err)
	}
}

// sets the pleasureList for the the day
func (coll *Collection) setRecurringPurpose(recurringPurpose []Recurring) {
	coll.getRecurrings()
	filter := bson.D{{"id", "recurrings"}}
	var err error
	_, err = coll.Coll.UpdateOne(context.Background(), filter, bson.M{"$set": bson.M{"recurringPurpose": recurringPurpose}})
	if err != nil {
		log.Println(err)
	}
}

func (coll *Collection) getRecurrings() Recurrings {
	log.Println("getRecurrings")
	filter := bson.D{{"id", "recurrings"}}
	var r Recurrings
	err := coll.Coll.FindOne(context.TODO(), filter).Decode(&r)
	if err != nil {
		log.Println(err)
		// Error if no document found
		r := Recurrings{ID: "recurrings"}
		_, err = coll.Coll.InsertOne(context.Background(), r)
		if err != nil {
			log.Println(err)
		}
		if r.RecurringPleasure == nil {
			r.RecurringPleasure = []Recurring{}
		}
		if r.RecurringPurpose == nil {
			r.RecurringPurpose = []Recurring{}
		}
		return r
	}
	if r.RecurringPleasure == nil {
		r.RecurringPleasure = []Recurring{}
	}
	if r.RecurringPurpose == nil {
		r.RecurringPurpose = []Recurring{}
	}
	return r
}
