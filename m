Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9D079C3F4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 05:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242374AbjILDTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 23:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241910AbjILDSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 23:18:47 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 171C11717;
        Mon, 11 Sep 2023 19:48:36 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38C2mEZt92015605, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38C2mEZt92015605
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 10:48:14 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 12 Sep 2023 10:48:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 12 Sep 2023 10:48:14 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c]) by
 RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c%5]) with mapi id
 15.01.2375.007; Tue, 12 Sep 2023 10:48:14 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 RESEND 1/2] usb: dwc3: core: configure TX/RX threshold for DWC3_IP
Thread-Topic: [PATCH v2 RESEND 1/2] usb: dwc3: core: configure TX/RX threshold
 for DWC3_IP
Thread-Index: AQHZ2XPLXhNkYatA80OF+c6YFdmS4bAV2rkAgAC24zA=
Date:   Tue, 12 Sep 2023 02:48:14 +0000
Message-ID: <567f066c59de49e88dec4bae459d1dcc@realtek.com>
References: <20230828055212.5600-1-stanley_chang@realtek.com>
 <20230911234408.xb5higafb6ssajyt@synopsys.com>
In-Reply-To: <20230911234408.xb5higafb6ssajyt@synopsys.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVGhpbmgsDQoNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUu
YyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGluZGV4DQo+ID4gOWM2YmYwNTRmMTVkLi4xZjc0
YTUzODE2YzMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gPiAr
KysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+IEBAIC0xMjQ2LDYgKzEyNDYsMzkgQEAg
c3RhdGljIGludCBkd2MzX2NvcmVfaW5pdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiA+ICAgICAgICAg
ICAgICAgfQ0KPiA+ICAgICAgIH0NCj4gPg0KPiA+ICsgICAgIGlmIChEV0MzX0lQX0lTKERXQzMp
KSB7DQo+IA0KPiBXb3VsZCB5b3UgbWluZCBhbHNvIGFkZCB0aGUgY2hlY2tzIGZvciBEV0NfdXNi
MzEgYW5kIERXQ191c2IzMj8gQm90aA0KPiB0aGUNCj4gRFdDX3VzYjMxIGFuZCBEV0NfdXNiMzIg
c2hhcmUgdGhlIHNhbWUgZmllbGQgb2Zmc2V0cyB3aXRoaW4NCj4gR1RYL1JYVEhSQ0ZHIHJlZ2lz
dGVycy4gVGhlIG1hY3JvcyBhcmUgYWxyZWFkeSBkZWZpbmVkIGZvciB0aG9zZSBJUHMuDQoNCkRX
QzMgYW5kIERXQzMxLCBEV0MzMiBzZWVtIHRvIGhhdmUgZGlmZmVyZW50IHJlZ2lzdGVyIGRlZmlu
aXRpb24gYXMgZm9sbG93cy4NCi8qIEdsb2JhbCBSWCBUaHJlc2hvbGQgQ29uZmlndXJhdGlvbiBS
ZWdpc3RlciAqLw0KI2RlZmluZSBEV0MzX0dSWFRIUkNGR19NQVhSWEJVUlNUU0laRShuKSAoKChu
KSAmIDB4MWYpIDw8IDE5KQ0KI2RlZmluZSBEV0MzX0dSWFRIUkNGR19SWFBLVENOVChuKSAoKChu
KSAmIDB4ZikgPDwgMjQpDQojZGVmaW5lIERXQzNfR1JYVEhSQ0ZHX1BLVENOVFNFTCBCSVQoMjkp
DQoNCi8qIEdsb2JhbCBUWCBUaHJlc2hvbGQgQ29uZmlndXJhdGlvbiBSZWdpc3RlciAqLw0KI2Rl
ZmluZSBEV0MzX0dUWFRIUkNGR19NQVhUWEJVUlNUU0laRShuKSAoKChuKSAmIDB4ZmYpIDw8IDE2
KQ0KI2RlZmluZSBEV0MzX0dUWFRIUkNGR19UWFBLVENOVChuKSAoKChuKSAmIDB4ZikgPDwgMjQp
DQojZGVmaW5lIERXQzNfR1RYVEhSQ0ZHX1BLVENOVFNFTCBCSVQoMjkpDQoNCi8qIEdsb2JhbCBS
WCBUaHJlc2hvbGQgQ29uZmlndXJhdGlvbiBSZWdpc3RlciBmb3IgRFdDX3VzYjMxIG9ubHkgKi8N
CiNkZWZpbmUgRFdDMzFfR1JYVEhSQ0ZHX01BWFJYQlVSU1RTSVpFKG4pICAgICAgICgoKG4pICYg
MHgxZikgPDwgMTYpDQojZGVmaW5lIERXQzMxX0dSWFRIUkNGR19SWFBLVENOVChuKSAgICAgICAg
ICAgICAoKChuKSAmIDB4MWYpIDw8IDIxKQ0KI2RlZmluZSBEV0MzMV9HUlhUSFJDRkdfUEtUQ05U
U0VMICAgICAgICAgICAgICAgQklUKDI2KQ0KI2RlZmluZSBEV0MzMV9SWFRIUk5VTVBLVFNFTF9I
U19QUkQgICAgICAgICAgICAgQklUKDE1KQ0KI2RlZmluZSBEV0MzMV9SWFRIUk5VTVBLVF9IU19Q
UkQobikgICAgICAgICAgICAgKCgobikgJiAweDMpIDw8IDEzKQ0KI2RlZmluZSBEV0MzMV9SWFRI
Uk5VTVBLVFNFTF9QUkQgICAgICAgICAgICAgICAgQklUKDEwKQ0KI2RlZmluZSBEV0MzMV9SWFRI
Uk5VTVBLVF9QUkQobikgICAgICAgICAgICAgICAgKCgobikgJiAweDFmKSA8PCA1KQ0KI2RlZmlu
ZSBEV0MzMV9NQVhSWEJVUlNUU0laRV9QUkQobikgICAgICAgICAgICAgKChuKSAmIDB4MWYpDQoN
Ci8qIEdsb2JhbCBUWCBUaHJlc2hvbGQgQ29uZmlndXJhdGlvbiBSZWdpc3RlciBmb3IgRFdDX3Vz
YjMxIG9ubHkgKi8NCiNkZWZpbmUgRFdDMzFfR1RYVEhSQ0ZHX01BWFRYQlVSU1RTSVpFKG4pICAg
ICAgICgoKG4pICYgMHgxZikgPDwgMTYpDQojZGVmaW5lIERXQzMxX0dUWFRIUkNGR19UWFBLVENO
VChuKSAgICAgICAgICAgICAoKChuKSAmIDB4MWYpIDw8IDIxKQ0KI2RlZmluZSBEV0MzMV9HVFhU
SFJDRkdfUEtUQ05UU0VMICAgICAgICAgICAgICAgQklUKDI2KQ0KI2RlZmluZSBEV0MzMV9UWFRI
Uk5VTVBLVFNFTF9IU19QUkQgICAgICAgICAgICAgQklUKDE1KQ0KI2RlZmluZSBEV0MzMV9UWFRI
Uk5VTVBLVF9IU19QUkQobikgICAgICAgICAgICAgKCgobikgJiAweDMpIDw8IDEzKQ0KI2RlZmlu
ZSBEV0MzMV9UWFRIUk5VTVBLVFNFTF9QUkQgICAgICAgICAgICAgICAgQklUKDEwKQ0KI2RlZmlu
ZSBEV0MzMV9UWFRIUk5VTVBLVF9QUkQobikgICAgICAgICAgICAgICAgKCgobikgJiAweDFmKSA8
PCA1KQ0KI2RlZmluZSBEV0MzMV9NQVhUWEJVUlNUU0laRV9QUkQobikgICAgICAgICAgICAgKChu
KSAmIDB4MWYpDQoNCj4gQWxzbywgSSB0aGluayB0aGlzIG5ldyBhZGRpdGlvbiB3aWxsIG1ha2Ug
ZHdjM19jb3JlX2luaXQoKSBsZW5ndGh5LiBDYW4gd2Ugc3BsaXQNCj4gdGhpcyBsb2dpYyB0byBh
IHNlcGFyYXRlIGZ1bmN0aW9uLCBwZXJoYXBzIGR3YzNfY29uZmlnX3RocmVzaG9sZCgpPw0KPiAN
Cg0KT2ssIEkgd2lsbCBtb3ZlIHRoaXMgbG9naWMgdG8gYSBuZXcgZnVuY3Rpb24uDQpUaGFua3Ms
DQpTdGFubGV5DQoNCg==
