Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77607C7B25
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 03:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjJMB3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 21:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJMB3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 21:29:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520BFC0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 18:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
 t=1697160438; x=1697765238; i=j.neuschaefer@gmx.net;
 bh=gUcj4o3vZJtlsdBOOUSYAbsfV3wmexs253dZxkkdyz0=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=o6Vsy+Hk60DmVPETPcBV7FnavasCbTzKLNTvorVvvzNH6cSPgMRxOZTN1/EnLl1fhlzKe1HtKPA
 3E6LJ3B5/WlIsslRnMndZ9VmVH752JoA4jnE+FJGSfm7n0OVW9KxQXZeqgYvvZhVR/wBtET5dPWbO
 la8GLanZAi1jL+iAak+M1MYXDPCwQuN1c+k24Ew5TnjbQSTnDmWEVF6JuegmLFdsf0Kz7noaYubS2
 Yttda6hF6p+hbb556e6uFBtayUqO0cXMyzjvTePGDJh580avdbr5GiJXTPRcm+HAxT0E+HCUxohNV
 EmiYFkFka54z090YhseuAZp84AvwPTp7YiDA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([89.0.46.56]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mel3t-1rRXhj1JTx-00aoUP; Fri, 13
 Oct 2023 03:27:18 +0200
Date:   Fri, 13 Oct 2023 03:27:12 +0200
From:   =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Nick Terrell <terrelln@meta.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
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
Message-ID: <ZSic8JsHGIlfuwhp@probook>
References: <20230412212126.3966502-1-j.neuschaefer@gmx.net>
 <9ae523ae-aad4-40b1-8b6b-d5e18bf8b92a@app.fastmail.com>
 <ecf9f34c-1f1f-47af-a470-0a6ae7773724@app.fastmail.com>
 <ZDoFQUYMZykLdTbX@probook>
 <1C6CE84E-557D-4436-BF13-E7275DE390A8@meta.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fENszzjOS5ioC/Ql"
Content-Disposition: inline
In-Reply-To: <1C6CE84E-557D-4436-BF13-E7275DE390A8@meta.com>
X-Provags-ID: V03:K1:VbbLOmjrmNi9GI7tUctipLRq/2ARR8Oz+xZsEasu+RCJSDNTC/M
 a44rvD0OV/HaZnp1OxL+SvjNMDYr6pRTKEz2boxkfi6N+cMZnind21vsmLT10w9uFBAvYpU
 dlpK2tAevwTQAkzEd7MUQQacM8J9y0mWGrGKL/7isQ5wuswd9CAhB8aeJdHGX3NQ8iEp287
 EnrxJJldd5NDVaq/pUC+g==
UI-OutboundReport: notjunk:1;M01:P0:lzRpfQE84TE=;N2NwbQNx6E62zk4ZUvyX8sC3vEz
 Lu08KYv28n2VYNWqtwZ02W9cNmRl75Ijt2Gl/tuCUQxlxwXMl5NvXW8UrwifyaG1vTS2XDabF
 uVYjVN4Ou3OLln//6voi0PHCtpFV4uscmXEMwnDERBAhj7OXAYUT8x7GBiCSfdAE4GgNNE2fq
 pPBFe4vnmYoOJoaEWNiHByYSKQlBdsTTvE8lJwzXr3LW0KvuSFBjN63iE1Z7nct8cTaxlnBhS
 Gt8WdNJ23NPYOXGog8tUozUHqf9g2vpMiWxGWTh1eRi7mmxPSTyvC1SGITBseheKcSSilBGiH
 dT1VZsIlxjEDHBcSA/fWjlTuF0vogWasgDrKivkVe0dqXVmnsQ8PGmpFOcp/W/HcT4tWWn0zz
 8HSUGbEFMrvj/+UQ4BQFSGWsKkkMU0z3B8s0HjhinboXW0BCQbbGsCmdnU+5bLyvz615HAdp7
 6BPMDemjgt8TQh5yJfu5wpcmKtaO4n1QZH5RblEoKI/QOiZipLp2jnYcG1HX86vx5CWMiG8MW
 9BsSRjBtsZOuUH1x0jJIWIFryPzyVONklko+kAymoUQuYDaGiIcoNi2AmV2cr5TO5rMeXJ7ai
 Nl1c88EH88bTsBG3lkBAENNIg9Iy8NK/hr+6au0geXbPHAhO5FHXmap3FOUDqS32+6JysnrZm
 cH7Gqy2vSzinsVgTQmqoN8hQTBn953U/3sajj2pSwWGduGd8imlbeXbGflXep1eKh3mYZh1GX
 cDVg0HcNs8KyNU12loH/uHkEttKNy8lMq+ijP4RLiyWdbZAoUdC0EODBnUiWCR/bLJGbiq8+V
 7FGJzsO0nw1qlYSxvkz/i6AMPaEa2UMB7i1RLp4JM+bm1EeeU5WmEhT7DJTRM4hMoMHcWFUbO
 5WAO+V/h0nHApFqv7/o8LCTWk3pKrt7MN6DSbk3JuweKvMVc0ZQaBUfulnieC7eJvds1BO14V
 P4rZyUWvUflc6RkLH/YXMOMCvzE=
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fENszzjOS5ioC/Ql
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 10:33:23PM +0000, Nick Terrell wrote:
> > On Apr 14, 2023, at 10:00 PM, Jonathan Neusch=C3=A4fer <j.neuschaefer@g=
mx.net> wrote:
> > On Thu, Apr 13, 2023 at 01:13:21PM +0200, Arnd Bergmann wrote:
> >> On Wed, Apr 12, 2023, at 23:33, Arnd Bergmann wrote:
> >>> On Wed, Apr 12, 2023, at 23:21, Jonathan Neusch=C3=A4fer wrote:
> >>>> This patchset enables ZSTD kernel (de)compression on 32-bit ARM.
> >>>> Unfortunately, it is much slower than I hoped (tested on ARM926EJ-S):
> >>>>=20
> >>>> - LZO:  7.2 MiB,  6 seconds
> >>>> - ZSTD: 5.6 MiB, 60 seconds
[...]
> > For ZSTD as used in kernel decompression (the zstd22 configuration), the
> > window is even bigger, 128 MiB. (AFAIU)
>=20
> Sorry, I=E2=80=99m a bit late to the party, I wasn=E2=80=99t getting LKML=
 email for some time...
>=20
> But this is totally configurable. You can switch compression configuratio=
ns
> at any time. If you believe that the window size is the issue causing spe=
ed
> regressions, you could use a zstd compression to use a e.g. 256KB window
> size like this:
>=20
>   zstd -19 --zstd=3Dwlog=3D18
>=20
> This will keep the same algorithm search strength, but limit the decoder =
memory
> usage.

Noted.

> I will also try to get this patchset working on my machine, and try to de=
bug.
> The 10x slower speed difference is not expected, and we see much better s=
peed
> in userspace ARM. I suspect it has something to do with the preboot envir=
onment.
> E.g. when implementing x86-64 zstd kernel decompression, I noticed that
> memcpy(dst, src, 16) wasn=E2=80=99t getting inlined properly, causing a m=
assive performance
> penalty.

In the meantime I've seen 8s for ZSTD vs. 2s for other algorithms, on
only mildly less ancient hardware (Hi3518A, another ARM9 SoC), so I
think the main culprit here was particularly bad luck in my choice of
test hardware.

The inlining issues are a good point, noted for the next time I work on thi=
s.


Thanks,
Jonathan

--fENszzjOS5ioC/Ql
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmUonMcACgkQCDBEmo7z
X9syGw//RZKYodw74qps/FZ90yB7fCKqlVjVk2cU9HGlAYs6kVFd6uHdo2ZprpPw
9BiCbMLZG8N7Kod9BwK5rHziutvQjYoNLHP2S6lxJMp916EVPZrD+UylJL0KJuIv
fV3hCuT/P6jWi5VaSrgtNRKYjF2SKDZrLMTx/2KJ5r15NSV1vyvCYxR9swB5ChgQ
QLL1JLNq0B7NRDwD+po+MCNZFXnM+UUpuCQOqbbTsYgiKCw3i8fvwENuT3yDWWJn
0/ggRsoVygh1he7itKmmJyvY7W53fgAdUK6/LQnmBR+cCrMR96qUs4dk2atCTgcT
vJ7Z7tIdNjK+Q5pmVy8eUATOA1cQ4B+XTmwup7hqSyDgI/V1MukSwSInhYmfoJqV
NbwWOk7qW611t/jxOhnBMSQro2NMQkxxakyKZGo+2h3dRNqZVVogRTh3p0NgFRPY
T1Mb67Ukt5UxInTCKEFCyyzDG/S31vhm3zm4dI/SC8RDNcwV3q8ImYB+7eDW987I
lLHDFMsxA1xOpBHyffU/8fbG4JajJmv0ZfpCLhfBuz6M8bLu+1lfJuWrXc1svB/R
4+JmlUCCRBUFoJXAg9dQgNdNEPEkgISkORSIHKe1YZeb12T1Ix/jKzcPDwg9jqJZ
YQW9oejOx/aQqbCUq0wXcQb9rGgXzYbMlCT99DfMQvkA/ckT2gY=
=KS0y
-----END PGP SIGNATURE-----

--fENszzjOS5ioC/Ql--
