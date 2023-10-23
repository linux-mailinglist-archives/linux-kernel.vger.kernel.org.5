Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D51B7D3E2F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjJWRqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbjJWRcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:32:47 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B030210D0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:32:43 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C017260002;
        Mon, 23 Oct 2023 17:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698082361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EfueXGvjgesecqSp0xRW1Mgp7vJPbqrWtJ0QA5A/ooA=;
        b=G+cA8AymeIh309nWrDAo4ku2dieKl/74zsIq3QlRtTAh/IQp++HRwyo4CEWj70lKWcZ7Gr
        DDd0bnD5B4LthHDfaP0ve6IK6YnSlCkKX3NfNvQQhnHTJWtuYtPwUk2NDS6X5FB5XeKbGa
        7HruUpjBgRfD9+1rlD5JIeT4mxp6EYt0MCgkAmMcluhtuYi79obeIv6CHwsh3No1dBGZNh
        WvGqOgp2Xu3FLwFzlCosH9fmtnvK0yYK5ruznD7X0achC357tP1ZWlHInvgJa/dGvBgFiH
        nfJ1evo1PqewNivzP7cX8qcPJ33g7/ghqPEN48WjKaikU3K7A5G9z+SWBcscdw==
Message-ID: <93c9b325c9178e5452734a1befcfc76f073f23a3.camel@bootlin.com>
Subject: Re: [PATCH] ARM: at91: pm: set soc_pm.data.mode in
 at91_pm_secure_init()
From:   Thomas Perrot <thomas.perrot@bootlin.com>
To:     claudiu beznea <claudiu.beznea@tuxon.dev>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clement.leger@bootlin.com
Date:   Mon, 23 Oct 2023 19:32:19 +0200
In-Reply-To: <635cea61-861b-4af3-a4ee-ed048456e200@tuxon.dev>
References: <20231020130219.1255937-1-thomas.perrot@bootlin.com>
         <635cea61-861b-4af3-a4ee-ed048456e200@tuxon.dev>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-+iX11BAxGAibvYjv7Ia/"
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-GND-Sasl: thomas.perrot@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+iX11BAxGAibvYjv7Ia/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

SGVsbG8gQ2xhdWRpdSwKCk9uIE1vbiwgMjAyMy0xMC0yMyBhdCAwOTowMSArMDMwMCwgY2xhdWRp
dSBiZXpuZWEgd3JvdGU6Cj4gPiBIaSwgVGhvbWFzLAo+ID4gCj4gPiA+ID4gCj4gPiA+ID4gZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtYXQ5MS9wbS5jIGIvYXJjaC9hcm0vbWFjaC1hdDkxL3Bt
LmMKPiA+ID4gPiBpbmRleCAxYTI2YWYwZmFiYzcuLjM0NWI5MWRjNjYyNyAxMDA2NDQKPiA+ID4g
PiAtLS0gYS9hcmNoL2FybS9tYWNoLWF0OTEvcG0uYwo+ID4gPiA+ICsrKyBiL2FyY2gvYXJtL21h
Y2gtYXQ5MS9wbS5jCj4gPiA+ID4gQEAgLTExMDMsNiArMTEwMyw3IEBAIHN0YXRpYyB2b2lkIF9f
aW5pdAo+ID4gPiA+IGF0OTFfcG1fc2VjdXJlX2luaXQodm9pZCkKPiA+ID4gPiDCoMKgwqDCoMKg
wqDCoMKgaWYgKHJlcy5hMCA9PSAwKSB7Cj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBwcl9pbmZvKCJBVDkxOiBTZWN1cmUgUE06IHN1c3BlbmQgbW9kZSBzZXQgdG8KPiA+
ID4gPiAlc1xuIiwKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBwbV9tb2Rlc1tzdXNwZW5kX21vZGVdLnBhdHRlcm4pOwo+ID4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzb2NfcG0uZGF0YS5tb2RlID0gc3VzcGVuZF9tb2Rl
Owo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuOwo+ID4gPiA+
IMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiA+ID4gwqAKPiA+ID4gPiBAQCAtMTExMiw2ICsxMTEzLDcg
QEAgc3RhdGljIHZvaWQgX19pbml0Cj4gPiA+ID4gYXQ5MV9wbV9zZWN1cmVfaW5pdCh2b2lkKQo+
ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqByZXMgPSBzYW1fc21jY2NfY2FsbChTQU1BNV9TTUNfU0lQ
X0dFVF9TVVNQRU5EX01PREUsIDAsCj4gPiA+ID4gMCk7Cj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDC
oGlmIChyZXMuYTAgPT0gMCkgewo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcHJfd2FybigiQVQ5MTogU2VjdXJlIFBNOiBmYWlsZWQgdG8gZ2V0IGRlZmF1bHQKPiA+ID4g
PiBtb2RlXG4iKTsKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc29jX3Bt
LmRhdGEubW9kZSA9IC0xOwo+ID4gCj4gPiBBcyB0aGlzIHZhcmlhYmxlJ3MgdHlwZSBpcyB1bnNp
Z25lZCBpbnQgc2V0dGluZyBpdCAtMSB3aWxsIG1ha2UKPiA+IGF0OTFfc3VzcGVuZF9lbnRlcmlu
Z19zbG93X2Nsb2NrKCkgcmV0dXJuIHRydWUgYWxsIHRoZSB0aW1lLiBJcwo+ID4gdGhpcwo+ID4g
d2hhdAo+ID4geW91IGludGVuZD8KPiA+IAoKWWVzLCB0byBzZXQgaXQgYXQgdGhlIHNhbWUgZGVm
YXVsdCB2YWx1ZSwgYXMgaW4gYXQ5MV9wbV9iZWdpbigpIFsxXSwKd2hlbiBhbiB1bnN1cHBvcnRl
ZCBtb2RlIGlzIHVzZWQgYW5kIGNhbuKAmXQgZ2V0IHRoZSBkZWZhdWx0IHZhbHVlIGZyb20KdGhl
IHNlY3VyZSBtb25pdG9yLgoKWzFdaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvbGF0
ZXN0L3NvdXJjZS9hcmNoL2FybS9tYWNoLWF0OTEvcG0uYyNMNDcwCgpLaW5kIHJlZ2FyZHMsClRo
b21hcyBQZXJyb3QKCj4gPiBUaGFuayB5b3UsCj4gPiBDbGF1ZGl1IEJlem5lYQo+ID4gCj4gPiA+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm47Cj4gPiA+ID4gwqDCoMKg
wqDCoMKgwqDCoH0KPiA+ID4gPiDCoAo+ID4gPiA+IEBAIC0xMTE5LDYgKzExMjEsNyBAQCBzdGF0
aWMgdm9pZCBfX2luaXQKPiA+ID4gPiBhdDkxX3BtX3NlY3VyZV9pbml0KHZvaWQpCj4gPiA+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwbV9tb2Rlc1tzdXNwZW5kX21vZGVdLnBh
dHRlcm4pOwo+ID4gPiA+IMKgCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoHNvY19wbS5kYXRhLnN1
c3BlbmRfbW9kZSA9IHJlcy5hMTsKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqBzb2NfcG0uZGF0YS5t
b2RlID0gc29jX3BtLmRhdGEuc3VzcGVuZF9tb2RlOwo+ID4gPiA+IMKgfQo+ID4gPiA+IMKgc3Rh
dGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgYXRtZWxfc2hkd2NfaWRzW10gPSB7Cj4gPiA+
ID4gwqDCoMKgwqDCoMKgwqDCoHsgLmNvbXBhdGlibGUgPSAiYXRtZWwsc2FtYTVkMi1zaGR3YyIg
fSwKCi0tIApUaG9tYXMgUGVycm90LCBCb290bGluCkVtYmVkZGVkIExpbnV4IGFuZCBrZXJuZWwg
ZW5naW5lZXJpbmcKaHR0cHM6Ly9ib290bGluLmNvbQoKCi0tIApUaG9tYXMgUGVycm90LCBCb290
bGluCkVtYmVkZGVkIExpbnV4IGFuZCBrZXJuZWwgZW5naW5lZXJpbmcKaHR0cHM6Ly9ib290bGlu
LmNvbQoK


--=-+iX11BAxGAibvYjv7Ia/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCAAdFiEEh0B3xqajCiMDqBIhn8ALBXH+Cu0FAmU2riMACgkQn8ALBXH+
Cu0RRgwAkGqqXyaTdx+10/tAws+p9gRO4AjELB8dgfRcaBAe2SUcGVkiGqfHWjH2
sxYJfNowGnJ4GfqtopppXCRrRWgnScdQ3iLOYjtblJ9wijzwi8ecLwt2nRYHxQk3
P92qW/9LXpXHKqCKEZZeTzb1OXbIFXSRX3PmYD3ek5OTzJYq6Ks4El8ykuD/kpyk
5mK5i5YlrfQyUBdcNa76KH1t8sx5hXbaxYl3sf9n+GjByVzoMzzJdDGQJCnB2h/g
v1kZz4hmylqOROlBtoZC+60EbcqVYLrlBg+BXDlzImrQNF90ySMb4R/0tqTELowK
64XQHsYe+AFw/8wtROu7m2PoA1bp0i7B4XfQJoA13bbO4/e6P3Vrry8KsbEEZ7bx
TbYBz5LRa/ICr3XfSHBYCJZDq1ybK2CCdALuH6fejstCzEzBDF7sv2xzg2pVnpZ4
Rj5c87O/K5/rYkFpspyectb1hLaBwCztprhxUWgtR+3PnwUGt0sbElilpxcBpdTA
wbmBuVgi
=ln6Y
-----END PGP SIGNATURE-----

--=-+iX11BAxGAibvYjv7Ia/--
