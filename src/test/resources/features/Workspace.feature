Feature: Clokify Workspace
  Background:
    Given base url $(env.base_url)
    And endpoint /v1/workspaces
    And header Content-Type = $(env.Content_Type)
    And header x-api-key = $(env.x_api_key)

  @AddNewWorkspace
  Scenario Outline: POST Workspace
    And set value <nameWorkspace> of key name in body jsons/bodies/NuevoWorkspace.json
    When execute method POST
    Then the status code should be 201
    And define workspaceId = response.id

    Examples:
      | nameWorkspace |
      | NuevoWorkspace 2 |

@GetWorkspaceInfo
  Scenario: GET Workspace info
  Given call Workspace.feature@AddNewWorkspace
  And endpoint /v1/workspaces/{{workspaceId}}
  When execute method GET
  Then the status code should be 200

