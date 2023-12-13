Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF90881168F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442182AbjLMP1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442523AbjLMPZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:25:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F0FB2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:25:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE5DC433C7;
        Wed, 13 Dec 2023 15:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702481109;
        bh=k3475fUWjt6cqtLAtUFoDPFZz/q8UFyFG6t5hNV1fdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IhEL5Jr+r1wwkykwxdY9oQmsfodd9RscQA12rUVSylaaZzmWiWpnlGhVa+sp+3r7b
         v98l3JDxaUBwRrSzu+mVf2fO350PgvFHe6HkXQltyVGpjer10RytkbZiEdJ1J46xxB
         Rwnd4MPP43z9LtQY4FzMMoqGpyvLzymWkT+GZhRXDFwftlnk0o61XcKDpTOJ4c3VFV
         WJek1HcyaFQE9cN2hOQhehvJFy7ICm8oKjfbFVNg9P51rjkPVfb0+1FG4ftPbraIGI
         h+9bCQ4O85y3TPmEFTZdDXAyKrldhroD8lPJl7ea9llzgrX9j0sI3kcrN2TuQrnLCe
         RPgdAjfZ6EasQ==
Date:   Wed, 13 Dec 2023 15:24:57 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Yu Chien Peter Lin <peterlin@andestech.com>
Cc:     acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com,
        alexander.shishkin@linux.intel.com, andre.przywara@arm.com,
        anup@brainfault.org, aou@eecs.berkeley.edu, atishp@atishpatra.org,
        conor+dt@kernel.org, conor.dooley@microchip.com,
        devicetree@vger.kernel.org, dminus@andestech.com,
        evan@rivosinc.com, geert+renesas@glider.be, guoren@kernel.org,
        heiko@sntech.de, irogers@google.com, jernej.skrabec@gmail.com,
        jolsa@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sunxi@lists.linux.dev, locus84@andestech.com,
        magnus.damm@gmail.com, mark.rutland@arm.com, mingo@redhat.com,
        n.shubin@yadro.com, namhyung@kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, peterz@infradead.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, sunilvl@ventanamicro.com,
        tglx@linutronix.de, tim609@andestech.com, uwu@icenowy.me,
        wens@csie.org, will@kernel.org, ycliang@andestech.com,
        inochiama@outlook.com
Subject: Re: [PATCH v5 15/16] riscv: dts: renesas: Add Andes PMU extension
 for r9a07g043f
Message-ID: <20231213-porous-panic-015409053e1d@spud>
References: <20231213070301.1684751-1-peterlin@andestech.com>
 <20231213070301.1684751-16-peterlin@andestech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CdyUBDMnoeaw9TCE"
Content-Disposition: inline
In-Reply-To: <20231213070301.1684751-16-peterlin@andestech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CdyUBDMnoeaw9TCE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 03:03:00PM +0800, Yu Chien Peter Lin wrote:
> xandespmu stands for Andes Performance Monitor Unit extension.
> Based on the added Andes PMU ISA string, the SBI PMU driver
> will make use of the non-standard irq source.
>=20
> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--CdyUBDMnoeaw9TCE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXnMyQAKCRB4tDGHoIJi
0iyVAQCorZx0jwXEAp2RWyzoTrHFg9KDdgLQHzCY1iV7IeT9DgD/SalZhcE47FKy
2wTkZDKDhXwkKbx9fAYA++KOZn1smA8=
=pQrz
-----END PGP SIGNATURE-----

--CdyUBDMnoeaw9TCE--
