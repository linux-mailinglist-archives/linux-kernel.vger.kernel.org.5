Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9A47B1692
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjI1Izm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjI1Izj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:55:39 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6394AC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:55:37 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-218-icZ6iOlVPO2szhBa61zbSw-1; Thu, 28 Sep 2023 09:55:18 +0100
X-MC-Unique: icZ6iOlVPO2szhBa61zbSw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 28 Sep
 2023 09:55:17 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 28 Sep 2023 09:55:17 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alexey Dobriyan' <adobriyan@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "Jason@zx2c4.com" <Jason@zx2c4.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: RE: + minmax-add-umina-b-and-umaxa-b.patch added to mm-nonmm-unstable
 branch
Thread-Topic: + minmax-add-umina-b-and-umaxa-b.patch added to
 mm-nonmm-unstable branch
Thread-Index: AQHZ8ec1aUNi4FjMMkSWNfrfKdrokrAv65tw
Date:   Thu, 28 Sep 2023 08:55:17 +0000
Message-ID: <decc112eaf2b4edca53b9a8f2d70ddf9@AcuMS.aculab.com>
References: <20230927173033.AF86DC433C7@smtp.kernel.org>
 <d74a3644-1d03-42c7-b258-4d5d63416ee0@p183>
 <ZRSJ5QMNGV7ObfrL@casper.infradead.org>
 <b1198988-b60e-41e2-99bf-6af145e1d201@p183>
In-Reply-To: <b1198988-b60e-41e2-99bf-6af145e1d201@p183>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQWxleGV5IERvYnJpeWFuDQo+IFNlbnQ6IDI4IFNlcHRlbWJlciAyMDIzIDA5OjM5DQo+
IA0KPiBPbiBXZWQsIFNlcCAyNywgMjAyMyBhdCAwOTowMDozN1BNICswMTAwLCBNYXR0aGV3IFdp
bGNveCB3cm90ZToNCj4gPiBPbiBXZWQsIFNlcCAyNywgMjAyMyBhdCAxMDoyMTo0MVBNICswMzAw
LCBBbGV4ZXkgRG9icml5YW4gd3JvdGU6DQo+ID4gPiBPbiBXZWQsIFNlcCAyNywgMjAyMyBhdCAx
MDozMDozM0FNIC0wNzAwLCBBbmRyZXcgTW9ydG9uIHdyb3RlOg0KPiA+ID4gPiArI2RlZmluZSB1
bWluKHgsIHkpCVwNCj4gPiA+ID4gKwlfX2NhcmVmdWxfY21wKCh4KSArIDB1ICsgMHVsICsgMHVs
bCwgKHkpICsgMHUgKyAwdWwgKyAwdWxsLCA8KQ0KPiA+ID4NCj4gPiA+IGttaW4oKSBhbmQga21h
eCgpIGFyZSAob2YgY291cnNlISkgbXVjaCBiZXR0ZXIgbmFtZXMuDQo+ID4NCj4gPiBpdCdzIHVu
c2lnbmVkLCBub3QgdXNlci4NCg0KTGludXMgc3VnZ2VzdGVkIHVtaW4oKSBhcyBiZWluZyBtdWNo
IHNob3J0ZXIgdGhhbiB0aGUgbWluX3Vuc2lnbmVkKCkNCkknZCBvcmlnaW5hbGx5IHVzZWQuDQoN
Cj4gWWVzLCBidXQgdGhlIHNhbWUgaWRlYSBhcHBsaWVzIHRvIHNpZ25lZCB0eXBlczoNCg0KVGhl
IGtlcm5lbCBwcmV0dHkgbXVjaCBuZXZlciB3YW50cyBhIGNhc3QgdG8gY29udmVydCBhIGxhcmdl
DQp1bnNpZ25lZCB2YWx1ZSB0byBhIG5lZ2F0aXZlIHNpZ25lZCBvbmUuDQpJZiB0aGUgdHlwZXMg
bWlzbWF0Y2ggYm90aCB2YWx1ZXMgYXJlIG5vcm1hbGx5IG5vbi1uZWdhdGl2ZQ0Kc28gZG9pbmcg
YW4gdW5zaWduZWQgY29tcGFyZSBpcyByaWdodC4NCklmIHlvdSBkbyBuZWVkIHRvIHRyZWF0IDB1
IC0gMSBhcyBhIHNpZ25lZCB2YWx1ZSB0aGVuIGFkZGluZw0KYW4gZXhwbGljaXQgY2FzdCBpcyBw
cm9iYWJseSBhIGdvb2QgaWRlYSENCg0KPiBtaW4sIG1heCByZXF1aXJlIGlkZW50aWNhbCB0eXBl
cw0KPiBtaW5fdCBmb3JjZSB0eXBlDQo+IGttaW4sIGttYXggYXJlIHJlbGF4ZWQgbWluL21heCB2
ZXJzaW9ucyBpZiBzaWduZWRuZXNzZXMgbWF0Y2guDQoNClRoZSAnaWRlbnRpY2FsIHR5cGVzJyBj
YXNlIGlzIHBvaW50bGVzcywgYW5kIHRoZSAnZm9yY2UgdHlwZScNCm9mdGVuIGJ1Z2d5Lg0KDQpU
aGUgb25seSByZWFzb24gZm9yIGFueSB0eXBlLWNoZWNrIGlzIHRvIHN0b3AgJ2ludGVnZXIgcHJv
bW90aW9uJw0KY29udmVydGluZyBhIG5lZ2F0aXZlIHZhbHVlIHRvIGEgdmVyeSBsYXJnZSB1bnNp
Z25lZCBvbmUuDQpBbmQgZXZlbiB0aGF0IGlzbid0IHdoeSB0aGUgdHlwZWNoZWNrIHdhcyBhZGRl
ZCB0byBtaW4oKS4NCihUaGF0IGlzLCB0aGVyZSBpcyBubyBpbmRpY2F0aW9uIHRoYXQgaXQgZXZl
ciBjYXVzZWQgYSBidWcuKQ0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2Vz
aWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVL
DQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

