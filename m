Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5307800F90
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 17:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjLAPqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjLAPqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:46:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D722D194
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 07:46:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212B9C433C9;
        Fri,  1 Dec 2023 15:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701445584;
        bh=0a5xvA+EE/HD2de4oTACqSgMGZmPpL1HYg7E91OIbjo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kpkGqEahS7E0OW2nucL/ztL6qJKWQx0MxMxLmZAdDDfZ89ofp2IjPwIA5I6aGAPjV
         CjesnHpkG/h8E6KJ9BsmnDCk2q+sxtS6cbKYUor+MIJ59zFh7Clb/cotQ+EjuNsZ2s
         PocD6TcHSUChgpIJa4Cu9/P1bvYm44vaRaRGMKkTvBTAABQ7NxL4RtxitFOhs5Shta
         6+eSxDgts1UMKBkdy1Rxrgxo0yeqUqt353LJPLcvck4fzM6UjHiYqm2LZlZcmXztxB
         mWLmQ6vfKy4eRBPu60CDjcIZn33jvcfmHFToypG8qpcBqEQjqxY1rH04mudpa/UWDE
         L6ITLblOSO8ZA==
Date:   Fri, 1 Dec 2023 15:46:17 +0000
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
Subject: Re: [PATCH v3 5/6] dt-bindings: serial: cdns: Add new compatible
 string for StarFive JH8100 UART
Message-ID: <20231201-retrace-unruffled-b755da60912e@spud>
References: <20231201121410.95298-1-jeeheng.sia@starfivetech.com>
 <20231201121410.95298-6-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="b6G910+EpcX16ELw"
Content-Disposition: inline
In-Reply-To: <20231201121410.95298-6-jeeheng.sia@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b6G910+EpcX16ELw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2023 at 08:14:09PM +0800, Sia Jee Heng wrote:
> Add new compatible string for UART in the StarFive JH8100 SoC.
>=20
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/serial/cdns,uart.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.yaml b/Do=
cumentation/devicetree/bindings/serial/cdns,uart.yaml
> index e35ad1109efc..07732ae60007 100644
> --- a/Documentation/devicetree/bindings/serial/cdns,uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
> @@ -12,6 +12,9 @@ maintainers:
>  properties:
>    compatible:
>      oneOf:
> +      - items:
> +          - const: starfive,jh8100-uart
> +          - const: cdns,uart-r1p8
>        - description: UART controller for Zynq-7xxx SoC
>          items:
>            - const: xlnx,xuartps
> --=20
> 2.34.1
>=20

--b6G910+EpcX16ELw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWn/yQAKCRB4tDGHoIJi
0k/0AQDtPnPwSdRJ029ZXgtTtqL+qNU1ejsQjcuMF0cVd85EHAEAxwLKjgVy43m6
Uy3JksLeRxTyyf4uxKhbKdlCsPTjTQw=
=8FHo
-----END PGP SIGNATURE-----

--b6G910+EpcX16ELw--
