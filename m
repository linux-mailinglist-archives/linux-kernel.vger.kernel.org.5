Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A813E77CC92
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 14:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235757AbjHOM1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 08:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237246AbjHOM0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 08:26:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42303213E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 05:26:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BE8B629DD
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:25:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C23C433C7;
        Tue, 15 Aug 2023 12:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692102330;
        bh=Nx1FBHvlUA/rdfOClPZHl5CH9zUDq8zeb7VqfMzCNd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a3rNwD2OchDQeGZ2Q4vgdL2cR5X5fMnwOoMqhnFBJ2FtRDcPkzZJTpJsYh6wuGeei
         lf2ppl1Dz2CZLUb84xXQGB9vUWGy2dPx4Q7MPzsYbyNmfUWSeRcMXbYlz5ozI/uCkF
         ltJhyOhk2TOvM3+Fzy9YibVPjDzQZ5a07y0SD8PuePzdeEKb8HzZdcQKvMe+WqBa5w
         I1Cj2B8zmDOg5VrN1epzToNYFo/zMB5C0ZcsvKvw1s7Hurs/320KD+Cpcoj1grNANo
         lnImrvBooqu1gPrn0yMAmZZXEvYVy0V9MnHEXGrpZ8bVOnQU18hc81MMq/8NrspaC4
         8qp/HE1ksv03A==
Date:   Tue, 15 Aug 2023 13:25:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kevin-Lu <kevin-lu@ti.com>
Cc:     peeyush@ti.com, navada@ti.com, baojun.xu@ti.com,
        shenghao-ding@ti.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] MAINTAINERS: Add entries for TEXAS INSTRUMENTS ASoC
 DRIVERS
Message-ID: <b60458ca-a6a0-4a71-a9f7-a9e68d9a9a68@sirena.org.uk>
References: <20230815095631.1655-1-kevin-lu@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OS/czi0XjYVQh/ZC"
Content-Disposition: inline
In-Reply-To: <20230815095631.1655-1-kevin-lu@ti.com>
X-Cookie: Darth Vader sleeps with a Teddywookie.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OS/czi0XjYVQh/ZC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2023 at 05:56:31PM +0800, Kevin-Lu wrote:
> Add the MAINTAINERS entries for TEXAS INSTRUMENTS ASoC DRIVERS.
> ---
> Changes in v1:
> Add maintian team members to support TEXAS INSTRUMENTS AUDIO DRIVER
>=20
> Signed-off-by: Kevin-Lu <kevin-lu@ti.com>
> ---

Your signoff needs to go *above* the --- otherwise it gets removed by
the tooling.

--OS/czi0XjYVQh/ZC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTbbrUACgkQJNaLcl1U
h9Dnnwf/WQcKx45cwFsixWqMXuDdTV92XM4xgOkcHnqoNiiQcO0mlmsGZ22La2NM
nmcPKEJ5jedPf7/g0JMekKt4xKUzdHcSwijVuEC8s8lUtL/ZEwTS6vS7gWJ2hmcU
b4rQbbR2rV/wHAE8ZOKNH1wNPmzsdUcF2VAWu643RDLfDW91WxzQyxGR02FEOIgN
RjbLQ8QlP8A5sw2VK3HLycY1yf7wuGCjkUoyugcr/MCSVXncd3YpI1Z/MUx2wbk9
g/Tf5gNJRD9YpalJZAq+l4coEO00olzxvB0TGFdhb5E4w2BLIs5nN7GQV1FGkMZk
3w+x07TMgUuH0V7OK3XQYuNY51d9dA==
=dkFx
-----END PGP SIGNATURE-----

--OS/czi0XjYVQh/ZC--
