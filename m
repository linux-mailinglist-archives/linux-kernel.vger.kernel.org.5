Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E063C78C3C3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbjH2MCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjH2MBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:01:32 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34229198;
        Tue, 29 Aug 2023 05:01:22 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.49.30]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MkYLW-1pq5zH3E2I-00m0fB; Tue, 29 Aug 2023 14:00:53 +0200
Received: from localhost.fjasle.eu (kirkenes.fjasle.eu [10.10.0.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id B404A3E765;
        Tue, 29 Aug 2023 14:00:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1693310449; bh=ZYytDiGRtJSdBQgTEmMBwbn3QofSWiZ6ieqprmah5Uk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ffsJ3MQ8pAHMow6/ENcXbRcDdGSihyosWQDA5tlOgKxvbSXfYpSudpK1G1LEtMCuV
         evYZC2zandRUROQbSi+jgRSCJmZzY1gQJUd9RpCAMySZIqz0cnAM/RNyTRH+Cr+ODd
         YmUrnlxgVrN//By7tRhDHqxKzKMzSrDAl5sr76KI=
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 4D130433B; Tue, 29 Aug 2023 14:00:44 +0200 (CEST)
Date:   Tue, 29 Aug 2023 14:00:44 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] kbuild: single-quote the format string of printf
Message-ID: <ZO3d7DrfKfsDXqa5@bergen.fjasle.eu>
References: <20230829113531.4004730-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cAtYkVZMdyBhLJxT"
Content-Disposition: inline
In-Reply-To: <20230829113531.4004730-1-masahiroy@kernel.org>
X-Operating-System: Debian GNU/Linux trixie/sid
Jabber-ID: nicolas@jabber.no
X-Provags-ID: V03:K1:1kGvKTysRflt5ERGARXsCw59oUWS6Z+SXXhoCC1zva1P0lEHIhP
 X3McxEspQpumtwU8c3a0ZxOJF797lVpGBI0bhVkoeXLBnU3gFBs95YfQjzFPA0r58im1oOK
 9tFyaksh9/Gk4baHZxgujmPSWvDE0cz0+Aj90PQMDaQAkqjCG1AkZOW9EMjE/S8uCue3kA4
 mpXVl4Ae0cOFpkFoTMt8A==
UI-OutboundReport: notjunk:1;M01:P0:IxoDjVXSpMM=;ZIJor4XiTMZyMcacDZ647ftZGZH
 i0GLAMIk0+qxKlh4EFC+4vL4Xp/uBw6p2ms3ASFR5gDVB2bcSk41SJGkdzvZRqsh1FhEKne4m
 0WZ4kfwoDbakDgrsUUWfRWj12wbZLM2O1thFi6e1cI4sSVVghAn5HfXPsEHcHn2AASRRwAv6q
 Fys3BAq6n0q8tGFuEaegRLK1yVvbzvDSof1OYJblKgg0F0SC49ZdNwtg0+xK+H6Y093GY4U1L
 GQ7T171i1TWlhJeD2AlFCOg7euDtRoUze1ISggXAaH9VYeH9OepjNjgKnE0dGswn+j+Yg4NCi
 reRsf5Zdv41URyvTUAiYW5gbVCRcW33TbGoZJNzAoQ42lzfHSjpbPYyLE3uzQ/e59uJkTv6MD
 6MfY+r1mvaUkPiHoy29mjh4Xf+Cq3qRFzx13+ToWvTty4V8aMyxRziZaFkL0glMvcJ+drtk32
 Ba+oBRqXqVREzaMf7aE8s3lFim4lChe3ya+6KEG9QuCPVk7cCL+AoYjsmZd3nIqaIb2bLZyvG
 /3jfUiees6az+L7k84ZZm43XbInsCwkMWGKJv3p0vh4dMgg9dX3Cr/2iMxwqXkgj5/px8u0pe
 7f6ST1WqorY/j/7lOpnnLNm9gVLRQYGpnP3ErKwDKGDBMWUgLvCFX1HDSoqfjA2DP0I7QBctP
 fT/3qBkVXqTElRrfcXSBlsIcRGUkbiIacjcyRVD3eriD9KMVDy43VFNxu8p7vteGZia3jnpl5
 wEQplE3p4NwOwtu0eZH0fp6e4tMpqkpzt2Dnd5/Bs+ihyhtJIQ+Qyyo1j2PAQ2h/zxlcMvGH6
 z33qQcu9awDCvjh78o/6VGZZiPQ93wxh6AwO7FTwPWawJmwyuO+tYfD22O3Lt5Jck+GP4KQsN
 wfYH1VnxpMfp/aQ==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cAtYkVZMdyBhLJxT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 29 Aug 2023 20:35:31 GMT, Masahiro Yamada wrote:
> Use single-quotes to avoid escape sequences (\\n).
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Is this really necessary?  Testing w/ GNU Make 4.3, bash 5.2.15 or
dash 0.5.12-6 and a stupid Makefile snippet I cannot see any difference=20
between these three:

print:
	@printf "hello med single-backslash and double quotes\n"
	@printf 'hello med single-backslash and single quotes\n'
	@printf "hello med double-backslash and double quotes\\n"

Only double-backslash+n in single-quotes does not work, for obvious=20
reasons.

Is this some compatibility to older make versions or other shells?

Iff it is, we should have several cases that are actually broken right=20
now:

$ git grep -Hrne 'printf.*".*\\n' '**/Makefile*' '**/Kbuild*'=20
arch/mips/Makefile:480:   printf "  %-24s - Build generic kernel for $(call=
 describe_generic_defconfig,$(cfg))\n" $(cfg);)
arch/mips/Makefile:486:   printf "  %-24s - Build $($(cfg)-y)\n" $(cfg);)
samples/bpf/Makefile:238:HDR_PROBE :=3D $(shell printf "$(pound)include <li=
nux/types.h>\n struct list_head { int a; }; int main() { return 0; }" | \
samples/hid/Makefile:76:HDR_PROBE :=3D $(shell printf "$(pound)include <lin=
ux/types.h>\n struct list_head { int a; }; int main() { return 0; }" | \
scripts/Makefile.compiler:41:   printf "%b\n" "$(1)" | $(CC) -Werror $(CLAN=
G_FLAGS) $(KBUILD_AFLAGS) -c -x assembler-with-cpp -o "$$TMP" -,$(2),$(3))
scripts/Makefile.lib:437:printf "%08x\n" $$dec_size |                      =
                     \
scripts/Makefile.modfinal:43:           printf "Skipping BTF generation for=
 %s due to unavailability of vmlinux\n" $@ 1>&2; \
scripts/Makefile.modfinal:45:           printf "Skipping BTF generation for=
 %s because it's a Rust module\n" $@ 1>&2; \
security/tomoyo/Makefile:11:    printf '\t"";\n';) \
tools/testing/selftests/Makefile:263:           [ ! -d $(INSTALL_PATH)/$$TA=
RGET ] && printf "Skipping non-existent dir: $$TARGET\n" && continue; \
tools/testing/selftests/Makefile:264:           printf "Emit Tests for $$TA=
RGET\n"; \
tools/testing/selftests/nolibc/Makefile:136:             if (s+f > 0) print=
f(" See all results in %s\n", ARGV[1]); else print; }' \
tools/testing/selftests/nolibc/Makefile:155:             if (s+f > 0) print=
f(" See all results in %s\n", ARGV[1]); else print; }' \
tools/testing/selftests/nolibc/Makefile:163:             if (s+f > 0) print=
f(" See all results in %s\n", ARGV[1]); else print; }' \
tools/testing/selftests/wireguard/qemu/Makefile:335:    printf 'CONFIG_NR_C=
PUS=3D$(NR_CPUS)\nCONFIG_INITRAMFS_SOURCE=3D"$(BUILD_PATH)/init-cpio-spec.t=
xt"\n' >> $(KERNEL_BUILD_PATH)/minimal.config

I assume, that changing '\\n' occurrences in all Makefiles to '\n'=20
should be enough; but only a cosmetic change.  Or did I miss some
point?

Kind regards,
Nicolas


>=20
>  Makefile              | 8 ++++----
>  arch/powerpc/Makefile | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index 87a9eef3fb4b..d09600f7a036 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1643,12 +1643,12 @@ help:
>  	@echo  ''
>  	@$(if $(boards), \
>  		$(foreach b, $(boards), \
> -		printf "  %-27s - Build for %s\\n" $(b) $(subst _defconfig,,$(b));) \
> +		printf '  %-27s - Build for %s\n' $(b) $(subst _defconfig,,$(b));) \
>  		echo '')
>  	@$(if $(board-dirs), \
>  		$(foreach b, $(board-dirs), \
> -		printf "  %-16s - Show %s-specific targets\\n" help-$(b) $(b);) \
> -		printf "  %-16s - Show all of the above\\n" help-boards; \
> +		printf '  %-16s - Show %s-specific targets\n' help-$(b) $(b);) \
> +		printf '  %-16s - Show all of the above\n' help-boards; \
>  		echo '')
> =20
>  	@echo  '  make V=3Dn   [targets] 1: verbose build'
> @@ -1684,7 +1684,7 @@ $(help-board-dirs): help-%:
>  	@echo  'Architecture specific targets ($(SRCARCH) $*):'
>  	@$(if $(boards-per-dir), \
>  		$(foreach b, $(boards-per-dir), \
> -		printf "  %-24s - Build for %s\\n" $*/$(b) $(subst _defconfig,,$(b));)=
 \
> +		printf '  %-24s - Build for %s\n' $*/$(b) $(subst _defconfig,,$(b));) \
>  		echo '')
> =20
> =20
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index dac7ca153886..f49ac05eae20 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -353,7 +353,7 @@ define archhelp
>    echo '  (minus the .dts extension).'
>    echo
>    $(foreach cfg,$(generated_configs),
> -    printf "  %-27s - Build for %s\\n" $(cfg) $(subst _defconfig,,$(cfg)=
);)
> +    printf '  %-27s - Build for %s\n' $(cfg) $(subst _defconfig,,$(cfg))=
;)
>  endef
> =20
>  PHONY +=3D install
> --=20
> 2.39.2

--cAtYkVZMdyBhLJxT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmTt3eIACgkQB1IKcBYm
Emna0hAArCtrpgicD8xzhVNb1OGzeFpOaXnhfny1nwN70DTlWDM9UTX1myUA8BiC
xIHFzsWglqGlWBLnKVJZ+Be15aU2w69rUcZWwKP+Vhve+2/8XTrAM/WOktNJUNSj
0y0+SuEr+ZichEH3V5Q8gv81oAvSUg2t+aqTV6aopftHYI55vkb8dYMwQr/NwE5u
OkybclmV3Rk9hY6Ri4pUf51lXbBcfLzh1ITxmei3o9jSbjrpyh9kdfj8+2i82NT4
54XkGNiKW3jc4xC3btJpAnLeQqx2O732yvwBxv9p2JWn3kXZL+rNUMMDu+UtpcLj
zZ/QKVbfBF30uDCVd28WLzT3qNmnkXrZeIEX7gJ8DHMf8j0+eLSzrtuXNEjxvSvz
vkJ++loQGAF+Yyft5XdEP+W+ayc5HKl2wiuqKWvjeH2qRiTPwTywkOC1XS5nV2wu
Me5BCRXwTl5440lqzBdWAWn6BVk/L5EUlsfXAQxAZ1qmyk46FDXG9FevkRXBGOVp
EYm6wo9mhIiw9y+/y0dAu5+9nhFDZOCfiW8dg2rlH5skFvr8tCn2Zvhq4io8He2k
JRLaz2wfyxsrGxWFBfOs6eyFVxULaMOOaUdbtfEIFCtN37OHUdPIAqiHeYpS8UVw
I3vkc3PlqtES6iD1rL4x0L3EiBBVqFgveugfsMGJlKRCdJv9JDY=
=MVoM
-----END PGP SIGNATURE-----

--cAtYkVZMdyBhLJxT--
