// Run once in mongosh against a fresh exercise database.
// These records are fictional events for the case study.
(async function () {
  db = db.getSiblingDB('portfolio_nosql');
  if ((await db.getCollectionNames()).includes("result_events")) {
    throw new Error('The exercise collection already exists. Use a fresh database.');
  }

  // The validator checks the stable event fields while details can vary.
  await db.createCollection("result_events", {
    validator: {
    "$jsonSchema": {
        "bsonType": "object",
        "required": [
            "_id",
            "schemaVersion",
            "simulation",
            "eventType",
            "occurredAt",
            "source",
            "embedded",
            "references",
            "details"
        ],
        "properties": {
            "_id": {
                "bsonType": "string",
                "minLength": 1
            },
            "schemaVersion": {
                "enum": [
                    1
                ]
            },
            "simulation": {
                "enum": [
                    true
                ]
            },
            "eventType": {
                "bsonType": "string",
                "enum": [
                    "enrollment_created",
                    "result_recorded"
                ]
            },
            "occurredAt": {
                "bsonType": "date"
            },
            "source": {
                "bsonType": "object",
                "required": [
                    "entity",
                    "key",
                    "snapshot"
                ],
                "properties": {
                    "entity": {
                        "enum": [
                            "result"
                        ]
                    },
                    "key": {
                        "bsonType": "object",
                        "required": [
                            "result_key"
                        ]
                    },
                    "snapshot": {
                        "bsonType": "object"
                    }
                }
            },
            "embedded": {
                "bsonType": "object"
            },
            "references": {
                "bsonType": "object"
            },
            "details": {
                "bsonType": "object"
            }
        }
    }
},
    validationLevel: 'strict', validationAction: 'error'
  });

  // Insert the four example events and show their IDs.
  printjson(await db.getCollection("result_events").insertMany([
    {
        "_id": "event_000001",
        "schemaVersion": 1,
        "simulation": true,
        "eventType": "enrollment_created",
        "occurredAt": ISODate("2030-01-01T10:00:00Z"),
        "source": {
            "entity": "result",
            "key": {
                "result_key": 401
            },
            "snapshot": {
                "result_key": 401,
                "enrollment_key": 301,
                "assessment_code": "MIDTERM",
                "score": 87.5,
                "recorded_at": "2026-10-15T14:30:00Z"
            }
        },
        "embedded": {},
        "references": {
            "student": [
                {
                    "key": {
                        "student_key": 101
                    },
                    "via": [
                        "result.enrollment_key → enrollment.student_key → student"
                    ]
                }
            ],
            "course": [
                {
                    "key": {
                        "course_key": 201
                    },
                    "via": [
                        "result.enrollment_key → enrollment.course_key → course"
                    ]
                }
            ],
            "enrollment": [
                {
                    "key": {
                        "enrollment_key": 301
                    },
                    "via": [
                        "result.enrollment_key → enrollment"
                    ]
                }
            ]
        },
        "details": {
            "channel": "web"
        }
    },
    {
        "_id": "event_000002",
        "schemaVersion": 1,
        "simulation": true,
        "eventType": "result_recorded",
        "occurredAt": ISODate("2030-01-01T10:01:00Z"),
        "source": {
            "entity": "result",
            "key": {
                "result_key": 401
            },
            "snapshot": {
                "result_key": 401,
                "enrollment_key": 301,
                "assessment_code": "MIDTERM",
                "score": 87.5,
                "recorded_at": "2026-10-15T14:30:00Z"
            }
        },
        "embedded": {},
        "references": {
            "student": [
                {
                    "key": {
                        "student_key": 101
                    },
                    "via": [
                        "result.enrollment_key → enrollment.student_key → student"
                    ]
                }
            ],
            "course": [
                {
                    "key": {
                        "course_key": 201
                    },
                    "via": [
                        "result.enrollment_key → enrollment.course_key → course"
                    ]
                }
            ],
            "enrollment": [
                {
                    "key": {
                        "enrollment_key": 301
                    },
                    "via": [
                        "result.enrollment_key → enrollment"
                    ]
                }
            ]
        },
        "details": {
            "channel": "mobile",
            "note": "Illustrative event-specific metadata",
            "examples": {
                "correction_reason": "illustrative correction_reason",
                "source_system": "illustrative source_system"
            }
        }
    },
    {
        "_id": "event_000003",
        "schemaVersion": 1,
        "simulation": true,
        "eventType": "enrollment_created",
        "occurredAt": ISODate("2030-01-01T10:02:00Z"),
        "source": {
            "entity": "result",
            "key": {
                "result_key": 402
            },
            "snapshot": {
                "result_key": 402,
                "enrollment_key": 302,
                "assessment_code": "FINAL",
                "score": 92,
                "recorded_at": "2026-11-03T09:15:00+00:00"
            }
        },
        "embedded": {},
        "references": {
            "student": [
                {
                    "key": {
                        "student_key": 102
                    },
                    "via": [
                        "result.enrollment_key → enrollment.student_key → student"
                    ]
                }
            ],
            "course": [
                {
                    "key": {
                        "course_key": 202
                    },
                    "via": [
                        "result.enrollment_key → enrollment.course_key → course"
                    ]
                }
            ],
            "enrollment": [
                {
                    "key": {
                        "enrollment_key": 302
                    },
                    "via": [
                        "result.enrollment_key → enrollment"
                    ]
                }
            ]
        },
        "details": {
            "channel": "web"
        }
    },
    {
        "_id": "event_000004",
        "schemaVersion": 1,
        "simulation": true,
        "eventType": "result_recorded",
        "occurredAt": ISODate("2030-01-01T10:03:00Z"),
        "source": {
            "entity": "result",
            "key": {
                "result_key": 402
            },
            "snapshot": {
                "result_key": 402,
                "enrollment_key": 302,
                "assessment_code": "FINAL",
                "score": 92,
                "recorded_at": "2026-11-03T09:15:00+00:00"
            }
        },
        "embedded": {},
        "references": {
            "student": [
                {
                    "key": {
                        "student_key": 102
                    },
                    "via": [
                        "result.enrollment_key → enrollment.student_key → student"
                    ]
                }
            ],
            "course": [
                {
                    "key": {
                        "course_key": 202
                    },
                    "via": [
                        "result.enrollment_key → enrollment.course_key → course"
                    ]
                }
            ],
            "enrollment": [
                {
                    "key": {
                        "enrollment_key": 302
                    },
                    "via": [
                        "result.enrollment_key → enrollment"
                    ]
                }
            ]
        },
        "details": {
            "channel": "mobile",
            "note": "Illustrative event-specific metadata",
            "examples": {
                "correction_reason": "illustrative correction_reason",
                "source_system": "illustrative source_system"
            }
        }
    }
]));
  await db.getCollection("result_events").createIndex({eventType: 1, occurredAt: -1}, {name: 'event_type_time'});

  // 1. Find the first sample event type (up to five documents).
  printjson(await db.getCollection("result_events").find({"eventType":"enrollment_created"}).sort({_id:1}).limit(5).toArray());

  // 2. Find events for the first source record using nested key fields (up to five).
  printjson(await db.getCollection("result_events").find({"source.key.result_key":401}).sort({_id:1}).limit(5).toArray());

  // 3. Find events in the sample time range using a MongoDB Date filter (up to five).
  printjson(await db.getCollection("result_events").find({"occurredAt":{"$gte":ISODate("2030-01-01T10:00:00Z"), "$lt":ISODate("2030-01-01T11:00:00Z")}}).sort({_id:1}).limit(5).toArray());

  // 4. Count documents for each event type.
  printjson(await db.getCollection("result_events").aggregate([{"$group":{"_id":"$eventType", "documentCount":{"$sum":1}}}, {"$sort":{"_id":1}}]).toArray());

  // A date stored as text should be rejected by the validator.
  try {
    await db.getCollection("result_events").insertOne({...{
    "_id": "event_000001",
    "schemaVersion": 1,
    "simulation": true,
    "eventType": "enrollment_created",
    "occurredAt": ISODate("2030-01-01T10:00:00Z"),
    "source": {
        "entity": "result",
        "key": {
            "result_key": 401
        },
        "snapshot": {
            "result_key": 401,
            "enrollment_key": 301,
            "assessment_code": "MIDTERM",
            "score": 87.5,
            "recorded_at": "2026-10-15T14:30:00Z"
        }
    },
    "embedded": {},
    "references": {
        "student": [
            {
                "key": {
                    "student_key": 101
                },
                "via": [
                    "result.enrollment_key → enrollment.student_key → student"
                ]
            }
        ],
        "course": [
            {
                "key": {
                    "course_key": 201
                },
                "via": [
                    "result.enrollment_key → enrollment.course_key → course"
                ]
            }
        ],
        "enrollment": [
            {
                "key": {
                    "enrollment_key": 301
                },
                "via": [
                    "result.enrollment_key → enrollment"
                ]
            }
        ]
    },
    "details": {
        "channel": "web"
    }
}, _id: 'invalid_date_example', occurredAt: 'not-a-date'});
  } catch (error) { print('Invalid date error: ' + error.code); }

  // Reusing an event ID should be rejected by the unique _id index.
  try { await db.getCollection("result_events").insertOne({
    "_id": "event_000001",
    "schemaVersion": 1,
    "simulation": true,
    "eventType": "enrollment_created",
    "occurredAt": ISODate("2030-01-01T10:00:00Z"),
    "source": {
        "entity": "result",
        "key": {
            "result_key": 401
        },
        "snapshot": {
            "result_key": 401,
            "enrollment_key": 301,
            "assessment_code": "MIDTERM",
            "score": 87.5,
            "recorded_at": "2026-10-15T14:30:00Z"
        }
    },
    "embedded": {},
    "references": {
        "student": [
            {
                "key": {
                    "student_key": 101
                },
                "via": [
                    "result.enrollment_key → enrollment.student_key → student"
                ]
            }
        ],
        "course": [
            {
                "key": {
                    "course_key": 201
                },
                "via": [
                    "result.enrollment_key → enrollment.course_key → course"
                ]
            }
        ],
        "enrollment": [
            {
                "key": {
                    "enrollment_key": 301
                },
                "via": [
                    "result.enrollment_key → enrollment"
                ]
            }
        ]
    },
    "details": {
        "channel": "web"
    }
}); }
  catch (error) { print('Duplicate ID error: ' + error.code); }

  print('Document count: ' + await db.getCollection("result_events").countDocuments());
})().catch(error => { print(error.stack || String(error)); quit(1); });
