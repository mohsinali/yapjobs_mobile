class JobsController < ApplicationController
  require 'rest-client'
  require 'json'
  
  def index
    jobs_get = RestClient.get Rails.application.config.api_server_url + "jobs",
       {:Authorization => Rails.application.config.api_authorization,  "Content-Type" => "application/json"}

    @jobs = Hash.from_xml(jobs_get)

  end

  def show

    job_get = RestClient.get Rails.application.config.api_server_url + "jobs/job_search", 
      {:params => {:job_id => params[:id]}, :Authorization => Rails.application.config.api_authorization,
        "Content-Type" => "application/json"}
        
    @job = Hash.from_xml(job_get)["hash"]["job"]

  end
end
