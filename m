Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6917B77BD63
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjHNPrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjHNPrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:47:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6CF10CE;
        Mon, 14 Aug 2023 08:47:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62AF663DE9;
        Mon, 14 Aug 2023 15:47:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6EF6C433C7;
        Mon, 14 Aug 2023 15:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692028038;
        bh=6GSu3pjMz8Et0gMkn69TwZo/5r8JBRUlijAeo9TCKPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E7Uf5C86CtHU5Ihf+elugH9Uxu+wt/novAeYIKjE2rBf8m4HRQIQRZssm4qloO/BC
         ot07osQfYkSDampv4CSumUWSQfgO0J+O5OPm8un5qIg9tF5SlcUJWh59vZn/RFiV96
         nMTFNBsbTSmGRn+J4e59P/ZZ+z4loH4HDD+VTmsJkvn/JvDi6wLmksVWnL8vUOrFcK
         30nj5BtTQVY37WuTtV0I4IDcwlxCsx2aKGBw8rV6Xhweka1eLOZU0A44ffD5/bW3db
         IjiSsqKXnNoItFl9uqcOZQ0RYKHA1b/7ULWlWZdT9uOEYLkTl5hSYeJZk/80vRAWEs
         2I8ra6SrjXweA==
Date:   Mon, 14 Aug 2023 16:47:13 +0100
From:   Conor Dooley <conor@kernel.org>
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     Suman Anna <s-anna@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, vigneshr@ti.com, srk@ti.com,
        nm@ti.com
Subject: Re: [PATCH v2] dt-bindings: remoteproc: pru: Add Interrupt property
Message-ID: <20230814-ellipse-backfield-1fd05a2d765e@spud>
References: <20230814095141.3526684-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kH60MhqjYS1JGdzg"
Content-Disposition: inline
In-Reply-To: <20230814095141.3526684-1-danishanwar@ti.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kH60MhqjYS1JGdzg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 03:21:41PM +0530, MD Danish Anwar wrote:
> Add interrupts and interrupt-names protperties for PRU and RTU cores.
>=20
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--kH60MhqjYS1JGdzg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNpMgQAKCRB4tDGHoIJi
0u22AP9QEsPEUyj1AWb0YGo781kJJHa6/Yow29+AedrY1bTlowD/dcj9ziQoP1z+
gyUWVK3hHq1DKUDGRfORHuX4O1yljAE=
=V0Y0
-----END PGP SIGNATURE-----

--kH60MhqjYS1JGdzg--
