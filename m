Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7B27FB131
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 06:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343539AbjK1FYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 00:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343536AbjK1FYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 00:24:33 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5D81B8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 21:24:38 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 166A780A7;
        Tue, 28 Nov 2023 13:24:37 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 28 Nov
 2023 13:24:36 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Tue, 28 Nov 2023 13:24:36 +0800
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
Subject: RE: [PATCH 5/7] dt-bindings: xilinx: Add StarFive compatible string
Thread-Topic: [PATCH 5/7] dt-bindings: xilinx: Add StarFive compatible string
Thread-Index: AQHaINInJurIv0YLuk654hbHre31qrCNVUWAgAHcYLA=
Date:   Tue, 28 Nov 2023 05:24:36 +0000
Message-ID: <1bfcd8067e3f4cea815ebb768fc58b5d@EXMBX066.cuchost.com>
References: <20231127013602.253835-1-jeeheng.sia@starfivetech.com>
 <20231127013602.253835-6-jeeheng.sia@starfivetech.com>
 <22cb035d-10b8-41f7-b7c6-5c8ae6627c59@kernel.org>
In-Reply-To: <22cb035d-10b8-41f7-b7c6-5c8ae6627c59@kernel.org>
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
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIE5vdmVtYmVyIDI3LCAyMDIz
IDQ6NDkgUE0NCj4gVG86IEplZUhlbmcgU2lhIDxqZWVoZW5nLnNpYUBzdGFyZml2ZXRlY2guY29t
PjsgcGF1bC53YWxtc2xleUBzaWZpdmUuY29tOyBwYWxtZXJAZGFiYmVsdC5jb207IGFvdUBlZWNz
LmJlcmtlbGV5LmVkdTsNCj4gY29ub3JAa2VybmVsLm9yZzsga2VybmVsQGVzbWlsLmRrOyByb2Jo
K2R0QGtlcm5lbC5vcmc7IGVtaWwucmVubmVyLmJlcnRoaW5nQGNhbm9uaWNhbC5jb20NCj4gQ2M6
IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IExleWZvb24gVGFuIDxsZXlmb29uLnRhbkBzdGFyZml2ZXRlY2guY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIDUvN10gZHQtYmluZGluZ3M6IHhpbGlueDogQWRkIFN0YXJGaXZlIGNv
bXBhdGlibGUgc3RyaW5nDQo+IA0KPiBPbiAyNy8xMS8yMDIzIDAyOjM2LCBTaWEgSmVlIEhlbmcg
d3JvdGU6DQo+ID4gQWRkIHN0YXJmaXZlLGpoODEwMC11YXJ0IGNvbXBhdGlibGUgc3RyaW5nDQo+
IA0KPiBEZXNjcmliZSB0aGUgaGFyZHdhcmUuIFdoeSBpcyBpdCBpbiB4aWxpbng/DQpNeSBiYWQu
IEl0IHNob3VsZCBDRE5TIFVBUlQgZHJpdmVyLiBXaWxsIGZpeCBpdC4NCj4gDQo+IEFsc28sIG1p
c3NpbmcgZnVsbCBzdG9wIGluIGVhY2ggY29tbWl0IG1zZy4NCk5vdGVkLg0KPiANCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IFNpYSBKZWUgSGVuZyA8amVlaGVuZy5zaWFAc3RhcmZpdmV0ZWNoLmNv
bT4NCj4gPiBSZXZpZXdlZC1ieTogTGV5IEZvb24gVGFuIDxsZXlmb29uLnRhbkBzdGFyZml2ZXRl
Y2guY29tPg0KPiA+IC0tLQ0KPiANCj4gUGxlYXNlIHVzZSBzY3JpcHRzL2dldF9tYWludGFpbmVy
cy5wbCB0byBnZXQgYSBsaXN0IG9mIG5lY2Vzc2FyeSBwZW9wbGUNCj4gYW5kIGxpc3RzIHRvIEND
LiBJdCBtaWdodCBoYXBwZW4sIHRoYXQgY29tbWFuZCB3aGVuIHJ1biBvbiBhbiBvbGRlcg0KPiBr
ZXJuZWwsIGdpdmVzIHlvdSBvdXRkYXRlZCBlbnRyaWVzLiBUaGVyZWZvcmUgcGxlYXNlIGJlIHN1
cmUgeW91IGJhc2UNCj4geW91ciBwYXRjaGVzIG9uIHJlY2VudCBMaW51eCBrZXJuZWwuDQo+IA0K
PiBZb3UgbWlzc2VkIGF0IGxlYXN0IGRldmljZXRyZWUgbGlzdCAobWF5YmUgbW9yZSksIHNvIHRo
aXMgd29uJ3QgYmUNCj4gdGVzdGVkIGJ5IGF1dG9tYXRlZCB0b29saW5nLiBQZXJmb3JtaW5nIHJl
dmlldyBvbiB1bnRlc3RlZCBjb2RlIG1pZ2h0IGJlDQo+IGEgd2FzdGUgb2YgdGltZSwgdGh1cyBJ
IHdpbGwgc2tpcCB0aGlzIHBhdGNoIGVudGlyZWx5IHRpbGwgeW91IGZvbGxvdw0KPiB0aGUgcHJv
Y2VzcyBhbGxvd2luZyB0aGUgcGF0Y2ggdG8gYmUgdGVzdGVkLg0KPiANCj4gUGxlYXNlIGtpbmRs
eSByZXNlbmQgYW5kIGluY2x1ZGUgYWxsIG5lY2Vzc2FyeSBUby9DYyBlbnRyaWVzLg0KTm90ZWQu
IFNob3VsZCBJIHJlc2VuZCB0aGUgcGF0Y2hlcyB3aXRoIHRoZSBWMSB0YWcgYW5kIHdpdGggYWRk
cmVzc2VkIGNvbW1lbnRzPw0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
