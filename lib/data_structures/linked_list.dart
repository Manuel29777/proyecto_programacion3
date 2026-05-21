import 'package:flutter/material.dart';
import '../models/user_model.dart';

class Node {
  UserModel data;
  Node? next;

  Node(this.data);
}

class LinkedList {
  Node? head;

  // Insertar usuario
  void insert(UserModel user) {
    Node newNode = Node(user);

    if (head == null) {
      head = newNode;
    } else {
      Node current = head!;

      while (current.next != null) {
        current = current.next!;
      }

      current.next = newNode;
    }
  }

  // Mostrar lista
  void display() {
    Node? current = head;

    while (current != null) {
      debugPrint(current.data.name);

      current = current.next;
    }
  }

  // Buscar usuario
  UserModel? search(String name) {
    Node? current = head;

    while (current != null) {
      if (current.data.name.toLowerCase() == name.toLowerCase()) {
        return current.data;
      }

      current = current.next;
    }

    return null;
  }

  // Eliminar usuario
  void delete(String name) {
    if (head == null) return;

    if (head!.data.name.toLowerCase() == name.toLowerCase()) {
      head = head!.next;

      return;
    }

    Node? current = head;

    while (current?.next != null &&
        current!.next!.data.name.toLowerCase() != name.toLowerCase()) {
      current = current.next;
    }

    if (current?.next != null) {
      current!.next = current.next!.next;
    }
  }
}
