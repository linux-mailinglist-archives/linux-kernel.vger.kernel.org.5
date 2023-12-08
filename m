Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB2A809BDD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 06:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbjLHFld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 00:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235655AbjLHFk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 00:40:58 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9210C1BF9;
        Thu,  7 Dec 2023 21:40:39 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3B85e2Qy9644105, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3B85e2Qy9644105
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Dec 2023 13:40:03 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 8 Dec 2023 13:40:03 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 8 Dec 2023 13:40:01 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::5510:ad08:5390:1ed3]) by
 RTEXMBS03.realtek.com.tw ([fe80::5510:ad08:5390:1ed3%2]) with mapi id
 15.01.2375.007; Fri, 8 Dec 2023 13:40:01 +0800
From:   =?utf-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?= <james.tai@realtek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: RE: [PATCH v3 1/6] dt-bindings: interrupt-controller: Add support for Realtek DHC SoCs
Thread-Topic: [PATCH v3 1/6] dt-bindings: interrupt-controller: Add support
 for Realtek DHC SoCs
Thread-Index: AQHaIocbzgu5rIWoH0WCW95lXyvvArCQeOSAgA5Nk3A=
Date:   Fri, 8 Dec 2023 05:40:01 +0000
Message-ID: <43d4a52d03374280a5f5dcdf378b39e8@realtek.com>
References: <20231129054339.3054202-1-james.tai@realtek.com>
 <20231129054339.3054202-2-james.tai@realtek.com>
 <bc95ef35-7eab-4806-9cf8-4594156c9d98@linaro.org>
In-Reply-To: <bc95ef35-7eab-4806-9cf8-4594156c9d98@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [49.216.16.144]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
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

SGkgS3J6eXN6dG9mLA0KDQo+T24gMjkvMTEvMjAyMyAwNjo0MywgSmFtZXMgVGFpIHdyb3RlOg0K
Pj4gQWRkIHRoZSBZQU1MIGRvY3VtZW50YXRpb24gZm9yIFJlYWx0ZWsgREhDIChEaWdpdGFsIEhv
bWUgQ2VudGVyKSBTb0NzLg0KPj4NCj4+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8
bGtwQGludGVsLmNvbT4NCj4+IENsb3NlczoNCj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL29l
LWtidWlsZC1hbGwvMjAyMzExMTgwOTIxLmF5S2hpRkhMLWxrcEBpbnRlbC4NCj4+IGNvbS8NCj4N
Cj5Ecm9wIGJvdGguIFRoZXkgYXJlIG5vdCBhcHBsaWNhYmxlIHRvIHRoaXMgcGF0Y2guDQo+DQpP
a2F5LiBJIHdpbGwgZHJvcCB0aGVtLg0KDQo+PiBDQzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxp
bnV0cm9uaXguZGU+DQo+PiBDQzogTWFyYyBaeW5naWVyIDxtYXpAa2VybmVsLm9yZz4NCj4NCj4+
IENDOiBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPg0KPj4gQ0M6IEtyenlzenRvZiBL
b3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZz4NCj4+IENDOiBDb25v
ciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+DQo+PiBDQzogbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZw0KPj4gQ0M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnDQo+DQo+UGxlYXNl
IGRyb3AgdGhlIGF1dG9nZW5lcmF0ZWQgc2NyaXB0cy9nZXRfbWFpbnRhaW5lci5wbCBDQy1lbnRy
aWVzIGZyb20NCj5jb21taXQgbXNnLiBUaGVyZSBpcyBubyBzaW5nbGUgbmVlZCB0byBzdG9yZSBh
dXRvbWF0ZWQgb3V0cHV0IG9mDQo+Z2V0X21haW50YWluZXJzLnBsIGluIHRoZSBnaXQgbG9nLiBJ
dCBjYW4gYmUgZWFzaWx5IHJlLWNyZWF0ZWQgYXQgYW55IGdpdmVuIHRpbWUsDQo+dGh1cyBpdHMg
cHJlc2VuY2UgaW4gdGhlIGdpdCBoaXN0b3J5IGlzIHJlZHVuZGFudCBhbmQgb2JmdXNjYXRlcyB0
aGUgbG9nLg0KPg0KPklmIHlvdSBuZWVkIGl0IGZvciB5b3VyIG93biBwYXRjaCBtYW5hZ2VtZW50
IHB1cnBvc2VzLCBrZWVwIGl0IHVuZGVyIHRoZQ0KPi0tLSBzZXBhcmF0b3IuDQo+DQpJIHdpbGwg
bW92ZSB0aGUgQ0MtZW50cmllcyB1bmRlciB0aGUgJy0tLScgc2VwYXJhdG9yLg0KDQo+TXkgcHJl
dmlvdXMgY29tbWVudHMgd2VyZSBub3QgYWRkcmVzc2VkLiBXaHkgbGluZXMgYXJlIG5vdCBkZXNj
cmliZWQNCj4oaXRlbXM6IGRlc2NyaXB0aW9uOik/IEFyZSB0aGV5IGFsbCB0aGUgc2FtZT8gV2h5
IHlvdSBkaWQgbm90IHJlc3BvbmQgdG8gY2xhcmlmeQ0KPnRoaXMgY29tbWVudD8NCj4NCkkndmUg
YWRkcmVzc2VkIHRoZSBwcmV2aW91cyBjb21tZW50cyBhbmQgd2lsbCBpbmNsdWRlIGEgZGVzY3Jp
cHRpb24gZm9yIGVhY2ggbGluZSBpbiB0aGUgbmV4dCBwYXRjaGVzLg0KSSBtaXN1bmRlcnN0b29k
IHlvdXIgbWVhbmluZywgc28gSSBkaWQgbm90IHByb3ZpZGUgYSBjbGVhciByZXNwb25zZS4NCg0K
PlRoZSByZXN0IG9mIG15IGNvbW1lbnQgaGVyZSB3YXMgYWxzbyBpZ25vcmVkLiBZb3UgY2Fubm90
IGp1c3QgaWdub3JlDQo+Y29tbWVudHMsIGJ1dCBtdXN0IHJlc3BvbmQgdG8gdGhlbSBvciBpbXBs
ZW1lbnQgdGhlbS4NCj4NCkkgd2lsbCBpbXByb3ZlIHRoaXMgcGFydC4NCg0KPlRvIGNsYXJpZnk6
IEkgZXhwZWN0IGFsbE9mOiBibG9jayBhZnRlciByZXF1aXJlZDogY29uc3RyYWluaW5nIHRoZSBp
bnRlcnJ1cHRzIHBlcg0KPnZhcmlhbnQuDQo+DQpJIHdpbGwgYWRqdXN0IGl0IGluIG5leHQgcGF0
Y2hlcy4NCg0KUmVnYXJkcywNCkphbWVzDQoNCg0K
