Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6C0802548
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 17:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbjLCQDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 11:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCQDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 11:03:38 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C94CA;
        Sun,  3 Dec 2023 08:03:40 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3B3G3DGb81440227, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3B3G3DGb81440227
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Dec 2023 00:03:13 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 4 Dec 2023 00:03:09 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Sun, 3 Dec 2023 23:56:50 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::5510:ad08:5390:1ed3]) by
 RTEXMBS03.realtek.com.tw ([fe80::5510:ad08:5390:1ed3%2]) with mapi id
 15.01.2375.007; Sun, 3 Dec 2023 23:56:50 +0800
From:   =?utf-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?= <james.tai@realtek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 1/6] dt-bindings: interrupt-controller: Add support for Realtek DHC SoCs
Thread-Topic: [PATCH v2 1/6] dt-bindings: interrupt-controller: Add support
 for Realtek DHC SoCs
Thread-Index: AQHaGXMHJnbDooY4VkyEcMH4aisPjrCBFAaAgAG3OTCAE2RqMIABC34AgACK6PA=
Date:   Sun, 3 Dec 2023 15:56:50 +0000
Message-ID: <cf2f9fd124514cb9832e942e16b8fa6e@realtek.com>
References: <20231117162709.1096585-1-james.tai@realtek.com>
 <20231117162709.1096585-2-james.tai@realtek.com>
 <c3a98e2c-ba62-4798-a0d0-a8bc1fe5bb6b@linaro.org>
 <7959920acf004f3cb8072de1e17439fa@realtek.com>
 <e1490203387d4c48a5f8c4040ece038a@realtek.com>
 <6250c57b-6d38-4085-9a79-58e4e5ed1e3d@linaro.org>
In-Reply-To: <6250c57b-6d38-4085-9a79-58e4e5ed1e3d@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.16.16.224]
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQo+Pj4+PiArDQo+Pj4+PiArICBjb21wYXRpYmxlOg0KPj4+Pj4gKyAg
ICBlbnVtOg0KPj4+Pj4gKyAgICAgIC0gcmVhbHRlayxydGQxMzE5LWludGMtaXNvDQo+Pj4+PiAr
ICAgICAgLSByZWFsdGVrLHJ0ZDEzMTktaW50Yy1taXNjDQo+Pj4+PiArDQo+Pj4+PiArICAiI2Fk
ZHJlc3MtY2VsbHMiOg0KPj4+Pj4gKyAgICBjb25zdDogMA0KPj4+Pj4gKw0KPj4+Pj4gKyAgaW50
ZXJydXB0LWNvbnRyb2xsZXI6IHRydWUNCj4+Pj4+ICsNCj4+Pj4+ICsgIGludGVycnVwdHMtZXh0
ZW5kZWQ6DQo+Pj4+DQo+Pj4+IGludGVycnVwdHMgaW5zdGVhZC4NCj4+Pj4NCj4+Pj4gQW55d2F5
LCB5b3UgbXVzdCBkZXNjcmliZSB0aGUgaXRlbXMuIFdoeSB0aGlzIGlzIG5vdCBmaXhlZCBidXQg
ZmxleGlibGU/DQo+Pj4+IEhhcmR3YXJlIGhhcyBkaWZmZXJlbnQgbnVtYmVyIG9mIHBpbnM/IFRo
YXQncyB1bmxpa2VseS4NCj4+Pj4NCj4+PiBJIHdpbGwgcmVwbGFjZSBpdCB3aXRoICdpbnRlcnJ1
cHRzJy4gU2luY2Ugb3VyIEludGVycnVwdCBjb250cm9sbGVyDQo+Pj4gYXJjaGl0ZWN0dXJlIGRv
ZXNuJ3QgaW52b2x2ZSBtdWx0aXBsZSBpbnRlcnJ1cHQgc291cmNlcywgdXNpbmcgJ2ludGVycnVw
dHMnDQo+c2hvdWxkIHN1ZmZpY2UuDQo+Pj4NCj4+DQo+PiBEdWUgdG8gY2hhbmdlcyBpbiBoYXJk
d2FyZSBkZXNpZ24sIHNvbWUgcGVyaXBoZXJhbCBpbnRlcnJ1cHRzIHBpbiBpbml0aWFsbHkNCj5j
b25uZWN0ZWQgdG8gdGhlIFJlYWx0ZWsgaW50ZXJydXB0IGNvbnRyb2xsZXIgd2VyZSByZWRpcmVj
dGVkIHRvIHRoZSBHSUMuDQo+PiBIb3dldmVyLCB0aGUgYXNzb2NpYXRlZCBmaWVsZHMgYW5kIHN0
YXR1c2VzIGluIHRoZSBSZWFsdGVrIGludGVycnVwdCBjb250cm9sbGVyDQo+cmVnaXN0ZXJzIHdl
cmUgbm90IHJlbW92ZWQuDQo+PiBBcyBhIHJlc3VsdCwgdGhlc2UgaW50ZXJydXB0cyBjYW5ub3Qg
YmUgY2xlYXJlZCBieSBwZXJpcGhlcmFsIHJlZ2lzdGVyLCBhbmQgdGhlaXINCj5zdGF0dXMgY2xl
YXJpbmcgaXMgc3RpbGwgbmVlZGluZyB0aGUgUmVhbHRlayBpbnRlcnJ1cHQgY29udHJvbGxlciBk
cml2ZXIgdG8gbWFuYWdlLg0KPj4NCj4+IFRoYXQncyB3aHkgZmxleGliaWxpdHkgaXMgbmVjZXNz
YXJ5Lg0KPg0KPlRoaXMgZG9lcyBub3QgZXhwbGFpbiB3aHkgdGhpcyBpcyBub3QgZml4ZWQgcGVy
IHZhcmlhbnQuDQo+DQoNCkRvZXMgdGhlIGRlZmluaXRpb24gb2YgImZpeGVkIiB5b3UgbWVudGlv
bmVkIHJlZmVyIHRvIGZpeGVkIGludGVycnVwdCBwaW5zPyBJZiBub3QsIGNvdWxkIHlvdSBwbGVh
c2UgZ2l2ZSBtZSBhbiBleGFtcGxlIGFuZCBsZXQgbWUga25vdyB3aGF0IHlvdSBtZWFuIGJ5ICJm
aXhlZCI/DQoNClRoYW5rIHlvdSBmb3IgeW91ciBmZWVkYmFjay4NCg0KUmVnYXJkcywNCkphbWVz
DQo=
