Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B1D7D9B3D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345845AbjJ0OXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345851AbjJ0OXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:23:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DF2CC
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1698416546; x=1699021346; i=j.neuschaefer@gmx.net;
        bh=dCxpxgPmfy8g8OPUD5bxmh9AayipJuRVf4ARZt6MIug=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:
         In-Reply-To;
        b=Tit2SrAuTESMSKQiyL2yYwLFM+bUIDAk2PTxEOGE1qMOAyx5XHKID5f40c5FZfA7
         IesDvUH+hW5y4pfRbQUdwQpYBq1msKIlhBKBllMlhZSUhtjvXyaT6KvOxxHdWFf+D
         2W9oMDRdNyRMDTUX1JwYKtRK41ZsX9l35lbdCmyhpQ40kiceXbKCeoVWylYaGFtAN
         PWouRIZL92J7MD/1vsBqOWZa9a7pmWy28lF7Upy1e3DpeNfNfD3Xc/pSqtzBd2ipL
         sJAuS9zo4wLIIswfJaYTSVk9s4r0vAEPp9FwGKxOf8kaUKvYbAoeV0QFIjGbM85n3
         1MFl4OpCpeHN4urxXw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([89.1.58.199]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTzf6-1r4awK0Jnu-00R0S0; Fri, 27
 Oct 2023 16:22:26 +0200
Date:   Fri, 27 Oct 2023 16:22:24 +0200
From:   =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Nick Terrell <terrelln@meta.com>
Cc:     =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Xin Li <xin3.li@intel.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Paul Bolle <pebolle@tiscali.nl>,
        Bart Van Assche <bvanassche@acm.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] ARM ZSTD boot compression
Message-ID: <ZTvHoDXhKr8q4s1C@probook>
References: <20230412212126.3966502-1-j.neuschaefer@gmx.net>
 <9ae523ae-aad4-40b1-8b6b-d5e18bf8b92a@app.fastmail.com>
 <ecf9f34c-1f1f-47af-a470-0a6ae7773724@app.fastmail.com>
 <ZDoFQUYMZykLdTbX@probook>
 <1C6CE84E-557D-4436-BF13-E7275DE390A8@meta.com>
 <ZSic8JsHGIlfuwhp@probook>
 <35D39F92-FED3-479D-86FF-1B504C025831@meta.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UzfBP321mlYNqKjL"
Content-Disposition: inline
In-Reply-To: <35D39F92-FED3-479D-86FF-1B504C025831@meta.com>
X-Provags-ID: V03:K1:fWmh6hPdgt5gSIgG4BP/fNuJDyvfMLxv5AA4qUral9JnYXV1aK1
 Orv43lVLJ42sZpWiuP2X7CSMnMlGgbx1qkTwja9hKuuC2MaIVVR5MH7vEN/U+D8orV+/G+q
 WJ2GnJa2tE9p7+9/Y/gXojTGZtp2BuFJwpPY2HeqVYctwLeQoccBEQ52+mDb8OEBeDf5V55
 SCx310u+JvEU5z6cX1P7A==
UI-OutboundReport: notjunk:1;M01:P0:9SyZHCAFjQc=;db9s4RhsbH82A906vH5f6IbJHXU
 ukun4gw4PLSD6krnofm7kiHZvwv8DjSjaZM6WHQfoe5tLFKLRQTe3lKuMqR96JNhGMOZkw6EL
 vPj8+X6vhQNJyYwCh1aelmQSSSG4QNYaeWyGeyetn7vyKik/owDKhqbOKIY+nLwPs5I0Rf+qj
 2r3ECzpS2xR6nEyM3cXXdWXa7tPBt/Y+Q+sNC7zVDN6+h4PyXnC0dwvvtIaKfxb6xSKzu7aob
 coou2wiDlgahUxRyzawK1ULwrjsQBCZGA++5GQZprDo56smnEBDXUmpVTQ3VlVGczVo6BAyW7
 AdungMEHZgG9kupVGMaaBGUZJjgo26OAVV9O+ABNINkes+I3DjZ+Scdbnql+cABNO+IJVfHIW
 SyNuGs88DmnuFkw6G308xfRA7o7KJ7qm/jX57FIlGqRU6uo8yrUiPyK+om2EE4kVtJF2myr2x
 lgByaoZGmNV/UmOjBMHPqzOBJD1ni1T2B94stHXVocuBMKf+frmrSJhWCAb3E1dNh8kxjU56u
 hhedbcOMyhGxvhdLZUH/1HiOA5IeaMJforW+erkhI15kZyeLrw2CtVest4Ri9Q4WKhuRbUOip
 dEZFKhNU8+3sr7PYk5QVmhk5Fs5jMnNAdmGJHO9Cq9J3BEmaCgEO93u0/x5c6XNzzOHFwICps
 cadBKa3seUW7Dr9zr7BWGc1NTb666QkdUIIX3RU5BjLO+3BZyi++MDTssuta7P0OrivmDJtBJ
 1f7KLmuce4h9PDNKTudkzW2UMIukQQZbI2ZqOWgZVf9IlA3S33HMbUb70cVAXFyK0hYsuGuNn
 i1S2NUxHM6SiWMKR9UztRRAtdbexthsnqDlpdKY8GtZE6ECx8No5DLOJlOz+xoJwHBS683h69
 DK5pz9+TpmH1aldlLlgOagO7VgTqNuj9ML5t2CAc4foqUIrhg45/J17jsdqncNU07XGLdKq89
 emwronoVuqy3Sur0mhyVbFne7bU=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UzfBP321mlYNqKjL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 06:53:40PM +0000, Nick Terrell wrote:
> > On Oct 12, 2023, at 6:27 PM, J. Neusch=C3=A4fer <j.neuschaefer@gmx.net>=
 wrote:
[...]
> > In the meantime I've seen 8s for ZSTD vs. 2s for other algorithms, on
> > only mildly less ancient hardware (Hi3518A, another ARM9 SoC), so I
> > think the main culprit here was particularly bad luck in my choice of
> > test hardware.
> >=20
> > The inlining issues are a good point, noted for the next time I work on=
 this.
>=20
> I went out and bought a Raspberry Pi 4 to test on. I=E2=80=99ve done some=
 crude measurements
> and see that zstd kernel decompression is just slightly slower than gzip =
kernel
> decompression, and about 2x slower than lzo. In userspace decompression o=
f the same
> file (a manually compressed kernel image) I see that zstd decompression i=
s significantly
> faster than gzip. So it is definitely something about the preboot boot en=
vironment, or how
> the code is compiled for the preboot environment that is causing the issu=
e.
>=20
> My next step is to set up qemu on my Pi to try to get some perf measureme=
nts of the
> decompression. One thing I=E2=80=99ve really been struggling with, and wh=
at thwarted my last
> attempts at adding ARM zstd kernel decompression, was getting preboot log=
s printed.

Interesting, please keep me updated if you find something out :)

> I=E2=80=99ve figured out I need CONFIG_DEBUG_LL=3Dy, but I=E2=80=99ve yet=
 to actually get any logs.
> And I can=E2=80=99t figure out how to get it working in qemu. I haven=E2=
=80=99t tried qemu on an ARM
> host with kvm, but that=E2=80=99s the next thing I will try.
>=20
> Do you happen to have any advice about how to get preboot logs in qemu? I=
s it
> possible only on an ARM host, or would it also be possible on an x86-64 h=
ost?

I have a patch for that, although I've only used it on real hardware,
AFAIR:

  https://github.com/neuschaefer/linux/commit/f8542094e36652f2c086c76bf2058=
4330aa27711

Assuming, you use ARCH_MULTIPLATFORM, this should help, once you enable
CONFIG_EXPERT.


Thanks

--UzfBP321mlYNqKjL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmU7x3sACgkQCDBEmo7z
X9vBtQ//TtkfdWl+Ugzs+1IsrZIdpR5mkNMwvKvLuoMH0zi+kdnPNWCCo4rYENhH
nKZ+nT7kdVEpKoYMxEbXwcPinAuWOrqu4gE6UBzoi08PjEWC0jj/yvETtl2pxmyu
Hn/MsvovoxaGhIooMipfaL+1YvBIVvYbhWdL/yps4GXD+oWIZUgo8yF6GA3lxm9A
g5hlmFh0XMRyyiVQF67WedZs/WZ3FCw5w8S/G3A/flVzte9Rp4H2yxpR2HArWNR/
PI/5H1yPVj/S+adT/IfSs83aW7kFkHEeSRPPLN6LYzFAtSpMFw+VwGaraghuwDKZ
NLH9Dw1bdWi7nZrugouXsEWD8w8h5Y6aUMhXgMVHkPg/+U0v/Nda+yXqGw+O2xUT
DDKB2GOcBtobuOMZHpxr6+grNnUc8AItihWWwvZIBxPws3Gv6JB5CGA+khI6P+lD
g8wH92ubKIZ9BEy3meyuJZP7XbviIqAImor1O4v32ciiiSQLHChgT3zI6vB823Dl
QdgeLfUICUaX/Kt3ZUCya46OXklE4LhidqnjFh5BssyKI3NdleyEJXYyWioa49NB
o2hlyDnVL+mJpJ4IHPn7V93ANJSrUudtjnSwYJZcd98IjqN6+uPMAHrSQVsZvuvs
PV66P3aYknuHAWUF7QccZdCiXfPzhTl9e0zjoZTOYmvj3UnzQHk=
=P+g3
-----END PGP SIGNATURE-----

--UzfBP321mlYNqKjL--
