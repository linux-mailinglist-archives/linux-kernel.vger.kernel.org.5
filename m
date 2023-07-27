Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45665764EA2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjG0JI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbjG0JII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:08:08 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABE8EA5D5;
        Thu, 27 Jul 2023 01:49:07 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 36R8LnOkA004705, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 36R8LnOkA004705
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 27 Jul 2023 16:21:49 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 27 Jul 2023 16:22:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 27 Jul 2023 16:22:01 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Thu, 27 Jul 2023 16:22:01 +0800
From:   =?big5?B?VFlfQ2hhbmdbsWmkbLZoXQ==?= <tychang@realtek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: RE: [PATCH 7/7] dt-bindings: pinctrl: realtek: add RTD1619B pinctrl binding
Thread-Topic: [PATCH 7/7] dt-bindings: pinctrl: realtek: add RTD1619B pinctrl
 binding
Thread-Index: AQHZv7exjVfyXJsHrEuOnb3buOw8/6/NRDrg
Date:   Thu, 27 Jul 2023 08:22:00 +0000
Message-ID: <7ba2cf80260149fd8996a8ad8b9df82e@realtek.com>
References: <20230726090409.16606-1-tychang@realtek.com>
 <20230726090409.16606-8-tychang@realtek.com>
 <169037236741.1158189.1605537876806523813.robh@kernel.org>
In-Reply-To: <169037236741.1158189.1605537876806523813.robh@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.181.166]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KPkZyb206IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+U2VudDogV2Vk
bmVzZGF5LCBKdWx5IDI2LCAyMDIzIDc6NTMgUE0NCj5UbzogVFlfQ2hhbmdbsWmkbLZoXSA8dHlj
aGFuZ0ByZWFsdGVrLmNvbT4NCj5DYzogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtv
emxvd3NraStkdEBsaW5hcm8ub3JnPjsgUm9iIEhlcnJpbmcNCj48cm9iaCtkdEBrZXJuZWwub3Jn
PjsgQ29ub3IgRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsNCj5kZXZpY2V0cmVlQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtZ3Bpb0B2Z2VyLmtlcm5lbC5vcmc7DQo+bGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgTGludXMgV2FsbGVpaiA8bGludXMud2FsbGVpakBsaW5hcm8ub3JnPg0K
PlN1YmplY3Q6IFJlOiBbUEFUQ0ggNy83XSBkdC1iaW5kaW5nczogcGluY3RybDogcmVhbHRlazog
YWRkIFJURDE2MTlCIHBpbmN0cmwgYmluZGluZw0KPg0KPg0KPkV4dGVybmFsIG1haWwuDQo+DQo+
DQo+DQo+T24gV2VkLCAyNiBKdWwgMjAyMyAxNzowNDowOSArMDgwMCwgVFkgQ2hhbmcgd3JvdGU6
DQo+PiBBZGQgZGV2aWNlIHRyZWUgYmluZGluZ3MgZm9yIFJURDE2MTlCLg0KPj4NCj4+IFNpZ25l
ZC1vZmYtYnk6IFRZIENoYW5nIDx0eWNoYW5nQHJlYWx0ZWsuY29tPg0KPj4gLS0tDQo+PiAgLi4u
L3BpbmN0cmwvcmVhbHRlayxydGQxNjE5Yi1waW5jdHJsLnlhbWwgICAgIHwgMTYyICsrKysrKysr
KysrKysrKysrKw0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAxNjIgaW5zZXJ0aW9ucygrKQ0KPj4gIGNy
ZWF0ZSBtb2RlIDEwMDY0NA0KPj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bp
bmN0cmwvcmVhbHRlayxydGQxNjE5Yi1waW5jdHJsLnlhbQ0KPj4gbA0KPj4NCj4NCj5NeSBib3Qg
Zm91bmQgZXJyb3JzIHJ1bm5pbmcgJ21ha2UgRFRfQ0hFQ0tFUl9GTEFHUz0tbSBkdF9iaW5kaW5n
X2NoZWNrJw0KPm9uIHlvdXIgcGF0Y2ggKERUX0NIRUNLRVJfRkxBR1MgaXMgbmV3IGluIHY1LjEz
KToNCj4NCj55YW1sbGludCB3YXJuaW5ncy9lcnJvcnM6DQo+DQo+ZHRzY2hlbWEvZHRjIHdhcm5p
bmdzL2Vycm9yczoNCj5Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGluY3RybC9y
ZWFsdGVrLHJ0ZDE2MTliLXBpbmN0cmwuZXhhbXBsZS5kdGI6DQo+L2V4YW1wbGUtMC9waW5jdHJs
QDRlMDAwOiBmYWlsZWQgdG8gbWF0Y2ggYW55IHNjaGVtYSB3aXRoIGNvbXBhdGlibGU6DQo+Wydy
ZWFsdGVrLHJ0ZDE2eHhiLXBpbmN0cmwnXQ0KPg0KPmRvYyByZWZlcmVuY2UgZXJyb3JzIChtYWtl
IHJlZmNoZWNrZG9jcyk6DQo+DQo+U2VlDQo+aHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9w
cm9qZWN0L2RldmljZXRyZWUtYmluZGluZ3MvcGF0Y2gvMjAyMzA3MjYwOTA0MDkNCj4uMTY2MDYt
OC10eWNoYW5nQHJlYWx0ZWsuY29tDQo+DQo+VGhlIGJhc2UgZm9yIHRoZSBzZXJpZXMgaXMgZ2Vu
ZXJhbGx5IHRoZSBsYXRlc3QgcmMxLiBBIGRpZmZlcmVudCBkZXBlbmRlbmN5IHNob3VsZCBiZQ0K
Pm5vdGVkIGluICp0aGlzKiBwYXRjaC4NCj4NCj5JZiB5b3UgYWxyZWFkeSByYW4gJ21ha2UgZHRf
YmluZGluZ19jaGVjaycgYW5kIGRpZG4ndCBzZWUgdGhlIGFib3ZlIGVycm9yKHMpLCB0aGVuDQo+
bWFrZSBzdXJlICd5YW1sbGludCcgaXMgaW5zdGFsbGVkIGFuZCBkdC1zY2hlbWEgaXMgdXAgdG8N
Cj5kYXRlOg0KPg0KPnBpcDMgaW5zdGFsbCBkdHNjaGVtYSAtLXVwZ3JhZGUNCj4NCj5QbGVhc2Ug
Y2hlY2sgYW5kIHJlLXN1Ym1pdCBhZnRlciBydW5uaW5nIHRoZSBhYm92ZSBjb21tYW5kIHlvdXJz
ZWxmLiBOb3RlIHRoYXQNCj5EVF9TQ0hFTUFfRklMRVMgY2FuIGJlIHNldCB0byB5b3VyIHNjaGVt
YSBmaWxlIHRvIHNwZWVkIHVwIGNoZWNraW5nIHlvdXINCj5zY2hlbWEuIEhvd2V2ZXIsIGl0IG11
c3QgYmUgdW5zZXQgdG8gdGVzdCBhbGwgZXhhbXBsZXMgd2l0aCB5b3VyIHNjaGVtYS4NCj4NCkkg
d2lsbCBmaXggaXQgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KVGhhbmtzLA0KVFkgQ2hhbmcNCg==
