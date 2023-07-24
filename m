Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5C675FF2A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 20:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjGXSee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 14:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjGXSeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:34:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E81A172B;
        Mon, 24 Jul 2023 11:33:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1FE761388;
        Mon, 24 Jul 2023 18:33:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897FBC433C7;
        Mon, 24 Jul 2023 18:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690223587;
        bh=JISt563IUUY+dlMJ80xr16vHU+lFGUpNq78vQuVOfag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rjq10d8+XoabGQtTtG2oCA4j2WwfKgAZFghShXdx4w9PQXhQ1UEgHxFkAHBwQ6GL/
         RaKQ6pm3lG2p5S5vSJutTfnW9ArbRjFG2A8C7dtz6CeGh54TwOen7gOmrqnYwDaQfq
         vM24g4+lol71HScoo7V+DrLAurkC7U+CCgrsMru77EAupulHnLwOseCsLkI2uvTTp6
         2xExXTc4KaDx9kSQelpJpGTJeI24sL+E+7OJy59WTrSmgvnGjjdYgg2uyDsv/Q5adW
         Pha6Qj1rSiz2w5zNM4h7nD6mUibTLliiAFX61LWc2rZV1hJuYmZLrEYhxjYkjmI4SY
         jWZFmnajCycDQ==
Date:   Mon, 24 Jul 2023 19:33:02 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: change TH1520 files to dual license
Message-ID: <20230724-launch-whole-39fb304bd72a@spud>
References: <20230724182129.843687-1-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cyzpousSpwWFGzKR"
Content-Disposition: inline
In-Reply-To: <20230724182129.843687-1-dfustini@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cyzpousSpwWFGzKR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2023 at 11:21:29AM -0700, Drew Fustini wrote:
> Modify the SPDX-License-Identifier for dual license of GPL-2.0 OR MIT.
>=20
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> ---
>  arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi | 2 +-
>  arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts      | 2 +-
>  arch/riscv/boot/dts/thead/th1520.dtsi                  | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>=20
> Jisheng Zhang and Guo Ren - I thought I would post this patch based on
> the discussion in the thread about the BeagleV Ahead patches.

Not like my R-b does much in this case, but thanks for doing this,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--cyzpousSpwWFGzKR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZL7D3gAKCRB4tDGHoIJi
0k+1AQCCyHL3tublu6LQEJGFuPY7/m9/V1C1oco0R598IUfouAD/T2YQ9LQ+fDW8
iFOzAKINAeYyRebDB1Bof6F25oOFcQE=
=NWyu
-----END PGP SIGNATURE-----

--cyzpousSpwWFGzKR--
