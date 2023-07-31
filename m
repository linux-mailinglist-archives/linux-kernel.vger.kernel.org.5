Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C6E768BF8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 08:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjGaG0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 02:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjGaG0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 02:26:03 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B90BE7B;
        Sun, 30 Jul 2023 23:26:00 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 36V6PNH00006422, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 36V6PNH00006422
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 31 Jul 2023 14:25:23 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 31 Jul 2023 14:25:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 31 Jul 2023 14:25:36 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Mon, 31 Jul 2023 14:25:36 +0800
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
Thread-Index: AQHZwQcMHiqO6RUc7UW0WlFc2kMWqq/OO0OAgAEzo7CAAgjiAIAB8loA
Date:   Mon, 31 Jul 2023 06:25:36 +0000
Message-ID: <74e8f0f1c0ec4196b242a1d5b47979d8@realtek.com>
References: <20230728035318.18741-1-stanley_chang@realtek.com>
 <20230728035318.18741-2-stanley_chang@realtek.com>
 <4bbdd646-ad16-1a7d-a727-878c6cf92410@linaro.org>
 <740d0d33a9064c2bb2696ef762294b0c@realtek.com>
 <08388eec-bfe8-c4c4-06b7-8450bc34182e@linaro.org>
In-Reply-To: <08388eec-bfe8-c4c4-06b7-8450bc34182e@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
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

SGkgS3J6eXN6dG9mLA0KDQo+ID4+PiArICByZWFsdGVrLGVuYWJsZS1sNGljZzoNCj4gPj4+ICsg
ICAgZGVzY3JpcHRpb246IEVuYWJsZSB0aGUgcG93ZXIgc2F2aW5nIGZlYXR1cmUgbDRpY2cgYnkg
aGFyZHdhcmUNCj4gY2xvY2suDQo+ID4+PiArICAgICAgZ2F0aW5nLg0KPiA+Pg0KPiA+PiBZb3Ug
ZGVzY3JpYmVkIHRoZSBkZXNpcmVkIExpbnV4IGZlYXR1cmUgb3IgYmVoYXZpb3IsIG5vdCB0aGUg
YWN0dWFsDQo+IGhhcmR3YXJlLg0KPiA+PiBUaGUgYmluZGluZ3MgYXJlIGFib3V0IHRoZSBsYXR0
ZXIsIHNvIGluc3RlYWQgeW91IG5lZWQgdG8gcmVwaHJhc2UNCj4gPj4gdGhlIHByb3BlcnR5IGFu
ZCBpdHMgZGVzY3JpcHRpb24gdG8gbWF0Y2ggYWN0dWFsIGhhcmR3YXJlDQo+ID4+IGNhcGFiaWxp
dGllcy9mZWF0dXJlcy9jb25maWd1cmF0aW9uIGV0Yy4NCj4gPg0KPiA+IFRoZSBsNGljZyBlbnRy
eSBpcyBhIGhhcmR3YXJlIGZlYXR1cmUgZm9yIHBvd2VyIHNhdmluZy4NCj4gPiBUaGUgdGVybSBt
YXkgbm90IGNsZWFybHkgY29udmV5IHRoZSBmdW5jdGlvbi4NCj4gPiBTbyBpbnN0ZWFkIG9mIHRo
ZSB0ZXJtICJsNGljZyIgSSB1c2UgImh3IGNsb2NrIGdhdGluZyIuDQo+ID4NCj4gPiAgIHJlYWx0
ZWssZW5hYmxlLWh3LWNsb2NrLWdhdGluZzoNCj4gPiAgICAgZGVzY3JpcHRpb246IEVuYWJsZSB0
aGUgY2xvY2sgZ2F0ZWQgZnVuY3Rpb24gd2hpY2ggd2lsbCBnYXRpbmcgc3JhbQ0KPiA+ICAgICAg
IGNsb2NrIHdoZW4gZGJ1cyBpZGxlLg0KPiANCj4gQW5kIHdoeSB0aGlzIHNob3VsZCBiZSBjb25m
aWd1cmFibGUgcGVyIGJvYXJkPyBJdCBsb29rcyB5b3UgbGlrZSB0byBwdXQgT1MNCj4gcG9saWN5
IGludG8gRFQsIHNvIG5vLg0KPiANCk9rLCBJJ2xsIHJlbW92ZSBpdCBmcm9tIERULg0KSSBwdXQg
aXQgaW4gRFQgYmVjYXVzZSBody1jbG9jay1nYXRpbmcgaXMgbm90IGFuIE9TIHBvbGljeS4gVGhp
cyBpcyBhIHB1cmUgaGFyZHdhcmUgZnVuY3Rpb24gYW5kIGlzIG5vdCBjb250cm9sbGVkIGJ5IHNv
ZnR3YXJlLg0KSSB3YW50IHRvIGNvbnRyb2wgZW5hYmxpbmcgb3IgZGlzYWJsaW5nIG9uIGRpZmZl
cmVudCBTb0NzIG9yIGJvYXJkcy4NCkJ1dCBmb3IgcG93ZXIgc2F2aW5nLCBpdCBzaG91bGQgYmUg
ZW5hYmxlZCBieSBkZWZhdWx0IGV4Y2VwdCBmb3IgcnRkMTI5NSBTb0MuDQpTbyBJIHdvdWxkIGhh
bmRsZSB0aGlzIHNwZWNpYWwgY2FzZSBvZiBydGQxMjk1IGluIHRoZSBkcml2ZXIuDQoNClRoYW5r
cywNClN0YW5sZXkNCg==
