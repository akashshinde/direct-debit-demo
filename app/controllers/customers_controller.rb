# frozen_string_literal: true

require 'gocardless_pro'

class CustomersController < ApplicationController
  attr_accessor :given_name, :family_name, :email

  def initialize
    super
    @session_token = 'dummy_session_token_169'
  end

  def index
    @customers = @client.customers.list.records
  end

  def create
    @contact = {}
  end

  def create_customer
    begin
      parameters = params[:create_customer].to_enum.to_h
      redirect_flow = @client.redirect_flows.create(
        params: {
          description: 'Lager kegs',
          session_token: @session_token,
          success_redirect_url: 'http://localhost:3000/customers/create_user_success',
          prefilled_customer: parameters
        }
      )
      redirect_to redirect_flow.redirect_url
    rescue StandardError => e
      pp e
    end
  end

  def create_user_success
    @client.redirect_flows.complete(params[:redirect_flow_id], params: {
                                      session_token: @session_token
                                    })
    redirect_to action: 'index'
  end

  def create_customer_params
    params.require(:create_customer).permit(:given_name, :family_name, :email, :language )
  end
end
