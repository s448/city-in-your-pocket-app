import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

List shoppingCategories = [
  {
    "icon": CupertinoIcons.car_detailed,
    "title": "مركبات",
    "id": "vehicles",
    // "meta_data": [
    //   "سيارات",
    //   "موتوسيكل",
    //   "عجلة",
    // ]
  },
  {
    "icon": Ionicons.book_sharp,
    "title": "كتب",
    "id": "books",
    // "meta_data": [
    //   "كتب",
    // ]
  },
  {
    "icon": Icons.shopping_bag_outlined,
    "title": "ملابس وأحذية",
    "id": "clothing",
    // "meta_data": [
    //   "كتب",
    // ]
  },
  {
    "icon": Icons.home,
    "title": "أثاث وأجهزة منزلية",
    "id": "household",
    // "meta_data": [
    //   "أثاث منزلي",
    // ]
  },
  {
    "icon": Icons.pets,
    "title": "حيوانات أليفة",
    "id": "pets",
    // "meta_data": [
    //   "قطط",
    //   "كلاب",
    // ]
  },
  {
    "icon": Icons.tablet_android,
    "title": "أجهزة والكترونيات",
    "id": "electronics",
    // "meta_data": [
    //   "تليفون",
    //   "لابتوب",
    //   "شاشات",
    //   "ساعات",
    // ]
  },
  {
    "icon": Icons.real_estate_agent_outlined,
    "title": "عقارات وأراضي",
    "id": "real_estates",
    // "meta_data": [
    //   "منازل",
    //   "أراضي",
    //   "محلات تجارية",
    // ]
  },
  {
    "icon": Ionicons.arrow_back_circle,
    "title": "الكل",
    "id": "all",
    // "meta_data": [
    //   "الكل",
    // ]
  },
];

List freelanceCategories = [
  {
    "icon": Icons.delivery_dining_sharp,
    "title": "خدمات التوصيل",
    "route": "delivery"
  },
  {"icon": Icons.bus_alert_sharp, "title": "سائقون", "route": "driver"},
  {"icon": Icons.work, "title": "أعمال يدوية", "route": "handmade_things"},
  {"icon": Icons.more_outlined, "title": "الكل", "route": "more_freelancer"},
];
