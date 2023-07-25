# We have to disable this linters check to enable api doc creation
# rubocop:disable Metrics/BlockLength
require 'rails_helper'

RSpec.configure do |config|
  config.swagger_root = Rails.root.join('swagger').to_s

  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'My Medical App API',
        version: 'v1',
        description: 'API documentation for managing doctors and appointments in My Medical App.'
      },
      servers: [
        {
          url: 'https://{defaultHost}',
          variables: {
            defaultHost: {
              default: 'www.example.com'
            }
          }
        }
      ],
      paths: {
        '/users': {
          get: {
            summary: 'Get all users',
            tags: [
              'Users'
            ],
            description: 'Returns a list of all users.',
            responses: {
              '200': {
                description: 'Successful operation',
                content: {
                  'application/json': {
                    schema: {
                      type: 'array',
                      items: {
                        '$ref': '#/components/schemas/User'
                      }
                    }
                  }
                }
              }
            }
          },
          post: {
            summary: 'Create a new user',
            tags: ['Users'],
            description: 'Creates a new user with the provided data.',
            requestBody: {
              required: true,
              content: {
                'application/json': {
                  schema: {
                    type: 'object',
                    properties: {
                      name: {
                        type: 'string'
                      },
                      email: {
                        type: 'string',
                        format: 'email'
                      },
                      password: {
                        type: 'string',
                        format: 'password'
                      }
                    },
                    required: %w[
                      name
                      email
                      password
                    ]
                  }
                }
              }
            },
            responses: {
              '201': {
                description: 'User created successfully',
                content: {
                  'application/json': {
                    schema: {
                      type: 'object',
                      items: {
                        '$ref': '#/components/schemas/User'
                      }
                    }
                  }
                }
              },
              '400': {
                description: 'Bad request',
                content: {
                  'application/json': {
                    schema: {
                      type: 'array',
                      items: {
                        '$ref': '#/components/schemas/UserError'
                      }
                    }
                  }
                }
              }
            }
          }
        },
        '/users/{id}': {
          get: {
            summary: 'Get a user by id',
            tags: [
              'Users'
            ],
            description: 'Returns a user by id.',
            parameters: [
              {
                name: 'id',
                in: 'path',
                required: true,
                description: 'User id',
                schema: {
                  type: 'integer'
                }
              }
            ],
            responses: {
              '200': {
                description: 'Successful operation',
                content: {
                  'application/json': {
                    schema: {
                      '$ref': '#/components/schemas/User'
                    }
                  }
                }
              }
            }
          },
          delete: {
            summary: 'Delete a user',
            tags: [
              'Users'
            ],
            description: 'Deletes a user.',
            parameters: [
              {
                name: 'id',
                in: 'path',
                required: true,
                description: 'User id',
                schema: {
                  type: 'integer'
                }
              }
            ],
            responses: {
              '204': {
                description: 'User deleted successfully'
              }
            }
          },
          put: {
            summary: 'Update a user',
            tags: [
              'Users'
            ],
            description: 'Updates a user.',
            parameters: [
              {
                name: 'id',
                in: 'path',
                required: true,
                description: 'User id',
                schema: {
                  type: 'integer'
                }
              }
            ]
          }
        },
        '/doctors': {
          get: {
            summary: 'Get all doctors',
            tags: [
              'Doctors'
            ],
            description: 'Returns a list of all doctors.',
            responses: {
              '200': {
                description: 'Successful operation',
                content: {
                  'application/json': {
                    schema: {
                      type: 'array',
                      items: {
                        '$ref': '#/components/schemas/Doctor'
                      }
                    }
                  }
                }
              }
            }
          },
          post: {
            summary: 'Create a new doctor',
            tags: ['Doctors'],
            description: 'Creates a new doctor with the provided data.',
            requestBody: {
              required: true,
              content: {
                'application/json': {
                  schema: {
                    type: 'object',
                    properties: {
                      name: {
                        type: 'string'
                      },
                      bio: {
                        type: 'string',
                        format: 'text'
                      },
                      image: {
                        type: 'string',
                        format: 'binary'
                      },
                      location_attributes: {
                        type: 'object',
                        properties: {
                          address: {
                            type: 'string'
                          },
                          city: {
                            type: 'string'
                          },
                          state: {
                            type: 'string'
                          },
                          zip_code: {
                            type: 'integer'
                          }
                        }
                      },
                      payment_attributes: {
                        type: 'object',
                        properties: {
                          consultation_fee: {
                            type: 'number',
                            format: 'float'
                          }
                        }
                      },
                      social_medium_attributes: {
                        type: 'object',
                        properties: {
                          facebook: {
                            type: 'string'
                          },
                          twitter: {
                            type: 'string'
                          },
                          instagram: {
                            type: 'string'
                          }
                        }
                      }
                    },
                    required: %w[name bio image location_attributes payment_attributes
                                 social_medim_attributes]
                  }
                }
              }
            },
            responses: {
              '201': {
                description: 'Doctor created successfully',
                content: {
                  'application/json': {
                    schema: {
                      type: 'array',
                      items: {
                        '$ref': '#/components/schemas/Doctor'
                      }
                    }
                  }
                }
              },
              '400': {
                description: 'Bad request - Invalid data',
                content: {
                  'application/json': {
                    schema: {
                      type: 'object',
                      properties: {
                        error: {
                          type: 'string'
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        },
        '/doctors/{id}': {
          get: {
            summary: 'Get a doctor by ID',
            tags: ['Doctors'],
            description: 'Retrieves a doctor by ID',
            parameters: [
              {
                name: 'id',
                in: 'path',
                required: true,
                description: 'Doctor ID',
                schema: {
                  type: 'integer'
                }
              }
            ],
            responses: {
              '200': {
                description: 'Successful operation',
                content: {
                  'application/json': {
                    schema: {
                      '$ref': '#/components/schemas/Doctor'
                    }
                  }
                }
              }
            }
          },

          delete: {
            summary: ['Delete a doctor by id'],
            tags: ['Doctors'],
            description: 'Deletes a doctor by id',
            parameters: [
              {
                name: 'id',
                in: 'path',
                required: true,
                description: 'Doctor ID',
                schema: {
                  type: 'integer'
                }
              }
            ],
            responses: {
              '204': {
                description: 'Doctor deleted successfully'
              }
            }
          }
        },
        '/doctors/{id}/appointments': {
          get: {
            summary: 'Get all appoitments for a given doctor',
            tags: ['Appointments'],
            description: 'Retrieves list of all appointments for a given doctor',
            parameters: [
              {
                name: 'id',
                in: 'path',
                required: true,
                description: 'Doctor ID',
                schema: {
                  type: 'integer'
                }
              }
            ],
            responses: {
              '200': {
                description: 'Successful operation',
                content: {
                  'application/json': {
                    schema: {
                      type: 'array',
                      items: {
                        '$ref': '#/components/schemas/Appointment'
                      }
                    }
                  }
                }
              }
            }
          },
          post: {
            summary: 'Creates a new appointment for a specific doctor',
            tags: ['Appointments'],
            description: ['Creates a new appointment for a specific doctor'],
            parameters: [
              {
                name: 'id',
                in: 'path',
                required: true,
                description: 'Doctor ID',
                schema: {
                  type: 'integer'
                }
              }
            ],
            requestBody: {
              required: true,
              content: {
                'application/json': {
                  schema: {
                    type: 'object',
                    properties: {
                      date: {
                        type: 'string',
                        format: 'date'
                      }
                    },
                    required: ['date']
                  }
                }
              }
            },
            responses: {
              '201': {
                'application/json': {
                  description: 'Created successfully',
                  content: {
                    schema: {
                      type: 'array',
                      items: {
                        '$ref': '#/components/schemas/Appointment'
                      }
                    }
                  }
                }
              },
              '400': {
                description: 'Bad request Invalid-data',
                content: {
                  'application/json': {
                    schema: {
                      type: 'object',
                      properties: {
                        error: {
                          type: 'string'
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        },
        '/doctors/{doctor_id}/appointments/{appointment_id}': {
          delete: {
            summary: 'Delete appointment by ID',
            tags: ['Appointments'],
            description: 'Deletes aappointment by a given ID',
            parameters: [
              {
                name: 'doctor_id',
                in: 'path',
                required: true,
                description: 'Doctor ID',
                schema: {
                  type: 'integer'
                }
              },
              {
                name: 'appointment_id',
                in: 'path',
                required: true,
                description: 'Appointment ID',
                schema: {
                  type: 'integer'
                }
              }
            ],
            responses: {
              '204': {
                description: 'Deleted successfully'
              }
            }
          }
        }
      },
      components: {
        schemas: {
          User: {
            type: 'object',
            properties: {
              name: {
                type: 'string',
                example: 'John Doe'
              },
              email: {
                type: 'string',
                format: 'email'
              },
              password: {
                type: 'string',
                format: 'password'
              }
            }
          },
          UserInput: {
            type: 'object',
            properties: {
              name: {
                type: 'string',
                example: 'John Doe'
              },
              email: {
                type: 'string',
                format: 'email'
              },
              password: {
                type: 'string',
                format: 'password'
              }
            }
          },
          Appointment: {
            type: 'object',
            properties: {
              date: {
                type: 'string',
                format: 'date'
              },
              city: {
                type: 'string',
                description: 'New York'
              }
            }
          },
          AppointmentInput: {
            type: 'object',
            properties: {
              date: {
                type: 'string',
                format: 'date'
              },
              city: {
                type: 'string',
                description: 'New York'
              }
            }
          },
          Doctor: {
            type: 'object',
            properties: {
              id: {
                type: 'integer'
              },
              name: {
                type: 'string'
              },
              bio: {
                type: 'string'
              },
              image: {
                type: 'string'
              },
              location_attributes: {
                '$ref': '#/components/schemas/Location'
              },
              social_medium_attributes: {
                '$ref': '#/components/schemas/SocialMedium'
              },
              payment_attributes: {
                '$ref': '#/components/schemas/Payment'
              }
            }
          },
          DoctorInput: {
            type: 'object',
            properties: {
              name: {
                type: 'string',
                example: 'John Doe'
              },
              bio: {
                type: 'string',
                example: 'Experienced doctor with specialization in Cardiology'
              },
              image: {
                type: 'string',
                format: 'binary'
              },
              location_attributes: {
                '$ref': '#/components/schemas/LocationInput'
              },
              social_medium_attributes: {
                '$ref': '#/components/schemas/SocialMediumInput'
              },
              payment_attributes: {
                '$ref': '#/components/schemas/PaymentInput'
              }
            }
          },
          Location: {
            type: 'object',
            properties: {
              address: {
                type: 'string'
              },
              city: {
                type: 'string'
              },
              state: {
                type: 'string'
              },
              zip_code: {
                type: 'integer'
              }
            }
          },
          LocationInput: {
            type: 'object',
            properties: {
              address: {
                type: 'string',
                example: '123 Main St'
              },
              city: {
                type: 'string',
                example: 'New York'
              },
              state: {
                type: 'string',
                example: 'NY'
              },
              zip_code: {
                type: 'integer',
                example: 12_345
              }
            }
          },
          SocialMedium: {
            type: 'object',
            properties: {
              facebook: {
                type: 'string'
              },
              twitter: {
                type: 'string'
              },
              instagram: {
                type: 'string'
              }
            }
          },
          SocialMediumInput: {
            type: 'object',
            properties: {
              facebook: {
                type: 'string',
                example: 'https://facebook.com/doctorspage'
              },
              twitter: {
                type: 'string',
                example: 'https://twitter.com/doctorspage'
              },
              instagram: {
                type: 'string',
                example: 'https://instagram.com/doctorspage'
              }
            }
          },
          Payment: {
            type: 'object',
            properties: {
              consultation_fee: {
                type: 'number',
                format: 'float'
              }
            }
          },
          PaymentInput: {
            type: 'object',
            properties: {
              consultation_fee: {
                type: 'number',
                format: 'float',
                example: 150.0
              }
            }
          }
        }
      }
    }
  }

  config.swagger_format = :yaml
end
# rubocop:enable Metrics/BlockLength
