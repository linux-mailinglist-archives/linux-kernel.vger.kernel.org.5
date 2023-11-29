Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2C47FDB8C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343689AbjK2PeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343556AbjK2PeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:34:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33379D6F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:34:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CA3C433C8;
        Wed, 29 Nov 2023 15:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701272065;
        bh=NDds0U//x3U5dLm8RNoLfCGV6444vjGBb1oXhvGNN/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gGWz/fIEJqq3GbXihGQtbeznsAIgwFjUQsttBkb86C+Addjd8y16Hb4JDOMLFwIDt
         lkM7Xp0xvNaxO3v0HYRQ0C06j9Nq2+KlThujRXUkBLtEbr/AseEmmrSRYOe3ZV9Llm
         hMBmbpk6KAedpeJbrMkH4wx7eL9+t0Ux6ITHkIsy2zlp3HbTyXnHv1emaHmugDcauT
         C2OnAWFRzewr2jW80nhTqMdtsNyOO4LvhVJ4nUseG9rtr4DM+8wPLWi/xyxeQazxco
         Jg7syfPN9XqJxVBMO3aTZvh4UeIFkG3HYZURlbTi7Usx0hMCtsgqum3tEXGXk5C3YX
         GNZ5QptaIOi7w==
Date:   Wed, 29 Nov 2023 15:34:20 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Thomas Richard <thomas.richard@bootlin.com>
Cc:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, u-kumar1@ti.com
Subject: Re: [PATCH 1/5] dt-bindings: arm: keystone: add ti,j7200-sci
 compatible
Message-ID: <20231129-caress-banister-5b5ccbf183e6@spud>
References: <20231129-j7200-tisci-s2r-v1-0-c1d5964ed574@bootlin.com>
 <20231129-j7200-tisci-s2r-v1-1-c1d5964ed574@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gK04LOCo56bJjY2Y"
Content-Disposition: inline
In-Reply-To: <20231129-j7200-tisci-s2r-v1-1-c1d5964ed574@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gK04LOCo56bJjY2Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 04:31:17PM +0100, Thomas Richard wrote:
> On j7200, during suspend to ram the soc is powered-off.
> At resume requested irqs shall be restored which is a different behavior
> from other platforms.
>=20
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--gK04LOCo56bJjY2Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWdZ/AAKCRB4tDGHoIJi
0kf/AP0ZTbNtxuRwCyGVqVjCdAnWLiq7QIYJJ1r6C9hjnpzH+gEAwZQSk1M057wJ
JnIpWdjsgxSsgP9VTogKzDwN5JbEXQI=
=Iq88
-----END PGP SIGNATURE-----

--gK04LOCo56bJjY2Y--
