Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBC37C6FA6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379009AbjJLNtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347282AbjJLNtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:49:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AC291
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:49:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB551C433C7;
        Thu, 12 Oct 2023 13:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697118552;
        bh=TmOqnjvyOI2L8Zeo6zptoTqnsmqtFR/n+cr6F5E1VIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=urQU7ZEWSZCHSvrvcyNPwgHYzBV5LbkjoMRy3qy6NOSn+hsN07UkhK6aa5K9Kr+PD
         M8GgpxEPL8QT2FAQITy8f3mmN7nNJi/bxLNyIbXHn5ll98FVqHQuLeX0lIiJ04CqcE
         Z5MkBprebVd7xsr0vLf0HPeaLeoC4I0h3vtdeMdR3vO79D+2vbQRlAGHRlmAhdSprE
         /fRxQNIIgmZwG0IRNmIW1LsoNKw0TdnIW3o8vBY9FLER7fGCTrP79bg7l4//XG0YR9
         jwmB9p3Nn9HxINOuUO9icsd0ZH+N4/AO6v2g/SW1/Oi/fB1eImSwcIYmmByQmCFz64
         Clo5tjOEpBYdg==
Date:   Thu, 12 Oct 2023 14:49:07 +0100
From:   Conor Dooley <conor@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>
Subject: Re: [PATCH v1 07/13] dt-bindings: riscv: add Zfh/Zfhmin ISA
 extensions description
Message-ID: <20231012-destiny-saggy-52f9cd1fa1c1@spud>
References: <20231011111438.909552-1-cleger@rivosinc.com>
 <20231011111438.909552-8-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VaxcIaWMAYAGRs6f"
Content-Disposition: inline
In-Reply-To: <20231011111438.909552-8-cleger@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VaxcIaWMAYAGRs6f
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yo,

On Wed, Oct 11, 2023 at 01:14:32PM +0200, Cl=E9ment L=E9ger wrote:
> Add description of Zfh and Zfhmin ISA extensions[1] which can now be
> reported through hwprobe for userspace usage.
>=20
> [1] https://drive.google.com/file/d/1z3tQQLm5ALsAD77PM0l0CHnapxWCeVzP/view
>=20
Same here about using Link: tags.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> Signed-off-by: Cl=E9ment L=E9ger <cleger@rivosinc.com>
> ---
>  .../devicetree/bindings/riscv/extensions.yaml       | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index 4002c65145c9..4c923800d751 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -190,6 +190,19 @@ properties:
>              instructions as ratified at commit 6d33919 ("Merge pull requ=
est #158
>              from hirooih/clmul-fix-loop-end-condition") of riscv-bitmani=
p.
> =20
> +        - const: zfh
> +          description:
> +            The standard Zfh extension for 16-bit half-precision binary
> +            floating-point instructions, as ratified in commit 64074bc (=
"Update
> +            version numbers for Zfh/Zfinx") of riscv-isa-manual.
> +
> +        - const: zfhmin
> +          description:
> +            The standard Zfhmin extension which provides minimal support=
 for
> +            16-bit half-precision binary floating-point instructions, as=
 ratified
> +            in commit 64074bc ("Update version numbers for Zfh/Zfinx") of
> +            riscv-isa-manual.
> +
>          - const: zicbom
>            description:
>              The standard Zicbom extension for base cache management oper=
ations as
> --=20
> 2.42.0
>=20

--VaxcIaWMAYAGRs6f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSf5UwAKCRB4tDGHoIJi
0tr/AQCk7QGlt1DYuTkfC7/Ie/4ZKgXSAGkWae7Uj/vh6N0ZcwEAgktjiAMJzZJZ
tGX7mGWegrW4LYC30dq8Xxa0W/UutQ0=
=gQ6T
-----END PGP SIGNATURE-----

--VaxcIaWMAYAGRs6f--
