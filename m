Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065EF7EE302
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbjKPOi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjKPOi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:38:27 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB82C4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:38:23 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AGEbUyI52478034, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AGEbUyI52478034
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Nov 2023 22:37:30 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 16 Nov 2023 22:37:31 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 16 Nov 2023 22:37:30 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::5510:ad08:5390:1ed3]) by
 RTEXMBS03.realtek.com.tw ([fe80::5510:ad08:5390:1ed3%2]) with mapi id
 15.01.2375.007; Thu, 16 Nov 2023 22:37:30 +0800
From:   =?utf-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?= <james.tai@realtek.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
CC:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Subject: RE: [PATCH 1/6] dt-bindings: interrupt-controller: Add support for Realtek DHC SoCs
Thread-Topic: [PATCH 1/6] dt-bindings: interrupt-controller: Add support for
 Realtek DHC SoCs
Thread-Index: AQHaDiHoz6V0e9z/ZE2rTw/EANlTv7B9EsIA
Date:   Thu, 16 Nov 2023 14:37:30 +0000
Message-ID: <d276118d69f648c8b236d5681ecb4bc1@realtek.com>
References: <20231102142731.2087245-1-james.tai@realtek.com>
 <20231102142731.2087245-2-james.tai@realtek.com>
 <72024444-da43-47e3-a76f-4107bda8e402@kernel.org>
In-Reply-To: <72024444-da43-47e3-a76f-4107bda8e402@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [114.25.87.77]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQo+DQo+UGxlYXNlIHJ1biBzY3JpcHRzL2NoZWNrcGF0Y2gucGwgYW5k
IGZpeCByZXBvcnRlZCB3YXJuaW5ncy4gU29tZSB3YXJuaW5ncyBjYW4NCj5iZSBpZ25vcmVkLCBi
dXQgdGhlIGNvZGUgaGVyZSBsb29rcyBsaWtlIGl0IG5lZWRzIGEgZml4Lg0KPkZlZWwgZnJlZSB0
byBnZXQgaW4gdG91Y2ggaWYgdGhlIHdhcm5pbmcgaXMgbm90IGNsZWFyLg0KPg0KDQpJIHdpbGwg
cnVuIGNoZWNrcGF0Y2gucGwgdG8gYWRkcmVzcyBhbmQgZml4IHRoZSByZXBvcnRlZCB3YXJuaW5n
cy4NCg0KPlBsZWFzZSB1c2Ugc2NyaXB0cy9nZXRfbWFpbnRhaW5lcnMucGwgdG8gZ2V0IGEgbGlz
dCBvZiBuZWNlc3NhcnkgcGVvcGxlIGFuZCBsaXN0cw0KPnRvIENDLiBJdCBtaWdodCBoYXBwZW4s
IHRoYXQgY29tbWFuZCB3aGVuIHJ1biBvbiBhbiBvbGRlciBrZXJuZWwsIGdpdmVzIHlvdQ0KPm91
dGRhdGVkIGVudHJpZXMuIFRoZXJlZm9yZSBwbGVhc2UgYmUgc3VyZSB5b3UgYmFzZSB5b3VyIHBh
dGNoZXMgb24gcmVjZW50DQo+TGludXgga2VybmVsLg0KPg0KPllvdSBtaXNzZWQgYXQgbGVhc3Qg
ZGV2aWNldHJlZSBsaXN0IChtYXliZSBtb3JlKSwgc28gdGhpcyB3b24ndCBiZSB0ZXN0ZWQgYnkN
Cj5hdXRvbWF0ZWQgdG9vbGluZy4gUGVyZm9ybWluZyByZXZpZXcgb24gdW50ZXN0ZWQgY29kZSBt
aWdodCBiZSBhIHdhc3RlIG9mDQo+dGltZSwgdGh1cyBJIHdpbGwgc2tpcCB0aGlzIHBhdGNoIGVu
dGlyZWx5IHRpbGwgeW91IGZvbGxvdyB0aGUgcHJvY2VzcyBhbGxvd2luZyB0aGUNCj5wYXRjaCB0
byBiZSB0ZXN0ZWQuDQo+DQo+UGxlYXNlIGtpbmRseSByZXNlbmQgYW5kIGluY2x1ZGUgYWxsIG5l
Y2Vzc2FyeSBUby9DYyBlbnRyaWVzLg0KDQpJIHdpbGwgZml4IGl0IGluIHRoZSBuZXh0IHBhdGNo
ZXMuDQoNCj4NCj5JdCBkb2VzIG5vdCBsb29rIGxpa2UgeW91IHRlc3RlZCB0aGUgYmluZGluZ3Ms
IGF0IGxlYXN0IGFmdGVyIHF1aWNrIGxvb2suIFBsZWFzZSBydW4NCj5gbWFrZSBkdF9iaW5kaW5n
X2NoZWNrYCAoc2VlDQo+RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3dyaXRpbmct
c2NoZW1hLnJzdCBmb3IgaW5zdHJ1Y3Rpb25zKS4NCj5NYXliZSB5b3UgbmVlZCB0byB1cGRhdGUg
eW91ciBkdHNjaGVtYSBhbmQgeWFtbGxpbnQuDQo+DQpJIHdpbGwgdGVzdCB0aGUgYmluZGluZ3Mg
dXNpbmcgJ21ha2UgZHRfYmluZGluZ19jaGVjaycuDQoNClRoYW5rIHlvdSBmb3IgeW91ciBmZWVk
YmFjay4NCg0KUmVnYXJkcywNCkphbWVzDQoNCg==
