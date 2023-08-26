Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A8B789666
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 13:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbjHZL5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 07:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbjHZL5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 07:57:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332C21BDA;
        Sat, 26 Aug 2023 04:57:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C649D62118;
        Sat, 26 Aug 2023 11:57:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810BDC433C8;
        Sat, 26 Aug 2023 11:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693051052;
        bh=xpLEl94lz3bAHngyJDKUKnMgh36APQF/M1HRWRQ8NF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DVINOEcU/sQCQXcrV+x89uUUvRQ/9nLb6jd5CdPohv0p6rgh7g1ItEFgMwmhPq8T4
         YhLysA3OVcMDhILPzYZtzdZhhkAUmPZi9a8Kh1oJcWxrv2KClwXRE1S5hr3gnKoCpX
         kYnSXYzcvD0+2jXtINOWVAKIXdXdjrXr/tyatxpQS/ioUQXZj1+jX1+OtTlau7bThR
         VJ4Uz6rRHpiYUOCfQjQbUd8Oy+DK/N4aUEsgySDgUWO8TwzeIROApoBoJz/23xjuuT
         DQvY3xN7W1aooqvaQOqgM7Jpxt4MEOXbFiognf6eWqgetcNmiTlYv8FIZOZlCeHAw5
         NJua2CsZEqKaA==
Date:   Sat, 26 Aug 2023 12:57:26 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Inochi Amaoto <inochiama@outlook.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>, Wei Fu <wefu@redhat.com>,
        Pei Chen <cp0613@linux.alibaba.com>,
        Guo Ren <guoren@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: allwinner: d1: Add PMU event node
Message-ID: <20230826-cubical-publisher-2580c5991069@spud>
References: <20230826-reverse-unroll-a2e0b2365dc1@spud>
 <IA1PR20MB4953161A592F3B8B00596FD0BBE2A@IA1PR20MB4953.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uKHK42U+Ycbmhh8k"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB4953161A592F3B8B00596FD0BBE2A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uKHK42U+Ycbmhh8k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 26, 2023 at 07:25:43PM +0800, Inochi Amaoto wrote:

> >On Sat, Aug 26, 2023 at 04:38:53PM +0800, Inochi Amaoto wrote:
> >> D1 has several pmu events supported by opensbi.
> >> These events can be used by perf for profiling.
> >>
> >> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> >
> >Could you please include a link to some documentation as to where these
> >values came from? I know several people have had some trouble with
> >understanding the pmu DT stuff & having some documentation would make
> >this an in-tree end-to-end example.

> The DT field of riscv,pmu for opensbi can be found on:
> https://github.com/riscv-software-src/opensbi/blob/master/docs/pmu_suppor=
t.md

There's an actual dt-binding for this.

> The value can be found in the R1S0 version of C906 documentation:
> https://dl.linux-sunxi.org/D1/Xuantie_C906_R1S0_User_Manual.pdf
>=20
> The meaning of T-HEAD events can be found in this patch:
> https://lore.kernel.org/linux-perf-users/IA1PR20MB4953DD82D0116EC291C2177=
7BBE2A@IA1PR20MB4953.namprd20.prod.outlook.com
>=20
> The patch above also provides documentation for T-HEAD events and a examp=
le
> that shows how to use perf with T-HEAD events.

What I meant was can you provide links to this in the commit messages so
that people have a way to find the documentation.


--uKHK42U+Ycbmhh8k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOnopgAKCRB4tDGHoIJi
0mSxAQDtF05y6F1rX6ExpSo7biIc/hisr+JfS70x6WEEbFwzAAD+LU33kG3lv3Xg
cDERdlj6Bvj0jstRNYumdBvHal7qpwg=
=CD0N
-----END PGP SIGNATURE-----

--uKHK42U+Ycbmhh8k--
