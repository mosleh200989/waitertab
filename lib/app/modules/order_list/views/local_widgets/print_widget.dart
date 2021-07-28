import 'dart:typed_data';
import 'package:flutter/material.dart' hide Image;
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart';
import 'package:get/get.dart';
import 'dart:io' show Platform;
import 'package:image/image.dart';
import 'package:waiter/app/modules/home/controllers/auth_controller.dart';
import 'package:waiter/app/modules/order_list/controllers/order_view_controller.dart';

class PrintWidget extends StatefulWidget {
  // PrintWidget(data);
  // final List<Map<String, dynamic>> data=[];
  // Print(this.data);
  @override
  _PrintWidgetState createState() => _PrintWidgetState();
}

class _PrintWidgetState extends State<PrintWidget> {

  PrinterBluetoothManager _printerManager = PrinterBluetoothManager();
  List<PrinterBluetooth> _devices = [];
  String _devicesMsg;
  BluetoothManager bluetoothManager = BluetoothManager.instance;
  final orderDetailsController=Get.find<OrderViewController>();
  @override
  void initState() {

    print('widget.data.length');
    print(orderDetailsController.sales.id);
    print(orderDetailsController.sales.items.length);
    if (Platform.isAndroid) {
      bluetoothManager.state.listen((val) {
        print('state = $val');
        if (!mounted) return;
        if (val == 12) {
          print('on');
          initPrinter();
        } else if (val == 10) {
          print('off');
          setState(() => _devicesMsg = 'Bluetooth Disconnect!');
        }
      });
    } else {
      initPrinter();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Print'),
      ),
      body: _devices.isEmpty
          ? Center(child: Text(_devicesMsg ?? ''))
          : ListView.builder(
              itemCount: _devices.length,
              itemBuilder: (c, i) {
                return ListTile(
                  leading: Icon(Icons.print),
                  title: Text(_devices[i].name),
                  subtitle: Text(_devices[i].address),
                  onTap: () {
                    _startPrint(_devices[i]);

                  },
                );
              },
            ),

    );
  }

  void initPrinter() {
    _printerManager.startScan(Duration(seconds: 2));
    _printerManager.scanResults.listen((val) {
      if (!mounted) return;
      setState(() => _devices = val);
      if (_devices.isEmpty) setState(() => _devicesMsg = 'No Devices');
    });
  }

  Future<void> _startPrint(PrinterBluetooth printer) async {
    _printerManager.selectPrinter(printer);
    final result = await _printerManager.printTicket(await _ticket(PaperSize.mm80));
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Text(result.msg),
      ),
    );
  }

  Future<Ticket> _ticket(PaperSize paper) async {
    final ticket = Ticket(paper);
    // Image assets
    final ByteData data = await rootBundle.load('assets/images/store.png');
    final Uint8List bytes = data.buffer.asUint8List();
    final Image image = decodeImage(bytes);
    ticket.image(image);
    ticket.text(
      'SaleNumber : ${orderDetailsController.sales.id??""}',
      styles: PosStyles(align: PosAlign.center, bold: true),
    );
    /*ticket.text(
      'SaleReference'.tr+': ${orderDetailsController.sales.reference_no??""}',
      styles: PosStyles(align: PosAlign.center, bold: true),
    );
    ticket.text(
      'SalesAssociate'.tr+': ${Get.find<AuthController>().currentUser.username??""}',
      styles: PosStyles(align: PosAlign.center, bold: true),
    );
    ticket.text(
      'Customer'.tr+': ${orderDetailsController.sales.customer??""}',
      styles: PosStyles(align: PosAlign.center, bold: true),
    );*/
    // for (var i = 0; i < orderDetailsController.sales.items.length; i++) {
    //   print(orderDetailsController.sales.items[i].product_name);
    //   ticket.row([
    //     PosColumn(
    //         text: '${orderDetailsController.sales.items[i].unit_price} x ${orderDetailsController.sales.items[i].quantity}',
    //         width: 6),
    //     PosColumn(text: 'SAR', width: 6),
    //   ]);
    // }

    ticket.feed(1);
    // ticket.row([
    //   PosColumn(text: 'Total', width: 6, styles: PosStyles(bold: true)),
    //   PosColumn(text: 'SAR ${orderDetailsController.sales.grand_total}', width: 6, styles: PosStyles(bold: true)),
    // ]);
    ticket.feed(2);
    ticket.text('Thank You',styles: PosStyles(align: PosAlign.center, bold: true));
    ticket.cut();

    return ticket;
  }

  @override
  void dispose() {
    _printerManager.stopScan();
    super.dispose();
  }

}
