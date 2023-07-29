import 'package:flutter/material.dart';

class ApiGetMethodExplanation extends StatelessWidget {
  final String apiEndpoint;
  final String purpose;
  final String exampleResponse;

  ApiGetMethodExplanation({
    required this.apiEndpoint,
    required this.purpose,
    required this.exampleResponse,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "API GET Method:",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text(
            "Endpoint: $apiEndpoint",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text(
            "Purpose: $purpose",
          ),
          SizedBox(height: 8.0),
          Text(
            "Example Response:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text(
            exampleResponse,
            style: TextStyle(fontFamily: 'Courier New'),
          ),
        ],
      ),
    );
  }
}

class GetApi extends StatefulWidget {
  const GetApi({Key? key}) : super(key: key);

  @override
  State<GetApi> createState() => _GetApiState();
}

class _GetApiState extends State<GetApi> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Get API',
      home: Container(
        child: ApiGetMethodExplanation(
          apiEndpoint: "https://api.example.com/users",
          purpose: "Fetch a list of users from the server.",
          exampleResponse: '''
{
  "status": "success",
  "data": [
    {
      "id": 1,
      "name": "John Doe",
      "email": "john@example.com"
    },
    {
      "id": 2,
      "name": "Jane Smith",
      "email": "jane@example.com"
    }
  ]
}
''',
        ),
      ),
    );
  }
}
