Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D547EFFE6
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 14:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjKRNdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 08:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjKRNdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 08:33:08 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DF212B;
        Sat, 18 Nov 2023 05:33:01 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AIDWir263688789, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AIDWir263688789
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Nov 2023 21:32:44 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Sat, 18 Nov 2023 21:32:44 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Sat, 18 Nov 2023 21:32:44 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::5510:ad08:5390:1ed3]) by
 RTEXMBS03.realtek.com.tw ([fe80::5510:ad08:5390:1ed3%2]) with mapi id
 15.01.2375.007; Sat, 18 Nov 2023 21:32:44 +0800
From:   =?big5?B?SmFtZXMgVGFpIFvAuafTrnBd?= <james.tai@realtek.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: RE: [PATCH v2 1/6] dt-bindings: interrupt-controller: Add support for Realtek DHC SoCs
Thread-Topic: [PATCH v2 1/6] dt-bindings: interrupt-controller: Add support
 for Realtek DHC SoCs
Thread-Index: AQHaGXMHJnbDooY4VkyEcMH4aisPjrB+PxWAgAGjMjA=
Date:   Sat, 18 Nov 2023 13:32:44 +0000
Message-ID: <fff420e3928c465abe1f0488062aafe7@realtek.com>
References: <20231117162709.1096585-1-james.tai@realtek.com>
 <20231117162709.1096585-2-james.tai@realtek.com>
 <170024235327.1869893.15173077111056096496.robh@kernel.org>
In-Reply-To: <170024235327.1869893.15173077111056096496.robh@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [114.25.81.91]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQo+eWFtbGxpbnQgd2FybmluZ3MvZXJyb3JzOg0KPg0KPmR0c2NoZW1hL2R0YyB3
YXJuaW5ncy9lcnJvcnM6DQo+L2J1aWxkcy9yb2JoZXJyaW5nL2R0LXJldmlldy1jaS9saW51eC9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW50ZXINCj5ydXB0LWNvbnRyb2xsZXIv
cmVhbHRlayxydGQxMzE5ZC1pbnRjLnlhbWw6IHRpdGxlOiAnUmVhbHRlayBESEMgUlREMTMxOUQN
Cj5JbnRlcnJ1cHQgQ29udHJvbGxlciBEZXZpY2UgVHJlZSBCaW5kaW5ncycgc2hvdWxkIG5vdCBi
ZSB2YWxpZCB1bmRlciB7J3BhdHRlcm4nOg0KPicoW0JiXWluZGluZ3wgW1NzXWNoZW1hKSd9DQo+
ICAgICAgICBoaW50OiBFdmVyeXRoaW5nIGlzIGEgYmluZGluZy9zY2hlbWEsIG5vIG5lZWQgdG8g
c2F5IGl0LiBEZXNjcmliZSB3aGF0DQo+aGFyZHdhcmUgdGhlIGJpbmRpbmcgaXMgZm9yLg0KPiAg
ICAgICAgZnJvbSBzY2hlbWEgJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFz
L2Jhc2UueWFtbCMNCj4vYnVpbGRzL3JvYmhlcnJpbmcvZHQtcmV2aWV3LWNpL2xpbnV4L0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcg0KPnJ1cHQtY29udHJvbGxlci9yZWFs
dGVrLHJ0ZDEzMjUtaW50Yy55YW1sOiB0aXRsZTogJ1JlYWx0ZWsgREhDIFJURDEzMjUgSW50ZXJy
dXB0DQo+Q29udHJvbGxlciBEZXZpY2UgVHJlZSBCaW5kaW5ncycgc2hvdWxkIG5vdCBiZSB2YWxp
ZCB1bmRlciB7J3BhdHRlcm4nOg0KPicoW0JiXWluZGluZ3wgW1NzXWNoZW1hKSd9DQo+ICAgICAg
ICBoaW50OiBFdmVyeXRoaW5nIGlzIGEgYmluZGluZy9zY2hlbWEsIG5vIG5lZWQgdG8gc2F5IGl0
LiBEZXNjcmliZSB3aGF0DQo+aGFyZHdhcmUgdGhlIGJpbmRpbmcgaXMgZm9yLg0KPiAgICAgICAg
ZnJvbSBzY2hlbWEgJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2Jhc2Uu
eWFtbCMNCj4vYnVpbGRzL3JvYmhlcnJpbmcvZHQtcmV2aWV3LWNpL2xpbnV4L0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcg0KPnJ1cHQtY29udHJvbGxlci9yZWFsdGVrLHJ0
ZDE2MTliLWludGMueWFtbDogdGl0bGU6ICdSZWFsdGVrIERIQyBSVEQxNjE5Qg0KPkludGVycnVw
dCBDb250cm9sbGVyIERldmljZSBUcmVlIEJpbmRpbmdzJyBzaG91bGQgbm90IGJlIHZhbGlkIHVu
ZGVyIHsncGF0dGVybic6DQo+JyhbQmJdaW5kaW5nfCBbU3NdY2hlbWEpJ30NCj4gICAgICAgIGhp
bnQ6IEV2ZXJ5dGhpbmcgaXMgYSBiaW5kaW5nL3NjaGVtYSwgbm8gbmVlZCB0byBzYXkgaXQuIERl
c2NyaWJlIHdoYXQNCj5oYXJkd2FyZSB0aGUgYmluZGluZyBpcyBmb3IuDQo+ICAgICAgICBmcm9t
IHNjaGVtYSAkaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvYmFzZS55YW1s
Iw0KPi9idWlsZHMvcm9iaGVycmluZy9kdC1yZXZpZXctY2kvbGludXgvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2ludGVyDQo+cnVwdC1jb250cm9sbGVyL3JlYWx0ZWsscnRkMTMx
OS1pbnRjLnlhbWw6IHRpdGxlOiAnUmVhbHRlayBESEMgUlREMTMxOSBJbnRlcnJ1cHQNCj5Db250
cm9sbGVyIERldmljZSBUcmVlIEJpbmRpbmdzJyBzaG91bGQgbm90IGJlIHZhbGlkIHVuZGVyIHsn
cGF0dGVybic6DQo+JyhbQmJdaW5kaW5nfCBbU3NdY2hlbWEpJ30NCj4gICAgICAgIGhpbnQ6IEV2
ZXJ5dGhpbmcgaXMgYSBiaW5kaW5nL3NjaGVtYSwgbm8gbmVlZCB0byBzYXkgaXQuIERlc2NyaWJl
IHdoYXQNCj5oYXJkd2FyZSB0aGUgYmluZGluZyBpcyBmb3IuDQo+ICAgICAgICBmcm9tIHNjaGVt
YSAkaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvYmFzZS55YW1sIw0KPg0K
PmRvYyByZWZlcmVuY2UgZXJyb3JzIChtYWtlIHJlZmNoZWNrZG9jcyk6DQo+DQo+U2VlDQo+aHR0
cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2RldmljZXRyZWUtYmluZGluZ3MvcGF0
Y2gvMjAyMzExMTcxNjI3DQo+MDkuMTA5NjU4NS0yLWphbWVzLnRhaUByZWFsdGVrLmNvbQ0KPg0K
PlRoZSBiYXNlIGZvciB0aGUgc2VyaWVzIGlzIGdlbmVyYWxseSB0aGUgbGF0ZXN0IHJjMS4gQSBk
aWZmZXJlbnQgZGVwZW5kZW5jeSBzaG91bGQNCj5iZSBub3RlZCBpbiAqdGhpcyogcGF0Y2guDQo+
DQo+SWYgeW91IGFscmVhZHkgcmFuICdtYWtlIGR0X2JpbmRpbmdfY2hlY2snIGFuZCBkaWRuJ3Qg
c2VlIHRoZSBhYm92ZSBlcnJvcihzKSwNCj50aGVuIG1ha2Ugc3VyZSAneWFtbGxpbnQnIGlzIGlu
c3RhbGxlZCBhbmQgZHQtc2NoZW1hIGlzIHVwIHRvDQo+ZGF0ZToNCj4NCj5waXAzIGluc3RhbGwg
ZHRzY2hlbWEgLS11cGdyYWRlDQo+DQo+UGxlYXNlIGNoZWNrIGFuZCByZS1zdWJtaXQgYWZ0ZXIg
cnVubmluZyB0aGUgYWJvdmUgY29tbWFuZCB5b3Vyc2VsZi4gTm90ZQ0KPnRoYXQgRFRfU0NIRU1B
X0ZJTEVTIGNhbiBiZSBzZXQgdG8geW91ciBzY2hlbWEgZmlsZSB0byBzcGVlZCB1cCBjaGVja2lu
Zw0KPnlvdXIgc2NoZW1hLiBIb3dldmVyLCBpdCBtdXN0IGJlIHVuc2V0IHRvIHRlc3QgYWxsIGV4
YW1wbGVzIHdpdGggeW91ciBzY2hlbWEuDQoNCk9LLiBJIHdpbGwgdXBkYXRlIHRoZSBkdHNjaGVt
YSBhbmQgcmVydW4gJ21ha2UgZHRfYmluZGluZ19jaGVjaycuDQoNClRoYW5rIHlvdSBmb3IgeW91
ciBmZWVkYmFjay4NCg0KUmVnYXJkcywNCkphbWVzDQoNCg0K
