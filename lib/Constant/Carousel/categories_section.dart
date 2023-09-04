import 'package:flutter/material.dart';

List shoppingCategories = [
  {
    "icon": Icons.car_rental,
    "title": "مركبات",
    "id": "vehicles",
    "meta_data": [
      "سيارات",
      "موتوسيكل",
      "عجلة",
    ]
  },
  {
    "icon": Icons.real_estate_agent,
    "title": "عقارات",
    "id": "real_estates",
    "meta_data": [
      "منازل",
      "أراضي",
      "محلات تجارية",
    ]
  },
  {
    "icon": Icons.mobile_friendly_outlined,
    "title": "الكترونيات",
    "id": "electronics",
    "meta_data": [
      "تليفون",
      "لابتوب",
      "شاشات",
      "ساعات",
    ]
  },
  {
    "icon": Icons.home,
    "title": "أثاث منزلي",
    "id": "household",
    "meta_data": [
      "أثاث منزلي",
    ]
  },
  {
    "icon": Icons.pets,
    "title": "حيوانات أليفة",
    "id": "pets",
    "meta_data": [
      "قطط",
      "كلاب",
    ]
  },
  {
    "icon": Icons.book_sharp,
    "title": "كتب",
    "id": "books",
    "meta_data": [
      "كتب",
    ]
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
