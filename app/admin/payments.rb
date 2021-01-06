ActiveAdmin.register Payment do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :transaction_type, :transaction_status, :transaction_id, :total_amount, :transaction_date, :account_type, :result_code, :result_message, :user_account, :payer_identity, :timestamp, :transaction_hash, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:transaction_type, :transaction_status, :transaction_id, :total_amount, :transaction_date, :account_type, :result_code, :result_message, :user_account, :payer_identity, :timestamp, :transaction_hash, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  form do |f| # This is a formtastic form builder
    f.semantic_errors # shows errors on :base
    f.inputs do
      f.input :user_id, as: :select, collection: User.all
      f.input :total_amount
      li "Transaction Type #{f.object.transaction_type}" unless f.object.new_record?
      f.input :transaction_type, input_html: {value: "1"} unless f.object.persisted?
      li "Transaction Status #{f.object.transaction_status}" unless f.object.new_record?
      f.input :transaction_status, input_html: {value: "1"} unless f.object.persisted?
      f.input :transaction_id
      f.input :account_type
      f.input :result_message
      f.input :transaction_date, input_html: {value: "#{DateTime.now.strftime('%Y%m%d%H%M')}"}
      # li "Camp Year #{f.object.camp_year}" unless f.object.new_record?
      # f.input :camp_year, input_html: {value: current_camp_year} unless f.object.persisted?
    end
    f.actions         # adds the 'Submit' and 'Cancel' button
  end

end
