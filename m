Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1085C7680E9
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 20:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjG2SQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 14:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjG2SQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 14:16:21 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C5E2134;
        Sat, 29 Jul 2023 11:16:12 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.97.66]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MPooP-1qCndF3e7P-00MrSE; Sat, 29 Jul 2023 20:15:51 +0200
Received: from localhost.fjasle.eu (kirkenes.fjasle.eu [10.10.0.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 28ABE3E9EF;
        Sat, 29 Jul 2023 20:15:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1690654531; bh=ANgB6/OXFrn8cVEFF/RHGhz8LgeScIwb9GVKxWGLi2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LJ8uezkX2XoLTca0Hh1u3EsU/SBRzpFk+cfWcWilXy9xP50NawR313Z5sqcySEAJb
         Jj483ncJIguZLVtYKvJimnj3DUrJsIwU9sq8SIGo/tyWaxMoJYgpHkWug6dEuoyJyc
         nhVwZ9Y9QFPJD753PUyVt020oCEjvMd8tY99FfW4=
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 6ADCD6088; Sat, 29 Jul 2023 20:15:20 +0200 (CEST)
Date:   Sat, 29 Jul 2023 20:15:20 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Hutchings <ben@decadent.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 1/2] kbuild: deb-pkg: use Debian compliant shebang for
 debian/rules
Message-ID: <ZMVXOMXgb9nO8SxD@bergen.fjasle.eu>
References: <20230729143814.1509196-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v7/e55c+Hr3ZuXZo"
Content-Disposition: inline
In-Reply-To: <20230729143814.1509196-1-masahiroy@kernel.org>
X-Operating-System: Debian GNU/Linux trixie/sid
Jabber-ID: nicolas@jabber.no
X-Provags-ID: V03:K1:YdoSJod8SMYSsOE06YAhpqdXENfVOZs9TLwQtgECgt4Gv8AzyZs
 f9qDQRvkdVVOJ/gb6wfFUyasQD55EQ04J4ahckjJjYDybUfUm5LwMvAQ7S8nJB8/ZfeeCxL
 EPfx3aNkiq24pWd9Ayd7sTSkIid/6+CKqnvPHpvI06/Mqk4XSphtxaSqESDFqykQhmH59rl
 S9zNCl84TG/4HYcupwMHw==
UI-OutboundReport: notjunk:1;M01:P0:Bh3uYMo3Ys8=;Ls+uWQ3diZjW05S8T+PHnI9Yqqy
 3iVi93ufwrJ9rOprn4+WhEpX3y99m4DGNm6JgkKl1ZewBGcCm3et6meI5ITNYn8QwFKWfpeAv
 WrNJhGRjL7UqqZ5efO4m3yOv9BlaBkOYHWgQtKDfLwVMV1X96Vw3hLq25xPK3aJ3l6cc+t2/A
 8ZyZBri3eIpvgSqy8CzdMDrlL8Jr3x3K7kjBrqdzu16rZFX9mkOU3wk3A82e8lITmkt0G9ou1
 HTAJC68gKpP7m6Zy9djlWB/VH9On3iI5tLnW0JUbbXUcakpbyqsxCrbNTIyVkDqbhDxBw6dKn
 a8e1HUHc94cVHKkBXYj2I6xHgMk7B3Ts8ebrS1I5uBRySKuSxa9A1MK/wr9v+hO7WD8nHRTge
 i2tyYMUrpq9SIo47yGe315n2Rn5pjgrK9T4vtovA32pfRLqac+y9sNIiODiXMo9GorbdO/z73
 mXalYQtlCVeERAsulPZW6CLg2/06tzxM2xQHiIWGTRKIGk71caxtgmAvIpvZPuELBw9hF26wK
 aPA/jCALxngkK1mE5WuX29obKDMhvJ7NJDrU3xG5mSUuA82yOvKTMBTCyTQt8rnNQgX3rPLTq
 Ku5rpoEoNU/HSXlDIsQcJAEsZERsyJJs/T4aR0RLziNf7rMB/tNrqvAyzJO8+XIpKH3+XAGDr
 IB4J7h16elOKOsp2k7/VFawjovIecn4N/HROY+giA5hIttGsp3CLG33Fx7YHHxWhwU9LcH4Mk
 +pf6yTv0eV6zCb9Co7ZQVTyhd2i6aoTZune5+3if65u2ctvVLYyQ51uSWTeAd6coOSdt+alPT
 VySrPTqb/kaz07vATwi/RYYL9fkNRf2z0Hu6drgGDIXHmiO81a0ZP9leRbriouQJVYtRDhgdR
 xuaJHYukIAeZ7Ag==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v7/e55c+Hr3ZuXZo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 29 Jul 2023 23:38:13 GMT, Masahiro Yamada wrote:
> Debian Policy "4.9. Main building script: debian/rules" requires
> "debian/rules must start with the line #!/usr/bin/make -f". [1]
>=20
> Currently, Kbuild does not follow this policy.
>=20
> When Kbuild generates debian/rules, "#!$(command -v $MAKE) -f" is
> expanded by shell. The result may not be "#!/usr/bin/make -f".
>=20
> There was a reason to opt out the Debian policy.
>=20
> If you run '/path/to/my/custom/make deb-pkg', debian/rules must also be
> invoked by the same Make program. If #!/usr/bin/make were hard-coded in
> debian/rules, the sub-make would be executed by a possibly different
> Make version.
>=20
> This is problematic due to the MAKEFLAGS incompatibility, especially the
> job server flag. Old Make versions used --jobserver-fds to propagate job
> server file descriptors, but Make >=3D 4.2 uses --jobserver-auth. The flag
> disagreement between the parent and the child Make would result in a
> process fork explosion.
>=20
> However, having a non-standard path in the shebang causes another issue;
> the generated source package is not portable as such a path does not
> exist in other build environments.
>=20
> This commit solves those conflicting demands.
>=20
> Hard-code '#!/usr/bin/make -f' in debian/rules to create a portable and
> Debian-compliant source package.
>=20
> Pass '--rules-file=3D$(MAKE) -f debian/rules' when dpkg-buildpackage is
> invoked from Makefile so that debian/rules is executed by the same Make
> program as used to start Kbuild.
>=20
> [1] https://www.debian.org/doc/debian-policy/ch-source.html#main-building=
-script-debian-rules
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

LGTM, thanks!

Tested-by: Nicolas Schier <nicolas@fjasle.eu>
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

>=20
>  scripts/Makefile.package | 2 +-
>  scripts/package/mkdebian | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/scripts/Makefile.package b/scripts/Makefile.package
> index 85beab0363d7..f8a948ec2c6b 100644
> --- a/scripts/Makefile.package
> +++ b/scripts/Makefile.package
> @@ -148,7 +148,7 @@ deb-pkg srcdeb-pkg bindeb-pkg:
>  	$(if $(findstring source, $(build-type)), \
>  		--unsigned-source --compression=3D$(KDEB_SOURCE_COMPRESS)) \
>  	$(if $(findstring binary, $(build-type)), \
> -		-r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch), \
> +		--rules-file=3D'$(MAKE) -f debian/rules' -r$(KBUILD_PKG_ROOTCMD) -a$$(=
cat debian/arch), \
>  		--no-check-builddeps) \
>  	$(DPKG_FLAGS))
> =20
> diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
> index 9105abab9728..2829f5b8aea6 100755
> --- a/scripts/package/mkdebian
> +++ b/scripts/package/mkdebian
> @@ -264,7 +264,7 @@ EOF
>  fi
> =20
>  cat <<EOF > debian/rules
> -#!$(command -v $MAKE) -f
> +#!/usr/bin/make -f
> =20
>  srctree ?=3D .
>  KERNELRELEASE =3D ${KERNELRELEASE}
> --=20
> 2.39.2

--=20
Nicolas Schier
=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--v7/e55c+Hr3ZuXZo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmTFVzIACgkQB1IKcBYm
Emku0A/+OZci72EhT1YWBt2KtL0ogLGD7H+OJs6l2KaU3V4hDD+DZMBHZxwHID3a
hHcmoGsTROZFHOPcYc5JVlULGzPFZHHtVibXTahjg+xxV1gOE5CeN8csyVBIsq7t
eVJRBC+qXlIjreAf0A5rOqjDyCkoHvP2gAA57RELDa1PyMfxpRsPI4iwxt9/rQgi
aFF7gk+mXv59ZY+t7eRi1D/hfbS/7TPzyUsPXdAfASRYazNxIHH514to/t2zk8pt
3mX0wAKAyr7MHLXF6iYZ5wUL6AL7AVzj6XrzFK41kAcaT4bbjePqbqKMHiHPSt61
kufmvVdDMnTHMngPoYcYXxeLOivKhxUMvojU5pAAXe3d02xBvXEy7jMKt6j9zQ7q
CIYwqjxnAGkbKH7acgO2ih3gkh4HUa36QKOdddW9Wl1Pa6kSWKevH0lyodi5zSE9
wYNIZtonnARcZanBSqDgUjnPssBBO1gDx9fh3+ruygvIf5o2IGAtFTlYs+y1afer
Ub/AUTjZZ11gNLC7r7PX7OnzBhuYDDo9PIsUCGBu8oS7TQ5UryhfV6nfzpa8sACB
8+UVn+NV6+tDsNlZL8EZJYX9JHxPhPPCNIMY/tOvqYpx+E1WPhsqkmPt9ge8YpsZ
tA++XGXw3ZL+cooOW0xPFf8iDjzFLlQDDprAoVCzw0r4r73fw6M=
=nbZm
-----END PGP SIGNATURE-----

--v7/e55c+Hr3ZuXZo--
