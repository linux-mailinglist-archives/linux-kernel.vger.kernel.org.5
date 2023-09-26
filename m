Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23A97AEB5B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 13:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjIZLVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 07:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjIZLVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 07:21:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E020FE5;
        Tue, 26 Sep 2023 04:21:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294EAC433C8;
        Tue, 26 Sep 2023 11:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695727267;
        bh=2gOX8j8Bpd71NS1nna8S7OILwEFx9/Dy2ZBKhdUPq18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=McsDBJMVj8c3f6kYnX2lioUGCa7q6iMN4EWLEPKhIH2VRRiqEphAt87k+hQhDwUcq
         kUX3k1ekJmdKtubXdAM1rK8WKWmfM118k22EOV19/Ysg2T+TjfSS30Bz/iPykXMDCe
         NoYFy9B6TTS2Swvy0pWVgvb5qa9A5L3Egs9dn1bdK5MQSdMGziakGxWB80L/W0WQN7
         SnaJWB5dpRT0EaGjtVL10HDamtaJuja8kqZ52wQ2R3YLwH9jB0dFqdXpGZ9fLiWfAo
         aHakas7kSS0T0DD9lRKcxuy5Cer+t7wRQDZx23iscn5fbwlzaftJRN7PheDqCXwHBX
         XZGkHLnfu/NJA==
Date:   Tue, 26 Sep 2023 13:21:04 +0200
From:   Mark Brown <broonie@kernel.org>
To:     Dhruva Gole <d-gole@ti.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH V2] spi: spi-cadence-quadspi: Fix missing unwind goto
 warnings
Message-ID: <ZRK+oDrT4vaZ0R/G@finisterre.sirena.org.uk>
References: <20230919074658.41666-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zr0gR96YlBjxdIPs"
Content-Disposition: inline
In-Reply-To: <20230919074658.41666-1-d-gole@ti.com>
X-Cookie: You will be misunderstood by everyone.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zr0gR96YlBjxdIPs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2023 at 01:16:59PM +0530, Dhruva Gole wrote:
> The following smatch warnings [0] were recently introduced:
>=20
> drivers/spi/spi-cadence-quadspi.c:1882 cqspi_probe() warn: missing
> unwind goto?

This doesn't apply against current code, please check and resend.

--zr0gR96YlBjxdIPs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUSvqAACgkQJNaLcl1U
h9CHCwf/YwtvEcBjz+vmZvRluOc90Nc9FI7IUAy6vMIeLIfxWxaBIBfgXlNQY3Lg
mwTTTMi2AICvxMjnw1nUDgr+oimHlkbXnUg0oj8+3DE6omvkZNSxvzl8pNMtkF5o
TyX91WYV7M6sq/1QstB3t211s9fiv5YwcDxVdto7lVi8/ZlMT1CKRcn9r8mOVpXC
xoN+La74nbXfrj0WdgF+L7iwtm8HhB8keWc2o0LoyMKHSgz8V5JhUpjPhUkvAM3+
X8dU5gOQU7qPLOGbwj6S5ZyZzsleKfCHjtAS1iQ5oPCEBm9rfEDQGzuAE2EOWI4u
w3CJpXDWrl1ATFYEzA9YzHYxuFg0ig==
=MQUh
-----END PGP SIGNATURE-----

--zr0gR96YlBjxdIPs--
