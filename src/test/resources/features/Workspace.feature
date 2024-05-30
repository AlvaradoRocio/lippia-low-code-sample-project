@ -0,0 +1,46 @@
Feature: Clokify Workspace
  Background:
    Given base url https://api.clockify.me/api
    And endpoint /v1/workspaces
    And header Content-Type = application/json
    And header x-api-key = ZDMxZjFmMmYtN2YyYy00MGMzLThjNDEtNGZiNzFmY2FkYWQy

  @AddNewWorkspace
  Scenario Outline: POST Workspace
    And set value nameWorkspace of key name in body jsons/bodies/NuevoWorkspace.json
    When execute method POST
    Then the status code should be 201
    And define workspaceId = response.id

    Examples:
      | nameWorkspace |
      | NuevoWorkspace 2 |

@GetWorkspaceInfo
  Scenario: GET Workspace info
  Given call Workspace.feature@AddNewWorkspace
  And base url https://api.clockify.me/api
  And endpoint /v1/workspaces/{{workspaceId}}
  And header Content-Type = application/json
  And header x-api-key = ZDMxZjFmMmYtN2YyYy00MGMzLThjNDEtNGZiNzFmY2FkYWQy
  When execute method GET
  Then the status code should be 200

