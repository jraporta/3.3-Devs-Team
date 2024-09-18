db.createCollection('element', {
  validator: {
    $jsonSchema: {
      bsonType: 'object',
      title: 'element',
      required: ['type', 'name', 'quantity', 'price', 'status'],
      properties: {
        type: {
          enum: "room",
          "clue",
          "decor_item"
        },
        name: {
          bsonType: 'string'
        },
        quantity: {
          bsonType: 'int'
        },
        price: {
          bsonType: 'decimal'
        },
        status: {
          enum: "active",
          "deleted"
        },
        clue_theme: {
          enum: "scifi",
          "horror",
          "murder",
          "fantasy",
          "team-work",
          "family"
        },
        decor_material: {
          enum: 'wood',
          'metal',
          'glass',
          'cardboard',
          'paper',
          'fabric',
          'leather',
          'stone',
          'ceramic',
          'electronics',
          'resin',
          'rubber',
          'foam',
          'plastic',
          'other'
        },
        room_difficulty: {
          enum: "easy",
          "medium",
          "hard",
          "very hard"
        }
      }
    }
  }
});
db.createCollection('room', {
  validator: {
    $jsonSchema: {
      bsonType: 'object',
      title: 'room',
      required: ['difficulty'],
      properties: {
        difficulty: {
          enum: "easy",
          "medium",
          "hard",
          "very hard"
        },
        decor_item: {
          bsonType: 'array',
          items: {
            title: 'object',
            required: ['name', 'quantity', 'price', 'material'],
            properties: {
              name: {
                bsonType: 'string'
              },
              quantity: {
                bsonType: 'int'
              },
              price: {
                bsonType: 'decimal'
              },
              material: {
                enum: 'wood',
                'metal',
                'glass',
                'cardboard',
                'paper',
                'fabric',
                'leather',
                'stone',
                'ceramic',
                'electronics',
                'resin',
                'rubber',
                'foam',
                'plastic',
                'other'
              }
            }
          }
        },
        clue: {
          bsonType: 'array',
          items: {
            title: 'object',
            required: ['name', 'quantity', 'price', 'theme'],
            properties: {
              name: {
                bsonType: 'string'
              },
              quantity: {
                bsonType: 'int'
              },
              price: {
                bsonType: 'decimal'
              },
              theme: {
                enum: "scifi",
                "horror",
                "murder",
                "fantasy",
                "team-work",
                "family"
              }
            }
          }
        }
      }
    }
  }
});
db.createCollection('user', {
  validator: {
    $jsonSchema: {
      bsonType: 'object',
      title: 'user',
      required: ['name', 'email', 'password'],
      properties: {
        name: {
          bsonType: 'string'
        },
        email: {
          bsonType: 'string'
        },
        password: {
          bsonType: 'string'
        },
        reward: {
          bsonType: 'array',
          items: {
            title: 'object',
            required: ['name'],
            properties: {
              name: {
                bsonType: 'string'
              }
            }
          }
        },
        subscription: {
          bsonType: 'array',
          items: {
            title: 'object',
            required: ['type'],
            properties: {
              type: {
                enum: 'clues',
                'rooms'
              }
            }
          }
        },
        current_ticket: {
          bsonType: 'array',
          items: {
            title: 'object',
            required: ['date', 'price', 'session_total', 'player_count', 'session_used'],
            properties: {
              date: {
                bsonType: 'timestamp'
              },
              price: {
                bsonType: 'decimal'
              },
              session_total: {
                bsonType: 'int'
              },
              player_count: {
                bsonType: 'int'
              },
              session_used: {
                bsonType: 'int'
              }
            }
          }
        },
        session: {
          bsonType: 'array',
          items: {
            title: 'object',
            required: ['room_id', 'solved', 'date'],
            properties: {
              room_id: {
                bsonType: 'objectId'
              },
              solved: {
                bsonType: 'bool'
              },
              date: {
                bsonType: 'timestamp'
              }
            }
          }
        }
      }
    }
  }
});
db.createCollection('ticket', {
  validator: {
    $jsonSchema: {
      bsonType: 'object',
      title: 'ticket',
      required: ['date', 'price', 'session_total', 'player_count', 'session_used'],
      properties: {
        date: {
          bsonType: 'timestamp'
        },
        price: {
          bsonType: 'decimal'
        },
        session_total: {
          bsonType: 'int'
        },
        player_count: {
          bsonType: 'int'
        },
        session_used: {
          bsonType: 'int'
        }
      }
    }
  }
});
db.createCollection('subscription', {
  validator: {
    $jsonSchema: {
      bsonType: 'object',
      title: 'subscription',
      required: ['user_id', 'type'],
      properties: {
        user_id: {
          bsonType: 'objectId'
        },
        type: {
          enum: 'clues',
          'rooms'
        }
      }
    }
  }
});