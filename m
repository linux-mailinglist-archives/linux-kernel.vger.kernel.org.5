Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AF87FB365
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbjK1H51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjK1H5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:57:21 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD0AC5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:57:26 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id B1D1024DC8B;
        Tue, 28 Nov 2023 15:57:19 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 28 Nov
 2023 15:57:19 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX066.cuchost.com
 (172.16.7.66) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 28 Nov
 2023 15:57:19 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Tue, 28 Nov 2023 15:57:19 +0800
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
Subject: RE: [PATCH 6/7] serial: xilinx_uartps: Add new compatible string for
 StarFive
Thread-Topic: [PATCH 6/7] serial: xilinx_uartps: Add new compatible string for
 StarFive
Thread-Index: AQHaINIphsM8jXvQa0qbM8hLZxm2GLCNVWaAgAG91cD//7vrAIAAj/Xg
Date:   Tue, 28 Nov 2023 07:57:19 +0000
Message-ID: <15b8ae81c5184ce3b42a6ab39a6852d6@EXMBX066.cuchost.com>
References: <20231127013602.253835-1-jeeheng.sia@starfivetech.com>
 <20231127013602.253835-7-jeeheng.sia@starfivetech.com>
 <07fc5ebe-47b2-4843-ad49-36e6686e5a9a@kernel.org>
 <b423574c710b44aabb36cd434693b3e2@EXMBX066.cuchost.com>
 <d6dd14c2-f662-4b82-bc96-7e161cb721c9@kernel.org>
In-Reply-To: <d6dd14c2-f662-4b82-bc96-7e161cb721c9@kernel.org>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAyOCwgMjAy
MyAzOjIxIFBNDQo+IFRvOiBKZWVIZW5nIFNpYSA8amVlaGVuZy5zaWFAc3RhcmZpdmV0ZWNoLmNv
bT47IHBhdWwud2FsbXNsZXlAc2lmaXZlLmNvbTsgcGFsbWVyQGRhYmJlbHQuY29tOyBhb3VAZWVj
cy5iZXJrZWxleS5lZHU7DQo+IGNvbm9yQGtlcm5lbC5vcmc7IGtlcm5lbEBlc21pbC5kazsgcm9i
aCtkdEBrZXJuZWwub3JnOyBlbWlsLnJlbm5lci5iZXJ0aGluZ0BjYW5vbmljYWwuY29tDQo+IENj
OiBsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBMZXlmb29uIFRhbiA8bGV5Zm9vbi50YW5Ac3RhcmZpdmV0ZWNoLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCA2LzddIHNlcmlhbDogeGlsaW54X3VhcnRwczogQWRkIG5ldyBjb21w
YXRpYmxlIHN0cmluZyBmb3IgU3RhckZpdmUNCj4gDQo+IE9uIDI4LzExLzIwMjMgMDY6MjUsIEpl
ZUhlbmcgU2lhIHdyb3RlOg0KPiA+DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gPj4gRnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiA+
PiBTZW50OiBNb25kYXksIE5vdmVtYmVyIDI3LCAyMDIzIDQ6NDkgUE0NCj4gPj4gVG86IEplZUhl
bmcgU2lhIDxqZWVoZW5nLnNpYUBzdGFyZml2ZXRlY2guY29tPjsgcGF1bC53YWxtc2xleUBzaWZp
dmUuY29tOyBwYWxtZXJAZGFiYmVsdC5jb207IGFvdUBlZWNzLmJlcmtlbGV5LmVkdTsNCj4gPj4g
Y29ub3JAa2VybmVsLm9yZzsga2VybmVsQGVzbWlsLmRrOyByb2JoK2R0QGtlcm5lbC5vcmc7IGVt
aWwucmVubmVyLmJlcnRoaW5nQGNhbm9uaWNhbC5jb20NCj4gPj4gQ2M6IGxpbnV4LXJpc2N2QGxp
c3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IExleWZvb24g
VGFuIDxsZXlmb29uLnRhbkBzdGFyZml2ZXRlY2guY29tPg0KPiA+PiBTdWJqZWN0OiBSZTogW1BB
VENIIDYvN10gc2VyaWFsOiB4aWxpbnhfdWFydHBzOiBBZGQgbmV3IGNvbXBhdGlibGUgc3RyaW5n
IGZvciBTdGFyRml2ZQ0KPiA+Pg0KPiA+PiBPbiAyNy8xMS8yMDIzIDAyOjM2LCBTaWEgSmVlIEhl
bmcgd3JvdGU6DQo+ID4+PiBUaGlzIHBhdGNoIGFkZHMgdGhlIG5ldyBjb21wYXRpYmxlIHN0cmlu
ZyBmb3IgU3RhckZpdmUgSkg4MTAwIFNvQw0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IFNp
YSBKZWUgSGVuZyA8amVlaGVuZy5zaWFAc3RhcmZpdmV0ZWNoLmNvbT4NCj4gPj4+IFJldmlld2Vk
LWJ5OiBMZXkgRm9vbiBUYW4gPGxleWZvb24udGFuQHN0YXJmaXZldGVjaC5jb20+DQo+ID4+PiAt
LS0NCj4gPj4+ICBkcml2ZXJzL3R0eS9zZXJpYWwveGlsaW54X3VhcnRwcy5jIHwgMyArKy0NCj4g
Pj4+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4+
Pg0KPiA+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC94aWxpbnhfdWFydHBzLmMg
Yi9kcml2ZXJzL3R0eS9zZXJpYWwveGlsaW54X3VhcnRwcy5jDQo+ID4+PiBpbmRleCA2NmE0NWE2
MzQxNTguLjE3MDkwMWMxNDNjMiAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvdHR5L3Nlcmlh
bC94aWxpbnhfdWFydHBzLmMNCj4gPj4+ICsrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC94aWxpbnhf
dWFydHBzLmMNCj4gPj4+IEBAIC0xMjEwLDcgKzEyMTAsNyBAQCBPRl9FQVJMWUNPTl9ERUNMQVJF
KGNkbnMsICJ4bG54LHh1YXJ0cHMiLCBjZG5zX2Vhcmx5X2NvbnNvbGVfc2V0dXApOw0KPiA+Pj4g
IE9GX0VBUkxZQ09OX0RFQ0xBUkUoY2RucywgImNkbnMsdWFydC1yMXA4IiwgY2Ruc19lYXJseV9j
b25zb2xlX3NldHVwKTsNCj4gPj4+ICBPRl9FQVJMWUNPTl9ERUNMQVJFKGNkbnMsICJjZG5zLHVh
cnQtcjFwMTIiLCBjZG5zX2Vhcmx5X2NvbnNvbGVfc2V0dXApOw0KPiA+Pj4gIE9GX0VBUkxZQ09O
X0RFQ0xBUkUoY2RucywgInhsbngsenlucW1wLXVhcnQiLCBjZG5zX2Vhcmx5X2NvbnNvbGVfc2V0
dXApOw0KPiA+Pj4gLQ0KPiA+Pj4gK09GX0VBUkxZQ09OX0RFQ0xBUkUoY2RucywgInN0YXJmaXZl
LGpoODEwMC11YXJ0IiwgY2Ruc19lYXJseV9jb25zb2xlX3NldHVwKTsNCj4gPj4+DQo+ID4+PiAg
LyogU3RhdGljIHBvaW50ZXIgdG8gY29uc29sZSBwb3J0ICovDQo+ID4+PiAgc3RhdGljIHN0cnVj
dCB1YXJ0X3BvcnQgKmNvbnNvbGVfcG9ydDsNCj4gPj4+IEBAIC0xNDQ4LDYgKzE0NDgsNyBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBjZG5zX3VhcnRfb2ZfbWF0Y2hbXSA9IHsN
Cj4gPj4+ICAJeyAuY29tcGF0aWJsZSA9ICJjZG5zLHVhcnQtcjFwOCIsIH0sDQo+ID4+PiAgCXsg
LmNvbXBhdGlibGUgPSAiY2Rucyx1YXJ0LXIxcDEyIiwgLmRhdGEgPSAmenlucW1wX3VhcnRfZGVm
IH0sDQo+ID4+PiAgCXsgLmNvbXBhdGlibGUgPSAieGxueCx6eW5xbXAtdWFydCIsIC5kYXRhID0g
Jnp5bnFtcF91YXJ0X2RlZiB9LA0KPiA+Pj4gKwl7IC5jb21wYXRpYmxlID0gInN0YXJmaXZlLGpo
ODEwMC11YXJ0IiwgfSwNCj4gPj4NCj4gPj4gV2h5IHlvdSBkbyBub3QgZXhwcmVzcyBjb21wYXRp
YmlsaXR5IGluIHlvdXIgYmluZGluZ3M/IFNraXAgdGhpcyBkcml2ZXINCj4gPj4gY2hhbmdlLg0K
PiA+IFRoZSBjb21wYXRpYmlsaXR5IHN0cmluZyB3YXMgYWRkZWQgdG8gdGhlIGJpbmRpbmcgaW4g
dGhlIDV0aCBwYXRjaC4gV2UgbmVlZCB0byBhZGQgdGhpcyBjb21wYXRpYmlsaXR5IHN0cmluZyB0
byB0aGUgZHJpdmVyLCBhcyB0aGUNCj4gb3RoZXIgY29tcGF0aWJpbGl0aWVzIHdlcmUgdXNlZCBm
b3Igb3RoZXIgU29Dcy4NCj4gDQo+IFlvdSBkaWQgbm90IGFkZCAiY29tcGF0aWJpbGl0eSBzdHJp
bmciIGJ1dCBjb21wYXRpYmxlLiBJIGFtIGFza2luZyB3aHkNCj4geW91IGFyZSBub3QgZXhwcmVz
c2luZyBpbiB5b3VyIGJpbmRpbmdzIHRoZSBjb21wYXRpYmlsaXR5IGJldHdlZW4gdGhpcw0KPiBh
bmQgb3RoZXIgZGV2aWNlcy4NCj4gDQo+IEFuZCBubywgeW91IGRvIG5vdCBuZWVkIGRyaXZlciBj
aGFuZ2UgZm9yIGNvbXBhdGlibGUgZGV2aWNlcywgc28gYWdhaW46DQo+IHNraXAgdGhpcyBkcml2
ZXIgY2hhbmdlLg0KQWxyaWdodCwgSSB3aWxsIHNraXAgdGhpcyBkcml2ZXIgY2hhbmdlLiBUaGFu
a3MuDQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
