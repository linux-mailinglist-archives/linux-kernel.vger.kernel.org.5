Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06FD7D0788
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 07:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345309AbjJTFSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 01:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjJTFSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 01:18:43 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5742B8;
        Thu, 19 Oct 2023 22:18:38 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39K5ILVJ03796783, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39K5ILVJ03796783
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Oct 2023 13:18:21 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 20 Oct 2023 13:18:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 20 Oct 2023 13:18:20 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Fri, 20 Oct 2023 13:18:20 +0800
From:   =?utf-8?B?SnlhbiBDaG91IFvlkajoirflrold?= <jyanchou@realtek.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "jh80.chung@samsung.com" <jh80.chung@samsung.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "benchuanggli@gmail.com" <benchuanggli@gmail.com>
Subject: RE: [PATCH V2][4/4] mmc: Add dt-bindings for realtek mmc driver
Thread-Topic: [PATCH V2][4/4] mmc: Add dt-bindings for realtek mmc driver
Thread-Index: AQHaAYdvaUivfrDiG06E3JgYAyloabBPFJAAgAMQaGA=
Date:   Fri, 20 Oct 2023 05:18:20 +0000
Message-ID: <c74fafea1ebe454c845e22306e356f7d@realtek.com>
References: <20231018055326.18256-1-jyanchou@realtek.com>
 <20231018055326.18256-5-jyanchou@realtek.com>
 <4a20bcf9-c0d7-45e9-ab19-e7e3bb073601@kernel.org>
In-Reply-To: <4a20bcf9-c0d7-45e9-ab19-e7e3bb073601@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.190.236]
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQo+IFBsZWFzZSB1c2Ugc3ViamVjdCBwcmVmaXhlcyBtYXRjaGluZyB0
aGUgc3Vic3lzdGVtLiBZb3UgY2FuIGdldCB0aGVtIGZvciBleGFtcGxlIHdpdGggYGdpdCBsb2cg
LS1vbmVsaW5lIC0tIERJUkVDVE9SWV9PUl9GSUxFYCBvbiB0aGUgZGlyZWN0b3J5IHlvdXIgcGF0
Y2ggaXMgdG91Y2hpbmcuDQo+IFBsZWFzZSB1c2Ugc2NyaXB0cy9nZXRfbWFpbnRhaW5lcnMucGwg
dG8gZ2V0IGEgbGlzdCBvZiBuZWNlc3NhcnkgcGVvcGxlIGFuZCBsaXN0cyB0byBDQy4gSXQgbWln
aHQgaGFwcGVuLCB0aGF0IGNvbW1hbmQgd2hlbiBydW4gb24gYW4gb2xkZXIga2VybmVsLCBnaXZl
cyB5b3Ugb3V0ZGF0ZWQgZW50cmllcy4gVGhlcmVmb3JlIHBsZWFzZSBiZSBzdXJlIHlvdSBiYXNl
IHlvdXIgcGF0Y2hlcyBvbiByZWNlbnQgTGludXgga2VybmVsLg0KDQpUaGFua3MgZm9yIHlvdXIg
cmVtaW5kLiBXZSBoYWQgbW9kaWZpZWQgb3VyIGNvZGUgYW5kIHJlc2VuZCBuZXcgcGF0Y2hlcy4N
Cg0KPiBZb3UgbWlzc2VkIGF0IGxlYXN0IGRldmljZXRyZWUgbGlzdCAobWF5YmUgbW9yZSksIHNv
IHRoaXMgd29uJ3QgYmUgdGVzdGVkIGJ5IGF1dG9tYXRlZCB0b29saW5nLiBQZXJmb3JtaW5nIHJl
dmlldyBvbiB1bnRlc3RlZCBjb2RlIG1pZ2h0IGJlIGEgd2FzdGUgb2YgdGltZSwgdGh1cyBJIHdp
bGwgc2tpcCB0aGlzIHBhdGNoIGVudGlyZWx5IHRpbGwgeW91IGZvbGxvdyB0aGUgcHJvY2VzcyBh
bGxvd2luZyB0aGUgPiBwYXRjaCB0byBiZSB0ZXN0ZWQuDQo+IEFsc28sIGNvZGluZyBzdHlsZSBv
ZiB5b3VyIGV4YW1wbGUgaXMgbWVzc3kuDQoNCkl0IHdhcyBvdXIgbWlzdGFrZSB0aGF0IGRpZG4n
dCBjaGVjayBkdC1iaW5kaW5ncyBhY2N1cmF0ZWx5LiBXZSBoYWQgY29ycmVjdGVkIGl0IGFuZCBy
ZXNlbmQgdG8gYWxsIG5lY2Vzc2FyeSBUby9DYyBlbnRyaWVzLiBUaGFua3MuDQoNCkJlc3QgcmVn
YXJkcywNCkp5YW4NCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogS3J6eXN6
dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPiANClNlbnQ6IFdlZG5lc2RheSwgT2N0b2Jl
ciAxOCwgMjAyMyAxMDoyNSBQTQ0KVG86IEp5YW4gQ2hvdSBb5ZGo6Iq35a6JXSA8anlhbmNob3VA
cmVhbHRlay5jb20+OyBhZHJpYW4uaHVudGVyQGludGVsLmNvbTsgdWxmLmhhbnNzb25AbGluYXJv
Lm9yZzsgamg4MC5jaHVuZ0BzYW1zdW5nLmNvbQ0KQ2M6IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGJlbmNodWFuZ2dsaUBnbWFpbC5jb20N
ClN1YmplY3Q6IFJlOiBbUEFUQ0ggVjJdWzQvNF0gbW1jOiBBZGQgZHQtYmluZGluZ3MgZm9yIHJl
YWx0ZWsgbW1jIGRyaXZlcg0KDQoNCkV4dGVybmFsIG1haWwuDQoNCg0KDQpPbiAxOC8xMC8yMDIz
IDA3OjUzLCBKeWFuIENob3Ugd3JvdGU6DQo+IERvY3VtZW50IHRoZSBkZXZpY2UtdHJlZSBiaW5k
aW5ncyBmb3IgUmVhbHRlayBTb0NzIG1tYyBkcml2ZXIuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEp5
YW4gQ2hvdSA8anlhbmNob3VAcmVhbHRlay5jb20+DQoNClBsZWFzZSB1c2Ugc3ViamVjdCBwcmVm
aXhlcyBtYXRjaGluZyB0aGUgc3Vic3lzdGVtLiBZb3UgY2FuIGdldCB0aGVtIGZvciBleGFtcGxl
IHdpdGggYGdpdCBsb2cgLS1vbmVsaW5lIC0tIERJUkVDVE9SWV9PUl9GSUxFYCBvbiB0aGUgZGly
ZWN0b3J5IHlvdXIgcGF0Y2ggaXMgdG91Y2hpbmcuDQoNClBsZWFzZSB1c2Ugc2NyaXB0cy9nZXRf
bWFpbnRhaW5lcnMucGwgdG8gZ2V0IGEgbGlzdCBvZiBuZWNlc3NhcnkgcGVvcGxlIGFuZCBsaXN0
cyB0byBDQy4gSXQgbWlnaHQgaGFwcGVuLCB0aGF0IGNvbW1hbmQgd2hlbiBydW4gb24gYW4gb2xk
ZXIga2VybmVsLCBnaXZlcyB5b3Ugb3V0ZGF0ZWQgZW50cmllcy4gVGhlcmVmb3JlIHBsZWFzZSBi
ZSBzdXJlIHlvdSBiYXNlIHlvdXIgcGF0Y2hlcyBvbiByZWNlbnQgTGludXgga2VybmVsLg0KDQpZ
b3UgbWlzc2VkIGF0IGxlYXN0IGRldmljZXRyZWUgbGlzdCAobWF5YmUgbW9yZSksIHNvIHRoaXMg
d29uJ3QgYmUgdGVzdGVkIGJ5IGF1dG9tYXRlZCB0b29saW5nLiBQZXJmb3JtaW5nIHJldmlldyBv
biB1bnRlc3RlZCBjb2RlIG1pZ2h0IGJlIGEgd2FzdGUgb2YgdGltZSwgdGh1cyBJIHdpbGwgc2tp
cCB0aGlzIHBhdGNoIGVudGlyZWx5IHRpbGwgeW91IGZvbGxvdyB0aGUgcHJvY2VzcyBhbGxvd2lu
ZyB0aGUgcGF0Y2ggdG8gYmUgdGVzdGVkLg0KDQpQbGVhc2Uga2luZGx5IHJlc2VuZCBhbmQgaW5j
bHVkZSBhbGwgbmVjZXNzYXJ5IFRvL0NjIGVudHJpZXMuDQoNCkFsc28sIGNvZGluZyBzdHlsZSBv
ZiB5b3VyIGV4YW1wbGUgaXMgbWVzc3kuDQoNCkJlc3QgcmVnYXJkcywNCktyenlzenRvZg0KDQo=
