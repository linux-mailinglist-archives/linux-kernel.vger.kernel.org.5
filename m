Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2471B7FD45C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjK2KgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjK2KgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:36:01 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0518C1BFB;
        Wed, 29 Nov 2023 02:35:28 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 8DA1724DBCE;
        Wed, 29 Nov 2023 18:35:20 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 29 Nov
 2023 18:35:20 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 29 Nov
 2023 18:35:19 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Wed, 29 Nov 2023 18:35:20 +0800
From:   JeeHeng Sia <jeeheng.sia@starfivetech.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "kernel@esmil.dk" <kernel@esmil.dk>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "conor@kernel.org" <conor@kernel.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "michal.simek@amd.com" <michal.simek@amd.com>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        "drew@beagleboard.org" <drew@beagleboard.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>
Subject: RE: [PATCH v2 2/6] dt-bindings: riscv: Add StarFive JH8100 SoC
Thread-Topic: [PATCH v2 2/6] dt-bindings: riscv: Add StarFive JH8100 SoC
Thread-Index: AQHaIol9aAocnWtYekK6RWgAjEqLk7CQcGuAgACp5ZA=
Date:   Wed, 29 Nov 2023 10:35:20 +0000
Message-ID: <9f5648c3dbaa4f7ba2c600c125e0837a@EXMBX066.cuchost.com>
References: <20231129060043.368874-1-jeeheng.sia@starfivetech.com>
 <20231129060043.368874-3-jeeheng.sia@starfivetech.com>
 <76a13e48-5053-4fdc-8089-710943e52e29@linaro.org>
In-Reply-To: <76a13e48-5053-4fdc-8089-710943e52e29@linaro.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [60.54.3.230]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXks
IE5vdmVtYmVyIDI5LCAyMDIzIDQ6MjcgUE0NCj4gVG86IEplZUhlbmcgU2lhIDxqZWVoZW5nLnNp
YUBzdGFyZml2ZXRlY2guY29tPjsga2VybmVsQGVzbWlsLmRrOyByb2JoK2R0QGtlcm5lbC5vcmc7
IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsNCj4ga3J6a0BrZXJuZWwub3JnOyBj
b25vcitkdEBrZXJuZWwub3JnOyBwYXVsLndhbG1zbGV5QHNpZml2ZS5jb207IHBhbG1lckBkYWJi
ZWx0LmNvbTsgYW91QGVlY3MuYmVya2VsZXkuZWR1Ow0KPiBkYW5pZWwubGV6Y2Fub0BsaW5hcm8u
b3JnOyB0Z2x4QGxpbnV0cm9uaXguZGU7IGNvbm9yQGtlcm5lbC5vcmc7IGFudXBAYnJhaW5mYXVs
dC5vcmc7IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOw0KPiBqaXJpc2xhYnlAa2VybmVsLm9y
ZzsgbWljaGFsLnNpbWVrQGFtZC5jb207IE1pY2hhZWwgWmh1IDxtaWNoYWVsLnpodUBzdGFyZml2
ZXRlY2guY29tPjsgZHJld0BiZWFnbGVib2FyZC5vcmcNCj4gQ2M6IGRldmljZXRyZWVAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBMZXlmb29uIFRhbg0KPiA8bGV5Zm9vbi50YW5Ac3RhcmZpdmV0ZWNo
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAyLzZdIGR0LWJpbmRpbmdzOiByaXNjdjog
QWRkIFN0YXJGaXZlIEpIODEwMCBTb0MNCj4gDQo+IE9uIDI5LzExLzIwMjMgMDc6MDAsIFNpYSBK
ZWUgSGVuZyB3cm90ZToNCj4gPiBBZGQgZGV2aWNlIHRyZWUgYmluZGluZ3MgZm9yIHRoZSBTdGFy
Rml2ZSBKSDgxMDAgUklTQy1WIFNvQy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNpYSBKZWUg
SGVuZyA8amVlaGVuZy5zaWFAc3RhcmZpdmV0ZWNoLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogTGV5
IEZvb24gVGFuIDxsZXlmb29uLnRhbkBzdGFyZml2ZXRlY2guY29tPg0KPiA+IC0tLQ0KPiA+ICBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmlzY3Yvc3RhcmZpdmUueWFtbCB8IDUg
KysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9yaXNjdi9zdGFyZml2ZS55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3Jpc2N2L3N0YXJmaXZlLnlhbWwNCj4gPiBpbmRleCBjYzRkOTJmMGExYmYuLjdlMmRhOWVlZjNk
YiAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvcmlz
Y3Yvc3RhcmZpdmUueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9yaXNjdi9zdGFyZml2ZS55YW1sDQo+ID4gQEAgLTI5LDcgKzI5LDEwIEBAIHByb3BlcnRp
ZXM6DQo+ID4gICAgICAgICAgICAgICAgLSBzdGFyZml2ZSx2aXNpb25maXZlLTItdjEuMmENCj4g
PiAgICAgICAgICAgICAgICAtIHN0YXJmaXZlLHZpc2lvbmZpdmUtMi12MS4zYg0KPiA+ICAgICAg
ICAgICAgLSBjb25zdDogc3RhcmZpdmUsamg3MTEwDQo+ID4gLQ0KPiA+ICsgICAgICAtIGl0ZW1z
Og0KPiA+ICsgICAgICAgICAgLSBlbnVtOg0KPiA+ICsgICAgICAgICAgICAgIC0gc3RhcmZpdmUs
amg4MTAwLWV2Yg0KPiA+ICsgICAgICAgICAgLSBjb25zdDogc3RhcmZpdmUsamg4MTAwDQo+IA0K
PiBXaHkgZGlkIHlvdSByZW1vdmUgdGhlIGJsYW5rIGxpbmU/IE5vIG5lZWQgZm9yIGRvaW5nIHRo
YXQuDQpOb3RlZC4gV2lsbCBmaXggaXQuDQo+IA0KPiA+ICBhZGRpdGlvbmFsUHJvcGVydGllczog
dHJ1ZQ0KPiA+DQo+ID4gIC4uLg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
