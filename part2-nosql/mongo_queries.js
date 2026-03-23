// OP1: insertMany() — insert all 3 documents from sample_documents.json

db.test.insertMany([
	{
	  "product_id": "P001",
	  "product_name": "MSI Ryzen 7",
	  "category": "Electronics",
	  "brand": "MSI",
	  "price": 85000,
	  "specifications": {
		"processor": "Intel Core i5 12th Gen",
		"ram": "16GB",
		"storage": "512GB SSD",
		"screen_size": "15.6 inches"
	  },
	  "warranty": {
		"period_years": 2,
		"type": "Onsite Service"
	  },
	  "User_feedback": [
		{
		  "user": "Rohan Mehta",
		  "rating": 4,
		  "review": "Good performance for daily work."
		},
		{
		  "user": "Anita Sharma",
		  "rating": 5,
		  "review": "Fast and reliable laptop."
		}
	  ]
	},
	{
	  "product_id": "P002",
	  "product_name": "Ergonomic Office Chair",
	  "category": "Furniture",
	  "brand": "Neelkamal",
	  "price": 7200,
	  "material": {
		"frame": "Steel",
		"seat": "Mesh",
		"base": "Nylon"
	  },
	  "features": [
		"Adjustable height",
		"Lumbar support",
		"Breathable mesh back"
	  ]
	},
	{
	  "product_id": "P003",
	  "product_name": "Premium Notebook Set",
	  "category": "Stationery",
	  "brand": "Classmate",
	  "price": 350,
	  "pack_details": {
		"items_per_pack": 5,
		"pages_per_notebook": 200
	  },
	  "available_colors": [
		"Blue",
		"Black",
		"Red",
		"Green"
	  ]	  
	},
	{
	  "product_id": "P004",
	  "product_name": "Sugar",
	  "category": "Groceries",
	  "brand": "DMART",
	  "price": 200,
	  "pack_details": {
		"weight_kg": 1,
		"expiry": 2024-11-19
	  }	  
	}
])


// OP2: find() — retrieve all Electronics products with price > 20000
db.test.find({category:"Electronics",price: {$gt:2000}})

// OP3: find() — retrieve all Groceries expiring before 2025-01-01
db.test.find({category: 'Groceries', "pack_details.expiry": {$lt: ISODate('2025-01-01')}})

// OP4: updateOne() — add a "discount_percent" field to a specific product
db.test.updateOne({product_id: "P004"}, {$set: {discount_percent: 10}})

// OP5: createIndex() — create an index on category field and explain why
db.test.createIndex({category: 1})

//Explanation:
//Creating an index enable mongoDB to perform an index scan rather than the entire collection scan that can improve performance considerably for large datasets.

## Database Recommendation
For a Healthcare startup building a Patient Management Systems involves very sensitive and highly accurate & highly available data. This could include patient records, diagnosis, treatment, billings, Hospital Staffs, Machines availability etc.,. This type of data requires strong guarantees of consistency, integrity, and reliability, which are best provided by ACID (Atomicity, Consistency, Isolation, Durability) properties.

If we consider CAP Theorem, healthcare systems prioritize Consistency and Availability over Partition Tolerance in most controlled environments. Any inconsistency in patient data (e.g., incorrect medication or duplicated records) can have serious real-world consequences. MySQL a RDBMS ensures that transactions are processed reliably and that data remains accurate even in cases of system failure. For instance when a patient's report result or a medication is updated, the transaction must fully commit or fail and show error so that hospital staff can take corrective Action. If transaction initiates and doesn't fully commit patient can be misdiagnosed or given wrong medication.

If we consider MongoDB that follows BASE model allows for scalability & flexibility but can compromise on strict consistency e,g., Schema. It is preferred to handle unstructured rapidly changing data but might not be suited for a healthcare system having such critical Data.
For above reasons my Recommendations will be MySQL

However, if we need to consider a fraud detection system I would consider a Hybrid approach. FDS might include analysis and observing huge amount of logs, patterns, streaming data from various sources. This kind of rapidly incoming, rapidly changing, unstructured, analytical data is more suitable or easier to handle via MongoDB

Final recommendations: MySQL for core PMS & MongoDB for FDS.