Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A7480A65D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574111AbjLHO6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574244AbjLHO6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:58:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182971FD2
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 06:57:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB662C433C8;
        Fri,  8 Dec 2023 14:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702047462;
        bh=TsgOtp2pOsKJASjSL0SpYDC+/IYiO1HmXSSM+vE4NQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lH58aO3TmPy8xCYgxgboVNeStd0484h5tzJsVgdEcgqG7LNN2lxHtitjBhWBoM54f
         hmPl7nRZJXx0KRS8fnIpaLKfpKNqN7Ytl5OmIym6CUcefeVkhOEVEI89SOd/+D+Eat
         vlBS1ytUJ3t7F3LHtclec0QhFt4ZVMKeUNpIQyiB4895xmiiWiNq3T0QWd65KINoV4
         fe9QFTQrmr+L/WBiWy4/yTK9k/N6LztqJbV+5HrUaZJs4H5D1D8TL8rRA3jng5Dn0R
         ckJt4oQg0lCEr1KpCeWhO4oFzp9q+UOsC5s2kHaSEO6IxKfemFGLLCMKVBPpBFGJos
         QkYs+5Y3jfjnA==
Date:   Fri, 8 Dec 2023 14:57:35 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Xu Yang <xu.yang_2@nxp.com>
Cc:     Frank.li@nxp.com, will@kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, john.g.garry@oracle.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        linux-imx@nxp.com, mike.leach@linaro.org, leo.yan@linaro.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: perf: fsl-imx-ddr: Add i.MX95
 compatible
Message-ID: <20231208-depress-smuggler-f3069487a067@spud>
References: <20231208085402.2106904-1-xu.yang_2@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="g6Ugyjd58i/GxHWU"
Content-Disposition: inline
In-Reply-To: <20231208085402.2106904-1-xu.yang_2@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g6Ugyjd58i/GxHWU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2023 at 04:53:59PM +0800, Xu Yang wrote:
> i.MX95 has a DDR pmu. This will add a compatible for it.

On v1 we had a discussion because the commit message wasn't clear about
whether or not the device was compatible with existing ones. For some
reason, the v2 patch _removes_ information from the commit message
rather than tries to explain.
This [1] message of yours, that I didn't get a chance to reply to before
you sent this new version, seems to say that there should be an
imx93-ddr-pmu fallback.

Cheers,
Conor.

1 - https://lore.kernel.org/all/DB7PR04MB514668A8B172CD1A2187BC408C84A@DB7P=
R04MB5146.eurprd04.prod.outlook.com/

>=20
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
>=20
> ---
> Changes in v2:
>  - no changes
> ---
>  Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml b/Do=
cumentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
> index e9fad4b3de68..1bc7bf1c8368 100644
> --- a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
> +++ b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
> @@ -20,6 +20,7 @@ properties:
>            - fsl,imx8mn-ddr-pmu
>            - fsl,imx8mp-ddr-pmu
>            - fsl,imx93-ddr-pmu
> +          - fsl,imx95-ddr-pmu
>        - items:
>            - enum:
>                - fsl,imx8mm-ddr-pmu
> --=20
> 2.34.1
>=20

--g6Ugyjd58i/GxHWU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXMu3wAKCRB4tDGHoIJi
0msHAQC3ZQYeL0gyA31spxo+JvqFwsg3GtH4mMo1cFUHmUqmVwEA0tMX5BLYVvc5
WhrU5Nmr3kIsKe82lqZtqJQ2tPHXOQ4=
=wrTE
-----END PGP SIGNATURE-----

--g6Ugyjd58i/GxHWU--
