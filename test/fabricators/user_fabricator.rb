Fabricator(:user) do
  fname 'Joseph'
  lname 'Sniddle'
  email 'sniddle@example.com'
  encrypted_password { Devise::Encryptor.digest(User, 'password') }
  phone '423-555-1111'
  zip '99999'
  role_id { Fabricate(:role) }
end
