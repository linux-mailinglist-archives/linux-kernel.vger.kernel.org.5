Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356767FB09B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbjK1DXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 22:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbjK1DXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 22:23:43 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928E818D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 19:23:44 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id BD51824E284;
        Tue, 28 Nov 2023 11:23:29 +0800 (CST)
Received: from EXMBX163.cuchost.com (172.16.7.73) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 28 Nov
 2023 11:23:29 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX163.cuchost.com
 (172.16.7.73) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 28 Nov
 2023 11:23:29 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Tue, 28 Nov 2023 11:23:29 +0800
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
Subject: RE: [PATCH 7/7] riscv: dts: starfive: Add initial StarFive JH8100
 device tree
Thread-Topic: [PATCH 7/7] riscv: dts: starfive: Add initial StarFive JH8100
 device tree
Thread-Index: AQHaINIsNJmOJgxv1UyTHTa/bh+M/LCNVdGAgAG7ubA=
Date:   Tue, 28 Nov 2023 03:23:29 +0000
Message-ID: <09c51c5301c54659828c5cce748d3762@EXMBX066.cuchost.com>
References: <20231127013602.253835-1-jeeheng.sia@starfivetech.com>
 <20231127013602.253835-8-jeeheng.sia@starfivetech.com>
 <20b13322-3cd1-47b1-bb39-2710ddc59a11@kernel.org>
In-Reply-To: <20b13322-3cd1-47b1-bb39-2710ddc59a11@kernel.org>
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
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIE5vdmVtYmVyIDI3LCAyMDIz
IDQ6NTEgUE0NCj4gVG86IEplZUhlbmcgU2lhIDxqZWVoZW5nLnNpYUBzdGFyZml2ZXRlY2guY29t
PjsgcGF1bC53YWxtc2xleUBzaWZpdmUuY29tOyBwYWxtZXJAZGFiYmVsdC5jb207IGFvdUBlZWNz
LmJlcmtlbGV5LmVkdTsNCj4gY29ub3JAa2VybmVsLm9yZzsga2VybmVsQGVzbWlsLmRrOyByb2Jo
K2R0QGtlcm5lbC5vcmc7IGVtaWwucmVubmVyLmJlcnRoaW5nQGNhbm9uaWNhbC5jb20NCj4gQ2M6
IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IExleWZvb24gVGFuIDxsZXlmb29uLnRhbkBzdGFyZml2ZXRlY2guY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIDcvN10gcmlzY3Y6IGR0czogc3RhcmZpdmU6IEFkZCBpbml0aWFsIFN0
YXJGaXZlIEpIODEwMCBkZXZpY2UgdHJlZQ0KPiANCj4gT24gMjcvMTEvMjAyMyAwMjozNiwgU2lh
IEplZSBIZW5nIHdyb3RlOg0KPiA+IEFkZCBpbml0aWFsIGRldmljZSB0cmVlIGZvciB0aGUgU3Rh
ckZpdmUgSkg4MTAwIFJJU0MtViBTb0MNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNpYSBKZWUg
SGVuZyA8amVlaGVuZy5zaWFAc3RhcmZpdmV0ZWNoLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogTGV5
IEZvb24gVGFuIDxsZXlmb29uLnRhbkBzdGFyZml2ZXRlY2guY29tPg0KPiA+IC0tLQ0KPiA+ICBh
cmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZlL01ha2VmaWxlICAgICAgIHwgICAxICsNCj4gPiAg
YXJjaC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9qaDgxMDAtZXZiLmR0cyB8ICA0MiArKysNCj4g
PiAgYXJjaC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9qaDgxMDAuZHRzaSAgICB8IDM2NSArKysr
KysrKysrKysrKysrKysrKw0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDQwOCBpbnNlcnRpb25zKCsp
DQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2po
ODEwMC1ldmIuZHRzDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3Jpc2N2L2Jvb3QvZHRz
L3N0YXJmaXZlL2poODEwMC5kdHNpDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9i
b290L2R0cy9zdGFyZml2ZS9NYWtlZmlsZSBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvc3RhcmZpdmUv
TWFrZWZpbGUNCj4gPiBpbmRleCAwMTQxNTA0YzBmNWMuLmZiYjBkYzYxOTEwMiAxMDA2NDQNCj4g
PiAtLS0gYS9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZlL01ha2VmaWxlDQo+ID4gKysrIGIv
YXJjaC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9NYWtlZmlsZQ0KPiA+IEBAIC0xMCwzICsxMCw0
IEBAIGR0Yi0kKENPTkZJR19BUkNIX1NUQVJGSVZFKSArPSBqaDcxMDAtc3RhcmZpdmUtdmlzaW9u
Zml2ZS12MS5kdGINCj4gPg0KPiA+ICBkdGItJChDT05GSUdfQVJDSF9TVEFSRklWRSkgKz0gamg3
MTEwLXN0YXJmaXZlLXZpc2lvbmZpdmUtMi12MS4yYS5kdGINCj4gPiAgZHRiLSQoQ09ORklHX0FS
Q0hfU1RBUkZJVkUpICs9IGpoNzExMC1zdGFyZml2ZS12aXNpb25maXZlLTItdjEuM2IuZHRiDQo+
ID4gK2R0Yi0kKENPTkZJR19BUkNIX1NUQVJGSVZFKSArPSBqaDgxMDAtZXZiLmR0Yg0KPiA+IGRp
ZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2poODEwMC1ldmIuZHRzIGIv
YXJjaC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9qaDgxMDAtZXZiLmR0cw0KPiA+IG5ldyBmaWxl
IG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi42N2M0OTY0YTg3NzMNCj4gPiAt
LS0gL2Rldi9udWxsDQo+ID4gKysrIGIvYXJjaC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9qaDgx
MDAtZXZiLmR0cw0KPiA+IEBAIC0wLDAgKzEsNDIgQEANCj4gPiArLy8gU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjAgT1IgTUlUDQo+ID4gKy8qDQo+ID4gKyAqIENvcHlyaWdodCAoYykg
MjAyMS0yMDIzIFN0YXJGaXZlIFRlY2hub2xvZ3kgQ28uLCBMdGQuDQo+ID4gKyAqLw0KPiA+ICsN
Cj4gPiArI2luY2x1ZGUgImpoODEwMC5kdHNpIg0KPiA+ICsNCj4gPiArLyB7DQo+ID4gKwltb2Rl
bCA9ICJTdGFyRml2ZSBKSDgxMDAgRVZCIjsNCj4gPiArCWNvbXBhdGlibGUgPSAic3RhcmZpdmUs
amg4MTAwLWV2YiIsICJzdGFyZml2ZSxqaDgxMDAiOw0KPiA+ICsNCj4gPiArCWFsaWFzZXMgew0K
PiA+ICsJCXNlcmlhbDAgPSAmdWFydDA7DQo+ID4gKwl9Ow0KPiA+ICsNCj4gPiArCWNob3NlbiB7
DQo+ID4gKwkJc3Rkb3V0LXBhdGggPSAic2VyaWFsMDoxMTUyMDBuOCI7DQo+ID4gKwl9Ow0KPiA+
ICsNCj4gPiArCWNwdXMgew0KPiA+ICsJCXRpbWViYXNlLWZyZXF1ZW5jeSA9IDw0MDAwMDAwPjsN
Cj4gDQo+IFRoaXMgd2FzIGZpeGVkIHJlY2VudGx5IG9uIHRoZSBtYWlsaW5nIGxpc3RzLg0KVGhl
IHRpbWViYXNlLWZyZXF1ZW5jeSBvbiBTdGFyRml2ZSBKSDgxMDAgU29DIGlzIHNldCBieSBhbiBp
bnRlcm5hbCBjbGsgZGl2aWRlciwgd2lsbCBtb3ZlIHRoZSBwcm9wZXJ0eSB0byBqaDgxMDAuZHRz
aS4gVGhhbmtzLg0KPiANCj4gDQo+ID4gKw0KPiA+ICsJfTsNCj4gPiArDQo+ID4gKwltZW1vcnkg
ew0KPiA+ICsJCWRldmljZV90eXBlID0gIm1lbW9yeSI7DQo+ID4gKwkJcmVnID0gPDB4MCAweDQw
MDAwMDAwIDB4MiAweDAwMDAwMDAwPjsgLyogOEdCICovDQo+ID4gKwl9Ow0KPiA+ICsNCj4gPiAr
CXNvYyB7DQo+ID4gKwkJY2xrX3VhcnQ6IGNsa191YXJ0IHsNCj4gDQo+IFVuZGVyY29yZXMgYXJl
IG5vdCBhbGxvd2VkIGluIG5vZGUgbmFtZXMuIFVzZSBoeXBoZW4uDQpOb3RlZC4NCj4gDQo+IEFs
c28sIGJvYXJkcyBtdXN0IG5vdCBhZGQgbm9kZXMgdG8gdGhlIHNvYy4gVGhpcyBpcyBib2FyZCwg
bm90IFNvQyBEVFMuDQpOb3RlZC4gV2lsbCBtb3ZlIGl0IHRvIGR0c2kuDQo+IA0KPiAuLi4NCj4g
DQo+ID4gKw0KPiA+ICsJCXVhcnQ2OiBzZXJpYWxAMTI3ZTAwMDAgIHsNCj4gPiArCQkJY29tcGF0
aWJsZSA9ICJzdGFyZml2ZSxqaDgxMDAtdWFydCI7DQo+ID4gKwkJCXJlZyA9IDwweDAgMHgxMjdl
MDAwMCAweDAgMHgxMDAwMD47DQo+ID4gKwkJCWNsb2NrLW5hbWVzID0gInVhcnRfY2xrIiwgInBj
bGsiOw0KPiA+ICsJCQlpbnRlcnJ1cHRzID0gPDczPjsNCj4gPiArCQkJc3RhdHVzID0gImRpc2Fi
bGVkIjsNCj4gPiArCQl9Ow0KPiA+ICsNCj4gDQo+IFN0cmF5IGJsYW5rIGxpbmUuIEluIG90aGVy
IHBsYWNlcyBhcyB3ZWxsLg0KTm90ZWQuDQo+IA0KPiA+ICsJfTsNCj4gPiArfTsNCj4gDQo+IEJl
c3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==
