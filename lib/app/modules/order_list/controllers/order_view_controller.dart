import 'package:get/get.dart';
import 'package:waiter/app/data/models/sales.dart';
import 'package:waiter/app/data/providers/order_list_provider.dart';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart' hide Image;
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart';
import 'dart:io' show Platform;
import 'package:image/image.dart';
class OrderViewController extends GetxController {
  var isLoading = true.obs;
  final _sales = Sales().obs;
  Sales get sales=>_sales.value;
  // List<Sales> get salesList=>_salesList.value;
  final _reference=''.obs;
  final _orderStatus=''.obs;
  String get reference=>_reference.value;
  String get orderStatus=>_orderStatus.value;
  // print work start
  PrinterBluetoothManager printerManager = PrinterBluetoothManager();
  var  devices = <PrinterBluetooth>[].obs;
  // List<PrinterBluetooth> get devices=>_devices;
  String devicesMsg;
  BluetoothManager bluetoothManager = BluetoothManager.instance;

  @override
  void onInit()async {
    super.onInit();
    if(Get.arguments !=null && Get.arguments.length > 0){
      _reference.value=Get.arguments['reference'];
      _orderStatus.value=Get.arguments['orderStatus'];
      await getSingleSales(reference);
      print(reference);
      print('reference====');
    }
    if (Platform.isAndroid) {
      bluetoothManager.state.listen((val) {
        print('state = $val');
        // if (!mounted) return;
        if (val == 12) {
          print('on');
          initPrinter();
        } else if (val == 10) {
          print('off');
          devicesMsg = 'Bluetooth Disconnect!';
        }
      });
    } else {
      initPrinter();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    printerManager.stopScan();
  }
  Future<void> getSingleSales(reference) async {
    try {
      isLoading(true);
      var salesValue = await OrderListProvider().getOneSales(reference,orderStatus);
      if (salesValue != null) {
        _sales.value=salesValue;
      }else{
        _sales.value=null;
      }
    } finally {
      isLoading(false);
    }
  }
  void initPrinter() {
    printerManager.startScan(Duration(seconds: 2));
    printerManager.scanResults.listen((val) {
      // if (!mounted) return;
      print(val);
      print('val=============');
       devices.value = val;
       // devices.addAll(val);
      if (devices.isEmpty)  devicesMsg = 'No Devices';
    });
  }

  Future<void> startPrint(PrinterBluetooth printer) async {
    printerManager.selectPrinter(printer);
    final result = await printerManager.printTicket(await _ticket(PaperSize.mm80));
    showDialog(
      context: Get.overlayContext,
      builder: (_) => AlertDialog(
        content: Text(result.msg),
      ),
    );
  }

  Future<Ticket> _ticket(PaperSize paper) async {
    final ticket = Ticket(paper);
    int total = 0;

    // Image assets
    final ByteData data = await rootBundle.load('assets/images/store.png');
    final Uint8List bytes = data.buffer.asUint8List();
    final Image image = decodeImage(bytes);
    ticket.image(image);
    ticket.text(
      'TOKO KU',
      styles: PosStyles(align: PosAlign.center,height: PosTextSize.size2,width: PosTextSize.size2),
      linesAfter: 1,
    );

    for (var i = 0; i < sales.items.length; i++) {
      // total += widget.data[i]['total_price'];
      ticket.text(sales.items[i].id);
      ticket.row([
        PosColumn(
            text: '${sales.items[i].quantity} x ${sales.items[i].unit_price}',
            width: 6),
        PosColumn(text: 'Rp ${sales.items[i].subtotal}', width: 6),
      ]);
    }
    ticket.text(sales.id);
    ticket.feed(1);
    ticket.row([
      PosColumn(text: 'Total', width: 6, styles: PosStyles(bold: true)),
      PosColumn(text: 'Rp $total', width: 6, styles: PosStyles(bold: true)),
    ]);
    ticket.feed(2);
    ticket.text('Thank You',styles: PosStyles(align: PosAlign.center, bold: true));
    ticket.cut();

    return ticket;
  }


}
