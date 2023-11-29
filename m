Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105447FD7BA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbjK2NQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjK2NQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:16:01 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06B885;
        Wed, 29 Nov 2023 05:16:01 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id B8FCB24E03E;
        Wed, 29 Nov 2023 21:15:52 +0800 (CST)
Received: from EXMBX162.cuchost.com (172.16.6.72) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 29 Nov
 2023 21:15:52 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX162.cuchost.com
 (172.16.6.72) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 29 Nov
 2023 21:15:52 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Wed, 29 Nov 2023 21:15:52 +0800
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
Thread-Index: AQHaIomVReB7ZsOIbUqhwwRlprdVx7CQcD2AgACjd5D//4WkAIAArSFA
Date:   Wed, 29 Nov 2023 13:15:52 +0000
Message-ID: <a0181b9c536a4692bab5eb827af1636c@EXMBX066.cuchost.com>
References: <20231129060043.368874-1-jeeheng.sia@starfivetech.com>
 <20231129060043.368874-6-jeeheng.sia@starfivetech.com>
 <8f2f241d-580a-4906-949a-b99b5a600868@linaro.org>
 <d5a3a8798333431fbb2aee573383a8e4@EXMBX066.cuchost.com>
 <068ca34d-a930-4542-bde3-4fbb4c228807@linaro.org>
In-Reply-To: <068ca34d-a930-4542-bde3-4fbb4c228807@linaro.org>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXks
IE5vdmVtYmVyIDI5LCAyMDIzIDY6NTMgUE0NCj4gVG86IEplZUhlbmcgU2lhIDxqZWVoZW5nLnNp
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
DQo+IA0KPiBPbiAyOS8xMS8yMDIzIDExOjMzLCBKZWVIZW5nIFNpYSB3cm90ZToNCj4gPg0KPiA+
DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEtyenlzenRvZiBL
b3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gPj4gU2VudDogV2Vk
bmVzZGF5LCBOb3ZlbWJlciAyOSwgMjAyMyA0OjI2IFBNDQo+ID4+IFRvOiBKZWVIZW5nIFNpYSA8
amVlaGVuZy5zaWFAc3RhcmZpdmV0ZWNoLmNvbT47IGtlcm5lbEBlc21pbC5kazsgcm9iaCtkdEBr
ZXJuZWwub3JnOyBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7DQo+ID4+IGtyemtA
a2VybmVsLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsgcGF1bC53YWxtc2xleUBzaWZpdmUuY29t
OyBwYWxtZXJAZGFiYmVsdC5jb207IGFvdUBlZWNzLmJlcmtlbGV5LmVkdTsNCj4gPj4gZGFuaWVs
LmxlemNhbm9AbGluYXJvLm9yZzsgdGdseEBsaW51dHJvbml4LmRlOyBjb25vckBrZXJuZWwub3Jn
OyBhbnVwQGJyYWluZmF1bHQub3JnOyBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsNCj4gPj4g
amlyaXNsYWJ5QGtlcm5lbC5vcmc7IG1pY2hhbC5zaW1la0BhbWQuY29tOyBNaWNoYWVsIFpodSA8
bWljaGFlbC56aHVAc3RhcmZpdmV0ZWNoLmNvbT47IGRyZXdAYmVhZ2xlYm9hcmQub3JnDQo+ID4+
IENjOiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgTGV5Zm9vbiBUYW4NCj4gPj4g
PGxleWZvb24udGFuQHN0YXJmaXZldGVjaC5jb20+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djIgNS82XSBkdC1iaW5kaW5nczogc2VyaWFsOiBjZG5zOiBBZGQgbmV3IGNvbXBhdGlibGUgc3Ry
aW5nIGZvciBTdGFyRml2ZSBKSDgxMDAgVUFSVA0KPiA+Pg0KPiA+PiBPbiAyOS8xMS8yMDIzIDA3
OjAwLCBTaWEgSmVlIEhlbmcgd3JvdGU6DQo+ID4+PiBBZGQgbmV3IGNvbXBhdGlibGUgc3RyaW5n
IGZvciBVQVJUIGluIHRoZSBTdGFyRml2ZSBKSDgxMDAgU29DLg0KPiA+Pj4NCj4gPj4+IFNpZ25l
ZC1vZmYtYnk6IFNpYSBKZWUgSGVuZyA8amVlaGVuZy5zaWFAc3RhcmZpdmV0ZWNoLmNvbT4NCj4g
Pj4+IFJldmlld2VkLWJ5OiBMZXkgRm9vbiBUYW4gPGxleWZvb24udGFuQHN0YXJmaXZldGVjaC5j
b20+DQo+ID4+DQo+ID4+IFRoZSBwYXRjaCBpcyBxdWl0ZSBkaWZmZXJlbnQgdGhhbiB2MS4gQXJl
IHlvdSBzdXJlIHRoZSByZXZpZXcgaXMNCj4gPj4gYXBwbGljYWJsZT8gSWYgaXQgd2FzIGdpdmVu
IGZvciB2Miwgd2hlcmUgaXMgaXQ/DQo+ID4gVGhpcyBwYXRjaCBpcyBpbXBhY3RlZCBieSB0aGUg
Y29tbWVudCBzdWdnZXN0aW5nIHRoZSBleGNsdXNpb24gb2YgcGF0Y2ggNSBpbiBWMS4gSW4gVjIs
IHRoaXMgcGF0Y2ggYWRkcyBjb21wYXRpYmxlIGZvciBjZG5zLXVhcnQtDQo+IHIxcDgsIGFsbG93
aW5nIHVzIHRvIGNvbnRpbnVlIHVzaW5nIHRoZSBjZG5zIHVhcnQuDQo+IA0KPiBQbGVhc2Ugd3Jh
cCB5b3VyIHJlcGxpZXMuDQpJIGFtIHNvcnJ5LCBidXQgbWF5IEkga25vdyB0aGUgcHJlZmVycmVk
IGxlbmd0aCBvZiBjaGFyYWN0ZXJzPw0KPiANCj4gSG93IGRvZXMgdGhpcyBhbnN3ZXIgbXkgY29u
Y2VybiBhYm91dCByZXZpZXcgdGFnPw0KTXkgYmFkLiBJIHNob3VsZCBoYXZlIG9idGFpbmVkIHlv
dXIgY29uc2Vuc3VzIGJlZm9yZSBwcm9jZWVkaW5nIHdpdGggdGhlIGNoYW5nZXMNCnRvIHRoaXMg
cGF0Y2gsIGVzcGVjaWFsbHkgYWZ0ZXIgZHJvcHBpbmcgcGF0Y2ggNSBhcyByZXF1ZXN0ZWQgaW4g
dmVyc2lvbiAxLg0KPiANCj4gRG8geW91IHVuZGVyc3RhbmQgdGhhdCBteSBjb21tZW50cyBhcmUg
aW5saW5lIHVuZGVyIHRoZSBleGFjdCBsaW5lIHdoaWNoDQo+IGlzIHF1ZXN0aW9uZWQ/DQpZZXMs
IGxlc3NvbiBsZWFybmVkLg0KPiANCj4gPj4NCj4gPj4+IC0tLQ0KPiA+Pj4gIERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9zZXJpYWwvY2Rucyx1YXJ0LnlhbWwgfCA0ICsrKysNCj4g
Pj4+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+ID4+Pg0KPiA+Pj4gZGlmZiAt
LWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zZXJpYWwvY2Rucyx1YXJ0
LnlhbWwNCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc2VyaWFsL2NkbnMs
dWFydC55YW1sDQo+ID4+PiBpbmRleCBlMzVhZDExMDllZmMuLjBkMDUzMDU3NzhmMiAxMDA2NDQN
Cj4gPj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zZXJpYWwvY2Ru
cyx1YXJ0LnlhbWwNCj4gPj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9zZXJpYWwvY2Rucyx1YXJ0LnlhbWwNCj4gPj4+IEBAIC0yMCw2ICsyMCwxMCBAQCBwcm9wZXJ0
aWVzOg0KPiA+Pj4gICAgICAgICAgaXRlbXM6DQo+ID4+PiAgICAgICAgICAgIC0gY29uc3Q6IHhs
bngsenlucW1wLXVhcnQNCj4gPj4+ICAgICAgICAgICAgLSBjb25zdDogY2Rucyx1YXJ0LXIxcDEy
DQo+ID4+PiArICAgICAgLSBkZXNjcmlwdGlvbjogVUFSVCBjb250cm9sbGVyIGZvciBTdGFyRml2
ZSBKSDgxMDAgU29DDQo+ID4+DQo+ID4+IFRoaXMgaXMgZHVwbGljYXRpbmcgY29tcGF0aWJsZSwg
ZHJvcC4NCj4gPiBEbyB5b3UgbWVhbiBkcm9wIGNvbXBhdGlibGUgZm9yIHN0YXJmaXZlLGpoODEw
MC11YXJ0ID8NCj4gDQo+IE5vLCBkcm9wIGRlc2NyaXB0aW9uIGFuZCB1c2UgZGlyZWN0bHkgIiAt
IGl0ZW1zIg0KT2suDQo+IA0KPiA+Pg0KPiA+Pj4gKyAgICAgICAgaXRlbXM6DQo+ID4+PiArICAg
ICAgICAgIC0gY29uc3Q6IHN0YXJmaXZlLGpoODEwMC11YXJ0DQo+ID4+PiArICAgICAgICAgIC0g
Y29uc3Q6IGNkbnMsdWFydC1yMXA4DQo+ID4+DQo+ID4+IERvbid0IGFkZCB0aGluZ3MgdG8gdGhl
IGVuZCBvZiB0aGUgbGlzdCwgYnV0IGtlZXAgb3JkZXIuIEkgd291bGQgc3VnZ2VzdA0KPiA+PiB0
byBwdXQgaXQgYXQgdGhlIGJlZ2lubmluZywgc28gYmVmb3JlIFhpbGlueC4NCj4gPiBJJ20gdHJ5
aW5nIHRvIGdldCB3aGF0IHlvdSdyZSBhc2tpbmcsIGJ1dCBpdCdzIGEgYml0IGNvbmZ1c2luZyBm
b3IgbWUuIFNvLCBJIHRob3VnaHQgaXQgbWlnaHQgYmUgZWFzaWVyIGlmIEkganVzdCBzaGFyZSB0
aGUgY29kZSBiZWxvdy4NCj4gUGxlYXNlIGxldCBtZSBrbm93IGlmIHRoaXMgYWRkcmVzc2VzIHlv
dXIgY29tbWVudD8NCj4gPiBwcm9wZXJ0aWVzOg0KPiA+ICAgY29tcGF0aWJsZToNCj4gPiAgICAg
b25lT2Y6DQo+ID4gICAgICAgLSBkZXNjcmlwdGlvbjogVUFSVCBjb250cm9sbGVyIGZvciBTdGFy
Rml2ZSBKSDgxMDAgU29DDQo+ID4gICAgICAgICBpdGVtczoNCj4gPiAgICAgICAgICAgLSBjb25z
dDogY2Rucyx1YXJ0LXIxcDgNCj4gDQo+IE9yZGVyIGlzIGZpeGVkLCB0aGFua3MuIEJ1dCBkcm9w
IGRlc2NyaXB0aW9uIGFuZCBicmluZyBiYWNrIHNwZWNpZmljDQo+IGNvbXBhdGlibGUuIFlvdSBt
dXN0IGhhdmUgc3BlY2lmaWMgY29tcGF0aWJsZXMsIGFsd2F5cy4NCk5vdGVkLg0KPiANCj4gDQo+
IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=
