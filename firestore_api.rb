# require 'google/apis/firestore_v1beta1'
require 'net/http'
# require "google-cloud-firestore"
require 'dotenv'
Dotenv.load

require "google/cloud/firestore"

firestore = Google::Cloud::Firestore.new project_id: "pocketmentor-455ae"

firestore = Google::Cloud::Firestore.new(
  project_id: "pocketmentor-455ae",
  credentials: "/opt/app/mypocketmentor6-684a1426f386.json"
)
puts "Created Cloud Firestore client with given project ID."

puts ENV["GOOGLE_APPLICATION_CREDENTIALS"]

# SCOPE = ['https://www.googleapis.com/auth/datastore', 'https://www.googleapis.com/auth/cloud-platform']

# PROJECT_ROOT_PATH = "projects/pocketmentor-455ae/databases/(default)/documents/user"
doc_ref = firestore.doc "users/alovelace"

doc_ref.set(
  first: "Ada",
  last:  "Lovelace",
  born:  1815
)
  