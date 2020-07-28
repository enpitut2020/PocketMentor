# require 'google/apis/firestore_v1beta1'
require 'net/http'
require 'dotenv'
Dotenv.load
require "google/cloud/firestore"

firestore = Google::Cloud::Firestore.new project_id: "pocketmentor-455ae"

firestore = Google::Cloud::Firestore.new(
  project_id: "pocketmentor-455ae",
  credentials: "pocketmentor-455ae-firebase-adminsdk-bw1dg-9626bcc8d7.json"
)
doc_ref = firestore.doc "users/aaaa"
doc_ref.set(
  first: "niwaaaaaaaaa",
  last:  "uwaaaaaaaaa",
  born:  1111
)
  