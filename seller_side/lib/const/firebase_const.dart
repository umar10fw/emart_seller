
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore  fireStore = FirebaseFirestore.instance;
User? currentUser = auth.currentUser;

// Collections

const vendorsCollection = "vendors";
const productsCollection = "products";
const chatsCollection = "chats";
const messagesCollection = "messages";
const ordersCollection = "orders";