Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B97B760016
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 21:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjGXTyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 15:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjGXTys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 15:54:48 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C16A6;
        Mon, 24 Jul 2023 12:54:38 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.49.107]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mbiak-1pkqGQ2vyo-00dE4X; Mon, 24 Jul 2023 21:54:12 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id AD85F3E990; Mon, 24 Jul 2023 21:53:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1690228438; bh=pierYn0yhfaSVVo9LmmJ0hHZFZGKwLL8//gAQYb/uCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yHJBSVKcWES11t7ToxgYMd32HHaAZS6l2obQLnqjBzwvmAuhfdfVX2dtPEUyRhCYQ
         dvTQTzYkBLArFK5gG8Kvu053kaegkr7Fa8e0DQD89Vl4r94eUbHx4OsPPQhBnKMyaI
         RMc6WYp9X18O0NE+oUo6t2a0ReDYEwhc9vJKOIvU=
Date:   Mon, 24 Jul 2023 21:53:55 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 08/19] kbuild: add a phony target to run a command with
 Kbuild env vars
Message-ID: <ZL7W0+OZeUod+y7e@fjasle.eu>
References: <20230722044806.3867434-1-masahiroy@kernel.org>
 <20230722044806.3867434-8-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pe5Dnaw3JEvbZ27c"
Content-Disposition: inline
In-Reply-To: <20230722044806.3867434-8-masahiroy@kernel.org>
X-Provags-ID: V03:K1:bNUG9oZuTsPg2PJDWyjIaerLVbTcuiJjZ0HFnM1h3miPXRsg6D7
 2pZlzl6as3CTYr7heivw2y+/+MrcQv7E5lhrt9uqeLuBJtkJFbabWeeAFOvpVfAjdkYokAc
 zOsI1skmACvMOvn21l/Oda6hYHMN3aIsUbkySQFOvxjSszOKynrq3eZHhZNKTuyypEqW7RP
 MM/czV54brnVtoKfMS2tg==
UI-OutboundReport: notjunk:1;M01:P0:Ui6mNkV90sA=;sgYZbk9sd/iJLFR3gRgrE3aOanl
 SBpm2rfayKkCgalTGYmABDUZs+VGbc1fmlP/rkfhzJ4Rlr2a586i4ZtQAcD9ja7/M8ORLJEN1
 73pVHX26JwLgzK5VN3DpR1VMekYbY2aoRVKr6WzQri/7OXcXCSkjuyS/8OjIdRL/XXDsizy2I
 kNlYIOa0T87iU2wikpSHtzLBHt0o0qY6XWPIHVsOOY38dlJcARf2dz1qaK3EfyruNoUsCM0Y5
 K41ndx4sQl5k5uZmKByzPlGmiY/EAOVy+O+aB9v1X0g4/ubb4zmXTst38Ef0TbwF9ie48iyd4
 8ZJsXLn8KuebQoqSPS+Uaofckawu1YKYHiQueJjcVLPus94OBGKKIj1gWBESmWXr1/S9rFGvT
 YFEL5c1AxUfEAt6Uu0L0O18UhzNlsQFJrB9mDM5BoYwSf3fLzazZVKfe99CHv0OjiXESFiTPE
 LTz05xm0bcJ1h5q2cbZ3JephoXU+9ZiroKFtUMsPD/X7plfiWaAbmTm9lqX6XywIBKjYMYAtF
 KW4gu3X/osuts2AwdlYzDR3zn2Sh2dNfVPFskhw23/7OkIMoifRk/YS6+ipuMXKDNgcTNIafZ
 7t+tNe/HLOM6jtug05LUGyqtS1ycwqqJaDIOtY88l0Ud4Rb1eSaV3TN8A97gJQL8Q3PR/icuc
 6LxP0jX6cY6Z6QvVAVZXEj8PeNeoZMa8CErAqJG17Q==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pe5Dnaw3JEvbZ27c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 22, 2023 at 01:47:55PM +0900 Masahiro Yamada wrote:
> There are some cases where we want to run a command with the same
> environment variables as Kbuild uses. For example, 'make coccicheck'
> invokes scripts/coccicheck from the top Makefile so that the script can
> reference to ${LINUXINCLUDE}, ${KBUILD_EXTMOD}, etc. The top Makefile
> defines several phony targets that run a script.
>=20
> We do it also for an internally used script, which results in a somewhat
> complex call graph.
>=20
> One example:
>=20
>  debian/rules binary-arch
>    -> make intdeb-pkg
>       -> scripts/package/builddeb
>=20
> It is also tedious to add a dedicated target like 'intdeb-pkg' for each
> use case.
>=20
> Add a generic target 'run-command' to run an arbitrary command in an
> environment with all Kbuild variables set.
>=20
> The usage is:
>=20
>   $ make run-command KBUILD_RUN_COMMAND=3D<command>
>=20
> The concept is similar to:
>=20
>   $ dpkg-architecture -c <command>
>=20
> This executes <command> in an environment which has all DEB_* variables
> defined.
>=20
> Convert the existing 'make intdeb-pkg'.
>=20
> Another possible usage is to interrogate a Make variable.
>=20
>   $ make run-command KBUILD_RUN_COMMAND=3D'echo $(KBUILD_CFLAGS)'

nice idea, I like that.

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>


>=20
> might be useful to see KBUILD_CFLAGS set by the top Makefile.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  Makefile                 | 4 ++++
>  scripts/Makefile.package | 4 ----
>  scripts/package/mkdebian | 3 ++-
>  3 files changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index 47690c28456a..f258ef13fa5d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2133,6 +2133,10 @@ kernelversion:
>  image_name:
>  	@echo $(KBUILD_IMAGE)
> =20
> +PHONY +=3D run-command
> +run-command:
> +	$(Q)$(KBUILD_RUN_COMMAND)
> +
>  quiet_cmd_rmfiles =3D $(if $(wildcard $(rm-files)),CLEAN   $(wildcard $(=
rm-files)))
>        cmd_rmfiles =3D rm -rf $(rm-files)
> =20
> diff --git a/scripts/Makefile.package b/scripts/Makefile.package
> index e9217e997c68..7cd61a374dae 100644
> --- a/scripts/Makefile.package
> +++ b/scripts/Makefile.package
> @@ -146,10 +146,6 @@ deb-pkg srcdeb-pkg bindeb-pkg:
>  		--no-check-builddeps) \
>  	$(DPKG_FLAGS))
> =20
> -PHONY +=3D intdeb-pkg
> -intdeb-pkg:
> -	+$(CONFIG_SHELL) $(srctree)/scripts/package/builddeb
> -
>  # snap-pkg
>  # ----------------------------------------------------------------------=
-----
>  PHONY +=3D snap-pkg
> diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
> index ba2453e08d40..9105abab9728 100755
> --- a/scripts/package/mkdebian
> +++ b/scripts/package/mkdebian
> @@ -283,7 +283,8 @@ build: build-arch
>  binary-indep:
>  binary-arch: build-arch
>  	\$(MAKE) -f \$(srctree)/Makefile ARCH=3D${ARCH} \
> -	KERNELRELEASE=3D\$(KERNELRELEASE) intdeb-pkg
> +	KERNELRELEASE=3D\$(KERNELRELEASE) \
> +	run-command KBUILD_RUN_COMMAND=3D+\$(srctree)/scripts/package/builddeb
> =20
>  clean:
>  	rm -rf debian/files debian/linux-*
> --=20
> 2.39.2

--=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--pe5Dnaw3JEvbZ27c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmS+1tIACgkQB1IKcBYm
EmlWag//eOyzCKnDDtESITO2ov/T7kfBXfWW++/b7CAWJXZS77Yfw0fPBje/PYcs
cLHY7pcdRlHjzhf4nBP4SfUTKrxvYwrHl45rheysmMudNWdsSliohbu+ovhLz2aw
ZSzSyLbhyHEhwFBBfQEx5kPOczEi/LdQIwj71mfGGeGm+jPrgtWd+zi5nRdC3Agg
C+OEHTkZ0HGfNZDVq+TwFWspqv4X+KmdWxz8DkEMdRENdcZ+o+YZ9bcqwsLOwMYM
ka5LRtXvUB1QRQ/wuv5PCkPddU/ZoO1CT9WlQG5OAuns/5TttsRpq/WEX4ev87Dh
gkx8mRDZ3zAruWjmhVLRIlYgOyYPw6S+p0G49Dkb6E+xrr3d6eYbBaJpeTRBAMav
cNoRg7LTG+9rvsWd9EzMzSMtBcnIwyy+q0YeqpNSNnUKIbitOiOoZzE/ov3Nwc0X
YpFTHqA0OEnUdHJXSSCeKEVCO0RA35QcQ8Dh4ZkMCVcoBhyyYzf6SNWA2zO6ZF4K
Y6oDDjh4NDzK/vD/BUbYmEEFZ0Jf7SQAfYIiRuSIKJBaNjP6bvgbCUDSgJJcXp2I
mII4sYpC2Erd8OXbBaNxQGv0l8vs6TkGayeNGYRua/LxNxvpvnzE2GTh4gtcYNJ2
/RJFPE+rOJkRy4rvDf7C+F5uNqbMavyXQjM4eu8GZv904SU9TGY=
=l52X
-----END PGP SIGNATURE-----

--pe5Dnaw3JEvbZ27c--
