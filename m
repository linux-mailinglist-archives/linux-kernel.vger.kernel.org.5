Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661F48116BB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442285AbjLMP3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442347AbjLMP2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:28:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164D61AE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:26:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA69C433CB;
        Wed, 13 Dec 2023 15:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702481199;
        bh=5LrrEvMyyj0fWb6NPjVbblFGe/sJuNAe4eX2ZyX7Kt0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gb6BH7D+aYS61woucg5hbgnpKCFH2JrZe9F7CoamrCJlrRo+15C86NHi2e7T9MoI0
         voFaVtvfZv/m36LPNfwBTmuS+fzS/AZgBTL6y1G5uJKdzX+82fqYVPsguuz4WpGlfR
         1duPZzQ84PZHAjZJENwupiAANqkRbYlKDP8/kc4RZLH/+/VSSctEpbwMMA6dixOzmD
         sDUCEhLqqa6Mke47Dab95s7KYkO0rDF5YbInpc//M4u5vOhFqp/NY6TRGcO2+52gFm
         YH/2i10BIfOinYtmJuflXh8fQo2clkel8PHqG9azTs1GexOFYGdkEgJXJ3+1y3LPLm
         glD3qCYeHihAw==
Date:   Wed, 13 Dec 2023 15:26:28 +0000
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
Subject: Re: [PATCH v5 09/16] dt-bindings: riscv: Add T-Head PMU extension
 description
Message-ID: <20231213-romp-squeegee-0cdb44aff415@spud>
References: <20231213070301.1684751-1-peterlin@andestech.com>
 <20231213070301.1684751-10-peterlin@andestech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7g0vcE0ZONFlAzn3"
Content-Disposition: inline
In-Reply-To: <20231213070301.1684751-10-peterlin@andestech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7g0vcE0ZONFlAzn3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 03:02:54PM +0800, Yu Chien Peter Lin wrote:
> Document the ISA string for T-Head performance monitor extension
> which provides counter overflow interrupt mechanism.
>=20
> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> Reviewed-by: Inochi Amaoto <inochiama@outlook.com>
> ---
> Changes v2 -> v3:
>   - New patch
> Changes v3 -> v4:
>   - No change
> Changes v4 -> v5:
>   - Include Guo's Reviewed-by
>   - Include Inochi's Reviewed-by
>   - Update to C910 documentation with its commit hash
> ---
>  Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index c91ab0e46648..b5cb8ac7ac80 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -258,5 +258,11 @@ properties:
>              in commit 2e5236 ("Ztso is now ratified.") of the
>              riscv-isa-manual.
> =20
> +        - const: xtheadpmu
> +          description:
> +            The T-Head performance monitor extension for counter overflo=
w, as ratified

I'm not sure that "ratified" here is the right word, probably
"documented" is better, but I don't think that is worth a resend.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> +            in commit 4c4981 ("Initial commit") of Xuantie C910 user man=
ual.
> +            https://github.com/T-head-Semi/openc910/tree/main/doc
> +
>  additionalProperties: true
>  ...
> --=20
> 2.34.1
>=20

--7g0vcE0ZONFlAzn3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXnNJAAKCRB4tDGHoIJi
0rGDAQD3aa1sgvZcl2UuyEAdv8hNrEY8UAeOmq4VVREsig79WAEAp7psoeCxBWLM
X4adVORVHKHi9jWmb2mdq7PBBO0wmwE=
=8PPM
-----END PGP SIGNATURE-----

--7g0vcE0ZONFlAzn3--
