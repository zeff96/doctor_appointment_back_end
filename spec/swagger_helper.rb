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
          # post: {
          #   summary: 'Create a new doctor',
          #   tags: ['Posts'],
          #   description: 'Creates a new doctor with the provided data.',
          #   requestBody: {
          #     required: true,
          #     content: {
          #       'application/json': {
          #         schema: {
          #           type: 'object',
          #           properties: {
          #             name: {
          #               type: 'string'
          #             },
          #             bio: {
          #               type: 'string',
          #               format: 'text'
          #             },
          #             image: {
          #               type: 'string',
          #               format: 'binary'
          #             },
          #             location_attributes: {
          #               type: 'object',
          #               properties: {
          #                 address: {
          #                   type: 'string'
          #                 },
          #                 city: {
          #                   type: 'string'
          #                 },
          #                 state: {
          #                   type: 'string'
          #                 },
          #                 zip_code: {
          #                   type: 'integer'
          #                 }
          #               }
          #             },
          #             payment_attributes: {
          #               type: 'object',
          #               properties: {
          #                 consultation_fee: {
          #                   type: 'decimal'
          #                 }
          #               }
          #             },
          #             social_medium_attributes: {
          #               type: 'object',
          #               properties: {
          #                 facebook: {
          #                   type: 'string'
          #                 },
          #                 twitter: {
          #                   type: 'string'
          #                 },
          #                 instagram: {
          #                   type: 'string'
          #                 }
          #               }
          #             }
          #           },
          #           required: ['name', 'bio', 'image', 'location_attributes', 'payment_attributes', 'social_media_attributes'] // Add any other required fields
          #         }
          #       }
          #     }
          #   },
          #   responses: {
          #     '201': {
          #       description: 'Post created successfully',
          #       content: {
          #         'application/json': {
          #           schema: {
          #             type: 'array',
          #             items: {
          #               '$ref': '#/components/schemas/Doctor'
          #             }
          #           }
          #         }
          #       }
          #     },
          #     '400': {
          #       description: 'Bad request - Invalid data',
          #       content: {
          #         'application/json': {
          #           schema: {
          #             type: 'object',
          #             properties: {
          #               error: {
          #                 type: 'string'
          #               }
          #             }
          #           }
          #         }
          #       }
          #     }
          #   }
          # }
        }
      },
      components: {
        schemas: {
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
                example: 12345
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
