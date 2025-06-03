General summary of process:

- See if a pack should be de-prioritized globally ⇒ decrease search priority
- See if a pack should be prioritized globally ⇒ increase search priority
- See if a specific node namespace should be claimed by a specific node pack ⇒ add to preempted node names

Specific steps:

for each item, suggest changes (which will be converted to sql commands at the end):

1. keep track of the search priority mutations we are planning, when we make changes, update the cahce (sql query will be made at end)
2. first, check for global priority changes usign process:
   1. check if a node pack (strings in comma-separated node_ids properties) is present in a large number of records (>=3), create list of all such packs
   2. present that list in a nicely formatted table or visualization using viz tools
   3. Walk through the list one by one asking user if they want to de-prioritize or prioritize the pack. To help inform we should query https://api.comfy.org to get all frelevant info to make decision (e.g., the info about the node packs in question). To understand how to structure the queries and what endpoints are available, check the openapi.yml in this folder
   4. wait for user's decision. if they do want to change search priority (all defaults are 5 in the beginning by the wya), then update our temporary cahce and move forward. IMPORTANT: any time we update the cache it reflects a change: the records which contain a node_id whose priority has changed may now no longer actually be a duplicate, as there is a priority shift and therefore no tie to have to break
3. Next, we need to go through all the "True" duplicates -- that is, any record where there is 2 or more node_ids with the same search priority (excpet if tehre is a clear "winner" in the same list that has a distinct search priority that is lower than the others)
4. for each duplicate scenario, again prompt user if that record's name field should be 'claimed' by any of the node_ids. And again, provide any relevant details to help make decision and even format those details in the CLI nicely.
5. for that node_id, add the record's 'name' to a data structure that is just node_id mapped to lists.
6. After all that is done, prepare the results in a json file
7. Next, convert to SQL queries that will work in the supabase database and save them to a file.

IMPORTANT: while doing all this, keep a cache in a json file so we dont have to repeat any requests to the api throughout the process.
