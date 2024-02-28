return {
  settings = {
    yaml = {
      schemaStore = {
        enable = false,
        url = "",
      },
      schemas = require("schemastore").yaml.schemas({
        replace = {
          ["openapi.json"] = {
            description = "A Open API documentation files",
            fileMatch = { "openapi.json", "openapi.yml", "openapi.yaml" },
            name = "openapi.json",
            url = "https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.0/schema.json",
            versions = {
              ["3.0"] = "https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.0/schema.json",
              ["3.1"] = "https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"
            }
          },
        }
      }),
    },
  },
}
