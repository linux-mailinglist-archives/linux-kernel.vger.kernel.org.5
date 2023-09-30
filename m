Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F6A7B3FA0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 11:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjI3JHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 05:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjI3JHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 05:07:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D026FBF;
        Sat, 30 Sep 2023 02:07:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E204C433C7;
        Sat, 30 Sep 2023 09:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696064820;
        bh=NwvWD4FEjSotkVVzU+xSvceZ30vpdtls5+cvsV6Lbvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sSVrii61DAFrKdO+1WxEwIcbLL//+XZ+BTon2Za76vf1jSUYf+MR5z1aMA0IaOT6H
         zPvesdJqRIVIb9wFkRzP6+p530959FmnF54CCbPFMT70TMHtjy4bvc8dKhZTQJF2JD
         kD/cKpPWU7cctaAEKSergC+ScvNYTdkqm+3fubPEmoubb4JIzqOOhW8RWCdMd6xMKt
         wn97L2HwCQq2iDMcajP3vCvvz0SqUD9ILcA4aLqPOyfJMZiKrtAI4LjG0K+FR7Mocm
         ahk9KGXJUglcLrQBEa7MDpJPsWHcsDk7fLHloDK8X8Sh35lvkXMJRDrfCmJXQZGKw5
         CQwuNjANLfXBA==
Date:   Sat, 30 Sep 2023 10:06:52 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Costa Shulyupin <costa.shul@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Heiko Carstens <hca@linux.ibm.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Chiu <andy.chiu@sifive.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Charlie Jenkins <charlie@rivosinc.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Wu XiangCheng <bobwxc@email.cn>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, workflows@vger.kernel.org
Subject: Re: [PATCH] docs: move riscv under arch
Message-ID: <20230930-mauve-jargon-0f7760fd262d@spud>
References: <20230928103134.2779459-1-costa.shul@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sN+66oTGhy/xPMul"
Content-Disposition: inline
In-Reply-To: <20230928103134.2779459-1-costa.shul@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sN+66oTGhy/xPMul
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2023 at 01:29:42PM +0300, Costa Shulyupin wrote:
> and fix all in-tree references.
>=20
> Architecture-specific documentation is being moved into Documentation/arc=
h/
> as a way of cleaning up the top-level documentation directory and making
> the docs hierarchy more closely match the source hierarchy.
>=20
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

This doesn't apply to riscv/for-next or next/master, with git
complaining about the sha1 being lacking or useless. What does this
actually apply to?

Thanks,
Conor.

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
> index 837d7e78606a..3f9962e45c09 100644
> --- a/Documentation/arch/index.rst
> +++ b/Documentation/arch/index.rst
> @@ -19,7 +19,7 @@ implementation.
>     openrisc/index
>     parisc/index
>     powerpc/index
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
> index 283a60458d36..71f038c40f48 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18498,7 +18498,7 @@ L:	linux-riscv@lists.infradead.org
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

--sN+66oTGhy/xPMul
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRflLAAKCRB4tDGHoIJi
0nnKAP9wpqaCYSXogu/JFhxGkh09m0LnCoCVNhqoyNWQhsfhugD/b2nuroLNTFob
lKna+n5ZIT4NbH3xnLcBYkAPCJKq0AI=
=ElGM
-----END PGP SIGNATURE-----

--sN+66oTGhy/xPMul--
