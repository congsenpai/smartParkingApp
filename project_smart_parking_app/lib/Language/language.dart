class EnglishLanguage {
  Map<String, String> dictionary = {
    'Order': 'Order',
    'MyOrders':'My Orders',
    'Customer': 'Customer',
    'Payment': 'Payment',
    'Do not any order':'Do not any order',
    'Booking Now':'Booking Now',
    'Finding...':'Finding...',
    'VND/hr':'VND/hr',
    'Description':'Description',
    'AI Secure':'AI Secure',
    'Electrics':'Electrics System',
    'Toilets': 'Toilets System',
    'Slots':'Slots',
    'Parking Slot':'Paking Slots',
    'Booking Slot':'Booking Slot',
    'Booking Now':'Booking Now',
    'Cancel': 'Cancel',
    'Selected parking slot:':'Selected parking slot:'


    // Thêm từ khóa tiếng Anh khác tại đây
  };
}

class VietnameseLanguage {
  Map<String, String> dictionary = {
    'Order': 'Đơn hàng',
    'MyOrders':'Đơn hàng của tôi',
    'Customer': 'Khách hàng',
    'Payment': 'Thanh toán',
    'Do not any order':'Không có đơn hàng nào được tìm thấy.',
    'Booking Now':'Đặt chỗ ngay',
    'Finding...':'Tìm kiếm...',
    'VND/hr':'VND/giờ',
    'Description':'Mô tả',
    'AI Secure':'Nhận dạng AI',
    'Electrics':'Hệ thống điện',
    'Toilets': 'Hệ thống vệ sinh',
    'Slots': 'Vị trí',
    'Parking Slot':'Vị trí đặt xe',
    'Booking Slot':'Đặt chỗ',
    'Booking Now' : 'Đặt chỗ ngay',
    'Cancel':'Đóng',
     'Selected parking slot:' : 'Vị trí đã chọn: '



    // Thêm từ khóa tiếng Việt khác tại đây
  };
}
class LanguageSelector {
  final EnglishLanguage english = EnglishLanguage();
  final VietnameseLanguage vietnamese = VietnameseLanguage();

  String translate(String word, String language) {
    if (language == 'en') {
      return english.dictionary[word] ?? 'Not found';
    } else if (language == 'vi') {
      return vietnamese.dictionary[word] ?? 'Không tìm thấy';
    } else {
      return 'Invalid language';
    }
  }
}
