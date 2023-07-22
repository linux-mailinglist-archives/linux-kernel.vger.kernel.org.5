Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F0175DD22
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 17:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjGVPQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 11:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGVPQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 11:16:29 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C39269D;
        Sat, 22 Jul 2023 08:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1690038947; x=1690643747; i=j.neuschaefer@gmx.net;
 bh=DKp45IIBYoScM3gOq89irlgG4MZZBXYk35aNvXEQOVo=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=peSacVoEJkNn7OT3PwUNkttw0xdQPnK3uxgpurzyayH/u6+RwvAMnJyOMfYnerxCuf0hAWl
 cQu7b/lyBhA11jd+MAR5j67nGg0lCDYaEzj2knqfddYGTng5i1IpkdwGNAe9KW1sm9Y80noMP
 TnN2ej94DRlDbAObu0pRdC7x1Fk5+sqjfFL+YxMHqLaZVqRvvXK+prWK+B0WhGcPCWFfNfIdb
 QTZkI89hlIYpHxEbU8jKFo44rNliO5rxsFRi1UmpDvXe3m0XagUQpboY4h5BaVKwFcd84e7A8
 7r4/ZSrCjCptW02Y2ldI80cA/mO9NewuywMeSeGxwlmctj2fnhdg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.5]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5mGH-1pp9mS0NVT-017FN3; Sat, 22
 Jul 2023 17:15:47 +0200
Date:   Sat, 22 Jul 2023 17:15:43 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v8 2/2] clk: wpcm450: Add Nuvoton WPCM450 clock/reset
 controller driver
Message-ID: <ZLvyn0xq3Msk+lxF@probook>
References: <20230428190226.1304326-1-j.neuschaefer@gmx.net>
 <20230428190226.1304326-3-j.neuschaefer@gmx.net>
 <4e0a5db18ed7d37038e67be0f1ddcb08.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xFMPhOBEsOewdD2L"
Content-Disposition: inline
In-Reply-To: <4e0a5db18ed7d37038e67be0f1ddcb08.sboyd@kernel.org>
X-Provags-ID: V03:K1:U3JFa06nPX+yAAtsBGx7TZSMDiakMlG1SjIVlktrFkuwfBB9xYO
 npBSX+mt1v6aO8JRI4lMroP4+yEhRco9SIzyMmPBNCouS17ywTTjDwXxdpol0cHFnwqAyLd
 XXYTiaUp4PeJXAlqSXZrR003DaxOanpw7Z93EUPlVq9B/8LTFJ98ujQbF3FzchNLIKaVktI
 cxoeOkLixXqT5UkPjahvg==
UI-OutboundReport: notjunk:1;M01:P0:2LET3M57zaI=;LxrOSz1sHUrFBQLmLb9qrOzniUX
 0VG9rGiFRA/MYvcHmYAwCzY+xsq6RtKKlQV7aDjxwNeJ5ZRjgWXv0BIttT50LvuKK8mEC1riB
 IO4mP0i0zphD/+ZZAdd5Mmmit2OI4AQ348pi93CnKU0Bc9xOlFTjCryDJtdkPHxIhwioQ+Lfa
 ODNZv+sTtmQY+FyikFfXgXcOodULof5HGu0UDzkeBMddK0qME49Z00NbS34i3ijGAE5o57t/Z
 TdRLW86Imu6KEapbeQ0YMLxskhKLV/macUCyLQg9aywBmYuZ3NZzPRQKMyKR/HdOVycqFHCOY
 OXQ+lxiq53c1oHYOtbkJ3I5DtDwSJPuPNyt8xYJ8p7V9CBQOPGJKMdoDRBMNk1MuoD40ox1jx
 x12tfbkYgCrS0WuLGiHQ/50ncKSwl527CtyXh+lgkXVOZnufQN2fUEpn7IFF0kjEjDYrUkhJc
 ZSAA8cpcWQdv0KbLIbGkU32bIP5VBCiOM5G5QKdKixEJcwrDQ+7lUfvrJ5p4A/V0xNmayeP4d
 MRAW1U3uOUA5ZlLn2b6SKItaOQnzKEb8cSLKhSPsky7ZDatlriBuqxEd2RSSl7E0QMPd2qAWf
 TVL+Dn41vH4mjGvkJXQKLcato3u99upzixf5zOdlPiA4l1CWUE24Jni2wNPtOLJuW5fNyWV4v
 Mmdx3lp46Jo/3N1WDkg6YKP5wLHDfeVC2xULRgP33Xnti+Pkz16lZZ1SwXP9wV+ZRQ1WyXWVa
 8jD21LykNLUw9NBKK6AIlUAbon0QwB95NifORBp+mFnqO/QxTTfJb2YI4c1G8PvXq3JXoTFJE
 Ia30Hlrx8AGPykk8O3yV9nnFsHHUb6SrsjfGtU0wsUSz0bzRiXHDeWidfRNsbTR/gUoWQvbLK
 7C9/VXk4wWeqECzWpqOFduiubjUZYo+zsah/Ym2Lg/oxgtnRZSKn6+2D+l4mOT357YECx6sTm
 e/FYtPNgzy3T2zmRTSI8KH4rr3k=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xFMPhOBEsOewdD2L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2023 at 05:02:15PM -0700, Stephen Boyd wrote:
> Quoting Jonathan Neusch=C3=A4fer (2023-04-28 12:02:26)
> > diff --git a/drivers/clk/clk-wpcm450.c b/drivers/clk/clk-wpcm450.c
[...]
> > +static unsigned long wpcm450_clk_pll_recalc_rate(struct clk_hw *hw,
> > +                                                unsigned long parent_r=
ate)
> > +{
> > +       struct wpcm450_clk_pll *pll =3D to_wpcm450_clk_pll(hw);
> > +       unsigned long fbdv, indv, otdv;
> > +       u64 rate;
> > +       u32 pllcon;
> > +
> > +       if (parent_rate =3D=3D 0) {
> > +               pr_err("%s: parent rate is zero", __func__);
>=20
> This can happen more often than you think, so probably best to remove
> it.

Alright.

> > +static const struct wpcm450_pll_data pll_data[] =3D {
> > +       { "pll0", { .name =3D "ref" }, REG_PLLCON0, 0 },
>=20
> This is new code, please don't use .name. Instead use .fw_name or .index =
with preference to
> .index first and .hw if the pointer is available in this driver.

As far as I can see, .fw_name and .index depend on a struct device*
being passed to clk_hw_register, which won't be available unless I
actually convert the driver to a platform driver.

Not relying on .name would indeed be nice.

> > +       // PLLs
>=20
> Please use /* comments like this */

Ok.

>=20
> > +       for (i =3D 0; i < ARRAY_SIZE(pll_data); i++) {
> > +               const struct wpcm450_pll_data *data =3D &pll_data[i];
> > +
> > +               hw =3D wpcm450_clk_register_pll(clk_base + data->reg, d=
ata->name,
> > +                                             &data->parent, data->flag=
s);
> > +               if (IS_ERR(hw)) {
> > +                       pr_info("Failed to register PLL: %pe", hw);
>=20
> Missing newline?

Indeed.

> > +CLK_OF_DECLARE(wpcm450_clk_init, "nuvoton,wpcm450-clk", wpcm450_clk_in=
it);
>=20
> Is something preventing this from being a platform driver?

As far as I remember I have tried to convert it to a platform driver but
wasn't very successful/satisfied. Unfortunately I didn't take detailed note=
s.

I'll give it another try.


Best regards,
Jonathan

--xFMPhOBEsOewdD2L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmS78nsACgkQCDBEmo7z
X9u0+RAArvX9QnMGiJdfJImygGn8bpW2vxZ7dWdP7trBycIf1ZXh1tU5g7ryDS7d
NuxbqryAcfcP1cWUbSStRPW+0lrHGGEbloDIUL1gjqNF3aPmHIftvLWeeX7hYXKw
fqUb/EYfBB6hJbiOXX97QkBrniwZ9o6SolV8xuc6QBU3LahtVV3BsO1RTWfQy72r
LSbHSW3K2JEPRAhHbPHoYNCJMmP+A5g16vnohM756tcDKAZkPc5VSN+d8PAlR+H4
k8LJE5d7MmXsAvi+MsURxgeNnrGuNuxASQ/P1Sym9jKa8/wgduDtBLs1heXFbmD5
0BfOPdEcYcDMpMmVbhFCwUa9qzuHYGJ6D1Bw8/GbtIiVqzgBYjyknjpPqSCEWQM+
OL9vqeEN4MIOFRwA1qaqvoEry3CFDsFJUsAXgTQ8cQ987xj2Wq90hcZtK2zD2aVa
2xpkvcneV8mHnnm7O3yOKeBXTK8n8NZIbl8wH4QmNLIlT0qbFaELRKRviOHb1piD
VY7Jgg2JQFcwnxAnU33IJRWpaPHraJRo/54jpjUAotIDrjYuESvSXIHPmfzecvzC
GEvuyRRgXjuC0IWJWZh5Jui5gU8UhK+UPbRpmuJtAAxCQok60maGBGl3eV4+ktwV
asLAGFJl5orQhr2PfMs01B87/Jv0QAGOGYqDGRUVGwFUZ6vmu3Y=
=pwkb
-----END PGP SIGNATURE-----

--xFMPhOBEsOewdD2L--
