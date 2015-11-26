require Amnesia

use Amnesia

defdatabase Database do
  #We define a table, records will be sorted, the first element will be taken as an index
  deftable Battery, [:timestamp, :status, :percentage ], type: :ordered_set do 
  #Nice to have, we declare a struct that represents a record in the database
  @type t :: %Battery{timestamp: non_neg_integer, status: String.t, percentage: non_neg_integer}
  end
end
