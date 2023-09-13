Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFFA79F2F6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 22:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjIMUex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 16:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjIMUew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 16:34:52 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A8C1BCC;
        Wed, 13 Sep 2023 13:34:47 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.99.40]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MxV4T-1reNP838Bd-00xsvc; Wed, 13 Sep 2023 22:34:03 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id B10AD3E92A; Wed, 13 Sep 2023 22:34:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1694637242; bh=FHAimLrZHHhF8N3CgKs14v93vknjgjW6r5VMGiBKQDI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LbRZAR9kjYJe9nfyWG3dyToRiphnpjx5s7w9vZ/whCu2VqWXtbPjgnQVa8XO4zHwv
         u96SLZ4CJZmy0AOg+vCjjOZEt9r+aSKhhasw0eeX7amyLVTPtuOCBE+EmHN6waH8eP
         LhmtkQwZTrVeyIpYKhbjsMWH8vWw5/aqyU0qBMdI=
Date:   Wed, 13 Sep 2023 22:34:01 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: kbuild: explain handling optional
 dependencies
Message-ID: <ZQIcuVgaDmA+VdV0@fjasle.eu>
References: <20230913113801.1901152-1-arnd@kernel.org>
 <ZQISGujwlH00B8KJ@fjasle.eu>
 <b234530c-88fe-4a2a-993c-f1733fe4d0c1@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ezqQzNRmwLErRa0+"
Content-Disposition: inline
In-Reply-To: <b234530c-88fe-4a2a-993c-f1733fe4d0c1@app.fastmail.com>
X-Provags-ID: V03:K1:j9GB8B2tR4Q6PQoLV76ATtVYxSr2KY/fdMjUyxiRCGWzFqEFuE1
 9CIchkO+T3CyJZFS1/G+mQAgIJXJJbbaODbryLuOyCWtctBf7ScQ0PgmEYZMwTCOp7AIZMW
 5J3ELoh9ZzWSUjc9iVgUyHJwnDQaNk4UiLZBAVAhfiDhUSIiGzHGWD/31BFO6WP2aNz47mL
 bZifS72wCzmlOwo8RcGlw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dT5CMpyfMSQ=;Yp5OtP6hXheT5kTFOkbZ+fJQj4x
 tGqcsWGFfHvfb4PrUZ+cMmkgZVXCYpio64YtLgsFQbhdFtGOtfX7TT6bVrMCsyV6nrAkCcdm3
 8s2hQq0BYSGPFsBztu0dfEDw9agA/wSdsmVMjPzf1rWeEe+W12puUUc1OkF9CDwqQb9kzS8JB
 vB3LW8/lYyeY7cJ3hm42BDBnCgGX+X40Jupt+slwvELmk8tznQyKU1y5R21K+ylG0bxi4ry+o
 iGuSUcJ0IrzrmACoxbKEi/whOYSMKDfS2JTJcH7ogZPU6EZkzbTJUE5ti8bEt9Z1ApFd86NWz
 XSQNasj/gAFDYi0jgK7Y4H0rw5IOF95ub0JI52uiC/BzHq35Jt0qc4i+fq3W56kfBuPJYjAkr
 NirNik2rEScNPzdLMpuElpfTtCN5h4Q1rR3inE811+DBoCSBK8cBnUgaWY9Qvv52jZZhGYuNW
 U7xzXOlWZTY7PZbqdt4C9s+t7CeoZHDEpMOduRsFiqVjKiz3olsTasqolhxeWuU1g42N8K3Ea
 vTFyeGoeG7aNycW/q7tFHIP+IAdUxzP4X4I2t39cB6uCg/ROENyLVSWSmi5tXK4IgtOOKtHu9
 ffZ2sQ2EK20hVqAPYoCNrPf5k9i/YdYehaLqk414pfk5xsD6Mg3iVZ0WK4A+d/P382zhe755a
 ZG5pTAqZMnz4G14otAb9/o2Ak4+XfuNipzufTPB+bC7uT8T0X9emOKKn1F1UfsekqX0uxhyk2
 gvzFM/wRGF2WRit6exoTfGXULQyXdbyvmHEOYouWCpa94IkKagTtpXuqkHceLSR7j/wPDVQNi
 NhxE8ClHUMAvGWgIa9XMmVhEbnJerh4MkMyQzUh1+W3BMR6fRPlBE8Vs9C0JAgrZNQMsmWsGZ
 sd7n28EYiPILT2A==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ezqQzNRmwLErRa0+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 09:55:36PM +0200 Arnd Bergmann wrote:
> On Wed, Sep 13, 2023, at 21:48, Nicolas Schier wrote:
> > On Wed, Sep 13, 2023 at 01:37:52PM +0200 Arnd Bergmann wrote:
> >
> >>  Documentation/kbuild/kconfig-language.rst | 26 +++++++++++++++++++++++
> >>  1 file changed, 26 insertions(+)
> >>=20
> >> diff --git a/Documentation/kbuild/kconfig-language.rst b/Documentation=
/kbuild/kconfig-language.rst
> >> index 858ed5d80defe..89dea587a469a 100644
> >> --- a/Documentation/kbuild/kconfig-language.rst
> >> +++ b/Documentation/kbuild/kconfig-language.rst
> >> @@ -573,6 +573,32 @@ above, leading to:
> >>  	bool "Support for foo hardware"
> >>  	depends on ARCH_FOO_VENDOR || COMPILE_TEST
> >> =20
> >> +Optional dependencies
> >> +~~~~~~~~~~~~~~~~~~~~~
> >> +
> >> +Some drivers are able to optionally use a feature from another module
> >> +or build cleanly with that module disabled, but cause a link failure
> >> +when trying to use that loadable module from a built-in driver.
> >> +
> >> +The most common way to express this optional dependency in Kconfig lo=
gic
> >> +uses the slighly counterintuitive
> >
> > slighly -> slightly
>=20
> Fixed, thanks
>=20
> > For better RST compliance: could you explicitly start the code block e.=
g. by
> > appending '::' as in "... counterintuitive::"?
>=20
> Ok, done.
>=20
> >> +
> >> +  config FOO
> >> +	bool "Support for foo hardware"
> >> +	depends on BAR || !BAR
> >
> > are you sure that this is enough?  While testing, I needed to explicitl=
y use
> > =3Dy|=3Dn:
> >
> >     depends on BAR=3Dy || BAR=3Dn
> >
> > to prevent FOO to be selectable iff BAR=3Dm.
>=20
> I see my problem, I made a different mistake here. Your version
> is correct for a 'bool' symbol as I had here, but the intention
> of this was to make it work for tristate symbols, which are the
> interesting case. I've fixed it up this way now, hope it now makes
> sense to you:
>=20
> --- a/Documentation/kbuild/kconfig-language.rst
> +++ b/Documentation/kbuild/kconfig-language.rst
> @@ -581,19 +581,19 @@ or build cleanly with that module disabled, but cau=
se a link failure
>  when trying to use that loadable module from a built-in driver.
> =20
>  The most common way to express this optional dependency in Kconfig logic
> -uses the slighly counterintuitive
> +uses the slightly counterintuitive::
> =20
>    config FOO
> -       bool "Support for foo hardware"
> +       tristate "Support for foo hardware"
>         depends on BAR || !BAR

ah, thanks, tristate kconfig symbols are really more interesting.  But I am
still not sure, whether this works as proposed:

With the 'config FOO' above and

  config BAR
  	tristate "Support for bar feature"

kconfig allows me to choose between these:

BAR=3Dy  =3D> FOO=3D{N/m/y}
BAR=3Dm  =3D> FOO=3D{N/m}
BAR=3Dn  =3D> FOO=3D{N/m/y}

But with

  config FOO
  	tristate "Support for foo hardware"
  	depends on !BAR=3Dm

I can choose between:

BAR=3Dy  =3D> FOO=3D{N/m/y}
BAR=3Dm  =3D> FOO is not selectable
BAR=3Dn  =3D> FOO=3D{N/m/y}

(Re-checked with BAR=3DIPV6 and FOO=3DWIREGUARD; CONFIG_WIREGUARD as 'depen=
ds on
IPV6 || !IPV6' in its kconfig definition, and both are tristate kconfig
symbols.)

Thus, it seems to me, that the intuitive way is the way forward (and several
Kconfigs are out-of-date with regard to 'depends on !X=3Dm'.  Or do I still=
 miss
your point?

Kind regards,
Nicolas



>  This means that there is either a dependency on BAR that disallows
>  the combination of FOO=3Dy with BAR=3Dm, or BAR is completely disabled.
>  For a more formalized approach if there are multiple drivers that have
> -the same dependency, a helper symbol can be used, like
> +the same dependency, a helper symbol can be used, like::
> =20
>    config FOO
> -       bool "Support for foo hardware"
> +       tristate "Support for foo hardware"
>         depends on BAR_OPTIONAL
> =20
>    config BAR_OPTIONAL
>=20
> >> +This means that there is either a dependency on BAR that disallows
> >> +the combination of FOO=3Dy with BAR=3Dm, or BAR is completely disable=
d.
> >
> > For me, this sentence is hard to parse (but I am not a native speaker);=
 what
> > about something like this:
> >
> > This means that FOO can only be enabled, iff BAR is either built-in or
> > completely disabled.  If BAR is built as a module, FOO cannot be enable=
d.
>=20
> That would describe the version you suggested, but that's a
> different issue. Let me know if you still think it needs
> clarification after fixing the example.
>=20
>       Arnd

--ezqQzNRmwLErRa0+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmUCHLgACgkQB1IKcBYm
Emm6+xAApymEDDCvENlFvxMQcBo2GI1/j6oVgzZ5TPFA81a4Xq8zOv18mvyqd4DS
ywuq9vex449OaAcREnDSyQNgfBzrvax/MkcGlewGEjvDaY6wsQ7yQK4VlqwbrTRY
w6gvDRhfvFtv6KXo3g9T2kEJkpfGweKTrnmKRDoz94yZqoyFvWpD1hJuD6mBcx05
b7Y1DWcekIFxF9JxrctQQ3cxE4361G9mmRcwdjVox4jypsUXwqteDj5Fs0Ubh0FR
mi18xOKZ416w0nZOudwNGQV39Lgkcryr/y74PxJuKOI0pxze75ytG9S41UqauWBn
Kex+MT/p6C205IBJv3SVssxhHwycfl/gwwGxaKPaEXVKVvXFNT2OiOulP2ov4AiZ
j7ZuKbE1iCvU1Fh1QE19pWdDrSZrl+u/OOwtaqiytwrqLg2l4zxUEwrWQTZy9nBq
o4mlU47MPYviZnj4/ottshFt52CgA/m4WIK8WlelNxHS8JQr6/R5Ibzv89GapSDC
nm8Y1u+3uFJ3FxoxTqb2e92LpSPMZYBYhi/ZhqO1dZCX4VRN2a1pECU5eHlEHso7
7cY1v7NDoGbTIw5EAcUrxNpNvpCOnyiVxLVhLGKP/6aTTZJqRuObKeLHe4fcuRc7
hp7GH9P5SKt6vmWxMqcx/YeHurNeragRt8WseKJuEWybT5ncNAM=
=NdDD
-----END PGP SIGNATURE-----

--ezqQzNRmwLErRa0+--
