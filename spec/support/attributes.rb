def payment_attributes(overrides = {})
  random_number = rand(10**10).to_s
  {
    transactionType: "1",
    transactionStatus: "1",
    transactionId: random_number,
    transactionTotalAmount: "10000",
    transactionDate: "201812061817",
    transactionAcountType: "VISA",
    transactionResultCode: "TAS717",
    transactionResultMessage: "This transaction has been approved.",
    orderNumber: "example-1",
    payerFullName: "116482571300161375344",
    timestamp: "1544138228060",
    transactionHash: "63d042588e873b698ff8c04deeb68fa408a82d4fe26b1c5e91",
  }.merge(overrides)
end

def user_attributes(overrides = {})
  random_number = rand(10**21).to_s
  {
    google_id: random_number,
    name: "Example User",
    email_address: "user@example.com",
    avatar_url: "https://lh5.googleusercontent.com/-z90eNbVovkU/AAAAAAAAAAI/photo.jpg",
    locale: "en",
    hosted_domain: "example.com",
    remember_digest: nil
  }.merge(overrides)
end

def umich_user_attributes(overrides = {})
  random_number = rand(10**21).to_s
  {
    google_id: random_number,
    name: "Example User",
    email_address: "user@umich.edu",
    avatar_url: "https://lh5.googleusercontent.com/-z90eNbVovkU/AAAAAAAAAAI/photo.jpg",
    locale: "en",
    hosted_domain: "umich.edu",
    remember_digest: nil
  }.merge(overrides)
end

def login_attributes(overrides = {})
  random_number = rand(10**21).to_s
  {
    google_id: random_number,
    name: "Example User",
    email_address: "user@umich.edu",
  }.merge(overrides)
end
