Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840DF786751
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 08:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239975AbjHXGDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 02:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239944AbjHXGDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 02:03:24 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D50D10E4;
        Wed, 23 Aug 2023 23:03:21 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37O62eZiA003121, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37O62eZiA003121
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Aug 2023 14:02:40 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 24 Aug 2023 14:03:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 24 Aug 2023 14:03:02 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Thu, 24 Aug 2023 14:03:02 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
CC:     Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v1 2/2] dt-bindings: extcon: Add Realtek DHC RTD SoC Type-C
Thread-Topic: [PATCH v1 2/2] dt-bindings: extcon: Add Realtek DHC RTD SoC
 Type-C
Thread-Index: AQHZ1ONxPQNQ8ikjYkmsM4V64Zamr6/17aQAgAMBw+A=
Date:   Thu, 24 Aug 2023 06:03:02 +0000
Message-ID: <ca406c19e59145fd9e7e035ea5ad3eeb@realtek.com>
References: <20230822102846.4683-1-stanley_chang@realtek.com>
 <20230822102846.4683-2-stanley_chang@realtek.com>
 <1e0632d6-73e9-4633-a709-bf9140f2fd32@linaro.org>
In-Reply-To: <1e0632d6-73e9-4633-a709-bf9140f2fd32@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQo+IE9uIDIyLzA4LzIwMjMgMTI6MjgsIFN0YW5sZXkgQ2hhbmcgd3Jv
dGU6DQo+ID4gRG9jdW1lbnQgdGhlIGRldmljZS10cmVlIGJpbmRpbmdzIGZvciBSZWFsdGVrIFNv
Q3MgVHlwZS1DLg0KPiA+IFJlYWx0ZWsgREhDIChkaWdpdGFsIGhvbWUgY2VudGVyKSBSVEQgU29D
cyBzdXBwb3J0IGEgVHlwZS1DIG1vZHVsZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFN0YW5s
ZXkgQ2hhbmcgPHN0YW5sZXlfY2hhbmdAcmVhbHRlay5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9i
aW5kaW5ncy9leHRjb24vZXh0Y29uLXJ0ay10eXBlLWMueWFtbCAgICB8IDc3ICsrKysrKysrKysr
KysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDc3IGluc2VydGlvbnMoKykNCj4gPiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0DQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2V4
dGNvbi9leHRjb24tcnRrLXR5cGUtYy55YW1sDQo+IA0KPiBGaWxlbmFtZSBsaWtlIGNvbXBhdGli
bGUuDQoNCkkgd2lsbCByZW5hbWUuDQoNCj4gPg0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9leHRjb24vZXh0Y29uLXJ0ay10eXBlLWMueWFt
bA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2V4dGNvbi9leHRjb24t
cnRrLXR5cGUtYy55YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAw
MDAwMDAwMDAuLmQxNGI5ZWU1NDRiOQ0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZXh0Y29uL2V4dGNvbi1ydGstdHlwZS1jLnlh
bWwNCj4gPiBAQCAtMCwwICsxLDc3IEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6
IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKSAjIENvcHlyaWdodA0KPiA+ICsyMDIzIFJl
YWx0ZWsgU2VtaWNvbmR1Y3RvciBDb3Jwb3JhdGlvbiAlWUFNTCAxLjINCj4gPiArLS0tDQo+ID4g
KyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvZXh0Y29uL2V4dGNvbi1ydGstdHlw
ZS1jLnlhbWwjDQo+ID4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVt
YXMvY29yZS55YW1sIw0KPiA+ICsNCj4gPiArdGl0bGU6IFJlYWx0ZWsgREhDIFJURCBTb0NzIFVT
QiBUeXBlLUMgZGV0ZWN0aW9uDQo+IA0KPiBUeXBlLWMgdXN1YWxseSBnbyB0byB1c2IgZGlyZWN0
b3J5Lg0KDQpUaGlzIGJpbmRpbmcgaXMgbm90IGZvciBhIHR5cGUtYyBjb250cm9sbGVyLg0KSXQg
aXMgYW4gZXh0Y29uIGRldmljZSBmb3IgdHlwZS1jIGNvbm5lY3RvciBkZXRlY3Rpb24uDQpTbyBJ
IHB1dCBpdCBhdCBleHRjb24gZGlyZWN0b3J5Lg0KDQpBbmQgSSB3aWxsIGFkZCDigJxjb25uZWN0
b3LigJ0gdG8gdGhlIHRpdGxlLg0KdGl0bGU6IFJlYWx0ZWsgREhDIFJURCBTb0NzIFVTQiBUeXBl
LUMgQ29ubmVjdG9yIGRldGVjdGlvbg0KDQo+ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0gU3Rh
bmxleSBDaGFuZyA8c3RhbmxleV9jaGFuZ0ByZWFsdGVrLmNvbT4NCj4gPiArDQo+ID4gK2Rlc2Ny
aXB0aW9uOiB8DQo+IA0KPiBEbyBub3QgbmVlZCAnfCcgdW5sZXNzIHlvdSBuZWVkIHRvIHByZXNl
cnZlIGZvcm1hdHRpbmcuDQoNCk9rDQoNCj4gPiArICBSZWFsdGVrIGRpZ2l0YWwgaG9tZSBjZW50
ZXIgKERIQykgUlREIHNlcmllcyBTb0NzIGluY2x1ZGUgYSB0eXBlIGMNCj4gbW9kdWxlLg0KPiA+
ICsgIFRoaXMgbW9kdWxlIGlzIGFibGUgdG8gZGV0ZWN0IHRoZSBzdGF0ZSBvZiB0eXBlIGMgY29u
bmVjdG9yLg0KPiA+ICsNCj4gPiArcHJvcGVydGllczoNCj4gPiArICBjb21wYXRpYmxlOg0KPiA+
ICsgICAgZW51bToNCj4gPiArICAgICAgLSByZWFsdGVrLHJ0ZDEyOTUtdHlwZS1jDQo+ID4gKyAg
ICAgIC0gcmVhbHRlayxydGQxMzEyYy10eXBlLWMNCj4gPiArICAgICAgLSByZWFsdGVrLHJ0ZDEz
MTVlLXR5cGUtYw0KPiA+ICsgICAgICAtIHJlYWx0ZWsscnRkMTMxOS10eXBlLWMNCj4gPiArICAg
ICAgLSByZWFsdGVrLHJ0ZDEzMTlkLXR5cGUtYw0KPiA+ICsgICAgICAtIHJlYWx0ZWsscnRkMTM5
NS10eXBlLWMNCj4gPiArICAgICAgLSByZWFsdGVrLHJ0ZDE2MTktdHlwZS1jDQo+ID4gKyAgICAg
IC0gcmVhbHRlayxydGQxNjE5Yi10eXBlLWMNCj4gPiArDQo+ID4gKyAgcmVnOg0KPiA+ICsgICAg
bWF4SXRlbXM6IDENCj4gPiArICAgIGRlc2NyaXB0aW9uOiBBZGRyZXNzIGFuZCBsZW5ndGggb2Yg
cmVnaXN0ZXIgc2V0IGZvciB0eXBlLWMgbW9kdWxlLg0KPiANCj4gRHJvcCBkZXNjcmlwdGlvbiwg
aXQncyBvYnZpb3VzLg0KDQpPay4NCg0KPiA+ICsNCj4gPiArICBpbnRlcnJ1cHRzOg0KPiA+ICsg
ICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgbnZtZW0tY2VsbHM6DQo+ID4gKyAgICBtYXhJ
dGVtczogMQ0KPiA+ICsgICAgZGVzY3JpcHRpb246DQo+ID4gKyAgICAgIFRoZSBwaGFuZGxlIHRv
IG52bWVtIGNlbGwgdGhhdCBjb250YWlucyB0aGUgdHJpbW1pbmcgZGF0YS4NCj4gPiArICAgICAg
SWYgdW5zcGVjaWZpZWQsIGRlZmF1bHQgdmFsdWUgaXMgdXNlZC4NCj4gPiArDQo+ID4gKyAgcGlu
Y3RybC1uYW1lczoNCj4gPiArICAgIGNvbnN0OiBkZWZhdWx0DQo+ID4gKyAgICBkZXNjcmlwdGlv
bjogQSBwaW5jdHJsIHN0YXRlIG5hbWVzICJkZWZhdWx0IiBtdXN0IGJlIGRlZmluZWQuDQo+IA0K
PiBEcm9wLCBwcm9wZXJ0eSBub3QgbmVlZGVkLg0KDQpPaw0KDQo+ID4gKw0KPiA+ICsgIHBpbmN0
cmwtMDoNCj4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ICsgICAgICBTaG91bGQgY29udGFpbiBk
ZWZhdWx0IHBpbmN0cmwuDQo+IA0KPiBEcm9wLCBwcm9wZXJ0eSBub3QgbmVlZGVkLg0KPiANCk9r
Lg0KPiANCj4gPiArDQo+ID4gKyAgbnZtZW0tY2VsbC1uYW1lczoNCj4gPiArICAgIGNvbnN0OiB1
c2ItY2FsDQo+IA0KPiBpdGVtczoNCj4gICAtIGNvbnN0OiB1c2ItY2FsDQoNCj4gDQo+IGFuZCBt
b3ZlIGRlc2NyaXB0aW9uIHRvIG52bWVtLWNlbGxzLg0KPiANCj4gPiArICAgIGRlc2NyaXB0aW9u
Og0KPiA+ICsgICAgICBUaGUgdHlwZSBjIHBhcmFtZXRlciB0cmltbWluZyBkYXRhIHNwZWNpZmll
ZCB2aWEgZWZ1c2UuDQo+IA0KPiBLZWVwIHNhbWUgcHJvcGVydGllcyBuZXh0IHRvIGVhY2ggb3Ro
ZXIuIG52bWVtLWNlbGxzIHNob3VsZCBiZSBmb2xsb3dlZCBieQ0KPiBudm1lbS1jZWxsLW5hbWVz
Lg0KPiANCj4gPiArDQo+ID4gKyAgcmVhbHRlayxyZC1jdHJsLWdwaW86DQo+ID4gKyAgICBkZXNj
cmlwdGlvbjogVGhlIGdwaW8gbm9kZSB0byBjb250cm9sIGV4dGVybmFsIFJkIG9uIGJvYXJkLg0K
PiANCj4gVGhlIG5hbWVzIGFyZSBhbHdheXMgImdwaW9zIi4NCg0KRG8geW91IG1lYW4gInJlYWx0
ZWsscmQtY3RybC1ncGlvcyIgPw0KPiANCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiAN
Cj4gWW91IG1pc3MgaGVyZSBjb25uZWN0b3IuIFByb2JhYmx5IGFsc28gVkJVUyBzdXBwbHkgYW5k
IG90aGVyIHN1cHBsaWVzLg0KPiANCk9rLCBJIHdpbGwgYWRkIGNvbm5lY3Rvci4NCg0KPiA+ICty
ZXF1aXJlZDoNCj4gPiArICAtIGNvbXBhdGlibGUNCj4gPiArICAtIHJlZw0KPiA+ICsgIC0gaW50
ZXJydXB0cw0KPiA+ICsNCj4gPiArYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+ID4gKw0K
PiA+ICtleGFtcGxlczoNCj4gPiArICAtIHwNCj4gPiArICAgIHR5cGUtY0A3MjIwIHsNCj4gPiAr
ICAgICAgICBjb21wYXRpYmxlID0gInJlYWx0ZWsscnRkMTYxOWItdHlwZS1jIjsNCj4gPiArICAg
ICAgICByZWcgPSA8MHg3MjIwIDB4MjA+Ow0KPiA+ICsgICAgICAgIGludGVycnVwdHMgPSA8MCA2
MCA0PjsNCj4gDQo+IFVzZSBwcm9wZXIgZGVmaW5lcyBmb3IgY29tbW9uIGNvbnN0YW50cy4NCg0K
T2ssIEkgd2lsbCByZXZpc2UgdGhpcy4NCg0KPiA+ICsNCj4gPiArICAgICAgICBwaW5jdHJsLW5h
bWVzID0gImRlZmF1bHQiOw0KPiA+ICsgICAgICAgIHBpbmN0cmwtMCA9IDwmdXNiX2NjMV9waW5z
PiwgPCZ1c2JfY2MyX3BpbnM+Ow0KDQpZb3UgbWVudGlvbiB0aGF0IHRoZSBwcm9wZXJ0eSBvZiBw
aW5jdHJsIG5vdCBuZWVkIGluIGRvYy4NCkRvIEkgbmVlZCB0byBhZGQgdGhlIHByb3BlcnR5IG9m
IHBpbnRybCBpbiBleGFtcGxlPw0KDQo+ID4gKyAgICAgICAgbnZtZW0tY2VsbHMgPSA8Jm90cF91
c2JfY2FsPjsNCj4gPiArICAgICAgICBudm1lbS1jZWxsLW5hbWVzID0gInVzYi1jYWwiOw0KPiAN
Cj4gVHlwZS1jIHdpdGhvdXQgY29ubmVjdG9yPyBUaGlzIGlzIGluY29tcGxldGUuDQoNCk9rLCBJ
IHdpbGwgYWRkIGNvbm5lY3Rvci4NCg0KDQpUaGFua3MsDQpTdGFubGV5DQo=
