Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB8378184D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 10:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjHSI0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 04:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjHSI0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 04:26:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B2BA5D2;
        Sat, 19 Aug 2023 01:26:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7B4061632;
        Sat, 19 Aug 2023 08:26:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368A5C433C8;
        Sat, 19 Aug 2023 08:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692433562;
        bh=IqklKkPtidqb2CVW+tpMi5aCC8MPd+5t0OXkV7z/4YU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cSxWLhGjlcFR/25K7tpjKDR7n4q64KfhdItaAPLD/hH0XNTfLeTTHHZ/PLMyVOtoU
         0fhU+gJ8GmTopN4tqd0/Lt3nTeoFOf0xDmMJkwd0aey/vfD8JmY/RB9/0h8YNpko1i
         jvzqZ7mPmG1YRPV16nTQuL0TvtXcTs7j3yc+1+pBw1pI2lXWiF3LR2dz5BmygQEoo+
         Q/iMp4RTMM6BE5H0xUcV6nIqD46fjJ0NvcirPAviW5/xx9x/DUu1wj7Or3d3i6LHj5
         94joCv1NJs7eTfPzU42mHa2MMu6lrq0QD6/intcGi72cKFaq3QHgWAsZ1xsHunIqRw
         8x52cejPbF8jA==
Date:   Sat, 19 Aug 2023 09:25:57 +0100
From:   Conor Dooley <conor@kernel.org>
To:     marius.cristea@microchip.com
Cc:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: adc: adding MCP3564 ADC
Message-ID: <20230819-swimsuit-scallion-9e91ec99b92a@spud>
References: <20230818165750.55406-1-marius.cristea@microchip.com>
 <20230818165750.55406-2-marius.cristea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uKFwu7uCDxw/NwPv"
Content-Disposition: inline
In-Reply-To: <20230818165750.55406-2-marius.cristea@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uKFwu7uCDxw/NwPv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2023 at 07:57:49PM +0300, marius.cristea@microchip.com wrot=
e:
> From: Marius Cristea <marius.cristea@microchip.com>
>=20
> This is the device tree schema for iio driver for
> Microchip family of 153.6 ksps, Low-Noise 16/24-Bit
> Delta-Sigma ADCs with an SPI interface (Microchip's
> MCP3461, MCP3462, MCP3464, MCP3461R, MCP3462R,
> MCP3464R, MCP3561, MCP3562, MCP3564, MCP3561R,
> MCP3562R and MCP3564R analog to digital converters).
>=20
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--uKFwu7uCDxw/NwPv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOB8lQAKCRB4tDGHoIJi
0o3TAPwM74R81vKUiQEtMzW1+og9PDflT/siRzcGXep77V1vPwEA+GkxKH0X5QZJ
tucd4cgqowy/bgIRGcmoE5j14amnlg8=
=QCcD
-----END PGP SIGNATURE-----

--uKFwu7uCDxw/NwPv--
