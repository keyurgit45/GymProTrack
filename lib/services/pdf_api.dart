import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart' as pp;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_share2/whatsapp_share2.dart';

class PDFApi {
  void generatePDF(
      String id,
      String name,
      String age,
      String address,
      String number,
      String amount,
      DateTime date,
      String duration,
      bool openInPdf) async {
    final pdf = pw.Document();

    pw.ImageProvider netImage = await imageFromAssetBundle(
      'assets/launcher.jpg',
    );

    pw.ImageProvider sign = await imageFromAssetBundle(
      'assets/signature_a.png',
    );

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
              decoration: pw.BoxDecoration(border: pw.Border.all()),
              child: pw.Padding(
                padding: pw.EdgeInsets.only(left: 26, top: 50, right: 26),
                child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          children: [
                            pw.Image(netImage, height: 80, width: 80),
                            pw.SizedBox(width: 20),
                            pw.Text("Pacific Fitness\n& Gymnasium",
                                textAlign: pw.TextAlign.center,
                                style: pw.TextStyle(fontSize: 35)),
                            pw.SizedBox(width: 20),
                            pw.Image(netImage, height: 80, width: 80),
                          ]),
                      pw.SizedBox(height: 50),
                      pw.Text("Name : $name",
                          style: pw.TextStyle(fontSize: 26)),
                      pw.SizedBox(height: 10),
                      pw.Text("Age : $age", style: pw.TextStyle(fontSize: 26)),
                      pw.SizedBox(height: 10),
                      pw.Text("Address : $address",
                          style: pw.TextStyle(fontSize: 26)),
                      pw.SizedBox(height: 10),
                      pw.Text("Phone : $number",
                          style: pw.TextStyle(fontSize: 26)),
                      pw.SizedBox(height: 10),
                      pw.Text("Date : ${date.day}/${date.month}/${date.year}",
                          style: pw.TextStyle(fontSize: 26)),
                      pw.SizedBox(height: 10),
                      pw.Text("Membership Duration : $duration",
                          style: pw.TextStyle(fontSize: 26)),
                      pw.SizedBox(height: 10),
                      pw.Text("Amount : $amount Rs. only",
                          style: pw.TextStyle(fontSize: 26)),
                      pw.SizedBox(height: 40),
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.end,
                          children: [
                            pw.Image(sign, height: 200, width: 200),
                            pw.SizedBox(width: 5),
                          ])
                    ]),
              ));
        }));
    // final url = await pp.getApplicationDocumentsDirectory();
    // final temp = await pp.getTemporaryDirectory();
    final directory = await pp.getExternalStorageDirectory();
    if (directory == null) return;
    final file = File("${directory.absolute.path}/Pacific_GYM_RECEIPT.pdf");
    log("${directory.absolute.path}/Pacific_GYM_RECEIPT.pdf");
    await file.writeAsBytes(await pdf.save());

    if (openInPdf) {
      await openFile(file);
    } else {
      if (await isInstalled() ?? false) {
        await shareFile(number.trim());
      } else {
        await openFile(file);
      }
    }
  }

  // void generatePDF(String id, String name, String age, String address,
  //     String number, String amount, DateTime date, String duration) async {
  //   await isInstalled();
  // }

  Future<void> openFile(File file) async {
    final res = await OpenFilex.open(file.path);
    print("RES : ${res.type} and ${res.message}");
  }

  Future<bool?> isInstalled() async {
    final bool? val =
        await WhatsappShare.isInstalled(package: Package.whatsapp);
    print('Whatsapp Business is installed: $val');
    return val;
  }

  Future<void> shareFile(String mobile) async {
    final directory = await pp.getExternalStorageDirectory();
    if (directory == null) return;

    log("${directory.absolute.path}/Pacific_GYM_RECEIPT.pdf");
    // log("91$mobile");
    // bool? res = await WhatsappShare.shareFile(
    //   text: 'Pacific GYM Payment receipt',
    //   phone: '91$mobile',
    //   filePath: ['${directory.absolute.path}/Pacific_GYM_RECEIPT.pdf'],
    // );

    // bool? res = await WhatsappShare.share(
    //   text: 'Pacific GYM Payment receipt',
    //   phone: '91$mobile',
    // );

    if (await canLaunchUrl(Uri.parse(
        'whatsapp://send?phone="+91$mobile+"&text=Here is your membership receipt'))) {
      await launchUrl(Uri.parse(
          'whatsapp://send?phone="+91$mobile+"&text=Here is your membership receipt'));
    }
  }
}
