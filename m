Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9D478C8DE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236041AbjH2Pqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbjH2PqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:46:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F76B7;
        Tue, 29 Aug 2023 08:46:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8450F61309;
        Tue, 29 Aug 2023 15:46:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A73C433C8;
        Tue, 29 Aug 2023 15:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693323962;
        bh=g+fBf7Oczwb7k98dyG5RRFI7qLsyFfAITpqjtY5tUAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pFAyjJdGZA2QN+sHEriECF3lFabLoF0BOQAPMTkm51IZsrFENRyyWY0p1im/m5nVt
         jxuUy3rdveqoUzcUPuojuvzEX1Ae2sq4T6z3+ZzwOeJbEub6NZAI/VRi+q23SVWC8w
         GHfOQo4kSAlNEMQPINVDKV1x1qg3A2oPFh6d4/5RYSslZS0DT7gG7a0zpcGed/iaOV
         zl2Eg7P6UXz6DrOSlhXSnL5K4UIFCaVoV4hBTIz6q3Gpt/ZONxPja7wjRkF5Tz7WjX
         jLbkYg5An1RI99CA+gG7cUIgUHuek07p7rsmbA+X70pkNElrxq9iDvT9QoffCQPZpT
         zAeJK2X74gK2w==
Date:   Tue, 29 Aug 2023 16:45:57 +0100
From:   Conor Dooley <conor@kernel.org>
To:     marius.cristea@microchip.com
Cc:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: adc: adding MCP3564 ADC
Message-ID: <20230829-legal-superjet-f992cdab2bd3@spud>
References: <20230829154133.40716-1-marius.cristea@microchip.com>
 <20230829154133.40716-2-marius.cristea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Fh8YD1gMQ1uWprqq"
Content-Disposition: inline
In-Reply-To: <20230829154133.40716-2-marius.cristea@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Fh8YD1gMQ1uWprqq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 29, 2023 at 06:41:32PM +0300, marius.cristea@microchip.com wrot=
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

Did you intentionally drop my reviewed-by that I gave you on v4?

Thanks,
Conor.

--Fh8YD1gMQ1uWprqq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZO4StQAKCRB4tDGHoIJi
0hVPAQC8YBbnuFcKN8jTrBlS4s36dIBiXA0RjWVsokFLobZtUAEA3pPdT/1/mQQe
tHUv3Dh+MKIKcK2e7UB+WBCypa+W0Qk=
=RU46
-----END PGP SIGNATURE-----

--Fh8YD1gMQ1uWprqq--
