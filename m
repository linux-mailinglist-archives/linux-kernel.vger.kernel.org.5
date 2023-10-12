Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DF67C6FB6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378706AbjJLNva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343925AbjJLNv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:51:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6A4B7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:51:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55F4C433C7;
        Thu, 12 Oct 2023 13:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697118687;
        bh=plfB4PpF0b7k0vrWaK38E9O7BeyLgBdbO+/vtChT7ag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cHSQvG6OoRICdYlNvQGCjgpI4P30dxpdBYMOzIAeVWXYBr7qU0mgIW+z5n4PC/adv
         4LVLCTYqvwlXRwmBEgsYhj+LhiAnNYZ9ZHfXZZ0Rp3LczAHN5V8KLbEqsLF0KSoqVL
         44t35/F3gHFjt6fyJGcOGlxy26d182rXzTJqb5T8pl1cDApJYNOTo3O3ccLxiGXKTa
         4clH9QERS87ECum+mez3A8Yh2LV1HTsrwO4UWen/IesbQVqFswDPWc+YV07oWGmImD
         /X8jYu8vALTfixz8EkVzX7CkAoZ5gXgLrDH2eiqIwivoZ3I5NIpXsMftv84OX99umn
         tM+dKni0WvTMQ==
Date:   Thu, 12 Oct 2023 14:51:22 +0100
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
Subject: Re: [PATCH v1 13/13] dt-bindings: riscv: add Zvfh[min] ISA extension
 description
Message-ID: <20231012-persuader-trombone-ea184e2c996c@spud>
References: <20231011111438.909552-1-cleger@rivosinc.com>
 <20231011111438.909552-14-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="q1HKiMXXfc9zP6aG"
Content-Disposition: inline
In-Reply-To: <20231011111438.909552-14-cleger@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q1HKiMXXfc9zP6aG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2023 at 01:14:38PM +0200, Cl=E9ment L=E9ger wrote:
> Add description for Zvfh[min] ISA extension[1] which can now be
> reported through hwprobe for userspace usage.
>=20
> [1] https://drive.google.com/file/d/1_Yt60HGAf1r1hx7JnsIptw0sqkBd9BQ8/view

And once more, the same.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

>=20
> Signed-off-by: Cl=E9ment L=E9ger <cleger@rivosinc.com>
> ---
>  .../devicetree/bindings/riscv/extensions.yaml        | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index 70c2b0351357..ae7db420ab92 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -277,6 +277,18 @@ properties:
>              instructions, as ratified in commit 56ed795 ("Update
>              riscv-crypto-spec-vector.adoc") of riscv-crypto.
> =20
> +        - const: zvfh
> +          description:
> +            The standard Zvfh extension for vectored half-precision
> +            floating-point instructions, as ratified in commit e2ccd05
> +            ("Remove draft warnings from Zvfh[min]") of riscv-v-spec.
> +
> +        - const: zvfhmin
> +          description:
> +            The standard Zvfhmin extension for vectored minimal half-pre=
cision
> +            floating-point instructions, as ratified in commit e2ccd05
> +            ("Remove draft warnings from Zvfh[min]") of riscv-v-spec.
> +
>          - const: zvkb
>            description:
>              The standard Zvkb extension for vector cryptography bit-mani=
pulation
> --=20
> 2.42.0
>=20

--q1HKiMXXfc9zP6aG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSf52gAKCRB4tDGHoIJi
0mXXAP43q831cMUYHEY7AgTTsOLdDdb5y1qIiBeSmb/No72uMQD/RN79QBvdM4vk
D77qY5QM22vPcXkhV13vkJ9bkp5bdAQ=
=83WE
-----END PGP SIGNATURE-----

--q1HKiMXXfc9zP6aG--
