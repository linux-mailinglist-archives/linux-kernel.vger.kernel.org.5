Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A7B7FF627
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjK3QfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjK3QfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:35:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD3E1A4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:35:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2514DC433C7;
        Thu, 30 Nov 2023 16:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701362112;
        bh=4F84RwjlB9iRgUGGooUK/h51rT4q/jQ9DxBI0GL7X3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e1Xe6LdBbc/vXQBJiz1UVPS09eoRnptp4TGoJNsQDsa8FQyHYOVuViYLPfaODNDGT
         Nsf95+FLT6aCOHk59YMHn+B64fpc5ofQ8Xzm7kcDI0YSe06j8GT+Et7RE0OOpa3sY7
         d/34yAiYl+XhbNNZm9IlZCIhtYe5kCOBrWRPhE8V005CUiIv8kNuby5r8UPR/r5hfh
         FsKQAKTLp2JSfoHcqDy0hqCqGIyBVUS5VVRJeoM6pIkZZXhWBs3d/NP2ZhWU1P0tGL
         2wH9Gg301TjqjQDtVsPKOsoJtjvGGffqw5ugqQkFV/O47w9Bbm3f5wEe6k5UDRtW1x
         SaqFLAxM3pDqw==
Date:   Thu, 30 Nov 2023 16:35:08 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Subject: Re: linux-next: Tree for Nov 22 (riscv: DMA_GLOBAL_POOL)
Message-ID: <20231130-mothproof-tripod-fe35364591ee@spud>
References: <20231122145257.6f668afa@canb.auug.org.au>
 <24942b4d-d16a-463f-b39a-f9dfcb89d742@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9Ll85g90yOGMJeXA"
Content-Disposition: inline
In-Reply-To: <24942b4d-d16a-463f-b39a-f9dfcb89d742@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9Ll85g90yOGMJeXA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 02:37:43PM -0800, Randy Dunlap wrote:
>=20
>=20
> On 11/21/23 19:52, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > Changes since 20231121:
> >=20
>=20
> on riscv 32-bit:
>=20
> WARNING: unmet direct dependencies detected for DMA_GLOBAL_POOL
>   Depends on [n]: !ARCH_HAS_DMA_SET_UNCACHED [=3Dn] && !DMA_DIRECT_REMAP =
[=3Dy]
>   Selected by [y]:
>   - ARCH_R9A07G043 [=3Dy] && SOC_RENESAS [=3Dy] && RISCV [=3Dy] && NONPOR=
TABLE [=3Dy] && RISCV_ALTERNATIVE [=3Dy] && !RISCV_ISA_ZICBOM [=3Dn] && RIS=
CV_SBI [=3Dy]
>=20
> WARNING: unmet direct dependencies detected for DMA_GLOBAL_POOL
>   Depends on [n]: !ARCH_HAS_DMA_SET_UNCACHED [=3Dn] && !DMA_DIRECT_REMAP =
[=3Dy]
>   Selected by [y]:
>   - ARCH_R9A07G043 [=3Dy] && SOC_RENESAS [=3Dy] && RISCV [=3Dy] && NONPOR=
TABLE [=3Dy] && RISCV_ALTERNATIVE [=3Dy] && !RISCV_ISA_ZICBOM [=3Dn] && RIS=
CV_SBI [=3Dy]

DMA_DIRECT_REMAP is selected by the T-HEAD CMO erratum.
DMA_GLOBAL_POOL by the Andes CMO erratum.

We could do

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 0071864c2111..d8723fdf1e55 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -339,6 +339,7 @@ if RISCV
=20
 config ARCH_R9A07G043
 	bool "RISC-V Platform support for RZ/Five"
+	depends on !DMA_DIRECT_REMAP
 	depends on NONPORTABLE
 	depends on RISCV_ALTERNATIVE
 	depends on !RISCV_ISA_ZICBOM


--9Ll85g90yOGMJeXA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWi5vAAKCRB4tDGHoIJi
0hKkAP4yMmlUllauDrHAD3p5t5OnJr8sCXiBdoS+jS+mf2gItQD9G/aFILUv61m/
9xJePo/tRRfXb4+RUXbYpR2KFHHq+A4=
=leVc
-----END PGP SIGNATURE-----

--9Ll85g90yOGMJeXA--
