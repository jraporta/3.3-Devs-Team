db.createCollection('subscription', {validator: {$jsonSchema: {bsonType: 'object',title: 'subscription',required: ['user_id','type'],properties:{user_id:{bsonType: 'objectId'},type:{enum: 'clues', 'rooms'}}}}});