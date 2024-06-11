Feature: Clokify Task

   @AddNewtask
  Scenario: POST Add a new time
    Given call Project.feature@GetFindProjectById
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{proyectoId}}/tasks
    And header Content-Type = application/json
    And header x-api-key = ZDMxZjFmMmYtN2YyYy00MGMzLThjNDEtNGZiNzFmY2FkYWQy
    And set value "Bugfixing2" of key name in body jsons/bodies/NuevaTask.json
    When execute method POST
    Then the status code should be 201
     * define taskId = response.id

