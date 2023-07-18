Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0115757F39
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjGRORB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjGRORA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:17:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FD8188
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:16:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41B13615CE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 14:16:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE806C433C7;
        Tue, 18 Jul 2023 14:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689689818;
        bh=lf5RNJdaMllIKh3vA5/3iXVbWW1q7JyY/17JolQlshA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s5DEUjwDSPaRWUOWX7T65HTvxlThVAS2KWg21ME7owysxmINFxX0hzDVYoSUbC+hl
         6R3nu/fvk4jmDQ+WknMqu4IAOSNdDIWKY1r1kr4Ij3+9FG0RRmaFcm2Txav5bB0x2A
         l9seExoK9x/TTDaPbT5+LnI8AgK9VfE6YqQot82IuLG/Ry7iYGd56Yum3X2+O6ZO1x
         n4nQw2zS86uJB0d3u220tIk1BArXPty6szt5IYbWIVuLRgLRMx+iYOPXlks3+ztyd1
         0fYgM0ndK5TbnIiXom6AeJIU8fhVH/lRYc2vkGuEO6Umw1gHBeClzj9fXUhXnsuZnJ
         3fuKniq2+qFSA==
Date:   Tue, 18 Jul 2023 15:16:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alina Yu <alina_yu@richtek.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] regulator: rtq2208: Add Richtek RTQ2208 SubPMIC
 driver
Message-ID: <0b956726-f96f-479a-85d1-80b315626a18@sirena.org.uk>
References: <cover.1688569987.git.alina_yu@richtek.com>
 <5fc248e0b2c4d3f59c2af3ec89cc333c8acbc372.1688569987.git.alina_yu@richtek.com>
 <20230718084028.GA24273@linuxcarl2.richtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qhv8UF0xXGP5bWrg"
Content-Disposition: inline
In-Reply-To: <20230718084028.GA24273@linuxcarl2.richtek.com>
X-Cookie: Nothing happens.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qhv8UF0xXGP5bWrg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 18, 2023 at 04:40:28PM +0800, Alina Yu wrote:

> Sorry, not intend to ping, just want to check the current review status.
> Is there any comment about rtq2208-regulator.c

It's not in my queue any more so probably no but I really don't
remember, I guess there was some issue with the DT binding that I was
expecting a respin for.

--Qhv8UF0xXGP5bWrg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS2ntYACgkQJNaLcl1U
h9BacAf8DV5sYZlPvsstFYJ+GAfJYX7Ce///65EQFqnFlT0b9zxUqpQdgPHksJKP
d8khveiwLbkHeqaIhmnk1L8ycrMP1ZsoZ5Hn98BOPqn5Y/+uXs/3991tfD+RaBpm
17SAGXVP3Jh79cGwNGYGA2whJOJUMhstZvoAFQK/+pnL8e5Fawtkq9jMUJk7t+yN
lV2HZu1gFrr4qP0RHQz9qoBaGt7U2AVNDNBcOpA3aOblIqHmcDDm1gafY7TDoZh/
96cY0i4ZDyPeTqq4Bc56wOvQUCrHsXdvDF2x/7wcJf7Iw/dsc9c5zFtTR2y2enRc
ZdU4GZm1h/duGICIM0LoSVqt7UWiLg==
=8HD6
-----END PGP SIGNATURE-----

--Qhv8UF0xXGP5bWrg--
