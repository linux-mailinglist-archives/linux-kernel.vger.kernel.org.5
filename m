Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3104755DC2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 10:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjGQID7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 04:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjGQID6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 04:03:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EC0123
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 01:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689581034; x=1721117034;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kP478oPhO3PO54sMuk0Whiq+DCboJgHaMfLMwkOLgOs=;
  b=iprGMcnPzDaxBOUjvQAx2hWxO5cqwcKLL29Z0K98jI8e7auDUIScJ3WS
   HSrErUcFCKgzptYHBpKDOu6w5+h/M0Z3XRibmxHYIv3YZtStpkRcvlRqP
   oSAgq1Tv/SP1wP/TQtzQHDNugOQ3Y4g1JiuP/3LGF8yZXDuo066X7G37e
   AYUlLswbvEHdOkKI7rGnqZ+TEmic70dLbNy6Fq2AGOOSLxqHguafxXBDv
   E4cHSqnTrZVJylWsHyiMEAhkig/O9hiS1PayzFkoz1ZkrsTTNv6/M2W82
   HH9aT4nYGG3qE0oNTyo/f8hIh9ID+doYeIzPds+5Q/hIty0Fzqtm/oFm0
   g==;
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="asc'?scan'208";a="223401307"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jul 2023 01:03:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 17 Jul 2023 01:03:47 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 17 Jul 2023 01:03:45 -0700
Date:   Mon, 17 Jul 2023 09:03:13 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <hanyu001@208suo.com>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <liaochang1@huawei.com>,
        <heiko.stuebner@vrull.eu>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: kernel: remove space before ')'
Message-ID: <20230717-gummy-frisbee-2f7dbe9f9512@wendy>
References: <tencent_6B88A6697F6AB7CEBD04EEABA52ACDC66909@qq.com>
 <8ef63e3296f5628896f373d696a078f8@208suo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="L/2VYdryjTVOyFzm"
Content-Disposition: inline
In-Reply-To: <8ef63e3296f5628896f373d696a078f8@208suo.com>
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

--L/2VYdryjTVOyFzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Mon, Jul 17, 2023 at 03:48:37PM +0800, hanyu001@208suo.com wrote:
> Fixes checkpatch errors:
>=20
> riscv/kernel/probes:ERROR:space prohibited before that close parenthesis =
')'
> riscv/kernel/probes:ERROR:space prohibited before that close parenthesis =
')'
> riscv/kernel/probes:ERROR:space prohibited before that close parenthesis =
')'
>=20
> Signed-off-by: ztt <1549089851@qq.com>

Checkpatch complaints that this does not match the email you sent the
patch from. "ztt" is not a known identity either, so that's insufficient
for DCO purposes.

Thirdly, the patch is corrupted, with tabs replaced by spaces.
I've seen a lot of "checkpatch -f" fix patches from 208suo.com people
across various subsystems over the last few weeks that are all corrupted
and do not apply. Please don't send any more for arch/riscv until you
figure out how to send them without corruption.

Thanks,
Conor.

> ---
>  arch/riscv/kernel/probes/simulate-insn.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/riscv/kernel/probes/simulate-insn.c
> b/arch/riscv/kernel/probes/simulate-insn.c
> index 7441ac8a6843..60792c79b42e 100644
> --- a/arch/riscv/kernel/probes/simulate-insn.c
> +++ b/arch/riscv/kernel/probes/simulate-insn.c
> @@ -128,10 +128,10 @@ bool __kprobes simulate_auipc(u32 opcode, unsigned
> long addr, struct pt_regs *re
>      (((opcode) >> 12) & 0x7)
>=20
>  #define branch_imm(opcode) \
> -    (((((opcode) >>  8) & 0xf ) <<  1) | \
> +    (((((opcode) >>  8) & 0xf) <<  1) | \
>       ((((opcode) >> 25) & 0x3f) <<  5) | \
> -     ((((opcode) >>  7) & 0x1 ) << 11) | \
> -     ((((opcode) >> 31) & 0x1 ) << 12))
> +     ((((opcode) >>  7) & 0x1) << 11) | \
> +     ((((opcode) >> 31) & 0x1) << 12))
>=20
>  #define branch_offset(opcode) \
>      sign_extend32((branch_imm(opcode)), 12)

--L/2VYdryjTVOyFzm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLT1wAAKCRB4tDGHoIJi
0riRAQC5x0bRrGl6P4BqE7Pp+DOZbmF0X73PbxpL8CQ3OQLu5wD+KlSkbuZfU55K
FyKYxpIKFpgkocwE27cbJKVW9svqQgE=
=iDgp
-----END PGP SIGNATURE-----

--L/2VYdryjTVOyFzm--
