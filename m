Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429437DD39F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbjJaRAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235538AbjJaQ74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:59:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A396EA6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 09:59:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3984BC433C8;
        Tue, 31 Oct 2023 16:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698771561;
        bh=mKGcn7R4nOzJ/7bvetTvuYzWfcgcPLJRUybDiFHL370=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kpFt7Pbl/emgwe30wMPCOP0nayL4uUkpaxty+FGoSU6Oy3UyNFtDughKPMyw47VZm
         v9dQ1vGg7XMFgwN2lMBFAc9SjWLBQMabMX+gOm30AkRFOpfmXz8C5opwQNk3I1Frwn
         ijxRfF+/8RTY0pHCGVi3BXv94yzBQwbAG32mZo2vysbXyrGpZ8ZjZx9xUx+zSoaqHh
         i1zlb6msZDBg8luJy7L6nsZFrYJuL+9fP3GZV4udCZ5v59GjpMqo1gWgswVvwvYFya
         fwGDtOaNcvIiprfvrkokVVnthRL62s1Ub8m0tdpoDBBBMSUp+YLDnxHxHXK82tDyV8
         MCLmDAbmpFG9Q==
Date:   Tue, 31 Oct 2023 16:59:13 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Iago Toral Quiroga <itoral@igalia.com>
Cc:     dri-devel@lists.freedesktop.org, Maira Canal <mcanal@igalia.com>,
        Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH v3 3/4] dt-bindings: gpu: v3d: Add BCM2712's compatible
Message-ID: <20231031-replace-quit-ecac72d24414@spud>
References: <20231031073859.25298-1-itoral@igalia.com>
 <20231031073859.25298-4-itoral@igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MQiHgOyvs+Jhp68k"
Content-Disposition: inline
In-Reply-To: <20231031073859.25298-4-itoral@igalia.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MQiHgOyvs+Jhp68k
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 08:38:58AM +0100, Iago Toral Quiroga wrote:
> BCM2712, Raspberry Pi 5's SoC, contains a V3D core. So add its specific
> compatible to the bindings.
>=20
> Signed-off-by: Iago Toral Quiroga <itoral@igalia.com>
> Reviewed-by: Ma=EDra Canal <mcanal@igalia.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/gpu/brcm,bcm-v3d.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/gpu/brcm,bcm-v3d.yaml b/Do=
cumentation/devicetree/bindings/gpu/brcm,bcm-v3d.yaml
> index dae55b8a267b..dc078ceeca9a 100644
> --- a/Documentation/devicetree/bindings/gpu/brcm,bcm-v3d.yaml
> +++ b/Documentation/devicetree/bindings/gpu/brcm,bcm-v3d.yaml
> @@ -17,6 +17,7 @@ properties:
>    compatible:
>      enum:
>        - brcm,2711-v3d
> +      - brcm,2712-v3d
>        - brcm,7268-v3d
>        - brcm,7278-v3d
> =20
> --=20
> 2.39.2
>=20

--MQiHgOyvs+Jhp68k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUEyYQAKCRB4tDGHoIJi
0nE7AQCw52kEthThrebujTTdNRQoLFnQMoyxvp6Kqz+KGrkVPgEA76dMVeuKHaHR
yNPSGG+N5t5tbpksMET+arL/A/vbegI=
=6UGw
-----END PGP SIGNATURE-----

--MQiHgOyvs+Jhp68k--
