Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21757DEB2F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 04:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348189AbjKBDL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 23:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbjKBDL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 23:11:56 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5594D110;
        Wed,  1 Nov 2023 20:11:49 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A23BT6J02297255, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 3A23BT6J02297255
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Nov 2023 11:11:30 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 2 Nov 2023 11:11:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 2 Nov 2023 11:11:29 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Thu, 2 Nov 2023 11:11:29 +0800
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
Subject: RE: [PATCH 2/2] dt-bindings: gpio: realtek: Add realtek,rtd-gpio bindings
Thread-Topic: [PATCH 2/2] dt-bindings: gpio: realtek: Add realtek,rtd-gpio
 bindings
Thread-Index: AQHaDG9It5wA6xURlESdwF4Dx71B1LBkhtMAgAHPQEA=
Date:   Thu, 2 Nov 2023 03:11:29 +0000
Message-ID: <eeded63e9e754e0e9a5b546e616be437@realtek.com>
References: <20231101025802.3744-1-tychang@realtek.com>
 <20231101025802.3744-3-tychang@realtek.com>
 <6a09f16e-0a41-4619-b7bb-b5561f7e36ce@linaro.org>
In-Reply-To: <6a09f16e-0a41-4619-b7bb-b5561f7e36ce@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.181.166]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-antivirus-attachment-filter-interceptor-info: license violation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpUaGFuayB5b3UgZm9yIHRoZSByZXZpZXcuDQoNCj5PbiAwMS8xMS8y
MDIzIDAzOjU4LCBUenV5aSBDaGFuZyB3cm90ZToNCj4+IFRoaXMgcGF0Y2ggYWRkcyB0aGUgZGV2
aWNlIHRyZWUgYmluZGluZ3MgZm9yIHRoZSBSZWFsdGVrIERIQyBSVEQgU29Dcw0KPj4gR1BJTyBj
b250cm9sbGVycy4NCj4+DQo+DQo+QSBuaXQsIHN1YmplY3Q6IGRyb3Agc2Vjb25kL2xhc3QsIHJl
ZHVuZGFudCAiYmluZGluZ3MiLiBUaGUgImR0LWJpbmRpbmdzIiBwcmVmaXggaXMNCj5hbHJlYWR5
IHN0YXRpbmcgdGhhdCB0aGVzZSBhcmUgYmluZGluZ3MuDQo+DQpJIHdpbGwgcmVtb3ZlIGl0Lg0K
DQo+PiBTaWduZWQtb2ZmLWJ5OiBUenV5aSBDaGFuZyA8dHljaGFuZ0ByZWFsdGVrLmNvbT4NCj4+
IC0tLQ0KPj4gIC4uLi9iaW5kaW5ncy9ncGlvL3JlYWx0ZWsscnRkLWdwaW8ueWFtbCAgICAgICB8
IDU2ICsrKysrKysrKysrKysrKysrKysNCj4+ICAxIGZpbGUgY2hhbmdlZCwgNTYgaW5zZXJ0aW9u
cygrKQ0KPj4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2dwaW8vcmVhbHRlayxydGQtZ3Bpby55YW1sDQo+DQo+SG93IGRvZXMgeW91ciBi
aW5kaW5nIGNvbWUgYWZ0ZXIgdGhlIHVzZXI/DQo+DQoNCkkgd2lsIG1vdmUgdGhlIGJpbmRpbmcg
dG8gdGhlIGZpcnN0IHBhdGNoLg0KDQo+Pg0KPj4gZGlmZiAtLWdpdA0KPj4gYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZ3Bpby9yZWFsdGVrLHJ0ZC1ncGlvLnlhbWwNCj4+IGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2dwaW8vcmVhbHRlayxydGQtZ3Bpby55
YW1sDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMDAwLi42Y2Fi
N2VjNTBjODgNCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9ncGlvL3JlYWx0ZWsscnRkLWdwaW8ueWFtbA0KPj4gQEAgLTAsMCArMSw1
NiBAQA0KPj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wIE9SIEJTRC0yLUNs
YXVzZSkgIyBDb3B5cmlnaHQgMjAyMw0KPj4gK1JlYWx0ZWsgU2VtaWNvbmR1Y3RvciBDb3Jwb3Jh
dGlvbiAlWUFNTCAxLjINCj4+ICstLS0NCj4+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9z
Y2hlbWFzL2dwaW8vcmVhbHRlayxydGQtZ3Bpby55YW1sIw0KPj4gKyRzY2hlbWE6IGh0dHA6Ly9k
ZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPj4gKw0KPj4gK3RpdGxlOiBS
ZWFsdGVrIERIQyBHUElPIGNvbnRyb2xsZXINCj4NCj5XaGF0IGlzIERIQz8gV2hlcmUgaXMgaXQg
ZXhwbGFpbmVkIGluIHRoZSBiaW5kaW5nPw0KPg0KDQpUaGlzIGlzIHRoZSBhYmJyZXZpYXRpb24g
b2YgIkRpZ2l0YWwgSG9tZSBDZW50ZXIiLiBJIHdpbGwgYWRkIHRoZSBkZXNjcmlwdGlvbiB0byBl
eHBsYWluIGl0Lg0KDQo+PiArDQo+PiArbWFpbnRhaW5lcnM6DQo+PiArICAtIFRZIENoYW5nIDx0
eWNoYW5nQHJlYWx0ZWsuY29tPg0KPj4gKw0KPj4gK3Byb3BlcnRpZXM6DQo+PiArICBjb21wYXRp
YmxlOg0KPj4gKyAgICBlbnVtOg0KPj4gKyAgICAgIC0gcmVhbHRlayxydGQtZ3Bpbw0KPg0KPldo
YXQgaXMgInJ0ZCI/IEdlbmVyaWMgbmFtZT8gRHJvcC4gWW91IGNhbm5vdCBoYXZlIGdlbmVyaWMg
Y29tcGF0aWJsZXMuDQo+DQoNClRoaXMgaXMgYSBnZW5lcmljIG5hbWUgZm9yIHRoZSBvdGhlcnMg
U29DcyB3aXRob3V0IHRoZSBzcGVjaWZpYyBjb21wYXRpYmxlLg0KSSB3aWxsIGZpeCBpdC4NCg0K
Pg0KPj4gKyAgICAgIC0gcmVhbHRlayxydGQxMjk1LW1pc2MtZ3Bpbw0KPj4gKyAgICAgIC0gcmVh
bHRlayxydGQxMjk1LWlzby1ncGlvDQo+PiArICAgICAgLSByZWFsdGVrLHJ0ZDEzOTUtaXNvLWdw
aW8NCj4+ICsgICAgICAtIHJlYWx0ZWsscnRkMTYxOS1pc28tZ3Bpbw0KPj4gKw0KPj4gKyAgcmVn
Og0KPj4gKyAgICBtYXhJdGVtczogMg0KPg0KPllvdSBuZWVkIHRvIGRlc2NyaWJlIHRoZSBpdGVt
cyBpbnN0ZWFkLg0KPg0KDQpJIHdpbGwgYWRkIHRoZSBkZXNjcmlwdGlvbi4NCg0KPj4gKw0KPj4g
KyAgaW50ZXJydXB0czoNCj4+ICsgICAgbWF4SXRlbXM6IDINCj4NCj5Zb3UgbmVlZCB0byBkZXNj
cmliZSB0aGUgaXRlbXMgaW5zdGVhZC4NCj4NCg0KSSB3aWxsIGFkZCB0aGUgZGVzY3JpcHRpb24u
DQoNCj4+ICsNCj4+ICsgIGdwaW8tcmFuZ2VzOiB0cnVlDQo+PiArDQo+PiArICBncGlvLWNvbnRy
b2xsZXI6IHRydWUNCj4+ICsNCj4+ICsgICIjZ3Bpby1jZWxscyI6DQo+PiArICAgIGNvbnN0OiAy
DQo+PiArDQo+PiArcmVxdWlyZWQ6DQo+PiArICAtIGNvbXBhdGlibGUNCj4+ICsgIC0gcmVnDQo+
PiArICAtIGludGVycnVwdHMNCj4+ICsgIC0gZ3Bpby1yYW5nZXMNCj4+ICsgIC0gZ3Bpby1jb250
cm9sbGVyDQo+PiArICAtICIjZ3Bpby1jZWxscyINCj4NCj5CZXN0IHJlZ2FyZHMsDQo+S3J6eXN6
dG9mDQoNCg0KVGhhbmtzLA0KVHp1eWkgQ2hhbmcNCg==
