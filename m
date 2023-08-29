Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701A678BD5E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 05:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjH2DwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 23:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbjH2DwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 23:52:03 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA67132;
        Mon, 28 Aug 2023 20:51:54 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.49.30]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MRTIx-1qMDBS04gP-00NUY1; Tue, 29 Aug 2023 05:51:27 +0200
Received: from localhost.fjasle.eu (kirkenes.fjasle.eu [10.10.0.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id BE4B43C0F5;
        Tue, 29 Aug 2023 05:51:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1693281084; bh=aDL9HAM2sY2iMlgs0LvUQQjOl/HdCHVkwSz+OFmsNZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G89ePoH9vwDJ/cyB5WppWSbbBrIQSfXpj9sd142Z0UGUsEK1k0tgMzF41+z/PxWi9
         CoA0hpm+uhUX+zAaicd909qEfzk39oHzO/jy3zz1uIlpR7vYIV+z5oqTqE6MqnXrb/
         mVl9TVxdHcGcING4UUAEID9TKrVbswgi0qa/ErZI=
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 874DD3949; Tue, 29 Aug 2023 05:50:52 +0200 (CEST)
Date:   Tue, 29 Aug 2023 05:50:52 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 6/8] kbuild: move more module installation code to
 scripts/Makefile.modinst
Message-ID: <ZO1rHGjch2s1Mitt@bergen.fjasle.eu>
References: <20230823115048.823011-1-masahiroy@kernel.org>
 <20230823115048.823011-6-masahiroy@kernel.org>
 <ZOyuY5XCfYEV8fW6@bergen.fjasle.eu>
 <CAK7LNAQ=5x+zOApY95Oqen0tyfVthb7QYjeskgQmUqGBDtSoiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wwZrl/+BtuNphl97"
Content-Disposition: inline
In-Reply-To: <CAK7LNAQ=5x+zOApY95Oqen0tyfVthb7QYjeskgQmUqGBDtSoiw@mail.gmail.com>
X-Operating-System: Debian GNU/Linux trixie/sid
Jabber-ID: nicolas@jabber.no
X-Provags-ID: V03:K1:kUyL768zMIZah30K60/PGjuiOVV5cBVhPoqO6IraiYSku2krGP9
 zcQjB0FYiuP7yVVhkLH8p0aOdVOTB0pKww5DeYYAUIOcyMbStha6Lq2hcGemoemXDsI3Rgg
 rTMFCCELuBVOdkJmpktsn2N3N8SGD25O2UAc6d5sG754RqoaHgLdpKJN/f7rScOvlRuTRSG
 NHE6RX4jakI440WUb7TCQ==
UI-OutboundReport: notjunk:1;M01:P0:MoGCE3M4v9Q=;iZIVKuy2KeX8mjFN0MVuvKNYN1A
 e9J7fK/wDqeRjYAFFWdWT53dij1JWe6RVkxAL1qDQ8F/InoN0nC8G0FdNC+8U5cUVhOuHlJvS
 qp8/0j7rR6+n+VMeeM7vkb3SEVa/6dazBoQj7T6DHY7VplM88In5RmdYD84xZPdYhVmQZQDKl
 JQjFaDp5+E8pkctktecjXjE77itSi/0d24lEvNVSR+9w1lUoug7bI8lD1m6M5aqwcpGqgSh+h
 W/Goe+y1XzH77NIRgHymMLqA+cjGvC5ZkGZmFNAkCOFf14NXEYBvp0VYbfHBS/51oUyy1h2/A
 D7/oV9lt6CjJOS0KodsWhnBTFVWGgzwwTus+BtiWqL9vT09eeKRS20VJOv6lSQKyibEmREg7O
 gRbTTDedyiIFDGSQsGMLk+qPS6P4iBzhpsSE1Pi+PvmN9ML7BfUiE5+IidHtyXn/vywpcC1QK
 dFYx3OalCztq/jqjFfRSQRVcbXw0WDC6a/u4w7mekXgs5H8e1Ek2U6a1ilFLVeI/w0EezcdPH
 lU2yPHegn0jbFaRXK4aCrwYcJE+mOfli3glnxpn19L8gmq5JYeXws4z2No1C2DtaDnkCt/Y8H
 gXSkPVNQCcM3jWJleZFjyZ5LnpHB9D+PJPv8ANjOlq5cKhWEHvYuj6QZYz5C/tobJn7JweaNv
 mXjZflAmLysq37iWumyMEuUstOnmhslZrQw2oA6t19a1NfOd4QU9O7Loi6C59OWhFrFK7JEK0
 LEnnrfK9i76Lvmdcsk4JLYy2DyNQ3rpBx1NUzaeKwzD27g22985PTldJFufL2ZJ7bLQvH8Tp/
 ftRWGaTJs2tWjzPzE9mdlVl5ZDo/PbfIn8xTOEEIs6Ldhbyxpn+r6BNDPMSt3BFLWjKY6qKtp
 VY2QMjlGM3CTo0g==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wwZrl/+BtuNphl97
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 29 Aug 2023 11:35:41 GMT, Masahiro Yamada wrote:
> On Tue, Aug 29, 2023 at 11:15=E2=80=AFAM Nicolas Schier <nicolas@fjasle.e=
u> wrote:
> >
> > On Wed 23 Aug 2023 20:50:46 GMT, Masahiro Yamada wrote:
> > > Move more relevant code to scripts/Makefile.modinst.
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > ---
> > >
> > >  Makefile                 | 34 +++++++--------------------------
> > >  scripts/Makefile.modinst | 41 +++++++++++++++++++++++++++++++++++++-=
--
> > >  2 files changed, 45 insertions(+), 30 deletions(-)
> > >
> > > diff --git a/Makefile b/Makefile
> > > index 7d9cab3d2186..82d22debf6c9 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -1477,24 +1477,6 @@ endif
> > >
> > >  endif # CONFIG_MODULES
> > >
> > > -modinst_pre :=3D
> > > -ifneq ($(filter modules_install,$(MAKECMDGOALS)),)
> > > -modinst_pre :=3D __modinst_pre
> > > -endif
> > > -
> > > -modules_install: $(modinst_pre)
> > > -PHONY +=3D __modinst_pre
> > > -__modinst_pre:
> > > -     @rm -rf $(MODLIB)/kernel
> > > -     @rm -f $(MODLIB)/build
> > > -     @mkdir -p $(MODLIB)
> > > -ifdef CONFIG_MODULES
> > > -     @ln -s $(CURDIR) $(MODLIB)/build
> > > -     @sed 's:^\(.*\)\.o$$:kernel/\1.ko:' modules.order > $(MODLIB)/m=
odules.order
> > > -endif
> > > -     @cp -f modules.builtin $(MODLIB)/
> > > -     @cp -f $(objtree)/modules.builtin.modinfo $(MODLIB)/
> > > -
> > >  ###
> > >  # Cleaning is done on three levels.
> > >  # make clean     Delete most generated files
> > > @@ -1836,12 +1818,15 @@ help:
> > >       @echo  '  clean           - remove generated files in module di=
rectory only'
> > >       @echo  ''
> > >
> > > +ifndef CONFIG_MODULES
> > > +modules modules_install: __external_modules_error
> > >  __external_modules_error:
> > >       @echo >&2 '***'
> > >       @echo >&2 '*** The present kernel disabled CONFIG_MODULES.'
> > >       @echo >&2 '*** You cannot build or install external modules.'
> > >       @echo >&2 '***'
> > >       @false
> > > +endif
> > >
> > >  endif # KBUILD_EXTMOD
> > >
> > > @@ -1850,6 +1835,9 @@ endif # KBUILD_EXTMOD
> > >
> > >  PHONY +=3D modules modules_install modules_prepare
> > >
> > > +modules_install:
> > > +     $(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modinst
> >
> > I was a bit surprised to see 'modules_install' being allowed
> > unconditionally for in-tree usage (thus, even if CONFIG_MODULES=3Dn), b=
ut
> > then realised that this is the same behaviour as we had before.  Out of
> > curiosity:  _why_ do we need to install
> > $(MODLIB)/modules.builtin{,.modinfo} also for configs w/
> > CONFIG_MODULES=3Dn?
>=20
>=20
> I see your tags in commit
> 8ae071fc216a25f4f797f33c56857f4dd6b4408e    :)
>=20
>=20
> Some drivers need to load firmware.
>=20
> To make such drivers working in initrd,
> mkinitramfs needs to copy necessary firmware files
> into the initrd.
> So, the tool needs to know which drivers are enabled.
>=20
> That is my understanding why modules.builtin(.modinfo)
> is needed even with CONFIG_MODULES=3Dn.

Ups, yes.  Thanks for the reminder!

Kind regards,
Nicolas

--wwZrl/+BtuNphl97
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmTtaxwACgkQB1IKcBYm
EmmGrhAAkAd/c/EkLRCmzQvltyOtcfAgunO0e91JRhOia0rAiOFBCZlN2Sv21qhu
ZM16RvvBdXK4Tvy0F9kwaC+nKfFFE4P0iMqigASR6L65+zoEWWJ/LITPK+mU9ehl
EZ4rrBv95mqch5mTuZEsg90z9h0rZgy6u6QGriyyH1umkUlpJr/LXP3d1tajraIw
ZKET6xfNElrQpq2W252Cn5PuvoI5tozcxirBuAU6rOC2ig2wiqtG754Nw6NC+4xj
y7hcPbs3JKnym7jCZFLBNUAPrgExMRPRBGb54+LgVst93WHzA4+9ADmShp5Jboou
NqNgRMfYmdA9ZHxX0QyCcpDPjbKD+jzGrtNaUb5/J1XdpYYsHZvWoLPzT7JJogct
odf7YQElIbbm9lX75hD+t2ZpzXADi6kn1et2YhyoMaGYFvMRpLHgqSLUMGsARkcQ
y5fBbdw+Jz/d4A7S8nk0LROnoR4TfV79gjmSl2av8ftUwDRl+W0r7T2kyJHA+oHG
mVvQc2EwiowW/Pb4EaO4w6KkgPRhh7COXmkWaZUXr1e+7Gci4DWUIo3GijeFOmkV
CNI7+OL6FPJ7zTZyifmJlnLd4qqfyL5C4HOlKnG27XxO23DQu5nETcyc0MkpJmLL
bZcjO9gaX1tdrkmsJzZv1dd0WWzmLCUAh4jcxlHd6uXkGLVkBM8=
=poPv
-----END PGP SIGNATURE-----

--wwZrl/+BtuNphl97--
