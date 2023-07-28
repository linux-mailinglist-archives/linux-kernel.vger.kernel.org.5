Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51BF767391
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbjG1RiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236399AbjG1RiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:38:06 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DE2C3A81;
        Fri, 28 Jul 2023 10:37:44 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 36SHb6Sp9029538, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 36SHb6Sp9029538
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sat, 29 Jul 2023 01:37:07 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Sat, 29 Jul 2023 01:37:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Sat, 29 Jul 2023 01:37:19 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Sat, 29 Jul 2023 01:37:19 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 2/2] doc: dt: bindings: usb: realtek,dwc3: Add Realtek DHC RTD SoC DWC3 USB
Thread-Topic: [PATCH v1 2/2] doc: dt: bindings: usb: realtek,dwc3: Add Realtek
 DHC RTD SoC DWC3 USB
Thread-Index: AQHZwQcMHiqO6RUc7UW0WlFc2kMWqq/OO0OAgAEzo7A=
Date:   Fri, 28 Jul 2023 17:37:18 +0000
Message-ID: <740d0d33a9064c2bb2696ef762294b0c@realtek.com>
References: <20230728035318.18741-1-stanley_chang@realtek.com>
 <20230728035318.18741-2-stanley_chang@realtek.com>
 <4bbdd646-ad16-1a7d-a727-878c6cf92410@linaro.org>
In-Reply-To: <4bbdd646-ad16-1a7d-a727-878c6cf92410@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMi8yXSBkb2M6IGR0OiBi
aW5kaW5nczogdXNiOiByZWFsdGVrLGR3YzM6IEFkZCBSZWFsdGVrDQo+IERIQyBSVEQgU29DIERX
QzMgVVNCDQo+IA0KPiBPbiAyOC8wNy8yMDIzIDA1OjUzLCBTdGFubGV5IENoYW5nIHdyb3RlOg0K
PiA+IERvY3VtZW50IHRoZSBEV0MzIFVTQiBiaW5kaW5ncyBmb3IgUmVhbHRlayBTb0NzLg0KPiAN
Cj4gUGxlYXNlIHVzZSBzdWJqZWN0IHByZWZpeGVzIG1hdGNoaW5nIHRoZSBzdWJzeXN0ZW0uIFlv
dSBjYW4gZ2V0IHRoZW0gZm9yDQo+IGV4YW1wbGUgd2l0aCBgZ2l0IGxvZyAtLW9uZWxpbmUgLS0g
RElSRUNUT1JZX09SX0ZJTEVgIG9uIHRoZSBkaXJlY3RvcnkgeW91cg0KPiBwYXRjaCBpcyB0b3Vj
aGluZy4NCj4gDQo+IE15IGZpbHRlcmluZyBvZiBlbWFpbHMgZGVwZW5kcyBvbiBpdC4NCg0KSSB3
aWxsIHJldmlzZSB0aGUgc3ViamVjdC4NCg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvdXNiL3JlYWx0ZWssZHdjMy55YW1sDQo+ID4gYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL3JlYWx0ZWssZHdjMy55YW1sDQo+IA0KPiBy
ZWFsdGVrLHJ0ZC1kd2MzLnlhbWwNCg0KSSB3aWxsIHJlbmFtZSB0aGlzIGZpbGUuDQoNCj4gPiAr
JGlkOiAiaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvdXNiL3JlYWx0ZWssZHdjMy55YW1s
IyINCj4gPiArJHNjaGVtYTogImh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29y
ZS55YW1sIyINCj4gDQo+IERyb3AgcXVvdGVzLiBXYXNuJ3QgdGVzdGVkLCBiZWNhdXNlIGR0c2No
ZW1hIHJlcG9ydHMgd2FybmluZ3MgaGVyZS4uLg0KDQpPa2F5LCBJIHdpbGwgZHJvcCBpdC4NCg0K
PiA+ICsgIHJlYWx0ZWssdW5saW5rLXVzYjMtcG9ydDoNCj4gPiArICAgIGRlc2NyaXB0aW9uOiBE
aXNhYmxlIGxpbmsgYmV0d2VlbiBVU0IgMy4wIFBIWSBhbmQgVVNCIG1hYy4NCj4gPiArICAgICAg
T25seSBmb3IgUlREMTYxOSBTb0MsIGlmIHRoZSBib2FyZCBkZXNpZ24gc3VwcG9ydCBtYXhpbXVt
IDIuMA0KPiBzcGVlZC4NCj4gPiArICAgIHR5cGU6IGJvb2xlYW4NCj4gPiArDQo+ID4gKyAgcmVh
bHRlayxkaXNhYmxlLXVzYjMtcGh5Og0KPiA+ICsgICAgZGVzY3JpcHRpb246IENsb3NlIFVTQiAz
LjAgUEhZIGlmIHRoZSBib2FyZCBkZXNpZ24gbm90IHN1cHBvcnQgVVNCIDMuMC4NCj4gPiArICAg
IHR5cGU6IGJvb2xlYW4NCj4gPiArDQo+ID4gKyAgcmVhbHRlayxlbmFibGUtbDRpY2c6DQo+ID4g
KyAgICBkZXNjcmlwdGlvbjogRW5hYmxlIHRoZSBwb3dlciBzYXZpbmcgZmVhdHVyZSBsNGljZyBi
eSBoYXJkd2FyZSBjbG9jay4NCj4gPiArICAgICAgZ2F0aW5nLg0KPiANCj4gWW91IGRlc2NyaWJl
ZCB0aGUgZGVzaXJlZCBMaW51eCBmZWF0dXJlIG9yIGJlaGF2aW9yLCBub3QgdGhlIGFjdHVhbCBo
YXJkd2FyZS4NCj4gVGhlIGJpbmRpbmdzIGFyZSBhYm91dCB0aGUgbGF0dGVyLCBzbyBpbnN0ZWFk
IHlvdSBuZWVkIHRvIHJlcGhyYXNlIHRoZSBwcm9wZXJ0eQ0KPiBhbmQgaXRzIGRlc2NyaXB0aW9u
IHRvIG1hdGNoIGFjdHVhbCBoYXJkd2FyZQ0KPiBjYXBhYmlsaXRpZXMvZmVhdHVyZXMvY29uZmln
dXJhdGlvbiBldGMuDQoNClRoZSBsNGljZyBlbnRyeSBpcyBhIGhhcmR3YXJlIGZlYXR1cmUgZm9y
IHBvd2VyIHNhdmluZy4gDQpUaGUgdGVybSBtYXkgbm90IGNsZWFybHkgY29udmV5IHRoZSBmdW5j
dGlvbi4NClNvIGluc3RlYWQgb2YgdGhlIHRlcm0gImw0aWNnIiBJIHVzZSAiaHcgY2xvY2sgZ2F0
aW5nIi4NCg0KICByZWFsdGVrLGVuYWJsZS1ody1jbG9jay1nYXRpbmc6DQogICAgZGVzY3JpcHRp
b246IEVuYWJsZSB0aGUgY2xvY2sgZ2F0ZWQgZnVuY3Rpb24gd2hpY2ggd2lsbCBnYXRpbmcgc3Jh
bQ0KICAgICAgY2xvY2sgd2hlbiBkYnVzIGlkbGUuDQoNCj4gPiArZXhhbXBsZXM6DQo+ID4gKyAg
LSB8DQo+ID4gKyAgICB1c2JAOTgwMTNlMDAgew0KPiA+ICsgICAgICAgIGNvbXBhdGlibGUgPSAi
cmVhbHRlayxydGQxMzE5ZC1kd2MzIiwgInJlYWx0ZWsscnRkLWR3YzMiOw0KPiA+ICsgICAgICAg
IHJlZyA9IDwweDk4MDEzZTAwIDB4MjAwPjsNCj4gPiArICAgICAgICAjYWRkcmVzcy1jZWxscyA9
IDwxPjsNCj4gPiArICAgICAgICAjc2l6ZS1jZWxscyA9IDwxPjsNCj4gPiArICAgICAgICByYW5n
ZXM7DQo+ID4gKyAgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KPiANCj4gRHJvcCBzdGF0dXMuDQo+
IA0KT2theS4NCg0KVGhhbmtzLA0KU3RhbmxleQ0K
