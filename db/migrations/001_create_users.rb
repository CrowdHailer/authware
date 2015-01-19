Sequel.migration do
  up do
    create_table(:users) do
      primary_key :id
      DateTime :created_at
      DateTime :updated_at
      DateTime :last_login_at
      String :email, unique: true
      String :password_digest
      String :generated_password
    end
  end

  down do
    drop_table(:users)
  end
end
