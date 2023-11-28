Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A127FB356
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343903AbjK1H4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbjK1H4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:56:16 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55156F5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:56:19 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 42B7924E2A8;
        Tue, 28 Nov 2023 15:56:16 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 28 Nov
 2023 15:56:16 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 28 Nov
 2023 15:56:15 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Tue, 28 Nov 2023 15:56:15 +0800
From:   JeeHeng Sia <jeeheng.sia@starfivetech.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "conor@kernel.org" <conor@kernel.org>,
        "kernel@esmil.dk" <kernel@esmil.dk>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "emil.renner.berthing@canonical.com" 
        <emil.renner.berthing@canonical.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>
Subject: RE: [PATCH 3/7] dt-bindings: timer: Add StarFive JH8100 clint
Thread-Topic: [PATCH 3/7] dt-bindings: timer: Add StarFive JH8100 clint
Thread-Index: AQHaINIiROvFaqRrFUS69iv/KsB43rCNVRYAgAHfLRD//5qJgIAAj6gQ
Date:   Tue, 28 Nov 2023 07:56:15 +0000
Message-ID: <79191eebdc7b46709bd253da252941a0@EXMBX066.cuchost.com>
References: <20231127013602.253835-1-jeeheng.sia@starfivetech.com>
 <20231127013602.253835-4-jeeheng.sia@starfivetech.com>
 <93526583-ab8f-4ddb-9846-41e4d1834847@kernel.org>
 <d72d6fa58309438385e14c3713918654@EXMBX066.cuchost.com>
 <5820442a-7819-488f-b389-8385531b510f@kernel.org>
In-Reply-To: <5820442a-7819-488f-b389-8385531b510f@kernel.org>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAyOCwgMjAy
MyAzOjIwIFBNDQo+IFRvOiBKZWVIZW5nIFNpYSA8amVlaGVuZy5zaWFAc3RhcmZpdmV0ZWNoLmNv
bT47IHBhdWwud2FsbXNsZXlAc2lmaXZlLmNvbTsgcGFsbWVyQGRhYmJlbHQuY29tOyBhb3VAZWVj
cy5iZXJrZWxleS5lZHU7DQo+IGNvbm9yQGtlcm5lbC5vcmc7IGtlcm5lbEBlc21pbC5kazsgcm9i
aCtkdEBrZXJuZWwub3JnOyBlbWlsLnJlbm5lci5iZXJ0aGluZ0BjYW5vbmljYWwuY29tDQo+IENj
OiBsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBMZXlmb29uIFRhbiA8bGV5Zm9vbi50YW5Ac3RhcmZpdmV0ZWNoLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCAzLzddIGR0LWJpbmRpbmdzOiB0aW1lcjogQWRkIFN0YXJGaXZlIEpI
ODEwMCBjbGludA0KPiANCj4gT24gMjgvMTEvMjAyMyAwNjoyNCwgSmVlSGVuZyBTaWEgd3JvdGU6
DQo+ID4NCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBL
cnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+ID4+IFNlbnQ6IE1vbmRheSwg
Tm92ZW1iZXIgMjcsIDIwMjMgNDo0OCBQTQ0KPiA+PiBUbzogSmVlSGVuZyBTaWEgPGplZWhlbmcu
c2lhQHN0YXJmaXZldGVjaC5jb20+OyBwYXVsLndhbG1zbGV5QHNpZml2ZS5jb207IHBhbG1lckBk
YWJiZWx0LmNvbTsgYW91QGVlY3MuYmVya2VsZXkuZWR1Ow0KPiA+PiBjb25vckBrZXJuZWwub3Jn
OyBrZXJuZWxAZXNtaWwuZGs7IHJvYmgrZHRAa2VybmVsLm9yZzsgZW1pbC5yZW5uZXIuYmVydGhp
bmdAY2Fub25pY2FsLmNvbQ0KPiA+PiBDYzogbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgTGV5Zm9vbiBUYW4gPGxleWZvb24udGFu
QHN0YXJmaXZldGVjaC5jb20+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy83XSBkdC1iaW5k
aW5nczogdGltZXI6IEFkZCBTdGFyRml2ZSBKSDgxMDAgY2xpbnQNCj4gPj4NCj4gPj4gT24gMjcv
MTEvMjAyMyAwMjozNSwgU2lhIEplZSBIZW5nIHdyb3RlOg0KPiA+Pj4gQWRkIGNvbXBhdGlibGUg
c3RyaW5nIGZvciB0aGUgU3RhckZpdmUgSkg4MTAwIGNsaW50DQo+ID4+Pg0KPiA+Pj4gU2lnbmVk
LW9mZi1ieTogU2lhIEplZSBIZW5nIDxqZWVoZW5nLnNpYUBzdGFyZml2ZXRlY2guY29tPg0KPiA+
Pj4gUmV2aWV3ZWQtYnk6IExleSBGb29uIFRhbiA8bGV5Zm9vbi50YW5Ac3RhcmZpdmV0ZWNoLmNv
bT4NCj4gPj4+IC0tLQ0KPiA+Pg0KPiA+PiBQbGVhc2UgdXNlIHNjcmlwdHMvZ2V0X21haW50YWlu
ZXJzLnBsIHRvIGdldCBhIGxpc3Qgb2YgbmVjZXNzYXJ5IHBlb3BsZQ0KPiA+PiBhbmQgbGlzdHMg
dG8gQ0MuIEl0IG1pZ2h0IGhhcHBlbiwgdGhhdCBjb21tYW5kIHdoZW4gcnVuIG9uIGFuIG9sZGVy
DQo+ID4+IGtlcm5lbCwgZ2l2ZXMgeW91IG91dGRhdGVkIGVudHJpZXMuIFRoZXJlZm9yZSBwbGVh
c2UgYmUgc3VyZSB5b3UgYmFzZQ0KPiA+PiB5b3VyIHBhdGNoZXMgb24gcmVjZW50IExpbnV4IGtl
cm5lbC4NCj4gPj4NCj4gPj4gWW91IG1pc3NlZCBhdCBsZWFzdCBkZXZpY2V0cmVlIGxpc3QgKG1h
eWJlIG1vcmUpLCBzbyB0aGlzIHdvbid0IGJlDQo+ID4+IHRlc3RlZCBieSBhdXRvbWF0ZWQgdG9v
bGluZy4gUGVyZm9ybWluZyByZXZpZXcgb24gdW50ZXN0ZWQgY29kZSBtaWdodCBiZQ0KPiA+PiBh
IHdhc3RlIG9mIHRpbWUsIHRodXMgSSB3aWxsIHNraXAgdGhpcyBwYXRjaCBlbnRpcmVseSB0aWxs
IHlvdSBmb2xsb3cNCj4gPj4gdGhlIHByb2Nlc3MgYWxsb3dpbmcgdGhlIHBhdGNoIHRvIGJlIHRl
c3RlZC4NCj4gPj4NCj4gPj4gUGxlYXNlIGtpbmRseSByZXNlbmQgYW5kIGluY2x1ZGUgYWxsIG5l
Y2Vzc2FyeSBUby9DYyBlbnRyaWVzLg0KPiA+IE5vdGVkLiBTaG91bGQgSSByZXNlbmQgdGhlIHBh
dGNoZXMgd2l0aCB0aGUgVjEgdGFnIGFuZCB3aXRoIGFkZHJlc3NlZCBjb21tZW50cz8NCj4gDQo+
IFRoaXMgd2FzIHYxLiBOZXh0IG9uZSBpcyB2Mi4NCk5vdGVkIHdpdGggdGhhbmtzLg0KPiANCj4g
QmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
