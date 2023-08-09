Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27083776AF4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 23:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjHIV1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 17:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjHIV1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 17:27:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE1A1BF7;
        Wed,  9 Aug 2023 14:27:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F092364A3E;
        Wed,  9 Aug 2023 21:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2209BC433C8;
        Wed,  9 Aug 2023 21:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691616454;
        bh=K9TbPPBi9E1FP8KcEzKHe8YW64FFM8nkSehGDUFIHEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fPMhmNVkizZCtseVTQmHoLpBRz+NjAKDnJX698tRFWXXz+kwEKLORq+Bw6ciQWTQ5
         G+Ss77XVXCgRgH1ovqB6l8L9gwr0hLuyOW8QxiydPX4Jt/pc2Z45RfOm3PD0xhWNLV
         /TrH4CHhTgOzzDk1c1XzK0NFO/ULGcqDpkdUumx1zLEcSsjiViHwGDil8u6kDhb1UV
         /k5U8FdXy54G3qhVVIZEZzWpVSct3nQWEKT1KpRkCOBWwW+19vkouZ4nYFqPuiqG1S
         BZwvDzQmzJ3TdP8b40UdgpIUZQPuwOxxorr16mVNWJj87z8nfHn97u7dj3TiL7JPKm
         uTWR3HMNnSdTQ==
Date:   Wed, 9 Aug 2023 22:27:29 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: soc: ti: k3-ringacc: Describe cfg reg
 region
Message-ID: <20230809-letdown-fretted-0210aee28452@spud>
References: <20230809175932.2553156-1-vigneshr@ti.com>
 <20230809175932.2553156-2-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qMMx1qc6mc80wG3j"
Content-Disposition: inline
In-Reply-To: <20230809175932.2553156-2-vigneshr@ti.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qMMx1qc6mc80wG3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 09, 2023 at 11:29:31PM +0530, Vignesh Raghavendra wrote:
> RINGACC module on K3 SoCs have CFG register region which is usually
> configured by a Device Management firmware. But certain entities such as
> bootloader (like U-Boot) may have to access them directly. Describe this
> region in the binding documentation for completeness of module
> description.
>=20
> Keep the binding compatible with existing DTS files by requiring first
> four regions to be present at least.
>=20
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--qMMx1qc6mc80wG3j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNQEwQAKCRB4tDGHoIJi
0tuBAQD+kbyrlg9rB54uCmu9zM7nxlMZ3ypg96/eehu9Lro20AD/achmjCAruAfz
cR5c2Cs92zQ3Z417xou19PIpsvfhbA0=
=T9IH
-----END PGP SIGNATURE-----

--qMMx1qc6mc80wG3j--
