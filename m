Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E7D7D3668
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 14:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjJWMZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 08:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjJWMZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 08:25:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103A4100;
        Mon, 23 Oct 2023 05:25:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCAEC433C8;
        Mon, 23 Oct 2023 12:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698063930;
        bh=pPk74+A5jkmqRdGnbaBEtM5+7L3q3Pdzznl2EygyWmg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jADyhn3KDxsVw0aQWNmTregKnwEQBXXcSO49wnCXUkat73pY1hI6KtDnDFQm34yNX
         7MvHRIx6WL0/cr0s+SK8wS+umGybz2ywN6GuGJC+h5cwD6EifeF5Yk9iUAbDHVrZiZ
         M9PM0A47pVnRQOKjDrbDLohtInrVJPP7UBLYPglWs/N3lKwNjGeI9gTbM1/uFN1TVs
         1hIkOP53y97pl2AyOOlYg6AqlBMutyS5PsKih/qqjwfPluxI3+/TVLtL85yMRfmOQD
         5YTDUdsWTh2M5gRS7LH1ewaNVErSW7f16kdbtGU1DJ2meXbo2aUH1AJFHtx5XHAOAw
         Mp0AjZVVBiRIw==
Date:   Mon, 23 Oct 2023 13:25:19 +0100
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
        wens@csie.org, will@kernel.org, ycliang@andestech.com
Subject: Re: [RFC PATCH v3 RESEND 09/13] dt-bindings: riscv: Add T-Head PMU
 extension description
Message-ID: <20231023-facility-phonebook-1be493346bf1@spud>
References: <20231023004100.2663486-1-peterlin@andestech.com>
 <20231023004100.2663486-10-peterlin@andestech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qxXWr68G1YeFpESf"
Content-Disposition: inline
In-Reply-To: <20231023004100.2663486-10-peterlin@andestech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qxXWr68G1YeFpESf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 08:40:56AM +0800, Yu Chien Peter Lin wrote:
> Document the ISA string for T-Head performance monitor extension
> which provides counter overflow interrupt mechanism.
>=20
> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> ---
> Changes v2 -> v3:
>   - New patch
> ---
>  Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index cc1f546fdbdc..5e9291d258d5 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -246,5 +246,11 @@ properties:
>              in commit 2e5236 ("Ztso is now ratified.") of the
>              riscv-isa-manual.
> =20
> +        - const: xtheadpmu
> +          description:
> +            The T-Head performance monitor extension for counter overflo=
w. For more
> +            details, see the chapter 12 in the Xuantie C906 user manual.
> +            https://github.com/T-head-Semi/openc906/tree/main/doc

This really needs to be linked off to a specific version of the document,
lest there be revisions that remove the document from the repository and
to one that is in English.

Cheers,
Conor.


> +
>  additionalProperties: true
>  ...
> --=20
> 2.34.1
>=20

--qxXWr68G1YeFpESf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTZmLwAKCRB4tDGHoIJi
0mvTAP9Q91MnqFwF0cSPMA8pl6M5OOys/V88dfOQPFy4pUXhywEA/H8ZjdArLD56
bf3grpubAS0ckkD2IOWbV6DHx3P86AQ=
=TH1A
-----END PGP SIGNATURE-----

--qxXWr68G1YeFpESf--
