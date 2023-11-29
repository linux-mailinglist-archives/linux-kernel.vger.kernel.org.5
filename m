Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3D37FDA39
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbjK2Oql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbjK2Oq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:46:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782471731
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:46:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FC2C433C8;
        Wed, 29 Nov 2023 14:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701269165;
        bh=AS/6F864rQJoy0jd7IJxC8rKYScfP+Im0dnqLTD1LM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GVmbiXHDls+kb7E3ub5RkxLvadV56N5O0c1DYZDUZTi0X9wkuf01JJEqBzB7z5vw8
         Thk2jMhtqrmx316XEnWyrM2+AE2WG1kH4L6yL7Eb+jTiGzzSQDd4wCY4jFqx5OWMqo
         Evnsujym0A8r3+XeqbcH+4TXsWqLKfi9Da2mEbIn4909GFQY4GtSvEGPySJyqOCeAE
         Y+w0TJ2NRj/m9mXpXU4MieehhRcOAC7AGnVTN5mEoOcyXwodB7Zwk2OF9+wJzINgAw
         HB/wTA+fuW/bMcvEmW1vy622+k+ct2I6dBtT5JMTS0hl+G7Sljl+U0v7mivzsclcLm
         F/qu4qnrHIZBw==
Date:   Wed, 29 Nov 2023 14:45:58 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc:     kernel@esmil.dk, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, krzk@kernel.org,
        conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, daniel.lezcano@linaro.org,
        tglx@linutronix.de, anup@brainfault.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        michal.simek@amd.com, michael.zhu@starfivetech.com,
        drew@beagleboard.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        leyfoon.tan@starfivetech.com
Subject: Re: [PATCH v2 1/6] dt-bindings: riscv: Add StarFive Dubhe compatibles
Message-ID: <20231129-revisit-prefix-5327168e91f3@spud>
References: <20231129060043.368874-1-jeeheng.sia@starfivetech.com>
 <20231129060043.368874-2-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EUvI/cSgkBgk0Ae7"
Content-Disposition: inline
In-Reply-To: <20231129060043.368874-2-jeeheng.sia@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EUvI/cSgkBgk0Ae7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 02:00:38PM +0800, Sia Jee Heng wrote:
> Add new compatible strings for Dubhe-80 and Dubhe-90. These are
> RISC-V cpu core from StarFive Technology and are used in StarFive
> JH8100 SoC.
>=20
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Document=
ation/devicetree/bindings/riscv/cpus.yaml
> index f392e367d673..493972b29a22 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -48,6 +48,8 @@ properties:
>                - thead,c906
>                - thead,c910
>                - thead,c920
> +              - starfive,dubhe-80
> +              - starfive,dubhe-90

s goes before t.

Cheers,
Conor.

>            - const: riscv
>        - items:
>            - enum:
> --=20
> 2.34.1
>=20

--EUvI/cSgkBgk0Ae7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWdOpgAKCRB4tDGHoIJi
0uVEAP9+aU09s/wTZvSkheUPpKm6rd4yxNAHRKZCriICz4oaigD+PFVwtVTPyqlP
ZIoMEWCwYXrtM7SkFYto5vwuPsLNiwk=
=RbUh
-----END PGP SIGNATURE-----

--EUvI/cSgkBgk0Ae7--
