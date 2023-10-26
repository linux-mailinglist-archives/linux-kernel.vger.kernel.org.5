Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7B77D8346
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345001AbjJZNHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjJZNHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:07:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDBE12A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:07:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A69C433C8;
        Thu, 26 Oct 2023 13:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698325667;
        bh=qSGCd65c4a2ywTGNmKBPxAzOervWvlfXphWYRv+Cktw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vbc04HxzzJcfmVC9k2MU0Qu5+JTqWNg56/wK/2+OjxSXjcmm9yAQSPCwEEm/wm4ww
         gJaG+lpz9KVk1sYFmFd/BVhKiFUe5Xw9BV+jO+e3Fc60OzwEpIlwDgMoxyka8S5MCD
         ogo687OTyPfvdxevccyAUozcOz3D5i+H9hhsQggfpmimSiInZRl63KtooYiqE6M32r
         N65aw2Y5QmkBJ4pnCIgEixHNaQeL+V3dEXQ/aNpD1FrAdJeoJU3JjW/zsgwwjnPgJJ
         e2U0uXxdSuxnWORFUDXUokmMAHisyeRDZ4nmB2zbcn8it7oacVmwqfABeEzIMFIdZa
         jyBes+CMIzMjQ==
Date:   Thu, 26 Oct 2023 14:07:43 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Chen Wang <unicorn_wang@outlook.com>,
        linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Chao Wei <chao.wei@sophgo.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] riscv: dts: sophgo: remove address-cells from intc
 node
Message-ID: <20231026-legwarmer-triage-1d7922802d3c@spud>
References: <20231024-maternity-slang-fd3dcfb211c0@spud>
 <MA0P287MB0332C00AB091FD7139560E25FEDEA@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
 <ZTkwo/u6S9Atp2u3@xhacker>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JOJ8mdMNXG4ic7El"
Content-Disposition: inline
In-Reply-To: <ZTkwo/u6S9Atp2u3@xhacker>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JOJ8mdMNXG4ic7El
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 11:13:39PM +0800, Jisheng Zhang wrote:

> > Thanks=EF=BC=8Cbtw, will it be merged in 6.7?
>=20
> Don't worry, this is a fix, I think Conor will submit fix PR once rc1 is =
out.

Yup. There's no harmful affects at runtime, it's just a fix for some
dtbs_check warnings that I noticed in linux-next. I'll send it as part
of a fixes PR at some point after -rc1.

Cheers,
Conor.

--JOJ8mdMNXG4ic7El
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTpkngAKCRB4tDGHoIJi
0kqzAQCPFN41153Z1rGXO4AV7wGoq0T9lxUJ+9MShBAU+o4twQD9HNOLnVtbXTpc
EV2FeKUNpZ5UeTA2QQZJ4tMLyqS9rQM=
=hscr
-----END PGP SIGNATURE-----

--JOJ8mdMNXG4ic7El--
