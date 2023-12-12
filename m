Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEB880E23F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345823AbjLLCre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjLLCrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:47:22 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A93123;
        Mon, 11 Dec 2023 18:47:26 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 00D1424E29B;
        Tue, 12 Dec 2023 10:47:25 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 12 Dec
 2023 10:47:24 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 12 Dec
 2023 10:47:24 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Tue, 12 Dec 2023 10:47:24 +0800
From:   JeeHeng Sia <jeeheng.sia@starfivetech.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "kernel@esmil.dk" <kernel@esmil.dk>,
        "conor@kernel.org" <conor@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "emil.renner.berthing@canonical.com" 
        <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>
Subject: RE: [PATCH v1 05/16] dt-bindings: clock: Add StarFive JH8100 System
 clock and reset generator
Thread-Topic: [PATCH v1 05/16] dt-bindings: clock: Add StarFive JH8100 System
 clock and reset generator
Thread-Index: AQHaKDp4JclXcVkKt02w6zhm85IHbbCfKBKAgAW3QzA=
Date:   Tue, 12 Dec 2023 02:47:23 +0000
Message-ID: <090f2d44fc8b4113b5b5e002d15b0675@EXMBX066.cuchost.com>
References: <20231206115000.295825-1-jeeheng.sia@starfivetech.com>
 <20231206115000.295825-6-jeeheng.sia@starfivetech.com>
 <1ebb4733-0f1d-46ea-b399-34af7df088ac@linaro.org>
In-Reply-To: <1ebb4733-0f1d-46ea-b399-34af7df088ac@linaro.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [202.188.176.82]
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
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBTYXR1cmRheSwg
RGVjZW1iZXIgOSwgMjAyMyAxOjUzIEFNDQo+IFRvOiBKZWVIZW5nIFNpYSA8amVlaGVuZy5zaWFA
c3RhcmZpdmV0ZWNoLmNvbT47IGtlcm5lbEBlc21pbC5kazsgY29ub3JAa2VybmVsLm9yZzsgcm9i
aCtkdEBrZXJuZWwub3JnOw0KPiBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7IHBh
dWwud2FsbXNsZXlAc2lmaXZlLmNvbTsgcGFsbWVyQGRhYmJlbHQuY29tOyBhb3VAZWVjcy5iZXJr
ZWxleS5lZHU7DQo+IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOyBzYm95ZEBrZXJuZWwub3JnOyBw
LnphYmVsQHBlbmd1dHJvbml4LmRlOyBlbWlsLnJlbm5lci5iZXJ0aGluZ0BjYW5vbmljYWwuY29t
OyBIYWwgRmVuZw0KPiA8aGFsLmZlbmdAc3RhcmZpdmV0ZWNoLmNvbT47IFhpbmd5dSBXdSA8eGlu
Z3l1Lnd1QHN0YXJmaXZldGVjaC5jb20+DQo+IENjOiBsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRl
YWQub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtY2xrQHZnZXIua2VybmVsLm9yZzsgTGV5Zm9vbiBUYW4NCj4gPGxleWZv
b24udGFuQHN0YXJmaXZldGVjaC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDUvMTZd
IGR0LWJpbmRpbmdzOiBjbG9jazogQWRkIFN0YXJGaXZlIEpIODEwMCBTeXN0ZW0gY2xvY2sgYW5k
IHJlc2V0IGdlbmVyYXRvcg0KPiANCj4gT24gMDYvMTIvMjAyMyAxMjo0OSwgU2lhIEplZSBIZW5n
IHdyb3RlOg0KPiA+IEFkZCBiaW5kaW5ncyBmb3IgdGhlIFN5c3RlbSBjbG9ja3MgYW5kIHJlc2V0
IGdlbmVyYXRvcg0KPiA+IChTWVNDUkcpIG9uIEpIODEwMCBTb0MuDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBTaWEgSmVlIEhlbmcgPGplZWhlbmcuc2lhQHN0YXJmaXZldGVjaC5jb20+DQo+ID4g
UmV2aWV3ZWQtYnk6IExleSBGb29uIFRhbiA8bGV5Zm9vbi50YW5Ac3RhcmZpdmV0ZWNoLmNvbT4N
Cj4gPiAtLS0NCj4gDQo+IC4uLg0KPiANCj4gPiArICBjbG9ja3M6DQo+ID4gKyAgICBpdGVtczoN
Cj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogTWFpbiBPc2NpbGxhdG9yICgyNCBNSHopDQo+ID4g
KyAgICAgIC0gZGVzY3JpcHRpb246IEV4dGVybmFsIEkyUyBSeCBCQ0xLIGNsb2NrDQo+ID4gKyAg
ICAgIC0gZGVzY3JpcHRpb246IEV4dGVybmFsIEkyUyBSeCBMUkNLIGNsb2NrDQo+ID4gKyAgICAg
IC0gZGVzY3JpcHRpb246IEV4dGVybmFsIE1DTEsgY2xvY2sNCj4gPiArDQo+ID4gKyAgY2xvY2st
bmFtZXM6DQo+ID4gKyAgICBpdGVtczoNCj4gPiArICAgICAgLSBjb25zdDogY2xrX29zYw0KPiA+
ICsgICAgICAtIGNvbnN0OiBjbGtfaTJzcnhfYmNsa19leHQNCj4gPiArICAgICAgLSBjb25zdDog
Y2xrX2kyc3J4X2xyY2tfZXh0DQo+ID4gKyAgICAgIC0gY29uc3Q6IGNsa19tY2xrX2V4dA0KPiAN
Cj4gRHJvcCBjbGtfIHByZWZpeGVzIGV2ZXJ5d2hlcmUuDQpOb3RlZC4NCj4gDQo+ID4gKw0KPiA+
ICsgICcjY2xvY2stY2VsbHMnOg0KPiA+ICsgICAgY29uc3Q6IDENCj4gPiArICAgIGRlc2NyaXB0
aW9uOg0KPiA+ICsgICAgICBTZWUgPGR0LWJpbmRpbmdzL2Nsb2NrL3N0YXJmaXZlLGpoODEwMC1j
cmcuaD4gZm9yIHZhbGlkIGluZGljZXMuDQo+ID4gKw0KPiA+ICsgICcjcmVzZXQtY2VsbHMnOg0K
PiA+ICsgICAgY29uc3Q6IDENCj4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ICsgICAgICBTZWUg
PGR0LWJpbmRpbmdzL3Jlc2V0L3N0YXJmaXZlLWpoODEwMC1jcmcuaD4gZm9yIHZhbGlkIGluZGlj
ZXMuDQo+ID4gKw0KPiA+ICtyZXF1aXJlZDoNCj4gPiArICAtIGNvbXBhdGlibGUNCj4gPiArICAt
IHJlZw0KPiA+ICsgIC0gY2xvY2tzDQo+ID4gKyAgLSBjbG9jay1uYW1lcw0KPiA+ICsgIC0gJyNj
bG9jay1jZWxscycNCj4gPiArICAtICcjcmVzZXQtY2VsbHMnDQo+ID4gKw0KPiA+ICthZGRpdGlv
bmFsUHJvcGVydGllczogZmFsc2UNCj4gPiArDQo+ID4gK2V4YW1wbGVzOg0KPiA+ICsgIC0gfA0K
PiA+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2Nsb2NrL3N0YXJmaXZlLGpoODEwMC1jcmcu
aD4NCj4gPiArDQo+ID4gKyAgICBjbG9jay1jb250cm9sbGVyQDEyNmQwMDAwIHsNCj4gPiArICAg
ICAgICAgICAgY29tcGF0aWJsZSA9ICJzdGFyZml2ZSxqaDgxMDAtc3lzY3JnIjsNCj4gDQo+IFVz
ZSA0IHNwYWNlcyBmb3IgZXhhbXBsZSBpbmRlbnRhdGlvbi4NCk5vdGVkDQo+IA0KPiA+ICsgICAg
ICAgICAgICByZWcgPSA8MHgxMjZkMDAwMCAweDEwMDAwPjsNCj4gPiArICAgICAgICAgICAgY2xv
Y2tzID0gPCZjbGtfb3NjPiwgPCZjbGtfaTJzcnhfYmNsa19leHQ+LA0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICA8JmNsa19pMnNyeF9scmNrX2V4dD4sIDwmY2xrX21jbGtfZXh0PjsNCj4gPiAr
ICAgICAgICAgICAgY2xvY2stbmFtZXMgPSAiY2xrX29zYyIsICJjbGtfaTJzcnhfYmNsa19leHQi
LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICJjbGtfaTJzcnhfbHJja19leHQiLCAi
Y2xrX21jbGtfZXh0IjsNCj4gPiArICAgICAgICAgICAgI2Nsb2NrLWNlbGxzID0gPDE+Ow0KPiA+
ICsgICAgICAgICAgICAjcmVzZXQtY2VsbHMgPSA8MT47DQo+ID4gKyAgICB9Ow0KPiA+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL3N0YXJmaXZlLGpoODEwMC1jcmcuaCBi
L2luY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svc3RhcmZpdmUsamg4MTAwLWNyZy5oDQo+ID4gbmV3
IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLmU1YmI1ODhjZTc5OA0K
PiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9pbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL3N0
YXJmaXZlLGpoODEwMC1jcmcuaA0KPiA+IEBAIC0wLDAgKzEsMTIzIEBADQo+ID4gKy8qIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wIE9SIE1JVCAqLw0KPiANCj4gSG93IGFib3V0IGtl
ZXBpbmcgdGhlIHNhbWUgbGljZW5zZSBhcyBiaW5kaW5nPw0KU2hvdWxkbid0IGIgYSBwcm9ibGVt
Lg0KPiANCj4gPiArLyoNCj4gPiArICogQ29weXJpZ2h0IChDKSAyMDIzIFN0YXJGaXZlIFRlY2hu
b2xvZ3kgQ28uLCBMdGQuDQo+ID4gKyAqIFNpYSBKZWUgSGVuZyA8amVlaGVuZy5zaWFAc3RhcmZp
dmV0ZWNoLmNvbT4NCj4gPiArICoNCj4gPiArICovDQo+ID4gKw0KPiANCj4gLi4uDQo+IA0KPiA+
ICsjZGVmaW5lIFNZU0NSR19DTEtfTk5FX0lDR19FTgkJCQkJCTEwOA0KPiA+ICsNCj4gPiArI2Rl
ZmluZSBTWVNDUkdfQ0xLX0VORAkJCQkJCQkxMDkNCj4gDQo+IERyb3AgZnJvbSBiaW5kaW5nIGhl
YWRlci4NCkRvIHlvdSBtZWFuIGRvbuKAmXQgZGVmaW5lIHRoZSBudW1iZXIgb2YgY2xrIGluIHRo
ZSBoZWFkZXI/IEknbGwgaGF2ZSB0byBkZWZpbmUNCkl0IGluIHRoZSBkcml2ZXIgdGhlbi4uDQo+
IA0KPiA+ICsjZW5kaWYgLyogX19EVF9CSU5ESU5HU19DTE9DS19TVEFSRklWRV9KSDgxMDBfSF9f
ICovDQo+IA0KPiAuLi4NCj4gDQo+ID4gKyAqLw0KPiA+ICsjZGVmaW5lIFNZU0NSR19SU1ROX1NZ
U19TWVNDT04JCQkJCTANCj4gPiArI2RlZmluZSBTWVNDUkdfUlNUTl9DTEtfTU9ECQkJCQkxDQo+
ID4gKyNkZWZpbmUgU1lTQ1JHX1JTVE5fR1BVCQkJCQkJMg0KPiA+ICsjZGVmaW5lIFNZU0NSR19S
U1ROX0dQVV9TUFUJCQkJCTMNCj4gPiArI2RlZmluZSBTWVNDUkdfUlNUTl9HUFVfVFZTRU5TT1IJ
CQkJNA0KPiA+ICsjZGVmaW5lIFNZU0NSR19SU1ROX1BQVV9PUF9OT1JFVF9HUFVfUkVTRVQJCQk1
DQo+ID4gKyNkZWZpbmUgU1lTQ1JHX1JTVE5fTk5FCQkJCQkJNg0KPiA+ICsjZGVmaW5lIFNZU0NS
R19SU1ROX0hEX0FVRElPCQkJCQk3DQo+ID4gKw0KPiA+ICsjZGVmaW5lIFNZU0NSR19SRVNFVF9O
Ul9SRVNFVFMJCQkJCTgNCj4gDQo+IERyb3AgZnJvbSBiaW5kaW5nIGhlYWRlci4NCkRvIHlvdSBt
ZWFuIGRvbuKAmXQgZGVmaW5lIHRoZSBudW1iZXIgb2YgcmVzZXQgaW4gdGhlIGhlYWRlcj8gSSds
bCBoYXZlIHRvIGRlZmluZQ0KSXQgaW4gdGhlIGRyaXZlciB0aGVuLi4NCj4gDQo+ID4gKw0KPiA+
ICsjZW5kaWYgLyogX19EVF9CSU5ESU5HU19SRVNFVF9TVEFSRklWRV9KSDgxMDBfSF9fICovDQo+
IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=
