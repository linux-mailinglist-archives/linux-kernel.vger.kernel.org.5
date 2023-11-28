Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BFC7FB12F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 06:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343533AbjK1FYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 00:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbjK1FY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 00:24:29 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FC8E1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 21:24:33 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 1D1DD24E176;
        Tue, 28 Nov 2023 13:24:30 +0800 (CST)
Received: from EXMBX162.cuchost.com (172.16.6.72) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 28 Nov
 2023 13:24:29 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX162.cuchost.com
 (172.16.6.72) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 28 Nov
 2023 13:24:29 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Tue, 28 Nov 2023 13:24:29 +0800
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
Thread-Index: AQHaINIiROvFaqRrFUS69iv/KsB43rCNVRYAgAHfLRA=
Date:   Tue, 28 Nov 2023 05:24:29 +0000
Message-ID: <d72d6fa58309438385e14c3713918654@EXMBX066.cuchost.com>
References: <20231127013602.253835-1-jeeheng.sia@starfivetech.com>
 <20231127013602.253835-4-jeeheng.sia@starfivetech.com>
 <93526583-ab8f-4ddb-9846-41e4d1834847@kernel.org>
In-Reply-To: <93526583-ab8f-4ddb-9846-41e4d1834847@kernel.org>
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
IDQ6NDggUE0NCj4gVG86IEplZUhlbmcgU2lhIDxqZWVoZW5nLnNpYUBzdGFyZml2ZXRlY2guY29t
PjsgcGF1bC53YWxtc2xleUBzaWZpdmUuY29tOyBwYWxtZXJAZGFiYmVsdC5jb207IGFvdUBlZWNz
LmJlcmtlbGV5LmVkdTsNCj4gY29ub3JAa2VybmVsLm9yZzsga2VybmVsQGVzbWlsLmRrOyByb2Jo
K2R0QGtlcm5lbC5vcmc7IGVtaWwucmVubmVyLmJlcnRoaW5nQGNhbm9uaWNhbC5jb20NCj4gQ2M6
IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IExleWZvb24gVGFuIDxsZXlmb29uLnRhbkBzdGFyZml2ZXRlY2guY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIDMvN10gZHQtYmluZGluZ3M6IHRpbWVyOiBBZGQgU3RhckZpdmUgSkg4
MTAwIGNsaW50DQo+IA0KPiBPbiAyNy8xMS8yMDIzIDAyOjM1LCBTaWEgSmVlIEhlbmcgd3JvdGU6
DQo+ID4gQWRkIGNvbXBhdGlibGUgc3RyaW5nIGZvciB0aGUgU3RhckZpdmUgSkg4MTAwIGNsaW50
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaWEgSmVlIEhlbmcgPGplZWhlbmcuc2lhQHN0YXJm
aXZldGVjaC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IExleSBGb29uIFRhbiA8bGV5Zm9vbi50YW5A
c3RhcmZpdmV0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gDQo+IFBsZWFzZSB1c2Ugc2NyaXB0cy9nZXRf
bWFpbnRhaW5lcnMucGwgdG8gZ2V0IGEgbGlzdCBvZiBuZWNlc3NhcnkgcGVvcGxlDQo+IGFuZCBs
aXN0cyB0byBDQy4gSXQgbWlnaHQgaGFwcGVuLCB0aGF0IGNvbW1hbmQgd2hlbiBydW4gb24gYW4g
b2xkZXINCj4ga2VybmVsLCBnaXZlcyB5b3Ugb3V0ZGF0ZWQgZW50cmllcy4gVGhlcmVmb3JlIHBs
ZWFzZSBiZSBzdXJlIHlvdSBiYXNlDQo+IHlvdXIgcGF0Y2hlcyBvbiByZWNlbnQgTGludXgga2Vy
bmVsLg0KPiANCj4gWW91IG1pc3NlZCBhdCBsZWFzdCBkZXZpY2V0cmVlIGxpc3QgKG1heWJlIG1v
cmUpLCBzbyB0aGlzIHdvbid0IGJlDQo+IHRlc3RlZCBieSBhdXRvbWF0ZWQgdG9vbGluZy4gUGVy
Zm9ybWluZyByZXZpZXcgb24gdW50ZXN0ZWQgY29kZSBtaWdodCBiZQ0KPiBhIHdhc3RlIG9mIHRp
bWUsIHRodXMgSSB3aWxsIHNraXAgdGhpcyBwYXRjaCBlbnRpcmVseSB0aWxsIHlvdSBmb2xsb3cN
Cj4gdGhlIHByb2Nlc3MgYWxsb3dpbmcgdGhlIHBhdGNoIHRvIGJlIHRlc3RlZC4NCj4gDQo+IFBs
ZWFzZSBraW5kbHkgcmVzZW5kIGFuZCBpbmNsdWRlIGFsbCBuZWNlc3NhcnkgVG8vQ2MgZW50cmll
cy4NCk5vdGVkLiBTaG91bGQgSSByZXNlbmQgdGhlIHBhdGNoZXMgd2l0aCB0aGUgVjEgdGFnIGFu
ZCB3aXRoIGFkZHJlc3NlZCBjb21tZW50cz8NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6
dG9mDQoNCg==
