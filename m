Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0D379F25D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 21:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbjIMTuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 15:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjIMTuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 15:50:07 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61B3B7;
        Wed, 13 Sep 2023 12:50:01 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.99.40]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N4yuK-1rhSFF1ufU-010y5j; Wed, 13 Sep 2023 21:48:45 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 96B483E928; Wed, 13 Sep 2023 21:48:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1694634522; bh=dNCzMB7kZKbtu0SVV6D5vezQPGOeLJzdXPIlY9nn0HY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=geeh/i7seOFMHSGVnQ+Sj/uRyKKjwcvJl5CNhOXyrSrFDp6gwJvkdktKjxdM1rF6b
         X7smwIJYI2wKSqnwC9zKw/vql8yLkMlXw1WEr6FhD3NTpbxsrtPqt7orN/y5DktjwA
         3AEXv8Dw7URUCG3krehbxcFdeomCZq3ShPrvM4jQ=
Date:   Wed, 13 Sep 2023 21:48:42 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: kbuild: explain handling optional
 dependencies
Message-ID: <ZQISGujwlH00B8KJ@fjasle.eu>
References: <20230913113801.1901152-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qj5NqfuKdfJbnsCm"
Content-Disposition: inline
In-Reply-To: <20230913113801.1901152-1-arnd@kernel.org>
X-Provags-ID: V03:K1:iov+urfCVmemenuqZraQFTvmuNIwec5MwwsVygNgb5VgPZRcRFa
 QM7bFZWPE2qmRpIDd0eXsnnlb0iTv65I3DihInST+a7rHu/LeYuiHMMEwa0F8tszNYw4nP2
 ZO8hNBGZ/ApwY2MFMNkWF3pWdG0/SEZvHWo2PjPA5F7uQETqlzVhEuLTMB9MZmWXvRUk0nZ
 1+aq6jXzluTS8bI2UHYfA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CgZAQY0OLjY=;Fux1I7niPh29pTUhtkaavJ0GIgG
 1ZW4aV3JsJVWnnhLwRAeoPRf0iV8ppt8mqVghSTfBi+CB0zKLHEb1jfMSgEySlzkjRmCLQjaz
 bGCy1mls/cUX2U7q7+tPxUhJNhSM18BVXhSqoyEy2ndim2Z3MZ1voCGJVMjDjCAn8IJO7D+IJ
 SkdJIMTJRD4mzRAlrEF6ELnn2b77lFISbroBuPWjflMDLUbk/wHEaMcyzESOC8MF+/p5zr2j2
 KqJcozzCNqYGhCxL1AJ5ueT0a6x0wET9kxU1z3WbLCR9J4ogoSdXVvFSvAHUwZLHLqXleCfMR
 RCSVkR1I9kt44BWTU5nl9Zq0uJMRJ+7gxn3+d9Nn/xtR1delOlpdAuF277Hn0kI7B9rDEixVi
 uUkg8C3ChBNnX7CgIe7xgkDQjPDDQ+0kF4I/xKgKBFC9C2+tfPjha1ePzXWh7axftF6XWOsa/
 hS+a/taZnDdp+83ue0nMOA3BGJUw/IFdquZevOXIiz8UJXwxDN+EUUqIdSt/SxZOPnFI3qSpe
 wWS+8hiEAyq4dSMqR8diz2pqmPqTi87m/mxxafXM+C5ZZzTfbfhES/5WnJ5dcNE1hL6elPAGG
 qDgnPIgIQUK1s/UXEBhhC9xuC4YLijg7UIMJILzQnilLODThDEuJ/7MHnItTJeL0U6lmTVmRH
 p+eAzwAoAy4rzr2ruE6/n7gaalR0/dWF5gAqdu5gVrzbnypB8GobaJgdy89FCQkjp3txggNP6
 zD78D9wcdShhomR6V5qtKCwnpVTKbjbTdwmquL3gn2GbHxao/ui/waNDHlDqDks4qIvEUs4Al
 9ElJI9WOLEHdsKv4v3fKluIRIlVhOGO5pd5m54eM93PWxRCatw/G5fPkmAHERb7neOWPWTRnj
 4iY0Iv74ZqrC+iA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qj5NqfuKdfJbnsCm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 01:37:52PM +0200 Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> This problem frequently comes up in randconfig testing, with
> drivers failing to link because of a dependency on an optional
> feature.
>=20
> The Kconfig language for this is very confusing, so try to
> document it in "Kconfig hints" section.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Hi Arnd,

thanks for documenting this!  Three questions below:

>  Documentation/kbuild/kconfig-language.rst | 26 +++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/Documentation/kbuild/kconfig-language.rst b/Documentation/kb=
uild/kconfig-language.rst
> index 858ed5d80defe..89dea587a469a 100644
> --- a/Documentation/kbuild/kconfig-language.rst
> +++ b/Documentation/kbuild/kconfig-language.rst
> @@ -573,6 +573,32 @@ above, leading to:
>  	bool "Support for foo hardware"
>  	depends on ARCH_FOO_VENDOR || COMPILE_TEST
> =20
> +Optional dependencies
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +Some drivers are able to optionally use a feature from another module
> +or build cleanly with that module disabled, but cause a link failure
> +when trying to use that loadable module from a built-in driver.
> +
> +The most common way to express this optional dependency in Kconfig logic
> +uses the slighly counterintuitive

slighly -> slightly

For better RST compliance: could you explicitly start the code block e.g. by
appending '::' as in "... counterintuitive::"?

> +
> +  config FOO
> +	bool "Support for foo hardware"
> +	depends on BAR || !BAR

are you sure that this is enough?  While testing, I needed to explicitly use
=3Dy|=3Dn:

    depends on BAR=3Dy || BAR=3Dn

to prevent FOO to be selectable iff BAR=3Dm.

> +
> +This means that there is either a dependency on BAR that disallows
> +the combination of FOO=3Dy with BAR=3Dm, or BAR is completely disabled.

For me, this sentence is hard to parse (but I am not a native speaker); what
about something like this:

This means that FOO can only be enabled, iff BAR is either built-in or
completely disabled.  If BAR is built as a module, FOO cannot be enabled.

Kind regards,
Nicolas

--qj5NqfuKdfJbnsCm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmUCEhkACgkQB1IKcBYm
EmmgJA/+Juye9CK9p1ddXxiVaMgnc0h6bNPW2duYWRcI3EvdQmVnb6RO0Obvf62D
fp/lSkg4z6DIGnW3/LKEcx/3AAi6bjSF/TLgrURxUY6gHnRwgkj0NWR067iAXLkJ
vXlzAOk6eNLk6NvewHxeLtsBK32lInNbHfg3hw3GpP20DY9HFevVVe/painn/a9r
9TM9XVjwdxMsWLgTvc5s7JicyDMk/PdW2ByZVFINZ7Q/86E9z1eeS5SvUszxsgX5
gZp2C8nKx90/nuT4Sif9EOMvqjRZvtXuQew8TYVh195J0Fry+zPMjcOyKOSv8Fub
SRKsPg8hheICkmD3tHFxprKbRash+TgUGEo1+Vzi1p/NhASH5kzLGxKadvy+54Z/
DJWPlMr6ZSj9vUJngeyqFxvwTVnts2i9oJpRpkQs9qcpmxyg84k5IDlCZxTAnNmp
1wmAtNH/F2LfQaybnFHshNDDgK+0b6Vz6cSyj2V3godwdsB4Ecq7wqpbKdE6ioeH
x78t0sWS7eeYcZmduJKxbspuAJ2KwUFZZjMPPwaFXvwNeetM8BsDwZ9Dqyv5owZI
DTCagFieqmdvIg+jy8KVkAk2BoR0+STsTTFpf5wDtvXYFZIk2/0aq02moN7snAbm
k23lPOWs9h/sRhXxXW+Hg5D10Jhh5zSqf1Fk0ba3SZb+nZbIT10=
=N9EP
-----END PGP SIGNATURE-----

--qj5NqfuKdfJbnsCm--
