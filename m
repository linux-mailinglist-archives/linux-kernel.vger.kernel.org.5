Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729B778B332
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjH1OcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjH1OcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:32:09 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22C9CC;
        Mon, 28 Aug 2023 07:31:58 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.49.250]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N3bCH-1pbkpe3pHH-010car; Mon, 28 Aug 2023 16:31:30 +0200
Received: from localhost.fjasle.eu (kirkenes.fjasle.eu [10.10.0.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 183793C183;
        Mon, 28 Aug 2023 16:31:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1693233085; bh=Ydm2kf81Qq6R56WZXeYcVK7H9JA303Wow6gBMrBPSNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TH5EDg/S7StiKSZc+6JRbzwXfPJp/SNef3o9rZjFMyHOAZkxplbtuLiC20fUUL52n
         E6IjnFnzXJ5O+f5fro9yA9HUeX+Nn/1rwtPeZPdvaFLDBkcqU21d7rQrSxSXqbC9Mz
         ntPhqQIGMQy27ocbWztdSAEGV80jLSoUulEHa0O8=
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 2DE575DE3; Mon, 28 Aug 2023 16:31:24 +0200 (CEST)
Date:   Mon, 28 Aug 2023 16:31:24 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 7/8] kbuild: support 'make modules_sign' with
 CONFIG_MODULE_SIG_ALL=n
Message-ID: <ZOyvvDDiLSFJZG0G@bergen.fjasle.eu>
References: <20230823115048.823011-1-masahiroy@kernel.org>
 <20230823115048.823011-7-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J9Yc45GIQDHZ4LYD"
Content-Disposition: inline
In-Reply-To: <20230823115048.823011-7-masahiroy@kernel.org>
X-Operating-System: Debian GNU/Linux trixie/sid
Jabber-ID: nicolas@jabber.no
X-Provags-ID: V03:K1:PN/JmjeLv1gMquQ6WBkR4gxEX51LAwz7PVOZ8K7QAiNlaRbjia8
 xAz0fYnBuscYQWoj/jK4Si8uiluFDnL1hpEw4QwXxSHevCe4WSsd++qrz9Fp/HtOtvQGNMf
 f1hhPj0Wojgflsp4aWN0rJzJOWUoAK+UEBykuSlP9mVNyXsNqRyxFF7J7FPJ0Ir0J5wM0Je
 suQ5MaGA6+rw51CykdEZA==
UI-OutboundReport: notjunk:1;M01:P0:h8O/pTqSieI=;c47Nw4wXAFRZI+fPuyMPrza0Gmy
 0vrxpb1eXvofzTGYaLiIYwnrqXkR9fa30pCXRCUdAbAt/i5KOGJ6zcCUaddK5S1hL6eubSYcZ
 kUcbXxDrJdt5rDPcmCuBWb4n03DrOHfYSmUThAo5lyU/wAehb3mkCHkq5iyd5/+91m1ay53aY
 OIB/98sr8oH3qnyO4KFwNGAq1OsTyfCPR3cueDahl3VzPK3P7ONuuJ3mHGaRYA/rbazeuFlBK
 bZRRBTGemW/ugJ9sILIVGwQYPyoLwr2+QMsJvIALYEwvCD9dJ594Fv6VJBQhq32D3pv2HsB9e
 HdvwpacrluoH5xT3LB4Z0enrbjwmrGF4KJCUQWAyeXnly9G5R9mzJZ4aCg41iI7ohPsC90eeh
 sCs9M9NtT272XA1oNIYl8yRLqzCSAIThkT67TXyx7z8EsoFe/rU9Hs/XUTHr2UYyjhmW70ND1
 LxxDHsqbNDOMyHNHRxVJFYzeObjCN+dWsAYj4d646Dv9ZFDTaCmj6vzXcq/CRfLWogZaFk98z
 lbOLVkHSADK6oHNBJSb0ntEGOamQ8e8p8PVk0Rcif53YEPT/BN5n3INb2BU4zy2sKKg26jbbA
 PZvuFL2WjsoBgPuj9Vl0nw3C70Dm8O2qDpfap65eywF03Lb5X1gIkma6FqslQjuQU8PAJu1kr
 XyiaXn8UE6tghABqR7+YYEULt8XwEwoQzhCVbwXEDOLcRsJLfZIF7ibT/dIjKH2GY7ypKdvaI
 0cig5G8NzOa4IV6/Eb2GdjjU9RG3vknaTA6H3XJEknS2J8HeA7G222h1HGhhpUKdoozwWl0yZ
 6QiIlIrkgvbhtMUaCZxB9qciZ6E6KqrqwB28Jcqo/x6on4hQpp2P9X+XUKaj7vCdJrq8NQEeE
 7aG2xb7dhhRovDg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J9Yc45GIQDHZ4LYD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 23 Aug 2023 20:50:47 GMT, Masahiro Yamada wrote:
> Commit d890f510c8e4 ("MODSIGN: Add modules_sign make target") introduced
> 'make modules_sign' to manually sign modules.
>=20
> Some time later, commit d9d8d7ed498e ("MODSIGN: Add option to not sign
> modules during modules_install") introduced CONFIG_MODULE_SIG_ALL.
> If it was disabled, mod_sign_cmd was set to no-op ('true' command).
> It affected not only 'make modules_install' but also 'make modules_sign'.
> With CONFIG_MODULE_SIG_ALL=3Dn, 'make modules_install' did not sign modul=
es
> and 'make modules_sign' could not sign modules either.
>=20
> Kbuild has kept that behavior, and nobody has complained about it, but
> I think it is weird.
>=20
> CONFIG_MODULE_SIG_ALL=3Dn should turn off signing only for modules_instal=
l.
> If users want to sign modules manually, they should be allowed to use
> 'make modules_sign'.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

>=20
>  scripts/Makefile.modinst | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
> index dc7c54669082..33d424a3f265 100644
> --- a/scripts/Makefile.modinst
> +++ b/scripts/Makefile.modinst
> @@ -106,7 +106,6 @@ endif
>  # Signing
>  # Don't stop modules_install even if we can't sign external modules.
>  #
> -ifeq ($(CONFIG_MODULE_SIG_ALL),y)
>  ifeq ($(filter pkcs11:%, $(CONFIG_MODULE_SIG_KEY)),)
>  sig-key :=3D $(if $(wildcard $(CONFIG_MODULE_SIG_KEY)),,$(srctree)/)$(CO=
NFIG_MODULE_SIG_KEY)
>  else
> @@ -115,13 +114,15 @@ endif
>  quiet_cmd_sign =3D SIGN    $@
>        cmd_sign =3D scripts/sign-file $(CONFIG_MODULE_SIG_HASH) "$(sig-ke=
y)" certs/signing_key.x509 $@ \
>                   $(if $(KBUILD_EXTMOD),|| true)
> -else
> +
> +ifeq ($(modules_sign_only),)
> +
> +# During modules_install, modules are signed only when CONFIG_MODULE_SIG=
_ALL=3Dy.
> +ifndef CONFIG_MODULE_SIG_ALL
>  quiet_cmd_sign :=3D
>        cmd_sign :=3D :
>  endif
> =20
> -ifeq ($(modules_sign_only),)
> -
>  $(dst)/%.ko: $(extmod_prefix)%.ko FORCE
>  	$(call cmd,install)
>  	$(call cmd,strip)
> --=20
> 2.39.2

--=20
Nicolas Schier
=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--J9Yc45GIQDHZ4LYD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmTsr7sACgkQB1IKcBYm
Emkj8hAA2HJkjOFbQMPevgiZ/EBZhHtWCk26FuAM0QTZPex/NYy/YfsRD9jtiRxd
eiJ4kUu6g5v5bJxcwj9kxIyXr9IyTj+tfroNCK2XXFwx5neAOb0Xd/wW6BFthcNi
x/I5cQCQrQHMvcXDBKJXTfPoZFT90mDB3Qm5VuSFJvRUTFq9o9lSoESIcnEVL24f
AtYBxZ1XEGuS7YIOscvsIeMcFhn5WtKZHGJVr0IqrSl16Vl4z62nlbGTSNBSNunC
xFtg+LxzOOw+nYX6aQwL1hcGaTJSM+8Smpl9vhTJA1Y8GtUtcQ6V/OC68Ln37TM5
E2ReF21AG8aeBVh1Z6+9oOgyxOooPmC+tQy8/UeEzroEauyGFnRkIViWgAtXRypl
2QcJq4xdSZE2mkU4P5CGiXJ79+UIp1ngpQBLhb4iHw+51zsk0RXtBjWBERH3LlIc
0BSchArQj9+noiOKweL9o/PgJS9KEsBSKZarHmU0/AXloDBLpf2yL8kplMoWxaMV
A/V/qu6nPNj/UEfkRiwEyYDlYfPchy34/w8kpPYRhLXThTLEdkgGXPXN6MeOQkfO
kK90outqxzFXwmU8+BO7tJZSqVERMSHqe/6R8SDEVHEOmYeNOlJjKhlRXB8SovNl
e/rE3F9I4nq/0RzcwjS+QwQzbt23Ll5MCHN/HMdSenEg+v9mmlk=
=93K9
-----END PGP SIGNATURE-----

--J9Yc45GIQDHZ4LYD--
