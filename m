Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7757FD438
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjK2KdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjK2KdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:33:07 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025C1F4;
        Wed, 29 Nov 2023 02:33:12 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 95B8024DB83;
        Wed, 29 Nov 2023 18:33:11 +0800 (CST)
Received: from EXMBX067.cuchost.com (172.16.6.67) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 29 Nov
 2023 18:33:11 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX067.cuchost.com
 (172.16.6.67) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 29 Nov
 2023 18:33:11 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Wed, 29 Nov 2023 18:33:11 +0800
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
Subject: RE: [PATCH v2 5/6] dt-bindings: serial: cdns: Add new compatible
 string for StarFive JH8100 UART
Thread-Topic: [PATCH v2 5/6] dt-bindings: serial: cdns: Add new compatible
 string for StarFive JH8100 UART
Thread-Index: AQHaIomVReB7ZsOIbUqhwwRlprdVx7CQcD2AgACjd5A=
Date:   Wed, 29 Nov 2023 10:33:11 +0000
Message-ID: <d5a3a8798333431fbb2aee573383a8e4@EXMBX066.cuchost.com>
References: <20231129060043.368874-1-jeeheng.sia@starfivetech.com>
 <20231129060043.368874-6-jeeheng.sia@starfivetech.com>
 <8f2f241d-580a-4906-949a-b99b5a600868@linaro.org>
In-Reply-To: <8f2f241d-580a-4906-949a-b99b5a600868@linaro.org>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXks
IE5vdmVtYmVyIDI5LCAyMDIzIDQ6MjYgUE0NCj4gVG86IEplZUhlbmcgU2lhIDxqZWVoZW5nLnNp
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
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiA1LzZdIGR0LWJpbmRpbmdzOiBzZXJpYWw6
IGNkbnM6IEFkZCBuZXcgY29tcGF0aWJsZSBzdHJpbmcgZm9yIFN0YXJGaXZlIEpIODEwMCBVQVJU
DQo+IA0KPiBPbiAyOS8xMS8yMDIzIDA3OjAwLCBTaWEgSmVlIEhlbmcgd3JvdGU6DQo+ID4gQWRk
IG5ldyBjb21wYXRpYmxlIHN0cmluZyBmb3IgVUFSVCBpbiB0aGUgU3RhckZpdmUgSkg4MTAwIFNv
Qy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNpYSBKZWUgSGVuZyA8amVlaGVuZy5zaWFAc3Rh
cmZpdmV0ZWNoLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogTGV5IEZvb24gVGFuIDxsZXlmb29uLnRh
bkBzdGFyZml2ZXRlY2guY29tPg0KPiANCj4gVGhlIHBhdGNoIGlzIHF1aXRlIGRpZmZlcmVudCB0
aGFuIHYxLiBBcmUgeW91IHN1cmUgdGhlIHJldmlldyBpcw0KPiBhcHBsaWNhYmxlPyBJZiBpdCB3
YXMgZ2l2ZW4gZm9yIHYyLCB3aGVyZSBpcyBpdD8NClRoaXMgcGF0Y2ggaXMgaW1wYWN0ZWQgYnkg
dGhlIGNvbW1lbnQgc3VnZ2VzdGluZyB0aGUgZXhjbHVzaW9uIG9mIHBhdGNoIDUgaW4gVjEuIElu
IFYyLCB0aGlzIHBhdGNoIGFkZHMgY29tcGF0aWJsZSBmb3IgY2Rucy11YXJ0LXIxcDgsIGFsbG93
aW5nIHVzIHRvIGNvbnRpbnVlIHVzaW5nIHRoZSBjZG5zIHVhcnQuDQo+IA0KPiA+IC0tLQ0KPiA+
ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc2VyaWFsL2NkbnMsdWFydC55YW1s
IHwgNCArKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc2VyaWFsL2Nk
bnMsdWFydC55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NlcmlhbC9j
ZG5zLHVhcnQueWFtbA0KPiA+IGluZGV4IGUzNWFkMTEwOWVmYy4uMGQwNTMwNTc3OGYyIDEwMDY0
NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zZXJpYWwvY2Ru
cyx1YXJ0LnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
c2VyaWFsL2NkbnMsdWFydC55YW1sDQo+ID4gQEAgLTIwLDYgKzIwLDEwIEBAIHByb3BlcnRpZXM6
DQo+ID4gICAgICAgICAgaXRlbXM6DQo+ID4gICAgICAgICAgICAtIGNvbnN0OiB4bG54LHp5bnFt
cC11YXJ0DQo+ID4gICAgICAgICAgICAtIGNvbnN0OiBjZG5zLHVhcnQtcjFwMTINCj4gPiArICAg
ICAgLSBkZXNjcmlwdGlvbjogVUFSVCBjb250cm9sbGVyIGZvciBTdGFyRml2ZSBKSDgxMDAgU29D
DQo+IA0KPiBUaGlzIGlzIGR1cGxpY2F0aW5nIGNvbXBhdGlibGUsIGRyb3AuDQpEbyB5b3UgbWVh
biBkcm9wIGNvbXBhdGlibGUgZm9yIHN0YXJmaXZlLGpoODEwMC11YXJ0ID8NCj4gDQo+ID4gKyAg
ICAgICAgaXRlbXM6DQo+ID4gKyAgICAgICAgICAtIGNvbnN0OiBzdGFyZml2ZSxqaDgxMDAtdWFy
dA0KPiA+ICsgICAgICAgICAgLSBjb25zdDogY2Rucyx1YXJ0LXIxcDgNCj4gDQo+IERvbid0IGFk
ZCB0aGluZ3MgdG8gdGhlIGVuZCBvZiB0aGUgbGlzdCwgYnV0IGtlZXAgb3JkZXIuIEkgd291bGQg
c3VnZ2VzdA0KPiB0byBwdXQgaXQgYXQgdGhlIGJlZ2lubmluZywgc28gYmVmb3JlIFhpbGlueC4N
CkknbSB0cnlpbmcgdG8gZ2V0IHdoYXQgeW91J3JlIGFza2luZywgYnV0IGl0J3MgYSBiaXQgY29u
ZnVzaW5nIGZvciBtZS4gU28sIEkgdGhvdWdodCBpdCBtaWdodCBiZSBlYXNpZXIgaWYgSSBqdXN0
IHNoYXJlIHRoZSBjb2RlIGJlbG93LiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgdGhpcyBhZGRyZXNz
ZXMgeW91ciBjb21tZW50Pw0KcHJvcGVydGllczoNCiAgY29tcGF0aWJsZToNCiAgICBvbmVPZjoN
CiAgICAgIC0gZGVzY3JpcHRpb246IFVBUlQgY29udHJvbGxlciBmb3IgU3RhckZpdmUgSkg4MTAw
IFNvQw0KICAgICAgICBpdGVtczoNCiAgICAgICAgICAtIGNvbnN0OiBjZG5zLHVhcnQtcjFwOA0K
ICAgICAgLSBkZXNjcmlwdGlvbjogVUFSVCBjb250cm9sbGVyIGZvciBaeW5xLTd4eHggU29DDQog
ICAgICAgIGl0ZW1zOg0KICAgICAgICAgIC0gY29uc3Q6IHhsbngseHVhcnRwcw0KICAgICAgICAg
IC0gY29uc3Q6IGNkbnMsdWFydC1yMXA4DQogICAgICAtIGRlc2NyaXB0aW9uOiBVQVJUIGNvbnRy
b2xsZXIgZm9yIFp5bnEgVWx0cmFzY2FsZSsgTVBTb0MNCiAgICAgICAgaXRlbXM6DQogICAgICAg
ICAgLSBjb25zdDogeGxueCx6eW5xbXAtdWFydA0KICAgICAgICAgIC0gY29uc3Q6IGNkbnMsdWFy
dC1yMXAxMg0KPiANCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==
