Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BCB7F10D1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbjKTKw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbjKTKwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:52:24 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF8E9C;
        Mon, 20 Nov 2023 02:52:19 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AKAoiUhB743768, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AKAoiUhB743768
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 18:50:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 20 Nov 2023 18:50:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 20 Nov 2023 18:50:43 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Mon, 20 Nov 2023 18:50:43 +0800
From:   =?utf-8?B?SnlhbiBDaG91IFvlkajoirflrold?= <jyanchou@realtek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
        "riteshh@codeaurora.org" <riteshh@codeaurora.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "doug@schmorgal.com" <doug@schmorgal.com>,
        "tonyhuang.sunplus@gmail.com" <tonyhuang.sunplus@gmail.com>,
        "abel.vesa@linaro.org" <abel.vesa@linaro.org>,
        "william.qiu@starfivetech.com" <william.qiu@starfivetech.com>
Subject: RE: [PATCH V6][4/4] dt-bindings: mmc: Add dt-bindings for realtek mmc driver
Thread-Topic: [PATCH V6][4/4] dt-bindings: mmc: Add dt-bindings for realtek
 mmc driver
Thread-Index: AQHaEuWlfJtZ+jPaVUukiyPJyMGBZ7BxpgmAgBFuqOA=
Date:   Mon, 20 Nov 2023 10:50:43 +0000
Message-ID: <f471b7e2d1b54e05a92d70f6479305e2@realtek.com>
References: <20231109082043.27147-1-jyanchou@realtek.com>
 <20231109082043.27147-5-jyanchou@realtek.com>
 <71ca3812-9226-4a83-a655-78401e4ed33f@linaro.org>
In-Reply-To: <71ca3812-9226-4a83-a655-78401e4ed33f@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.190.236]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gRG9jdW1lbnQgdGhlIGRldmljZS10cmVlIGJpbmRpbmdzIGZvciBSZWFsdGVrIFNvQ3MgbW1j
IGRyaXZlci4NCg0KPiBTdWJqZWN0IGFuZCBjb21taXQgbXNnIC0gZHJvcCBkcml2ZXIgYW5kIGRl
c2NyaWJlIGhhcmR3YXJlIGluc3RlYWQuDQo+IHMvbW1jL01NQy8NCg0KPj4NCj4+IFNpZ25lZC1v
ZmYtYnk6IEp5YW4gQ2hvdSA8anlhbmNob3VAcmVhbHRlay5jb20+DQo+Pg0KPj4gLS0tDQo+PiB2
NSAtPiB2NjoNCj4+IC0gRHJvcCB0aGUgaW5jb3JyZWN0LCBnZW5lcmljIGNvbXBhdGlibGUgYW5k
IG1vZGlmeSBpdCB0byBzcGVjaWZpYy4NCj4+IC0gRHJvcCB1c2VsZXNzIHByb3BlcnRpZXMuDQoN
Cj4gV2hpY2ggb25lcz8NCg0KSSB3aWxsIGRlc2NyaWJlIGl0IGNsZWFybHkgaW4gb3VyIG5ldyB2
ZXJzaW9uLCB0aGUgdXNlbGVzcyBwcm9wZXJ0aWVzIHdlIGRyb3BwZWQgd2VyZQ0KDQpsaWtlIHNv
bWUgd2VyZSBub3QgYmUgdXNlZCBpbiBvdXIgZHJpdmVyIGFuZCBzb21lIHlvdSBhc2tlZCB1cyB0
byBkcm9wcGVkLg0KDQo+PiAtIE1vZGlmeSBiaW5kaW5ncyB0byBtYWtlIERUUyBhbmQgZHJpdmVy
IG1hdGNoLg0KPj4NCj4+IHY0IC0+IHY1Og0KPj4gLSBSZW1vdmUgdW51c2VkIHByb3BlcnR5LCBl
LmcuLGNxZSwgcmVzZXRzLCBjbG9jay1mcmVxLW1pbi1tYXguDQo+PiAtIEZpeCBpbmRlbnRhdGlv
bi4NCj4+DQo+PiB2MyAtPiB2NDoNCj4+IC0gRGVzY3JpYmUgdGhlIGl0ZW1zIHRvIG1ha2UgcHJv
cGVydGllcyBhbmQgaXRlbSBlYXN5IHRvIHVuZGVyc3RhbmQuDQo+PiAtIEZpeCBleGFtcGxlcycg
aW5kZW50YXRpb24gYW5kIGNvbXBpbGluZyBlcnJvci4NCj4+IC0gRHJvcCB1c2VsZXNzIHByb3Bl
cnRpZXMuDQo+Pg0KPj4gdjIgLT4gdjM6DQo+PiAtIE1vZGlmeSBkdC1iaW5kaW5ncycgY29udGVu
dCBhbmQgZGVzY3JpcHRpb24uDQo+PiAtIEZpeCBjb2Rpbmcgc3R5bGUuDQo+PiAtIFVwZGF0ZSB0
aGUgbGlzdCBvZiBtYWludGFpbmVycy4NCj4+DQo+PiB2MSAtPiB2MjoNCj4+IC0gQWRkIGR0LWJp
bmRpbmdzLg0KPj4gLS0tDQo+PiAgLi4uL2JpbmRpbmdzL21tYy9yZWFsdGVrLHJ0ZC1kdy1jcWUt
ZW1tYy55YW1sIHwgMTYyIA0KPj4gKysrKysrKysrKysrKysrKysrDQo+PiAgMSBmaWxlIGNoYW5n
ZWQsIDE2MiBpbnNlcnRpb25zKCspDQo+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IA0KPj4gRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9yZWFsdGVrLHJ0ZC1kdy1jcWUtZW1tYy55
YW1sDQo+Pg0KPj4gZGlmZiAtLWdpdCANCj4+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL21tYy9yZWFsdGVrLHJ0ZC1kdy1jcWUtZW1tYy55YW1sIA0KPj4gYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL3JlYWx0ZWsscnRkLWR3LWNxZS1lbW1jLnlhbWwN
Cj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwMDAuLmQ3MTE4Y2Y0
NTdlOA0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL21tYy9yZWFsdGVrLHJ0ZC1kdy1jcWUtZW1tYy55YQ0KPj4gKysrIG1sDQo+PiBA
QCAtMCwwICsxLDE2MiBAQA0KPj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4w
LW9ubHkgT1IgQlNELTItQ2xhdXNlKSAlWUFNTCAxLjINCj4+ICstLS0NCj4+ICskaWQ6IGh0dHA6
Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL21tYy9yZWFsdGVrLHJ0ZC1kdy1jcWUtZW1tYy55YW1s
Iw0KPj4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55
YW1sIw0KPj4gKw0KPj4gK3RpdGxlOiBSZWFsdGVrIERlc2lnbldhcmUgbW9iaWxlIHN0b3JhZ2Ug
aG9zdCBjb250cm9sbGVyDQo+PiArDQo+PiArZGVzY3JpcHRpb246DQo+PiArICBSZWFsdGVrIHVz
ZXMgdGhlIFN5bm9wc3lzIERlc2lnbldhcmUgbW9iaWxlIHN0b3JhZ2UgaG9zdCBjb250cm9sbGVy
DQo+PiArICB0byBpbnRlcmZhY2UgYSBTb0Mgd2l0aCBzdG9yYWdlIG1lZGl1bS4gVGhpcyBmaWxl
IGRvY3VtZW50cyB0aGUgDQo+PiArUmVhbHRlaw0KPj4gKyAgc3BlY2lmaWMgZXh0ZW5zaW9ucy4N
Cj4+ICsNCj4+ICttYWludGFpbmVyczoNCj4+ICsgIC0gSnlhbiBDaG91IDxqeWFuY2hvdUByZWFs
dGVrLmNvbT4NCj4+ICsNCj4+ICthbGxPZjoNCj4+ICsgIC0gJHJlZjogc3lub3BzeXMtZHctbXNo
Yy1jb21tb24ueWFtbCMNCj4+ICsNCj4+ICtwcm9wZXJ0aWVzOg0KPj4gKyAgY29tcGF0aWJsZToN
Cj4+ICsgICAgZW51bToNCj4+ICsgICAgICAtIHJlYWx0ZWsscnRkMTMyNS1kdy1jcWUtZW1tYw0K
Pj4gKyAgICAgIC0gcmVhbHRlayxydGQxMzE5LWR3LWNxZS1lbW1jDQo+PiArICAgICAgLSByZWFs
dGVrLHJ0ZDEzMTVlLWR3LWNxZS1lbW1jDQo+PiArICAgICAgLSByZWFsdGVrLHJ0ZDE2MTliLWR3
LWNxZS1lbW1jDQo+PiArDQo+PiArICByZWc6DQo+PiArICAgIGl0ZW1zOg0KPj4gKyAgICAgIC0g
ZGVzY3JpcHRpb246IGVtbWMgYmFzZSBhZGRyZXNzDQo+PiArICAgICAgLSBkZXNjcmlwdGlvbjog
Y3FoY2kgYmFzZSBhZGRyZXNzDQo+PiArDQo+PiArICByZWctbmFtZXM6DQo+PiArICAgIGl0ZW1z
Og0KPj4gKyAgICAgIC0gY29uc3Q6IGVtbWMNCj4+ICsgICAgICAtIGNvbnN0OiBjcWhjaQ0KPj4g
Kw0KPj4gKyAgcmVhbHRlayxtMnRteDoNCj4+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFt
bCMvZGVmaW5pdGlvbnMvcGhhbmRsZQ0KPj4gKyAgICBkZXNjcmlwdGlvbjogUGhhbmRsZSB0byBt
MnRteCBzeXNjb24gcmVnaXN0ZXIgcmVnaW9uLg0KDQo+IFRoZXJlIGlzIG5vIHN1Y2ggc3R1ZmYg
YXMgInN5c2NvbiByZWdpc3RlciByZWdpb24iLiBTeXNjb24gaXMgTGludXggdGVybS4gUGxlYXNl
IHdyaXRlIGhlcmUgaW5zdGVhZCB0aGUgZnVsbCBuYW1lIG9mIHRoZSBoYXJkd2FyZSBibG9jayBh
bmQgZGVzY3JpYmUgaXRzIHB1cnBvc2UgKGZvciB3aGF0IGlzIGl0IG5lZWRlZCBmb3IpLg0KDQpP
a2F5LCB3ZSB3aWxsIGNvcnJlY3QgaXQgaW4gb3VyIG5ldyB2ZXJzaW9uLCB0aGFua3MuDQoNCj4+
ICsNCj4+ICsgIGludGVycnVwdHM6DQo+PiArICAgIG1heEl0ZW1zOiAxDQo+PiArDQo+PiArICBj
bG9ja3M6DQo+PiArICAgIG1heEl0ZW1zOiA0DQo+PiArDQo+PiArICBjbG9jay1uYW1lczoNCj4+
ICsgICAgaXRlbXM6DQo+PiArICAgICAgLSBjb25zdDogYml1DQo+PiArICAgICAgLSBjb25zdDog
Y2l1DQo+PiArICAgICAgLSBjb25zdDogdnAwDQo+PiArICAgICAgLSBjb25zdDogdnAxDQo+PiAr
DQo+PiArICByZXNldHM6DQo+PiArICAgIG1heEl0ZW1zOiAxDQo+PiArDQo+PiArICByZXNldC1u
YW1lczoNCj4+ICsgICAgY29uc3Q6IHJlc2V0DQoNCj4gTm90aGluZyBpbXByb3ZlZCBoZXJlLg0K
DQo+IEdvIGJhY2sgdG8gcHJldmlvdXMgdmVyc2lvbnMgYW5kIGltcGxlbWVudCB0aGUgZmVlZGJh
Y2sgeW91IHJlY2VpdmVkLg0KDQpTb3JyeSBmb3IgYXNraW5nLCBidXQgSSB3b3VsZCBsaWtlIHRv
IGNoZWNrIGlmIEkgZXhhY3RseSBrbm93IHlvdXIgbWVhbmluZyBmaXJzdCBhbmQgDQoNCnRoZW4g
cHVzaCBvdXIgbmV3IHBhdGNoLiBBY2NvcmRpbmcgdG8gcHJldmlvdXMgdmVyc2lvbnMsIEkgZm91
bmQgb3V0IHRoYXQgDQoNCj4+ICsNCj4+ICsgIHJlc2V0czoNCj4+ICsgICAgbWF4SXRlbXM6IDEN
Cj4+ICsNCj4+ICsgIHJlc2V0LW5hbWVzOg0KPj4gKyAgICBjb25zdDogcmVzZXQNCg0KPiBBbmQg
aGVyZSB5b3UgZGVzY3JpYmUgdGhlIGl0ZW0/IFRoZSBvbmx5IHBsYWNlIHdoZW4gaXQgaXMgbm90
IG5lZWRlZD8NCj4gRHJvcCBlbnRpZXJseS4NCg0KZG9lcyBpdCBtZWFucyB3ZSBuZWVkIHRvIGRy
b3AgaXQ/IEJ1dCB3ZSBuZWVkIHRoaXMgdG8gZGV0ZXJtaW5lIHdoZXRoZXIgdG8NCg0Kc2V0dXAg
YSByZXNldCBjb250cm9sIG9yIG5vdCwgaWYgd2UgZGlkbid0IGFkZCBpdCBpbiBvdXIgYmluZGlu
Z3MsIGNoZWNrIHBhdGNoIHdpbGwNCg0Kc2hvdyBlcnJvci4gRGlkIEkgbWlzdW5kZXJzdGFuZCB5
b3VyIG1lYW5pbmc/IFRoYW5rcy4NCg0KQmVzdCByZWdhcmRzLA0KSnlhbg0KDQo=
