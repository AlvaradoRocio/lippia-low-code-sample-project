Feature: Clokify Proyectos
  Background:
    Given base url $(env.base_url)
    And endpoint /v1/workspaces
    And header Content-Type = $(env.Content_Type)
    And header x-api-key = $(env.x_api_key)

  @GetAllProjectExitoso
  Scenario: GET all projects exitoso
    Given call Workspace.feature@GetWorkspaceInfo
    And endpoint /v1/workspaces/{{workspaceId}}/projects
    When execute method GET
    Then the status code should be 200

  @AddNewProject
  Scenario Outline: POST Add a new project
    Given call Workspace.feature@GetWorkspaceInfo
    And endpoint /v1/workspaces/{{workspaceId}}/projects
    And set value <nameProyecto> of key name in body jsons/bodies/NuevoProyecto.json
    When execute method POST
    Then the status code should be 201
    * define proyectoId = response.id
    * define workspaceId = {{workspaceId}}

    Examples:
      | nameProyecto |
      | NuevoProyecto 1 |

  @GetFindProjectById
  Scenario: GET Find project by ID
    Given call Project.feature@AddNewProject
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{proyectoId}}
    When execute method GET
    Then the status code should be 200

  @DeleteProjectFromWorkspaceBadRequest
  Scenario: Delete project from workspace bad request 400
    Given call Project.feature@GetFindProjectById
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{proyectoId}}
    When execute method DELETE
    Then the status code should be 400

  @DeleteProjectFromWorkspaceExitoso
  Scenario: Delete project from workspace exitoso
    Given call Project.feature@UpdateProjectOnWorkspace
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{proyectoId}}
    When execute method DELETE
    Then the status code should be 200

  @DeleteProjectFromWorkspaceNoAutorizado
  Scenario: Delete project from workspace no autorizado
    Given call Project.feature@GetFindProjectById
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{proyectoId}}
    When execute method DELETE
    Then the status code should be 401

  @DeleteProjectFromWorkspaceNoEncontrado
  Scenario: Delete project from workspace No encontrado
    Given call Project.feature@UpdateProjectOnWorkspace
    And endpoint /v1/workspaces/{{workspaceId}}/projectes/221
    When execute method DELETE
    Then the status code should be 404

  @UpdateProjectOnWorkspace
  Scenario Outline: UPDATE Project On Workspace
    Given call Project.feature@GetFindProjectById
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{proyectoId}}
    And set value <nameProyecto> of key name in body jsons/bodies/ModificacionProyecto.json
    When execute method PUT
    Then the status code should be 200
    Examples:
      |nameProyecto|
      |"Proyecto Prueba Por API"|

  #Estan restringidas las modificaciones
  @UpdateProjectUserCostRate
  Scenario: Update project template
    Given call Project.feature@AddNewProject
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{proyectoId}}/users/6618421303a7b573aff3c282/cost-rate
    And set value "2020-01-01T00:00:00Z" of key since in body jsons/bodies/ProjectUserCost.json
    When execute method PUT
    Then the status code should be 405
