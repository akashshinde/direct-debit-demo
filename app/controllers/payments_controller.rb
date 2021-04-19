class PaymentsController < ApplicationController

  def initialize
    super
    @session_token = 'dummy_session_token_169'
  end

  def create
    @customer_id = params[:customer_id]
    add_breadcrumb 'Customer', "/customer/#{@customer_id}"
    add_breadcrumb 'Payments', "/payments/customer/#{@customer_id}"
    add_breadcrumb 'Create'
  end

  def create_payment
    mandate_id = get_mandate_id(params[:customer_id])
    p = {
      params: {
        amount: params[:create_payment][:amount].to_i * 100,
        description: params[:create_payment][:description],
        currency: 'GBP',
        links: {
          mandate: mandate_id
        },
        metadata: {
          invoice_number: '001'
        }
      },
      headers: {
        'Idempotency-Key': SecureRandom.uuid,
      }
    }
    pp p
    @client.payments.create(p)
    redirect_to controller: 'payments', action: 'list', customer_id: params[:customer_id]
  end

  def get_mandate_id(customer_id)
    mandates = @client.mandates.list({ customer: customer_id }).records
    active_mandates = mandates.select do |mandate|
      mandate.links.customer == customer_id
    end
    throw 'Error in getting mandate ID' if active_mandates.empty?
    active_mandates[0].id
  end

  def list
    @payments = if params.key?('customer_id')
                  @customer_id = params[:customer_id]
                  @client.payments.list(params: { customer: @customer_id }).records
                else
                  @client.payments.list.records
                end
  end

end
