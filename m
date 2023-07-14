Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5EE753F25
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 17:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236008AbjGNPjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 11:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235454AbjGNPjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 11:39:43 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DA130E3;
        Fri, 14 Jul 2023 08:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1689349178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OyBc4HygQ+C3p3pazjwJiG3/UxFzCI/AV+IJeiS4VBY=;
        b=kAFz7Mb3jX6mJrhmvWWpEf1IAik0/+mEHUrn4NzmohB/FINeYSJ1jwhfXRISEKSBWVfbCE
        C9/vuZdHavRuVhN9hdIau/DA8JIcZKwjxX0AkgYTiYD+BvOVtCFUyAu46torKBaGVWqLNC
        e3owR9xmrbwSoBWFjXUCl8cV6+55Tso=
Message-ID: <a7b7afa6ef2aed620c342f569e1911120aa2a6e5.camel@crapouillou.net>
Subject: Re: [PATCH] ARM: dts: exynos/i9100: Fix LCD screen's physical size
From:   Paul Cercueil <paul@crapouillou.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>, stable@vger.kernel.org
Date:   Fri, 14 Jul 2023 17:39:37 +0200
In-Reply-To: <20230714153720.336990-1-paul@crapouillou.net>
References: <20230714153720.336990-1-paul@crapouillou.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T29vcHMsIHNob3VsZCBoYXZlIGJlZW4gVjMuCgpWMS9WMiB3YXMgcGFydCBvZiBteSAiR2FsYXh5
IFMyIChpOTEwMCkgcGFuZWwgdXBkYXRlcyIgc2VyaWVzLiBUaGlzIG9uZQpwYXRjaCBkaWQgbm90
IGNoYW5nZSBzaW5jZSBWMSAtIGV4Y2VwdCB0aGUgQUNLIGZyb20gU2FtLgoKLVBhdWwKCkxlIHZl
bmRyZWRpIDE0IGp1aWxsZXQgMjAyMyDDoCAxNzozNyArMDIwMCwgUGF1bCBDZXJjdWVpbCBhIMOp
Y3JpdMKgOgo+IFRoZSBwcmV2aW91cyB2YWx1ZXMgd2VyZSBjb21wbGV0ZWx5IGJvZ3VzLCBhbmQg
cmVzdWx0ZWQgaW4gdGhlCj4gY29tcHV0ZWQKPiBEUEkgcmF0aW8gYmVpbmcgbXVjaCBsb3dlciB0
aGFuIHJlYWxpdHksIGNhdXNpbmcgYXBwbGljYXRpb25zIGFuZCBVSXMKPiB0bwo+IG1pc2JlaGF2
ZS4KPiAKPiBUaGUgbmV3IHZhbHVlcyB3ZXJlIG1lYXN1cmVkIGJ5IG15c2VsZiB3aXRoIGEgcnVs
ZXIuCj4gCj4gU2lnbmVkLW9mZi1ieTogUGF1bCBDZXJjdWVpbCA8cGF1bEBjcmFwb3VpbGxvdS5u
ZXQ+Cj4gQWNrZWQtYnk6IFNhbSBSYXZuYm9yZyA8c2FtQHJhdm5ib3JnLm9yZz4KPiBGaXhlczog
ODYyMGNjMmY5OWI3ICgiQVJNOiBkdHM6IGV4eW5vczogQWRkIGRldmljZXRyZWUgZmlsZSBmb3Ig
dGhlCj4gR2FsYXh5IFMyIikKPiBDYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+ICMgdjUuOCsK
PiAtLS0KPiDCoGFyY2gvYXJtL2Jvb3QvZHRzL3NhbXN1bmcvZXh5bm9zNDIxMC1pOTEwMC5kdHMg
fCA0ICsrLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pCj4gCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL3NhbXN1bmcvZXh5bm9zNDIx
MC1pOTEwMC5kdHMKPiBiL2FyY2gvYXJtL2Jvb3QvZHRzL3NhbXN1bmcvZXh5bm9zNDIxMC1pOTEw
MC5kdHMKPiBpbmRleCAzN2NkNGRkZTUzZTQuLmE5ZWMxZjZjMWRlYSAxMDA2NDQKPiAtLS0gYS9h
cmNoL2FybS9ib290L2R0cy9zYW1zdW5nL2V4eW5vczQyMTAtaTkxMDAuZHRzCj4gKysrIGIvYXJj
aC9hcm0vYm9vdC9kdHMvc2Ftc3VuZy9leHlub3M0MjEwLWk5MTAwLmR0cwo+IEBAIC0yMDcsOCAr
MjA3LDggQEAgbGNkQDAgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHBvd2VyLW9uLWRlbGF5ID0gPDEwPjsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXNldC1kZWxheSA9IDwxMD47Cj4gwqAKPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBhbmVsLXdpZHRoLW1t
ID0gPDkwPjsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHBhbmVsLWhlaWdodC1tbSA9IDwxNTQ+Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcGFuZWwtd2lkdGgtbW0gPSA8NTY+Owo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGFuZWwtaGVpZ2h0LW1tID0gPDkzPjsK
PiDCoAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRp
c3BsYXktdGltaW5ncyB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRpbWluZyB7Cgo=

