Sequel.migration do
  up do
    create_table(:users) do
      primary_key :id, :type => :varchar, :auto_increment => false, :unique => true
      String :email, unique: true
      String :password

      DateTime :created_at
      DateTime :updated_at
      DateTime :last_login_at
      String :generated_password
    end
  end

  down do
    drop_table(:users)
  end
end
