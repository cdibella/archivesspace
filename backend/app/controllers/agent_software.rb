class ArchivesSpaceService < Sinatra::Base

  Endpoint.post('/agents/software')
    .description("Create a software agent")
    .params(["agent", JSONModel(:agent_software), "The software to create", :body => true])
    .returns([200, :created],
             [400, :error]) \
  do
    agent = AgentSoftware.create_from_json(params[:agent])
    created_response(agent, params[:agent])
  end


  Endpoint.post('/agents/software/:agent_id')
    .description("Update a software agent")
    .params(["agent_id", Integer, "The ID of the software to update"],
            ["agent", JSONModel(:agent_software), "The software to create", :body => true])
    .returns([200, :updated],
             [400, :error]) \
  do
    agent = AgentSoftware.get_or_die(params[:agent_id])
    agent.update_from_json(params[:agent])

    updated_response(agent, params[:agent])
  end


  Endpoint.get('/agents/software/:id')
    .description("Get a software by ID")
    .params(["id", Integer, "ID of the software agent"])
    .returns([200, "(:agent)"],
             [404, '{"error":"Agent not found"}']) \
  do
    json_response(AgentSoftware.to_jsonmodel(AgentSoftware.get_or_die(params[:id]),
                                             :agent_software))
  end

end
