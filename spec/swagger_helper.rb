require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
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
          #             social_media_attributes: {
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
              social_media_attributes: {
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
              social_media_attributes: {
                '$ref': '#/components/schemas/SocialMediumInput'
              },
              payment_attributes: {
                '$ref': '#/components/schemas/PaymentInput'
              }
            }
          },
        }
      }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end
