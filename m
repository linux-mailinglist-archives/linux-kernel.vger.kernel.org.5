Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A5678B30C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjH1O07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjH1O0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:26:31 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94515CC;
        Mon, 28 Aug 2023 07:26:20 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.49.250]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N7yz7-1pgAmN3NmF-0154E0; Mon, 28 Aug 2023 16:25:49 +0200
Received: from localhost.fjasle.eu (kirkenes.fjasle.eu [10.10.0.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 987753C183;
        Mon, 28 Aug 2023 16:25:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1693232741; bh=NvZaUvsorX4VIRxpke/fs3TMHLz0h+URZisExrF6BDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xM9V80mbCRaH1el6Y/BVjxiqxOhIoAMOGz71C1CKgeS450zt/WOqqAmqjSB0fC33H
         LS3kcgyK/JChPsC0ROIewUoJnIhi0E/65ul1MqST30HnZlBlrLLGxOpTPmDcNRiPv9
         3f1yNaaa5eYMaErbDU8LJq2uPZt917V2N06Wr7Ic=
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 3A0C92902; Mon, 28 Aug 2023 16:25:39 +0200 (CEST)
Date:   Mon, 28 Aug 2023 16:25:39 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 6/8] kbuild: move more module installation code to
 scripts/Makefile.modinst
Message-ID: <ZOyuY5XCfYEV8fW6@bergen.fjasle.eu>
References: <20230823115048.823011-1-masahiroy@kernel.org>
 <20230823115048.823011-6-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jHQU5YkOQa07pdOM"
Content-Disposition: inline
In-Reply-To: <20230823115048.823011-6-masahiroy@kernel.org>
X-Operating-System: Debian GNU/Linux trixie/sid
Organization: AVM GmbH
X-Provags-ID: V03:K1:Pc3uj8UdP6K/LD4c3ghg6fvpojZYQCA4ISSh9zIH4aaSv7VpzLl
 r/VvmPj6b7TH1SE49dcjqh1LDnE41TFBqQzHMJX8e2ZoKFkFvlM4AF4Th0ANImLU0SBNLjl
 Czhacvlm4+Z/Z73e/CspVcgIId/YlXgPpIXqhltO9aQFV2E6K9zcau6b3PQiR2EC7/g7+u/
 L/bvNzPaBBPrB3W9dYMZA==
UI-OutboundReport: notjunk:1;M01:P0:ScLm8CEonbs=;ENLiye7BA92ZYsDEuwz1SBWsLHg
 FpfSE7fSN+OJHsOfJtTv2ddrqymqj4DlkxYVWxMfx21ADV+1OAtAXDzBMjNWczunhYsWCsJ0G
 YRL9Qwt68jcxHexuPBpl3RgyQTMicEbgZfTJoXYnrp0tS2C/KzlE1BSJNJs7t/jlx1WNsQyx8
 umyoxAmo6jAnaOUGCx+ws6wO2tu9/iGJZSDWN2GOxA4uQhXiVSp3LyS5+nNVyznorEi5EEAiQ
 KlUAx7vCymFFfWnGadgTj+F9qrBc1Wzz9RZeb6qgKWWhImvLD6izKk9i4PwFqRoYKh19MQbs7
 71/f56ndm36rUyd7zESl/YRotFc2/0/txZglUG5SyFTw7yUR+Xx6gEl4JuSN73RdUyFgwousV
 1+USup13nOsmDegEpnDe4g5i19KimhkezV+qbUPR0fHaRHAb2yBmSdp+Wq/Pyd8pZgvfAZ/al
 M1pTZVfbYWxZKAUjLKYmQj0a1nZzd2NkuKQeEC04VwAs2bzi5T21DgIEnA3BVzEsM+9rGDHmA
 2wYJU63bqGvuwECrhHY+M0E+G+C3IieumXTafqS7Ow3u9N+SgXfMvqIlyrN0TlUlJLQ0+/4Ut
 LXN6eA5Z3txBM11ZRorJGkvP8kdI4FfsW406fs/bQGBCOMqQItBJS4yeMVOgsrc9TRk2Wzjmo
 0bngAPWgIoDNyOdq0HRz+3TfooVHXpd2abj5zE27c9fW+08l6ERNbeDYob9Rx9kGzXLNvePIs
 CkAWY/FdPfmepC1syAaGyDhBQLcDh8j95U9Sb6IkL1MvCFj2PNImmMBclZoZ7gStqak39jcnf
 EcvWke/TKiIBvmWvo9a8PqzOqcqoh6VwKp6rVkYD9cEk+7VH2HME3+WbGWeX92LhAEpbLLy1l
 JHicYEhpUSq03ZQ==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jHQU5YkOQa07pdOM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 23 Aug 2023 20:50:46 GMT, Masahiro Yamada wrote:
> Move more relevant code to scripts/Makefile.modinst.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  Makefile                 | 34 +++++++--------------------------
>  scripts/Makefile.modinst | 41 +++++++++++++++++++++++++++++++++++++---
>  2 files changed, 45 insertions(+), 30 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index 7d9cab3d2186..82d22debf6c9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1477,24 +1477,6 @@ endif
> =20
>  endif # CONFIG_MODULES
> =20
> -modinst_pre :=3D
> -ifneq ($(filter modules_install,$(MAKECMDGOALS)),)
> -modinst_pre :=3D __modinst_pre
> -endif
> -
> -modules_install: $(modinst_pre)
> -PHONY +=3D __modinst_pre
> -__modinst_pre:
> -	@rm -rf $(MODLIB)/kernel
> -	@rm -f $(MODLIB)/build
> -	@mkdir -p $(MODLIB)
> -ifdef CONFIG_MODULES
> -	@ln -s $(CURDIR) $(MODLIB)/build
> -	@sed 's:^\(.*\)\.o$$:kernel/\1.ko:' modules.order > $(MODLIB)/modules.o=
rder
> -endif
> -	@cp -f modules.builtin $(MODLIB)/
> -	@cp -f $(objtree)/modules.builtin.modinfo $(MODLIB)/
> -
>  ###
>  # Cleaning is done on three levels.
>  # make clean     Delete most generated files
> @@ -1836,12 +1818,15 @@ help:
>  	@echo  '  clean           - remove generated files in module directory =
only'
>  	@echo  ''
> =20
> +ifndef CONFIG_MODULES
> +modules modules_install: __external_modules_error
>  __external_modules_error:
>  	@echo >&2 '***'
>  	@echo >&2 '*** The present kernel disabled CONFIG_MODULES.'
>  	@echo >&2 '*** You cannot build or install external modules.'
>  	@echo >&2 '***'
>  	@false
> +endif
> =20
>  endif # KBUILD_EXTMOD
> =20
> @@ -1850,6 +1835,9 @@ endif # KBUILD_EXTMOD
> =20
>  PHONY +=3D modules modules_install modules_prepare
> =20
> +modules_install:
> +	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modinst

I was a bit surprised to see 'modules_install' being allowed=20
unconditionally for in-tree usage (thus, even if CONFIG_MODULES=3Dn), but=
=20
then realised that this is the same behaviour as we had before.  Out of=20
curiosity:  _why_ do we need to install=20
$(MODLIB)/modules.builtin{,.modinfo} also for configs w/=20
CONFIG_MODULES=3Dn?

> +
>  ifdef CONFIG_MODULES
> =20
>  $(MODORDER): $(build-dir)
> @@ -1866,17 +1854,9 @@ PHONY +=3D modules_check
>  modules_check: $(MODORDER)
>  	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/modules-check.sh $<
> =20
> -modules_install:
> -	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modinst
> -
>  else # CONFIG_MODULES
> =20
> -# Modules not configured
> -# ----------------------------------------------------------------------=
-----
> -
> -PHONY +=3D __external_modules_error
> -
> -modules modules_install: __external_modules_error
> +modules:
>  	@:
> =20
>  KBUILD_MODULES :=3D
> diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
> index 5d687a453d90..dc7c54669082 100644
> --- a/scripts/Makefile.modinst
> +++ b/scripts/Makefile.modinst
> @@ -13,9 +13,41 @@ install-y :=3D
> =20
>  PHONY +=3D prepare
> =20
> +ifeq ($(KBUILD_EXTMOD)$(modules_sign_only),)
> +
> +# Install more files for in-tree modules_install
> +
> +prepare:
> +	$(Q)rm -fr $(MODLIB)/kernel $(MODLIB)/build
> +	$(Q)mkdir -p $(sort $(dir $(install-y)))
> +
> +install-$(CONFIG_MODULES) +=3D $(addprefix $(MODLIB)/, build modules.ord=
er)
> +
> +$(MODLIB)/build: FORCE
> +	$(call cmd,symlink)
> +
> +quiet_cmd_symlink =3D SYMLINK $@
> +      cmd_symlink =3D ln -s $(CURDIR) $@
> +
> +$(MODLIB)/modules.order: modules.order FORCE
> +	$(call cmd,install_modorder)
> +
> +quiet_cmd_install_modorder =3D INSTALL $@
> +      cmd_install_modorder =3D sed 's:^\(.*\)\.o$$:kernel/\1.ko:' $< > $@
> +
> +# Install modules.builtin(.modinfo) even when CONFIG_MODULES is disabled.
> +install-y +=3D $(addprefix $(MODLIB)/, modules.builtin modules.builtin.m=
odinfo)
> +
> +$(addprefix $(MODLIB)/, modules.builtin modules.builtin.modinfo): $(MODL=
IB)/%: % FORCE
> +	$(call cmd,install)
> +
> +else
> +
>  prepare:
>  	$(Q)mkdir -p $(sort $(dir $(install-y)))
> =20
> +endif
> +
>  modules :=3D $(call read-file, $(MODORDER))
> =20
>  ifeq ($(KBUILD_EXTMOD),)
> @@ -34,9 +66,10 @@ suffix-$(CONFIG_MODULE_COMPRESS_XZ)	:=3D .xz
>  suffix-$(CONFIG_MODULE_COMPRESS_ZSTD)	:=3D .zst
> =20
>  modules :=3D $(patsubst $(extmod_prefix)%.o, $(dst)/%.ko$(suffix-y), $(m=
odules))
> -install-y +=3D $(modules)
> =20
> -__modinst: $(modules)
> +install-$(CONFIG_MODULES) +=3D $(modules)
> +
> +__modinst: $(install-y)
>  	@:
> =20
>  #
> @@ -94,14 +127,16 @@ $(dst)/%.ko: $(extmod_prefix)%.ko FORCE
>  	$(call cmd,strip)
>  	$(call cmd,sign)
> =20
> +ifdef CONFIG_MODULES
>  __modinst: depmod
> =20
>  PHONY +=3D depmod
> -depmod: $(modules)
> +depmod: $(install-y)
>  	$(call cmd,depmod)
> =20
>  quiet_cmd_depmod =3D DEPMOD  $(MODLIB)
>        cmd_depmod =3D $(srctree)/scripts/depmod.sh $(KERNELRELEASE)
> +endif
> =20
>  $(install-y): prepare
> =20
> --=20
> 2.39.2

Thanks for cleaning up.  For me, the new rules look better than the=20
original ones.

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

--jHQU5YkOQa07pdOM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmTsrl0ACgkQB1IKcBYm
EmmMVA//QjbsbmxrdTu9JUUuuiBzBkqreXFTnr4TSQKQoQHPyxkfctElHUfwx037
4Wt417eXZlgMKDDTFQjVCvkXy/TZCe5w7m2FioxScbT/4WXHhCR8qZIsZGcHcTcp
oxfyryr9BVhWnT444ohRD91uLsiwbWs/tGfDlh80Vhx/yc7VM6bDApdEIv6lQhyZ
TOVV5rr1QPdykpnhY3grfK6tvNS8yAEtMuAK4DJOg1PjFEYhlugJTp53U90Sf87+
bqC5psMJ+2pO+Oa48RyOnhecT6wfjqj/rbvw4a54gM6xYgwqjHqdh+JO3hS4iq7L
3Of/IwQ9Clnh8o+eCi33w31z7yqNXK+wiZ/v8tw009JiPtEs228puNlb+iNg/9Ib
m9F89K1Ypq7SKUfxt3SZiBbNdOmU827f8OuOCEa+wpxbSGcEUnEM4H2CSrDnbn6D
QWhTp3DoTNUkW1379/XYhAYVqA2H2aeR/zG/cOWO63Kxl4UU0OWF0AWiSHaRMFTT
TuaXn00im+V7go4V4EW2GlYnht1hg8rZdYu3IRE29+gfuHiwXwQAaaXuFvyPW7nX
UhxjC4c6CUFs0GHUQBEOys2glR+cOo4a5AMao9zzxkAFuex3bgvz+CKtYmtyE5KJ
Vwc5xVBzZwVQ1p1J7ohShGOimJ+9Fm4MZOHlVSNMU7Eq26dZAAU=
=U2yF
-----END PGP SIGNATURE-----

--jHQU5YkOQa07pdOM--
