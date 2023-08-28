Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7481178B3BA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjH1Oxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbjH1OxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:53:22 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CA8DA;
        Mon, 28 Aug 2023 07:53:11 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.49.250]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M9Fvl-1qekCg1rYF-006NGl; Mon, 28 Aug 2023 16:52:45 +0200
Received: from localhost.fjasle.eu (kirkenes.fjasle.eu [10.10.0.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 4F5CD3C183;
        Mon, 28 Aug 2023 16:52:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1693234363; bh=D07xgmtdk8u9Xyn8YT6ntZi6x8yQRUr/knBhOcOrqv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=10m9fJG9md5yV0nUcJv1FciAr3L9lOm7zdjsadSyf3nodLcEyocChvCjfmYzc1D47
         A3T3YpcgYFkyuQutcKW4UiDTfVN416iA9/6jtjDOmAD+d0FALJWLEonhD70tajftSJ
         OhWI0ZJoESZ7rqFG2VVdOdV/SR34gwnmlfZe7e/g=
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id D5C4E5DE3; Mon, 28 Aug 2023 16:52:08 +0200 (CEST)
Date:   Mon, 28 Aug 2023 16:52:08 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 8/8] kbuild: support modules_sign for external modules as
 well
Message-ID: <ZOy0mMfTP1N3MRka@bergen.fjasle.eu>
References: <20230823115048.823011-1-masahiroy@kernel.org>
 <20230823115048.823011-8-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i/hBC4ylfwBtT2dT"
Content-Disposition: inline
In-Reply-To: <20230823115048.823011-8-masahiroy@kernel.org>
X-Operating-System: Debian GNU/Linux trixie/sid
Jabber-ID: nicolas@jabber.no
X-Provags-ID: V03:K1:JyNHo9EusGcVY+wwawjKRLmqqPhLJprw5c31UBEShikmeaNCnX4
 OLMty8VyY1X/tpAmpPFV2bgAz4pxS9bcXK2NwyMrt3zan4NAa5RCrS0s4oEpiT0HakNU3SV
 M6O6Cc3VFiN+i0tjHTdbK+gPXVfgbj7mJDQ/57Psl1ew2NcLHqh6CV/4zSrhFlPDW6wscZq
 /UgQIiaQoZBDiaUjeL7GA==
UI-OutboundReport: notjunk:1;M01:P0:HMVhglbr33k=;Cz+DoTYHFfhgpvgnzb2F4UFsv9n
 tHAyGO+xqJPMwBjZh3pzdZJZ0dRyu0SUQok2TlNq54N9u6T3G4xfdK4yAgCzwjCf9uZD7jcp7
 0JizXGGq+5odQczRb9IJXJJHp/tYFxDX85GKfYz9uKH9cv22SEma56cj3vFaPc//fdmsN4bHq
 U9JUxIOvifE/BPs3+Cml1Y+x748iX97w+0+EtjKovkb8l6+G7BuquN+OFhcmiIqQ5gKNi+Moe
 1Q9EoLcdcPllznRoeE1/mhhBoRvmOp90hhl78xBZ/MUZ1CiJBsq2Ogf5xW6r77J1EC1jRGC2P
 PoPff7QD+W/gdZ2LJ2Mmg3beqMTyWqkGR622Mn6s0EWXmnHckBeYvW+encYzOTeshzZkeA/fj
 TFIS8sz9WgeFXThZDXmEclRCaKKXvxiVDNU7iBqqcDQEzSmTXphpA5wxsTQi1nPdWYIT4gUVt
 RCDFqrrmWIAfOv3jioXelPpYzDmwpSL0la3M2WjLG7weJQ05MsasMkQYAC/VkUpnP6Q5wpmWO
 DcmpsLDJ4JMjwxN2IIgfAXA+TL9frqFjaSqM0r2YZmlz2BES03k7bv2SaBocrxf/8Kwr+vvpS
 4tIgk57QSODoJ7beh4Cvj7PXUZ4a6Zi20DRWQvzuOp1MOw9J847mkSSjTJZhlyV355eEmaWdo
 oTc+pVXuY6NErEVQIJpUVCJiYaMd4KobsqBQYEXIdrKCm/xheCGRF9uwZjZ3CB2zmMiFN1BZZ
 p9fY/7aVPrQ7p1U1QqyfIL483fPWOVdcHulyUy/2qS2+xFlwByPU2r7HpNel5uRdA5cQLNPVp
 cveWDFz55nimpMH2CFYBCCBWyGyE26ZOdSDSkeeFLAKBOnpObAKcp8Yfpt2TI9taqh6ap1zzc
 f4CEcuQmEc5Kzag==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i/hBC4ylfwBtT2dT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 23 Aug 2023 20:50:48 GMT, Masahiro Yamada wrote:
> The modules_sign target is currently only available for in-tree modules,
> but it actually works for external modules as well.
>=20
> Move the modules_sign rule to the common part.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>


>=20
>  Makefile                 | 32 ++++++++++++++++----------------
>  scripts/Makefile.modinst |  4 ++--
>  2 files changed, 18 insertions(+), 18 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index 82d22debf6c9..87a9eef3fb4b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1461,20 +1461,6 @@ modules: modules_prepare
>  modules_prepare: prepare
>  	$(Q)$(MAKE) $(build)=3Dscripts scripts/module.lds
> =20
> -export modules_sign_only :=3D
> -
> -ifeq ($(CONFIG_MODULE_SIG),y)
> -PHONY +=3D modules_sign
> -modules_sign: modules_install
> -	@:
> -
> -# modules_sign is a subset of modules_install.
> -# 'make modules_install modules_sign' is equivalent to 'make modules_ins=
tall'.
> -ifeq ($(filter modules_install,$(MAKECMDGOALS)),)
> -modules_sign_only :=3D y
> -endif
> -endif
> -
>  endif # CONFIG_MODULES
> =20
>  ###
> @@ -1833,10 +1819,24 @@ endif # KBUILD_EXTMOD
>  # ----------------------------------------------------------------------=
-----
>  # Modules
> =20
> -PHONY +=3D modules modules_install modules_prepare
> +PHONY +=3D modules modules_install modules_sign modules_prepare
> =20
>  modules_install:
> -	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modinst
> +	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modinst \
> +	sign-only=3D$(if $(filter modules_install,$(MAKECMDGOALS)),,y)
> +
> +ifeq ($(CONFIG_MODULE_SIG),y)
> +# modules_sign is a subset of modules_install.
> +# 'make modules_install modules_sign' is equivalent to 'make modules_ins=
tall'.
> +modules_sign: modules_install
> +	@:
> +else
> +modules_sign:
> +	@echo >&2 '***'
> +	@echo >&2 '*** CONFIG_MODULE_SIG is disabled. You cannot sign modules.'
> +	@echo >&2 '***'
> +	@false
> +endif
> =20
>  ifdef CONFIG_MODULES
> =20
> diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
> index 33d424a3f265..459cb1fed223 100644
> --- a/scripts/Makefile.modinst
> +++ b/scripts/Makefile.modinst
> @@ -13,7 +13,7 @@ install-y :=3D
> =20
>  PHONY +=3D prepare
> =20
> -ifeq ($(KBUILD_EXTMOD)$(modules_sign_only),)
> +ifeq ($(KBUILD_EXTMOD)$(sign-only),)
> =20
>  # Install more files for in-tree modules_install
> =20
> @@ -115,7 +115,7 @@ quiet_cmd_sign =3D SIGN    $@
>        cmd_sign =3D scripts/sign-file $(CONFIG_MODULE_SIG_HASH) "$(sig-ke=
y)" certs/signing_key.x509 $@ \
>                   $(if $(KBUILD_EXTMOD),|| true)
> =20
> -ifeq ($(modules_sign_only),)
> +ifeq ($(sign-only),)
> =20
>  # During modules_install, modules are signed only when CONFIG_MODULE_SIG=
_ALL=3Dy.
>  ifndef CONFIG_MODULE_SIG_ALL
> --=20
> 2.39.2

--=20
Nicolas Schier
=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--i/hBC4ylfwBtT2dT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmTstJMACgkQB1IKcBYm
Emmw9xAAjac+ChO9mHUwkO9cXgKRk3QQg86/wRluF48TUf1zlF7PUlwha/yfzRwT
HZsuz8CeUK7Q7HQkNHj36c7FYOps4GkibqHle6JI9dSxJJ91nNrVqFyiJFxRgeIK
04eKSb4wppKqjkbyPNNbUo9jAWx5uVxPWdle3h3VCbpp1/3B+VOWfG3txnUT9O8S
cZJTSnfLw6ptUvWFwOp+f31Pso+pMXT5i4p9kyYgn/N0v4/uzDUmvonA4Lgf4918
JGdTIn4h2UKAexADHAqeE9QP0pnJdw3JcB6k14oLEDerGmp5chuY6dQZ2bVrNmPx
6WMLDGvtW6jwiab7CVoayfhEuVQy9XsPd3knJFFWOrZ8zOGMn884pEO2W/kzvk3T
3zndYG/vWyAgHdNVWpU87a3op0HsCuLCNO/f7MBB+Sz/0LBHZR1Fy/7cjd1Om8MY
H4kxBleJ63kF9LhUGYXnYfanKLJm2FqTqDMpxFIr4Ohz96JbXTyjwM2IAywKIHqT
XzKB3oriA3XmfYrUBBNJ9gcvVWLTrPnlPOB2e0gnvDDX4IJiiW+yjVZCst2R5cX1
VfI8gE7SyCNca3po6+q1v6Z+mZi6XEJk6U7GUI75eO8jUGjy1rPHOoUdU7HPFPoN
d6bQpxNYGBEBDt+AR315a4xuwLO8brm/DRD2pq6gqrP3Dd2FDDU=
=7CGZ
-----END PGP SIGNATURE-----

--i/hBC4ylfwBtT2dT--
