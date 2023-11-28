Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD0D7FB135
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 06:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbjK1FZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 00:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343538AbjK1FZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 00:25:42 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30409D63
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 21:25:42 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id E7A2424E16E;
        Tue, 28 Nov 2023 13:25:40 +0800 (CST)
Received: from EXMBX164.cuchost.com (172.16.7.74) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 28 Nov
 2023 13:25:40 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX164.cuchost.com
 (172.16.7.74) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 28 Nov
 2023 13:25:40 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Tue, 28 Nov 2023 13:25:40 +0800
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
Thread-Index: AQHaINIphsM8jXvQa0qbM8hLZxm2GLCNVWaAgAG91cA=
Date:   Tue, 28 Nov 2023 05:25:40 +0000
Message-ID: <b423574c710b44aabb36cd434693b3e2@EXMBX066.cuchost.com>
References: <20231127013602.253835-1-jeeheng.sia@starfivetech.com>
 <20231127013602.253835-7-jeeheng.sia@starfivetech.com>
 <07fc5ebe-47b2-4843-ad49-36e6686e5a9a@kernel.org>
In-Reply-To: <07fc5ebe-47b2-4843-ad49-36e6686e5a9a@kernel.org>
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
IDQ6NDkgUE0NCj4gVG86IEplZUhlbmcgU2lhIDxqZWVoZW5nLnNpYUBzdGFyZml2ZXRlY2guY29t
PjsgcGF1bC53YWxtc2xleUBzaWZpdmUuY29tOyBwYWxtZXJAZGFiYmVsdC5jb207IGFvdUBlZWNz
LmJlcmtlbGV5LmVkdTsNCj4gY29ub3JAa2VybmVsLm9yZzsga2VybmVsQGVzbWlsLmRrOyByb2Jo
K2R0QGtlcm5lbC5vcmc7IGVtaWwucmVubmVyLmJlcnRoaW5nQGNhbm9uaWNhbC5jb20NCj4gQ2M6
IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IExleWZvb24gVGFuIDxsZXlmb29uLnRhbkBzdGFyZml2ZXRlY2guY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIDYvN10gc2VyaWFsOiB4aWxpbnhfdWFydHBzOiBBZGQgbmV3IGNvbXBh
dGlibGUgc3RyaW5nIGZvciBTdGFyRml2ZQ0KPiANCj4gT24gMjcvMTEvMjAyMyAwMjozNiwgU2lh
IEplZSBIZW5nIHdyb3RlOg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyB0aGUgbmV3IGNvbXBhdGlibGUg
c3RyaW5nIGZvciBTdGFyRml2ZSBKSDgxMDAgU29DDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBT
aWEgSmVlIEhlbmcgPGplZWhlbmcuc2lhQHN0YXJmaXZldGVjaC5jb20+DQo+ID4gUmV2aWV3ZWQt
Ynk6IExleSBGb29uIFRhbiA8bGV5Zm9vbi50YW5Ac3RhcmZpdmV0ZWNoLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgZHJpdmVycy90dHkvc2VyaWFsL3hpbGlueF91YXJ0cHMuYyB8IDMgKystDQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwveGlsaW54X3VhcnRwcy5jIGIvZHJpdmVycy90
dHkvc2VyaWFsL3hpbGlueF91YXJ0cHMuYw0KPiA+IGluZGV4IDY2YTQ1YTYzNDE1OC4uMTcwOTAx
YzE0M2MyIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC94aWxpbnhfdWFydHBz
LmMNCj4gPiArKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwveGlsaW54X3VhcnRwcy5jDQo+ID4gQEAg
LTEyMTAsNyArMTIxMCw3IEBAIE9GX0VBUkxZQ09OX0RFQ0xBUkUoY2RucywgInhsbngseHVhcnRw
cyIsIGNkbnNfZWFybHlfY29uc29sZV9zZXR1cCk7DQo+ID4gIE9GX0VBUkxZQ09OX0RFQ0xBUkUo
Y2RucywgImNkbnMsdWFydC1yMXA4IiwgY2Ruc19lYXJseV9jb25zb2xlX3NldHVwKTsNCj4gPiAg
T0ZfRUFSTFlDT05fREVDTEFSRShjZG5zLCAiY2Rucyx1YXJ0LXIxcDEyIiwgY2Ruc19lYXJseV9j
b25zb2xlX3NldHVwKTsNCj4gPiAgT0ZfRUFSTFlDT05fREVDTEFSRShjZG5zLCAieGxueCx6eW5x
bXAtdWFydCIsIGNkbnNfZWFybHlfY29uc29sZV9zZXR1cCk7DQo+ID4gLQ0KPiA+ICtPRl9FQVJM
WUNPTl9ERUNMQVJFKGNkbnMsICJzdGFyZml2ZSxqaDgxMDAtdWFydCIsIGNkbnNfZWFybHlfY29u
c29sZV9zZXR1cCk7DQo+ID4NCj4gPiAgLyogU3RhdGljIHBvaW50ZXIgdG8gY29uc29sZSBwb3J0
ICovDQo+ID4gIHN0YXRpYyBzdHJ1Y3QgdWFydF9wb3J0ICpjb25zb2xlX3BvcnQ7DQo+ID4gQEAg
LTE0NDgsNiArMTQ0OCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGNkbnNf
dWFydF9vZl9tYXRjaFtdID0gew0KPiA+ICAJeyAuY29tcGF0aWJsZSA9ICJjZG5zLHVhcnQtcjFw
OCIsIH0sDQo+ID4gIAl7IC5jb21wYXRpYmxlID0gImNkbnMsdWFydC1yMXAxMiIsIC5kYXRhID0g
Jnp5bnFtcF91YXJ0X2RlZiB9LA0KPiA+ICAJeyAuY29tcGF0aWJsZSA9ICJ4bG54LHp5bnFtcC11
YXJ0IiwgLmRhdGEgPSAmenlucW1wX3VhcnRfZGVmIH0sDQo+ID4gKwl7IC5jb21wYXRpYmxlID0g
InN0YXJmaXZlLGpoODEwMC11YXJ0IiwgfSwNCj4gDQo+IFdoeSB5b3UgZG8gbm90IGV4cHJlc3Mg
Y29tcGF0aWJpbGl0eSBpbiB5b3VyIGJpbmRpbmdzPyBTa2lwIHRoaXMgZHJpdmVyDQo+IGNoYW5n
ZS4NClRoZSBjb21wYXRpYmlsaXR5IHN0cmluZyB3YXMgYWRkZWQgdG8gdGhlIGJpbmRpbmcgaW4g
dGhlIDV0aCBwYXRjaC4gV2UgbmVlZCB0byBhZGQgdGhpcyBjb21wYXRpYmlsaXR5IHN0cmluZyB0
byB0aGUgZHJpdmVyLCBhcyB0aGUgb3RoZXIgY29tcGF0aWJpbGl0aWVzIHdlcmUgdXNlZCBmb3Ig
b3RoZXIgU29Dcy4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==
