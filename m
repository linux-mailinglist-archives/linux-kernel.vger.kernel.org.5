Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8239786840
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 09:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240323AbjHXHYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 03:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238047AbjHXHXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 03:23:44 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B597E6C;
        Thu, 24 Aug 2023 00:23:41 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37O7N7dH4001726, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37O7N7dH4001726
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Aug 2023 15:23:07 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 24 Aug 2023 15:23:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 24 Aug 2023 15:23:29 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Thu, 24 Aug 2023 15:23:29 +0800
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
Thread-Index: AQHZ1ONxPQNQ8ikjYkmsM4V64Zamr6/17aQAgAMBw+D//4itAIAAj2Mw
Date:   Thu, 24 Aug 2023 07:23:29 +0000
Message-ID: <1390ad28e50f493fa72209fe29b7f3f4@realtek.com>
References: <20230822102846.4683-1-stanley_chang@realtek.com>
 <20230822102846.4683-2-stanley_chang@realtek.com>
 <1e0632d6-73e9-4633-a709-bf9140f2fd32@linaro.org>
 <ca406c19e59145fd9e7e035ea5ad3eeb@realtek.com>
 <50ce8e71-613e-1ef5-0c23-67a2f6f78949@linaro.org>
In-Reply-To: <50ce8e71-613e-1ef5-0c23-67a2f6f78949@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQo+ID4+PiArDQo+ID4+PiArdGl0bGU6IFJlYWx0ZWsgREhDIFJURCBT
b0NzIFVTQiBUeXBlLUMgZGV0ZWN0aW9uDQo+ID4+DQo+ID4+IFR5cGUtYyB1c3VhbGx5IGdvIHRv
IHVzYiBkaXJlY3RvcnkuDQo+ID4NCj4gPiBUaGlzIGJpbmRpbmcgaXMgbm90IGZvciBhIHR5cGUt
YyBjb250cm9sbGVyLg0KPiA+IEl0IGlzIGFuIGV4dGNvbiBkZXZpY2UgZm9yIHR5cGUtYyBjb25u
ZWN0b3IgZGV0ZWN0aW9uLg0KPiA+IFNvIEkgcHV0IGl0IGF0IGV4dGNvbiBkaXJlY3RvcnkuDQo+
IA0KPiBJZiB0aGlzIGlzIG5vdCBhIHR5cGUtYyBjb250cm9sbGVyLCB0aGVuIHdoYXQgaXMgaXQ/
IEV4cGxhaW4gbWUgcGxlYXNlIHdoYXQgaXMgYW4NCj4gImV4dGNvbiBkZXZpY2UiIHdpdGhvdXQg
dXNpbmcgYW55IExpbnV4IHN1YnN5c3RlbSBuYW1pbmcuDQoNClNvcnJ5LiAiZXh0Y29uIGRldmlj
ZSIgbWF5IGJlIHRoZSB3cm9uZyBuYW1lIEknbSB1c2luZy4NCg0KQXMgZmFyIGFzIEkga25vdywg
dHlwZS1jIGNvbnRyb2xsZXIgc3VwcG9ydHMgUEQgZGV0ZWN0aW9uLCByb2xlIGRldGVjdGlvbiwg
cm9sZSBzd2FwIGFuZCBjYyBjb25maWd1cmF0aW9uLg0KQnV0IGluIG91ciBTb0MsIHR5cGUgYyBt
b2R1bGUgb25seSBzdXBwb3J0cyByb2xlIGRldGVjdGlvbi4NClNvIEkgZG9uJ3QgdGhpbmsgaXQn
cyBhIHR5cGUtYyBjb250cm9sbGVyLg0KDQpJIGZvdW5kIGEgc2ltaWxhciBkcml2ZXIgYXQNCmRy
aXZlcnMvZXh0Y29uL2V4dGNvbi11c2JjLWNyb3MtZWMuYw0KSXQgYmVsb25ncyB0byBFeHRlcm5h
bCBDb25uZWN0b3IsIHdoaWNoIGNhbiBkZXRlY3QgVVNCIFR5cGUgQyBjYWJsZXMuDQoNClNvIG91
ciBkcml2ZXIgaXMgYW4gZXh0ZXJuYWwgY29ubmVjdG9yIGRyaXZlci4NCg0KPiA+DQo+ID4gQW5k
IEkgd2lsbCBhZGQg4oCcY29ubmVjdG9y4oCdIHRvIHRoZSB0aXRsZS4NCj4gPiB0aXRsZTogUmVh
bHRlayBESEMgUlREIFNvQ3MgVVNCIFR5cGUtQyBDb25uZWN0b3IgZGV0ZWN0aW9uDQo+IA0KPiBT
byB1c2IuLi4NCg0KSSByZWZlciB0byB0aGlzIGJpbmRpbmcsIGFuZCBpdCBpcyBpbiBmb2xkZXIg
YmluZGluZ3MvZXh0Y29uLg0KZG9jcy9kZXZpY2V0cmVlL2JpbmRpbmdzL2V4dGNvbi9leHRjb24t
dXNiYy1jcm9zLWVjLnlhbWwNClRpdGxlOiBDaHJvbWVPUyBFQyBVU0IgVHlwZS1DIENhYmxlIGFu
ZCBBY2Nlc3NvcnkgRGV0ZWN0aW9uDQoNClRoYW5rLA0KU3RhbmxleQ0K
