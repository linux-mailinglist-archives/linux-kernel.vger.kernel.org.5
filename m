Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80117B53F2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237359AbjJBNZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235717AbjJBNZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:25:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0459DC6;
        Mon,  2 Oct 2023 06:25:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0E2C433C8;
        Mon,  2 Oct 2023 13:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696253117;
        bh=yMKiAZh8Zi1IRLurrlmkJCC3ZtBt6u8921RF62mKwiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ATTFpem79JBuSlV65H7DgvZGCj9e9VZO5bpbua2jGaJJsloz4yWNe4YgiS+6wNayG
         rQEgXCWlRMulM13fhYzlXbYAwqONLzm/qUB0SaiJXCiA+Yy6lCXMWRVCVgf5bisGQu
         lDhvgBWZc7iuYPaw1gmv6qN00GW/btCrvJ6n4Yp4hFy9rEoWOGRDj7HNaFukmL4xRP
         jCS50V2El2LLMiQqRUvAzDJ8DsOFyiLbBWIjITnjJ9RyiJ6LJMNYHfpTCQmACQi6Fg
         oyL4URChnP6XktZ8MRwUIx0VD+5mEPpJnvwozt1du0EMe33V34qcNcFUYE+NU9ijJt
         5Z+qHR/n2lvsw==
Date:   Mon, 2 Oct 2023 14:25:09 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Costa Shulyupin <costa.shul@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Chiu <andy.chiu@sifive.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Song Shuai <songshuaishuai@tinylab.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Charlie Jenkins <charlie@rivosinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Wu XiangCheng <bobwxc@email.cn>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, workflows@vger.kernel.org
Subject: Re: [PATCH v1] docs: move riscv under arch
Message-ID: <20231002-exclusive-ebay-29cf9c449e2a@spud>
References: <87h6nbka8x.fsf@meer.lwn.net>
 <20230930185354.3034118-1-costa.shul@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yyJILPRGEs0APJsw"
Content-Disposition: inline
In-Reply-To: <20230930185354.3034118-1-costa.shul@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yyJILPRGEs0APJsw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Sat, Sep 30, 2023 at 09:52:00PM +0300, Costa Shulyupin wrote:
> and fix all in-tree references.
>=20
> Architecture-specific documentation is being moved into Documentation/arc=
h/
> as a way of cleaning up the top-level documentation directory and making
> the docs hierarchy more closely match the source hierarchy.
>=20
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

Firstly, $subject is not correct - this is now v2.
Also, please do not send new versions as a response to old threads. It
buries them in people's mailboxes that do things like sorting by
threads. Clearly no resubmission should be required for either of those
items though, so:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>=20
> ---
> Changes in v1: rebased on linux-next
>=20
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  Documentation/arch/index.rst                                  | 2 +-
>  Documentation/{ =3D> arch}/riscv/acpi.rst                       | 0
>  Documentation/{ =3D> arch}/riscv/boot-image-header.rst          | 0
>  Documentation/{ =3D> arch}/riscv/boot.rst                       | 0
>  Documentation/{ =3D> arch}/riscv/features.rst                   | 0
>  Documentation/{ =3D> arch}/riscv/hwprobe.rst                    | 0
>  Documentation/{ =3D> arch}/riscv/index.rst                      | 0
>  Documentation/{ =3D> arch}/riscv/patch-acceptance.rst           | 0
>  Documentation/{ =3D> arch}/riscv/uabi.rst                       | 0
>  Documentation/{ =3D> arch}/riscv/vector.rst                     | 0
>  Documentation/{ =3D> arch}/riscv/vm-layout.rst                  | 0
>  Documentation/maintainer/maintainer-entry-profile.rst         | 2 +-
>  Documentation/process/index.rst                               | 2 +-
>  Documentation/translations/it_IT/riscv/patch-acceptance.rst   | 2 +-
>  Documentation/translations/zh_CN/arch/index.rst               | 2 +-
>  .../translations/zh_CN/{ =3D> arch}/riscv/boot-image-header.rst | 4 ++--
>  Documentation/translations/zh_CN/{ =3D> arch}/riscv/index.rst   | 4 ++--
>  .../translations/zh_CN/{ =3D> arch}/riscv/patch-acceptance.rst  | 4 ++--
>  .../translations/zh_CN/{ =3D> arch}/riscv/vm-layout.rst         | 4 ++--
>  .../zh_CN/maintainer/maintainer-entry-profile.rst             | 2 +-
>  MAINTAINERS                                                   | 2 +-
>  arch/riscv/include/uapi/asm/hwprobe.h                         | 2 +-
>  arch/riscv/kernel/sys_riscv.c                                 | 2 +-
>  23 files changed, 17 insertions(+), 17 deletions(-)
>  rename Documentation/{ =3D> arch}/riscv/acpi.rst (100%)
>  rename Documentation/{ =3D> arch}/riscv/boot-image-header.rst (100%)
>  rename Documentation/{ =3D> arch}/riscv/boot.rst (100%)
>  rename Documentation/{ =3D> arch}/riscv/features.rst (100%)
>  rename Documentation/{ =3D> arch}/riscv/hwprobe.rst (100%)
>  rename Documentation/{ =3D> arch}/riscv/index.rst (100%)
>  rename Documentation/{ =3D> arch}/riscv/patch-acceptance.rst (100%)
>  rename Documentation/{ =3D> arch}/riscv/uabi.rst (100%)
>  rename Documentation/{ =3D> arch}/riscv/vector.rst (100%)
>  rename Documentation/{ =3D> arch}/riscv/vm-layout.rst (100%)
>  rename Documentation/translations/zh_CN/{ =3D> arch}/riscv/boot-image-he=
ader.rst (96%)
>  rename Documentation/translations/zh_CN/{ =3D> arch}/riscv/index.rst (79=
%)
>  rename Documentation/translations/zh_CN/{ =3D> arch}/riscv/patch-accepta=
nce.rst (93%)
>  rename Documentation/translations/zh_CN/{ =3D> arch}/riscv/vm-layout.rst=
 (98%)
>=20
> diff --git a/Documentation/arch/index.rst b/Documentation/arch/index.rst
> index 194e7e797877..d27c360e0312 100644
> --- a/Documentation/arch/index.rst
> +++ b/Documentation/arch/index.rst
> @@ -19,7 +19,7 @@ implementation.
>     openrisc/index
>     parisc/index
>     ../powerpc/index
> -   ../riscv/index
> +   riscv/index
>     s390/index
>     sh/index
>     sparc/index
> diff --git a/Documentation/riscv/acpi.rst b/Documentation/arch/riscv/acpi=
=2Erst
> similarity index 100%
> rename from Documentation/riscv/acpi.rst
> rename to Documentation/arch/riscv/acpi.rst
> diff --git a/Documentation/riscv/boot-image-header.rst b/Documentation/ar=
ch/riscv/boot-image-header.rst
> similarity index 100%
> rename from Documentation/riscv/boot-image-header.rst
> rename to Documentation/arch/riscv/boot-image-header.rst
> diff --git a/Documentation/riscv/boot.rst b/Documentation/arch/riscv/boot=
=2Erst
> similarity index 100%
> rename from Documentation/riscv/boot.rst
> rename to Documentation/arch/riscv/boot.rst
> diff --git a/Documentation/riscv/features.rst b/Documentation/arch/riscv/=
features.rst
> similarity index 100%
> rename from Documentation/riscv/features.rst
> rename to Documentation/arch/riscv/features.rst
> diff --git a/Documentation/riscv/hwprobe.rst b/Documentation/arch/riscv/h=
wprobe.rst
> similarity index 100%
> rename from Documentation/riscv/hwprobe.rst
> rename to Documentation/arch/riscv/hwprobe.rst
> diff --git a/Documentation/riscv/index.rst b/Documentation/arch/riscv/ind=
ex.rst
> similarity index 100%
> rename from Documentation/riscv/index.rst
> rename to Documentation/arch/riscv/index.rst
> diff --git a/Documentation/riscv/patch-acceptance.rst b/Documentation/arc=
h/riscv/patch-acceptance.rst
> similarity index 100%
> rename from Documentation/riscv/patch-acceptance.rst
> rename to Documentation/arch/riscv/patch-acceptance.rst
> diff --git a/Documentation/riscv/uabi.rst b/Documentation/arch/riscv/uabi=
=2Erst
> similarity index 100%
> rename from Documentation/riscv/uabi.rst
> rename to Documentation/arch/riscv/uabi.rst
> diff --git a/Documentation/riscv/vector.rst b/Documentation/arch/riscv/ve=
ctor.rst
> similarity index 100%
> rename from Documentation/riscv/vector.rst
> rename to Documentation/arch/riscv/vector.rst
> diff --git a/Documentation/riscv/vm-layout.rst b/Documentation/arch/riscv=
/vm-layout.rst
> similarity index 100%
> rename from Documentation/riscv/vm-layout.rst
> rename to Documentation/arch/riscv/vm-layout.rst
> diff --git a/Documentation/maintainer/maintainer-entry-profile.rst b/Docu=
mentation/maintainer/maintainer-entry-profile.rst
> index 6b64072d4bf2..7ad4bfc2cc03 100644
> --- a/Documentation/maintainer/maintainer-entry-profile.rst
> +++ b/Documentation/maintainer/maintainer-entry-profile.rst
> @@ -101,7 +101,7 @@ to do something different in the near future.
> =20
>     ../doc-guide/maintainer-profile
>     ../nvdimm/maintainer-entry-profile
> -   ../riscv/patch-acceptance
> +   ../arch/riscv/patch-acceptance
>     ../driver-api/media/maintainer-entry-profile
>     ../driver-api/vfio-pci-device-specific-driver-acceptance
>     ../nvme/feature-and-quirk-policy
> diff --git a/Documentation/process/index.rst b/Documentation/process/inde=
x.rst
> index b501cd977053..db09a81d474b 100644
> --- a/Documentation/process/index.rst
> +++ b/Documentation/process/index.rst
> @@ -71,7 +71,7 @@ lack of a better place.
>     volatile-considered-harmful
>     botching-up-ioctls
>     clang-format
> -   ../riscv/patch-acceptance
> +   ../arch/riscv/patch-acceptance
>     ../core-api/unaligned-memory-access
> =20
>  .. only::  subproject and html
> diff --git a/Documentation/translations/it_IT/riscv/patch-acceptance.rst =
b/Documentation/translations/it_IT/riscv/patch-acceptance.rst
> index edf67252b3fb..2d7afb1f6959 100644
> --- a/Documentation/translations/it_IT/riscv/patch-acceptance.rst
> +++ b/Documentation/translations/it_IT/riscv/patch-acceptance.rst
> @@ -1,6 +1,6 @@
>  .. include:: ../disclaimer-ita.rst
> =20
> -:Original: :doc:`../../../riscv/patch-acceptance`
> +:Original: :doc:`../../../arch/riscv/patch-acceptance`
>  :Translator: Federico Vaga <federico.vaga@vaga.pv.it>
> =20
>  arch/riscv linee guida alla manutenzione per gli sviluppatori
> diff --git a/Documentation/translations/zh_CN/arch/index.rst b/Documentat=
ion/translations/zh_CN/arch/index.rst
> index 945b078168b0..71186d9df7c9 100644
> --- a/Documentation/translations/zh_CN/arch/index.rst
> +++ b/Documentation/translations/zh_CN/arch/index.rst
> @@ -10,7 +10,7 @@
> =20
>     mips/index
>     arm64/index
> -   ../riscv/index
> +   ../arch/riscv/index
>     openrisc/index
>     parisc/index
>     loongarch/index
> diff --git a/Documentation/translations/zh_CN/riscv/boot-image-header.rst=
 b/Documentation/translations/zh_CN/arch/riscv/boot-image-header.rst
> similarity index 96%
> rename from Documentation/translations/zh_CN/riscv/boot-image-header.rst
> rename to Documentation/translations/zh_CN/arch/riscv/boot-image-header.r=
st
> index 0234c28a7114..779b5172fe24 100644
> --- a/Documentation/translations/zh_CN/riscv/boot-image-header.rst
> +++ b/Documentation/translations/zh_CN/arch/riscv/boot-image-header.rst
> @@ -1,6 +1,6 @@
> -.. include:: ../disclaimer-zh_CN.rst
> +.. include:: ../../disclaimer-zh_CN.rst
> =20
> -:Original: Documentation/riscv/boot-image-header.rst
> +:Original: Documentation/arch/riscv/boot-image-header.rst
> =20
>  :=E7=BF=BB=E8=AF=91:
> =20
> diff --git a/Documentation/translations/zh_CN/riscv/index.rst b/Documenta=
tion/translations/zh_CN/arch/riscv/index.rst
> similarity index 79%
> rename from Documentation/translations/zh_CN/riscv/index.rst
> rename to Documentation/translations/zh_CN/arch/riscv/index.rst
> index 131e405aa857..3b041c116169 100644
> --- a/Documentation/translations/zh_CN/riscv/index.rst
> +++ b/Documentation/translations/zh_CN/arch/riscv/index.rst
> @@ -1,8 +1,8 @@
>  .. SPDX-License-Identifier: GPL-2.0
> =20
> -.. include:: ../disclaimer-zh_CN.rst
> +.. include:: ../../disclaimer-zh_CN.rst
> =20
> -:Original: Documentation/riscv/index.rst
> +:Original: Documentation/arch/riscv/index.rst
> =20
>  :=E7=BF=BB=E8=AF=91:
> =20
> diff --git a/Documentation/translations/zh_CN/riscv/patch-acceptance.rst =
b/Documentation/translations/zh_CN/arch/riscv/patch-acceptance.rst
> similarity index 93%
> rename from Documentation/translations/zh_CN/riscv/patch-acceptance.rst
> rename to Documentation/translations/zh_CN/arch/riscv/patch-acceptance.rst
> index d180d24717bf..c8eb230ca8ee 100644
> --- a/Documentation/translations/zh_CN/riscv/patch-acceptance.rst
> +++ b/Documentation/translations/zh_CN/arch/riscv/patch-acceptance.rst
> @@ -1,8 +1,8 @@
>  .. SPDX-License-Identifier: GPL-2.0
> =20
> -.. include:: ../disclaimer-zh_CN.rst
> +.. include:: ../../disclaimer-zh_CN.rst
> =20
> -:Original: Documentation/riscv/patch-acceptance.rst
> +:Original: Documentation/arch/riscv/patch-acceptance.rst
> =20
>  :=E7=BF=BB=E8=AF=91:
> =20
> diff --git a/Documentation/translations/zh_CN/riscv/vm-layout.rst b/Docum=
entation/translations/zh_CN/arch/riscv/vm-layout.rst
> similarity index 98%
> rename from Documentation/translations/zh_CN/riscv/vm-layout.rst
> rename to Documentation/translations/zh_CN/arch/riscv/vm-layout.rst
> index 91884e2dfff8..4b9f4dcf6c19 100644
> --- a/Documentation/translations/zh_CN/riscv/vm-layout.rst
> +++ b/Documentation/translations/zh_CN/arch/riscv/vm-layout.rst
> @@ -1,7 +1,7 @@
>  .. SPDX-License-Identifier: GPL-2.0
> -.. include:: ../disclaimer-zh_CN.rst
> +.. include:: ../../disclaimer-zh_CN.rst
> =20
> -:Original: Documentation/riscv/vm-layout.rst
> +:Original: Documentation/arch/riscv/vm-layout.rst
> =20
>  :=E7=BF=BB=E8=AF=91:
> =20
> diff --git a/Documentation/translations/zh_CN/maintainer/maintainer-entry=
-profile.rst b/Documentation/translations/zh_CN/maintainer/maintainer-entry=
-profile.rst
> index a1ee99c4786e..0f5acfb1012e 100644
> --- a/Documentation/translations/zh_CN/maintainer/maintainer-entry-profil=
e.rst
> +++ b/Documentation/translations/zh_CN/maintainer/maintainer-entry-profil=
e.rst
> @@ -89,4 +89,4 @@
> =20
>     ../doc-guide/maintainer-profile
>     ../../../nvdimm/maintainer-entry-profile
> -   ../../../riscv/patch-acceptance
> +   ../../../arch/riscv/patch-acceptance
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 208cfcc1aee3..863ba7e0123c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18533,7 +18533,7 @@ L:	linux-riscv@lists.infradead.org
>  S:	Supported
>  Q:	https://patchwork.kernel.org/project/linux-riscv/list/
>  C:	irc://irc.libera.chat/riscv
> -P:	Documentation/riscv/patch-acceptance.rst
> +P:	Documentation/arch/riscv/patch-acceptance.rst
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
>  F:	arch/riscv/
>  N:	riscv
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/u=
api/asm/hwprobe.h
> index 006bfb48343d..d43e306ce2f9 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -10,7 +10,7 @@
> =20
>  /*
>   * Interface for probing hardware capabilities from userspace, see
> - * Documentation/riscv/hwprobe.rst for more information.
> + * Documentation/arch/riscv/hwprobe.rst for more information.
>   */
>  struct riscv_hwprobe {
>  	__s64 key;
> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
> index 473159b5f303..b651ec698a91 100644
> --- a/arch/riscv/kernel/sys_riscv.c
> +++ b/arch/riscv/kernel/sys_riscv.c
> @@ -79,7 +79,7 @@ SYSCALL_DEFINE3(riscv_flush_icache, uintptr_t, start, u=
intptr_t, end,
> =20
>  /*
>   * The hwprobe interface, for allowing userspace to probe to see which f=
eatures
> - * are supported by the hardware.  See Documentation/riscv/hwprobe.rst f=
or more
> + * are supported by the hardware.  See Documentation/arch/riscv/hwprobe.=
rst for more
>   * details.
>   */
>  static void hwprobe_arch_id(struct riscv_hwprobe *pair,
> --=20
> 2.41.0
>=20

--yyJILPRGEs0APJsw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRrEtQAKCRB4tDGHoIJi
0nrbAQDt+tijrtXHvRrRVExbW8E394V2d3fuesA3s5gWsmMhTQD7BPgN+CDXM6L5
JA9U4cUnXWiRYkikQn1VtlMF1oHF3Qk=
=FMgc
-----END PGP SIGNATURE-----

--yyJILPRGEs0APJsw--
