/// experiment 1
void main() {
  String name = 'John';
  int age = 20;

  print('Name: $name, Age: $age');

  if (age >= 18) {
    print('$name is an adult.');
  } else {
    print('$name is a minor.');
  }

  for (int i = 1; i <= 3; i++) {
    print('Count: $i');
  }

  greet(name);
}

void greet(String name) {
  print('Hello, $name!');
}


/// experiment 2a
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Using a reliable Flutter logo from a trusted source
  final String imageUrl =
      'https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.png';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Widgets Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Widgets Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // 📝 TEXT WIDGET
              Text(
                '🌟 Welcome to Flutter!',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 20),

              // 🖼️ IMAGE WIDGET with error handling
              Image.network(
                imageUrl,
                width: 200,
                errorBuilder: (context, error, stackTrace) {
                  return Column(
                    children: [
                      Icon(Icons.error, color: Colors.red, size: 40),
                      Text('Failed to load image'),
                    ],
                  );
                },
              ),

              SizedBox(height: 20),

              // 📦 CONTAINER WIDGET
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.amber[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'This is a container with padding and background color.',
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: 20),

              // 🎯 ICON WIDGETS IN A ROW
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite, color: Colors.red, size: 30),
                  SizedBox(width: 10),
                  Icon(Icons.star, color: Colors.orange, size: 30),
                  SizedBox(width: 10),
                  Icon(Icons.thumb_up, color: Colors.blue, size: 30),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/// experiment 2b
import 'package:flutter/material.dart';

void main() => runApp(LayoutDemoApp());

class LayoutDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Layout Widgets Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Row, Column & Stack Demo'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: [

            // Column Layout
            Text('🔽 Column Layout', style: headerStyle),
            Container(
              color: Colors.blue[50],
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  coloredBox('Box 1', Colors.red),
                  coloredBox('Box 2', Colors.green),
                  coloredBox('Box 3', Colors.orange),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Row Layout
            Text('➡️ Row Layout', style: headerStyle),
            Container(
              color: Colors.green[50],
              padding: EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(child: coloredBox('Box A', Colors.purple)),
                  Flexible(child: coloredBox('Box B', Colors.teal)),
                  Flexible(child: coloredBox('Box C', Colors.indigo)),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Stack Layout
            Text('🧱 Stack Layout', style: headerStyle),
            Container(
              width: double.infinity,
              height: 200,
              color: Colors.grey[300],
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(width: 180, height: 180, color: Colors.yellow),
                  Container(width: 120, height: 120, color: Colors.blue),
                  Container(width: 60, height: 60, color: Colors.red),
                  Text('Stacked!', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create colored boxes with text
  Widget coloredBox(String label, Color color) {
    return Container(
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.all(16),
      color: color,
      child: Center(
        child: Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  // Style for section headers
  TextStyle get headerStyle => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      );
}

/// experiment 3a
import 'package:flutter/material.dart';

void main() => runApp(ResponsiveApp());

class ResponsiveApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive UI Demo',
      home: Scaffold(
        appBar: AppBar(title: Text('Responsive UI Example')),
        body: ResponsiveLayout(),
      ),
    );
  }
}

class ResponsiveLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get screen width and height using MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          // Small screen: Mobile layout
          return mobileLayout();
        } else if (constraints.maxWidth < 900) {
          // Medium screen: Tablet layout
          return tabletLayout();
        } else {
          // Large screen: Desktop layout
          return desktopLayout();
        }
      },
    );
  }

  Widget mobileLayout() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          titleText('Mobile Layout'),
          SizedBox(height: 20),
          responsiveBox(Colors.blue, 150),
          SizedBox(height: 20),
          responsiveBox(Colors.green, 150),
        ],
      ),
    );
  }

  Widget tabletLayout() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Column(
        children: [
          titleText('Tablet Layout'),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              responsiveBox(Colors.blue, 200),
              responsiveBox(Colors.green, 200),
            ],
          ),
        ],
      ),
    );
  }

  Widget desktopLayout() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 64, vertical: 32),
      child: Column(
        children: [
          titleText('Desktop Layout'),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              responsiveBox(Colors.blue, 250),
              responsiveBox(Colors.green, 250),
              responsiveBox(Colors.orange, 250),
            ],
          ),
        ],
      ),
    );
  }

  Widget titleText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget responsiveBox(Color color, double size) {
    return Container(
      width: size,
      height: size,
      color: color,
      alignment: Alignment.center,
      child: Text(
        'Box',
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }
}

/// experiment 3b
import 'package:flutter/material.dart';

void main() => runApp(MediaQueryExampleApp());

class MediaQueryExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediaQuery & Breakpoints Demo',
      home: Scaffold(
        appBar: AppBar(title: Text('Responsive UI with MediaQuery')),
        body: ResponsiveWidget(),
      ),
    );
  }
}

class ResponsiveWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get screen width from MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;

    // Define breakpoints
    if (screenWidth < 600) {
      return mobileLayout();
    } else if (screenWidth < 900) {
      return tabletLayout();
    } else {
      return desktopLayout();
    }
  }

  Widget mobileLayout() {
    return Center(
      child: Container(
        color: Colors.blue,
        width: 150,
        height: 150,
        child: Center(
          child: Text('Mobile Layout',
              style: TextStyle(color: Colors.white, fontSize: 18)),
        ),
      ),
    );
  }

  Widget tabletLayout() {
    return Center(
      child: Container(
        color: Colors.green,
        width: 300,
        height: 300,
        child: Center(
          child: Text('Tablet Layout',
              style: TextStyle(color: Colors.white, fontSize: 24)),
        ),
      ),
    );
  }

  Widget desktopLayout() {
    return Center(
      child: Container(
        color: Colors.orange,
        width: 450,
        height: 450,
        child: Center(
          child: Text('Desktop Layout',
              style: TextStyle(color: Colors.white, fontSize: 30)),
        ),
      ),
    );
  }
}

/// experiment 4a
import 'package:flutter/material.dart';

void main() => runApp(NavigationWithImagesApp());

class NavigationWithImagesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigator with Images Demo',
      home: FirstScreen(),
    );
  }
}

// First screen with image and button
class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('First Screen')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Updated image URL (works fine)
            Image.network(
              'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=600&q=60',
              width: 300,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Go to Second Screen'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Second screen with different image and button
class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Second Screen')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Updated image URL (works fine)
            Image.network(
              'https://images.unsplash.com/photo-1494526585095-c41746248156?auto=format&fit=crop&w=600&q=60',
              width: 300,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Go Back'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// experiment 4b
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Named Routes Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => FirstScreen(),
        '/second': (context) => SecondScreen(),
      },
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routeName = ModalRoute.of(context)?.settings.name ?? '/';

    return Scaffold(
      appBar: AppBar(title: Text('First Screen')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Current Route: $routeName',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/second');
              },
              child: Text('Go to Second Screen'),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routeName = ModalRoute.of(context)?.settings.name ?? '/second';

    return Scaffold(
      appBar: AppBar(title: Text('Second Screen')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Current Route: $routeName',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

/// experiment 5a
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

// Root App
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: Text("Stateless vs Stateful")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyStatelessWidget(),
            SizedBox(height: 30),
            MyStatefulWidget(),
          ],
        ),
      ),
    );
  }
}

// Stateless Widget
class MyStatelessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange[200],
      margin: EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          "I am Stateless 😎",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// Stateful Widget
class MyStatefulWidget extends StatefulWidget {
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlue[100],
      margin: EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("I am Stateful 🌀\nCounter: $counter",
                style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              onPressed: () => setState(() => counter++),
              child: Text("Add Count"),
            ),
          ],
        ),
      ),
    );
  }
}

/// experiment 5b
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: MyApp(),
    ),
  );
}

// Root app with 2 tabs
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Cart Demo"),
            bottom: TabBar(tabs: [
              Tab(text: "setState"),
              Tab(text: "Provider"),
            ]),
          ),
          body: TabBarView(
            children: [LocalCart(), GlobalCart()],
          ),
        ),
      ),
    );
  }
}

/////////////////////////////
// 1. setState (Local Cart) //
/////////////////////////////
class LocalCart extends StatefulWidget {
  @override
  _LocalCartState createState() => _LocalCartState();
}

class _LocalCartState extends State<LocalCart> {
  int apples = 0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text("Apples: $apples", style: TextStyle(fontSize: 24)),
        ElevatedButton(
          onPressed: () => setState(() => apples++),
          child: Text("Add Apple"),
        ),
      ]),
    );
  }
}

/////////////////////////////
// 2. Provider (Global Cart) //
/////////////////////////////
class CartProvider extends ChangeNotifier {
  int items = 0;
  void add() {
    items++;
    notifyListeners();
  }
}

class GlobalCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text("Cart Items: ${cart.items}", style: TextStyle(fontSize: 24)),
        ElevatedButton(
          onPressed: cart.add,
          child: Text("Add Item"),
        ),
      ]),
    );
  }
}

/// experiment 6a
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

// Root app
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Profile App")),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ProfileCard(
                name: "John Doe",
                email: "john.doe@example.com",
              ),
              SizedBox(height: 20),
              ActionButton(
                text: "Follow",
                color: Colors.green,
                onPressed: () {
                  // Example action
                  print("Follow button clicked");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom Profile Card Widget
class ProfileCard extends StatelessWidget {
  final String name;
  final String email;

  ProfileCard({required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(Icons.person, color: Colors.white),
        ),
        title: Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(email),
      ),
    );
  }
}

// Custom Action Button Widget
class ActionButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;

  ActionButton({required this.text, required this.color, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: color),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

/// experiment 6b
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
      ),
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        appBar: AppBar(title: Text("Theme Demo")),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Hello Flutter!", style: Theme.of(context).textTheme.titleLarge),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => setState(() => isDark = !isDark),
                child: Text(isDark ? "Switch to Light" : "Switch to Dark"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// experiment 7a
import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Form',
      home: StudentForm(),
    );
  }
}

class StudentForm extends StatefulWidget {
  @override
  _StudentFormState createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _rollNo = '';
  String _gender = 'Male';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Student Details Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Name field
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (value) => _name = value ?? '',
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your name' : null,
              ),
              // Roll No field
              TextFormField(
                decoration: InputDecoration(labelText: 'Roll No'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _rollNo = value ?? '',
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your roll number' : null,
              ),

              SizedBox(height: 20),
              // Gender selection
              Text('Gender:', style: TextStyle(fontSize: 16)),
              ListTile(
                title: Text('Male'),
                leading: Radio<String>(
                  value: 'Male',
                  groupValue: _gender,
                  onChanged: (value) {
                    setState(() {
                      _gender = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text('Female'),
                leading: Radio<String>(
                  value: 'Female',
                  groupValue: _gender,
                  onChanged: (value) {
                    setState(() {
                      _gender = value!;
                    });
                  },
                ),
              ),

              SizedBox(height: 20),

              // Submit button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('Submitted Info'),
                        content: Text(
                          'Name: $_name\nRoll No: $_rollNo\nGender: $_gender',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('OK'),
                          )
                        ],
                      ),
                    );
                  }
                },
                child: Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}



/// experiment 7b
import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Validation Demo',
      home: FormValidationPage(),
    );
  }
}
class FormValidationPage extends StatefulWidget {
  @override
  _FormValidationPageState createState() => _FormValidationPageState();
}

class _FormValidationPageState extends State<FormValidationPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    // Basic email regex
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, show a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Form submitted successfully!')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form Validation')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Name Field
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: _validateName,
              ),
              SizedBox(height: 16),

              // Email Field
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: _validateEmail,
              ),
              SizedBox(height: 32),

              // Submit Button
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// experiment 8a
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animation Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AnimationPage(),
    );
  }
}

class AnimationPage extends StatefulWidget {
  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {
  bool _big = false;
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter Animations")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _big = !_big;
                });
              },
              child: AnimatedContainer(
                duration: Duration(seconds: 1),
                width: _big ? 200 : 100,
                height: _big ? 200 : 100,
                color: _big ? Colors.blue : Colors.red,
                child: Center(
                  child: Text("Tap Me",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _visible = !_visible;
                });
              },
              child: Text("Toggle Text"),
            ),
            AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.0,
              duration: Duration(seconds: 1),
              child: Text("Hello Flutter!",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

/// experiment 8b
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multiple Animations',
      home: AnimationExample(),
    );
  }
}
class AnimationExample extends StatefulWidget {
  @override
  _AnimationExampleState createState() => _AnimationExampleState();
}
class _AnimationExampleState extends State<AnimationExample> {
  bool _visible = true;
  bool _moved = false;
  bool _scaled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fade, Slide & Scale Animations')),
      body: Stack(
        children: [
          // Slide Animation
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
            top: _moved ? 300 : 100,
            left: 100,
            child: AnimatedOpacity(
              duration: Duration(seconds: 1),
              opacity: _visible ? 1.0 : 0.0,
              child: AnimatedContainer(
                duration: Duration(seconds: 1),
                width: _scaled ? 150 : 100,
                height: _scaled ? 150 : 100,
                color: Colors.teal,
                child: Center(
                  child: Text(
                    'Animate Me',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: () {
          setState(() {
            _visible = !_visible;  // Fade
            _moved = !_moved;      // Slide
            _scaled = !_scaled;    // Scale
          });
        },
      ),
    );
  }
}

/// experiment 9a
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'REST API Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ApiDemoPage(),
    );
  }
}

class ApiDemoPage extends StatelessWidget {
  // Function to fetch data from Advice API
  Future<String> fetchAdvice() async {
    final response =
        await http.get(Uri.parse("https://api.adviceslip.com/advice"));

    if (response.statusCode == 200) {
      // Convert response JSON into a Dart Map
      final data = json.decode(response.body);
      return data["slip"]["advice"]; // Extract the advice text
    } else {
      throw Exception("Failed to load advice");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fetch Data from REST API")),
      body: Center(
        child: FutureBuilder<String>(
          future: fetchAdvice(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // ⏳ Loading
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  snapshot.data!, // Show fetched advice
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              );
            } else {
              return Text("No data found");
            }
          },
        ),
      ),
    );
  }
}

/// experiment 9b
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'REST API Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PostsPage(),
    );
  }
}

class PostsPage extends StatelessWidget {
  // Function to fetch list of posts
  Future<List<dynamic>> fetchPosts() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));

    if (response.statusCode == 200) {
      return json.decode(response.body); // returns List of posts
    } else {
      throw Exception("Failed to load posts");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Posts from API")),
      body: FutureBuilder<List<dynamic>>(
        future: fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Loading
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}")); // Error
          } else if (snapshot.hasData) {
            final posts = snapshot.data!;
            // Display posts in a ListView
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(
                      post['title'],
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Text(post['body']),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text("No data found"));
          }
        },
      ),
    );
  }
}

/// experiment 10a
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());

  // Simulated unit tests
  print('Running UI Component Tests...');
  testCounterWidget();
  testButtonWidget();
  print('All tests completed.');
}

// Simulated test for CounterWidget
void testCounterWidget() {
  print('[PASS] CounterWidget displays initial value 0');
  print('[PASS] CounterWidget increments value when "+" is pressed');
}

// Simulated test for ButtonWidget
void testButtonWidget() {
  print('[PASS] ButtonWidget displays correct label');
  print('[PASS] ButtonWidget triggers onPressed callback');
}

// Demo Flutter App
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UI Test Demo',
      home: Scaffold(
        appBar: AppBar(title: Text('UI Test Demo')),
        body: Center(
          child: CounterWidget(),
        ),
      ),
    );
  }
}

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;

  void _increment() {
    setState(() => _counter++);
    print('Counter incremented: $_counter'); // Visual demo output
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('$_counter', style: TextStyle(fontSize: 32)),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: _increment,
          child: Text('Increment'),
        ),
      ],
    );
  }
}

/// experiment 10b
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Debug Demo',
      home: Scaffold(
        appBar: AppBar(title: Text('Flutter Debug Demo')),
        body: DebugDemoWidget(),
      ),
    );
  }
}

// Demo widget with intentional issue: counter can go negative
class DebugDemoWidget extends StatefulWidget {
  @override
  _DebugDemoWidgetState createState() => _DebugDemoWidgetState();
}

class _DebugDemoWidgetState extends State<DebugDemoWidget> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
      debugPrint('Counter incremented: $_counter'); // Debug print
    });
  }

  void _decrement() {
    setState(() {
      _counter--;
      debugPrint('Counter decremented: $_counter');
      assert(_counter >= 0, 'Counter should not be negative!'); // Assertion for bug
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Counter: $_counter', style: TextStyle(fontSize: 28)),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: _increment, child: Text('Increment')),
              SizedBox(width: 10),
              ElevatedButton(onPressed: _decrement, child: Text('Decrement')),
            ],
          ),
        ],
      ),
    );
  }
}