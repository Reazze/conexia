import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

void main() async {
  final router = Router();

  // ==========================
  // MOCK DATABASE
  // ==========================

  final List<Map<String, dynamic>> users = [
    {
      "id": 1,
      "name": "José",
      "email": "jose@test.com",
      "password": "123456",
      "coins": 250
    },
    {
      "id": 2,
      "name": "Carlos",
      "email": "carlos@test.com",
      "password": "123456",
      "coins": 100
    }
  ];

  // ==========================
  // HEALTH CHECK
  // ==========================

  router.get('/api/status', (Request request) {
    return Response.ok(
      jsonEncode({
        "success": true,
        "message": "Conexia Mock Server Running"
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );
  });

  // ==========================
  // REGISTER
  // ==========================

  router.post('/api/auth/register', (Request request) async {
    final body = await request.readAsString();
    final data = jsonDecode(body);

    final email = data['email'];

    final exists = users.any(
      (user) => user['email'] == email,
    );

    if (exists) {
      return Response(
        409,
        body: jsonEncode({
          "success": false,
          "message": "El correo ya existe"
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );
    }

    final newUser = {
      "id": users.length + 1,
      "name": data['name'],
      "email": data['email'],
      "password": data['password'],
      "coins": 0
    };

    users.add(newUser);

    return Response.ok(
      jsonEncode({
        "success": true,
        "message": "Usuario registrado"
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );
  });

  // ==========================
  // LOGIN
  // ==========================

  router.post('/api/auth/login', (Request request) async {
    final body = await request.readAsString();

    final data = jsonDecode(body);

    final email = data['email'];
    final password = data['password'];

    try {
      final user = users.firstWhere(
        (u) =>
            u['email'] == email &&
            u['password'] == password,
      );

      return Response.ok(
        jsonEncode({
          "success": true,
          "token": "mock-token-123",
          "user": {
            "id": user['id'],
            "name": user['name'],
            "email": user['email'],
            "coins": user['coins']
          }
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );
    } catch (_) {
      return Response(
        401,
        body: jsonEncode({
          "success": false,
          "message": "Credenciales incorrectas"
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );
    }
  });

  // ==========================
  // GET USERS
  // ==========================

  router.get('/api/users', (Request request) {
    final responseUsers = users
        .map(
          (user) => {
            "id": user["id"],
            "name": user["name"],
            "email": user["email"],
            "coins": user["coins"],
          },
        )
        .toList();

    return Response.ok(
      jsonEncode(responseUsers),
      headers: {
        'Content-Type': 'application/json',
      },
    );
  });

  // ==========================
  // GET USER BY ID
  // ==========================

  router.get('/api/users/<id>', (Request request, String id) {
    try {
      final user = users.firstWhere(
        (u) => u['id'] == int.parse(id),
      );

      return Response.ok(
        jsonEncode({
          "id": user["id"],
          "name": user["name"],
          "email": user["email"],
          "coins": user["coins"],
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );
    } catch (_) {
      return Response.notFound(
        jsonEncode({
          "message": "Usuario no encontrado"
        }),
      );
    }
  });

  // ==========================
  // UPDATE PROFILE
  // ==========================

  router.put('/api/users/<id>',
      (Request request, String id) async {
    final body = await request.readAsString();

    final data = jsonDecode(body);

    try {
      final index = users.indexWhere(
        (u) => u['id'] == int.parse(id),
      );

      users[index]['name'] = data['name'];

      return Response.ok(
        jsonEncode({
          "success": true,
          "message": "Usuario actualizado"
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );
    } catch (_) {
      return Response.notFound(
        jsonEncode({
          "message": "Usuario no encontrado"
        }),
      );
    }
  });

  // ==========================
  // DELETE USER
  // ==========================

  router.delete('/api/users/<id>',
      (Request request, String id) {
    users.removeWhere(
      (u) => u['id'] == int.parse(id),
    );

    return Response.ok(
      jsonEncode({
        "success": true,
        "message": "Usuario eliminado"
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );
  });

  // ==========================
  // SERVER CONFIG
  // ==========================

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addHandler(router);

  final server = await io.serve(
    handler,
    '0.0.0.0',
    8080,
  );

  print(
    '🚀 Conexia Mock Server running on port ${server.port}',
  );
}