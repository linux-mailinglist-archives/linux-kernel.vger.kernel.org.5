Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC5A755E13
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 10:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjGQIOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 04:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjGQIOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 04:14:48 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A28129
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 01:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689581688; x=1721117688;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GiPwvl5IyiPlcPEFo50ZA45sK7nt5VZx1UMduNOcbOg=;
  b=ONJk6qxb128TUCqG/aQmmSkf8AXz8Eq4MtYspZlzHjEaZYQNkCNjmxur
   DyekhUDzHHzFAn+AR/xt1kcqcifqLSIdgDzAK0QLdtXUFjWlKTGQIbUpB
   FWuC760yv5/8FBGSKIG8zEI1jS5RmP7+QK+z0fArmdSBdXW3bhmEuuEQ5
   30wWV0BsKucwTyW4tNhZxzn/kgAlgjjUfoXiQvPFtrkudFUuwuUH316XJ
   q0n1bI3KTSKClwAvRnEIHnTeA2g1KGdGGOTR6mwe4FJLqhycJqIKvI59a
   IqLaoRNNgDFAYVo1tNYSEv9p4RfaDarR/cj/vrQ25i5A16cH1BeVVyZS7
   w==;
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="asc'?scan'208";a="224157965"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jul 2023 01:14:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 17 Jul 2023 01:14:36 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 17 Jul 2023 01:14:34 -0700
Date:   Mon, 17 Jul 2023 09:14:01 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <hanyu001@208suo.com>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <atishp@rivosinc.com>, <maz@kernel.org>,
        <apatel@ventanamicro.com>, <guoren@kernel.org>,
        <sunilvl@ventanamicro.com>, <ben-linux@fluff.org>,
        <vschneid@redhat.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: kernel: insert space before the open parenthesis
 '('
Message-ID: <20230717-scone-stalemate-ec749798275b@wendy>
References: <tencent_7D5EADDF79970079F568A5C4F801910DED06@qq.com>
 <b90d162c4fb8062355634fb53b05173d@208suo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="U4xOE9QBFvXHxi7W"
Content-Disposition: inline
In-Reply-To: <b90d162c4fb8062355634fb53b05173d@208suo.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--U4xOE9QBFvXHxi7W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Mon, Jul 17, 2023 at 04:06:11PM +0800, hanyu001@208suo.com wrote:
> Fix below checkpatch error:
>=20
> /riscv/kernel/smp.c:93:ERROR: space required before the open parenthesis =
'('
>=20
> Signed-off-by: ztt <1549089851@qq.com>

See:
https://lore.kernel.org/all/20230717-gummy-frisbee-2f7dbe9f9512@wendy/

Also, DKIM is failing for the 208suo address :/

Thanks,
Conor.

> ---
>  arch/riscv/kernel/smp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index 23e533766a49..1454f2415b7f 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -90,7 +90,7 @@ static inline void ipi_cpu_crash_stop(unsigned int cpu,
> struct pt_regs *regs)
>          cpu_ops[cpu]->cpu_stop();
>  #endif
>=20
> -    for(;;)
> +    for (;;)
>          wait_for_interrupt();
>  }
>  #else

--U4xOE9QBFvXHxi7W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLT4SQAKCRB4tDGHoIJi
0nPOAQC0Dfwwdu7s6Z/RZ3lSf0VzTVpe2NTrthyXqwm1LeFymwEAgMiTZZgkfsFl
txpikNMpNCe2vYXJPFx3ozXOLs5fKgc=
=2m/o
-----END PGP SIGNATURE-----

--U4xOE9QBFvXHxi7W--
