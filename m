Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DE57F2624
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjKUHHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbjKUHHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:07:34 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6CC18A;
        Mon, 20 Nov 2023 23:07:15 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AL774o441411189, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AL774o441411189
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 15:07:04 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 21 Nov 2023 15:07:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 21 Nov 2023 15:07:03 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Tue, 21 Nov 2023 15:07:03 +0800
From:   =?utf-8?B?VFlfQ2hhbmdb5by15a2Q6YC4XQ==?= <tychang@realtek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "Andy Shevchenko" <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] dt-bindings: gpio: realtek: Add realtek,rtd-gpio
Thread-Topic: [PATCH v2 1/2] dt-bindings: gpio: realtek: Add realtek,rtd-gpio
Thread-Index: AQHaGH4czgOqCilFZUC7eWiqDX/CI7B8UiAAgAgI9oA=
Date:   Tue, 21 Nov 2023 07:07:03 +0000
Message-ID: <b604280a26e94bcca139b74dfa2130eb@realtek.com>
References: <20231116111441.2339-1-tychang@realtek.com>
 <20231116111441.2339-2-tychang@realtek.com>
 <87e9b938-bb72-41a1-a54d-deed543077eb@linaro.org>
In-Reply-To: <87e9b938-bb72-41a1-a54d-deed543077eb@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.181.166]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEtyenlzenRvZg0KDQo+T24gMTYvMTEvMjAyMyAxMjoxNCwgVHp1eWkgQ2hhbmcgd3JvdGU6
DQo+PiBBZGQgdGhlIGRldmljZSB0cmVlIGJpbmRpbmdzIGZvciB0aGUgUmVhbHRlayBESEMoRGln
aXRhbCBIb21lIENlbnRlcikNCj4+IFJURCBTb0NzIEdQSU8gY29udHJvbGxlcnMuDQo+Pg0KPj4g
U2lnbmVkLW9mZi1ieTogVHp1eWkgQ2hhbmcgPHR5Y2hhbmdAcmVhbHRlay5jb20+DQo+PiAtLS0N
Cj4+IHYxIHRvIHYyIGNoYW5nZToNCj4+ICAgICAxLiBBZGQgZGVzY3JpcHRpb24gZm9yIERIQyBS
VEQgU29Dcy4NCj4+ICAgICAyLiBSZXZpc2UgdGhlIGNvbXBhdGlibGUgbmFtZXMuDQo+PiAgICAg
My4gQWRkIGRlc2NyaXB0aW9ucyBmb3IgcmVnIGFuZCBpbnRlcnJ1cHRzIHByb3BlcnRpZXMuDQo+
PiAtLS0NCj4+ICAuLi4vYmluZGluZ3MvZ3Bpby9yZWFsdGVrLHJ0ZC1ncGlvLnlhbWwgICAgICAg
fCA3NCArKysrKysrKysrKysrKysrKysrDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDc0IGluc2VydGlv
bnMoKykNCj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4+IERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9ncGlvL3JlYWx0ZWsscnRkLWdwaW8ueWFtbA0KPj4NCj4+IGRpZmYgLS1naXQN
Cj4+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2dwaW8vcmVhbHRlayxydGQt
Z3Bpby55YW1sDQo+PiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncGlvL3Jl
YWx0ZWsscnRkLWdwaW8ueWFtbA0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAw
MDAwMDAwMDAwMC4uMTFjODI3ODgwMWMzDQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZ3Bpby9yZWFsdGVrLHJ0ZC1ncGlvLnlhbWwN
Cj4+IEBAIC0wLDAgKzEsNzQgQEANCj4+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BM
LTIuMCBPUiBCU0QtMi1DbGF1c2UpICMgQ29weXJpZ2h0IDIwMjMNCj4+ICtSZWFsdGVrIFNlbWlj
b25kdWN0b3IgQ29ycG9yYXRpb24gJVlBTUwgMS4yDQo+PiArLS0tDQo+PiArJGlkOiBodHRwOi8v
ZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9ncGlvL3JlYWx0ZWsscnRkLWdwaW8ueWFtbCMNCj4+ICsk
c2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4+
ICsNCj4+ICt0aXRsZTogUmVhbHRlayBESEMgR1BJTyBjb250cm9sbGVyDQo+PiArDQo+PiArbWFp
bnRhaW5lcnM6DQo+PiArICAtIFR6dXlpIENoYW5nIDx0eWNoYW5nQHJlYWx0ZWsuY29tPg0KPj4g
Kw0KPj4gK2Rlc2NyaXB0aW9uOg0KPj4gKyAgVGhlIEdQSU8gY29udHJvbGxlciBpcyBkZXNpZ25l
ZCBmb3IgdGhlIFJlYWx0ZWsgREhDIChEaWdpdGFsIEhvbWUNCj4+ICtDZW50ZXIpDQo+PiArICBS
VEQgU29DIGZhbWlseSwgd2hpY2ggYXJlIGhpZ2gtZGVmaW5pdGlvbiBtZWRpYSBwcm9jZXNzb3Ig
U29Dcy4NCj4+ICsNCj4+ICtwcm9wZXJ0aWVzOg0KPj4gKyAgY29tcGF0aWJsZToNCj4+ICsgICAg
b25lT2Y6DQo+PiArICAgICAgLSBpdGVtczoNCj4NCj5Ecm9wIGl0ZW1zLg0KPg0KPj4gKyAgICAg
ICAgICAtIGVudW06DQo+PiArICAgICAgICAgICAgICAtIHJlYWx0ZWsscnRkMTI5NS1taXNjLWdw
aW8NCj4+ICsgICAgICAgICAgICAgIC0gcmVhbHRlayxydGQxMjk1LWlzby1ncGlvDQo+PiArICAg
ICAgICAgICAgICAtIHJlYWx0ZWsscnRkMTM5NS1pc28tZ3Bpbw0KPj4gKyAgICAgICAgICAgICAg
LSByZWFsdGVrLHJ0ZDE2MTktaXNvLWdwaW8NCj4+ICsgICAgICAtIGl0ZW1zOg0KPj4gKyAgICAg
ICAgICAtIGVudW06DQo+PiArICAgICAgICAgICAgICAtIHJlYWx0ZWsscnRkMTMxOS1pc28tZ3Bp
bw0KPj4gKyAgICAgICAgICAgICAgLSByZWFsdGVrLHJ0ZDE2MTliLWlzby1ncGlvDQo+PiArICAg
ICAgICAgICAgICAtIHJlYWx0ZWsscnRkMTMxOWQtaXNvLWdwaW8NCj4+ICsgICAgICAgICAgICAg
IC0gcmVhbHRlayxydGQxMzE1ZS1pc28tZ3Bpbw0KPj4gKyAgICAgICAgICAtIGNvbnN0OiByZWFs
dGVrLHJ0ZC1ncGlvDQo+DQo+RWl0aGVyIHlvdSB1c2UgZ2VuZXJpYyBjb21wYXRpYmxlIGZvciBl
dmVyeXRoaW5nIG9yIG5vdC4gT3RoZXIgdmFyaWFudHMgZG8gbm90DQo+dXNlIGdlbmVyaWMgY29t
cGF0aWJsZSwgc28gbmVpdGhlciBzaG91bGQgdGhlc2UuIFVzZSBTb0Mtc3BlY2lmaWMgY29tcGF0
aWJsZSBhcw0KPmZhbGxiYWNrLg0KPg0KPkkgYXNrZWQgeW91IHRvIHRvIGRyb3AgdGhpcyBjb21w
YXRpYmxlLiBJIGNvdWxkIG5vdCBiZSBtb3JlIHNwZWNpZmljLCBzbyB5b3UganVzdA0KPmlnbm9y
ZWQgdGhpcyByZW1hcmsuDQo+DQo+U28gYWdhaW46IHdoYXQgaXMgInJ0ZCI/IFdoeSBpdCBkb2Vz
IG5vdCBhcHBlYXIgYW55d2hlcmUgaW4gZGVzY3JpcHRpb24gb3IgdGl0bGU/DQo+Tm8sIGRyb3Ag
aXQuDQo+DQoNCiJydGQiIGlzIHRoZSBwcm9kdWN0IHNlcmllcyBpZGVudGlmaWVyLiBJIHdpbGwg
ZHJvcCB0aGlzIGdlbmVyaWMgY29tcGF0aWJsZSBhbmQgdXNlIFNvQy1zcGVjaWZpYyBjb21wYXRp
YmxlIGluc3RlYWQuDQoNClRoYW5rcywNClR6dXlpIENoYW5nDQo=
