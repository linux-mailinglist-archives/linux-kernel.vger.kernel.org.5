Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EF07C5B33
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbjJKSWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbjJKSWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:22:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1EF93;
        Wed, 11 Oct 2023 11:22:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C32C433C7;
        Wed, 11 Oct 2023 18:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697048567;
        bh=fUXzntWhuCY5Yuv0MdvtUSnj+oJW8Yotexf7R7sFNxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SXIRSaaRIIMJDs08kxtuRVZD9lnbutsgYhpmZYs22HhvSXJVOL8lcMp2X/kjIFwiq
         APdG+E6cxE54BnUoFnlWOrgRcRmWOWDporGhcl3qddF6U18IGBhAWxEL8UfWtQ0oL5
         P5vBvcFh4HUg+Shl0QK2sAYWU7KUP6tUG/+32L/4WSZ1hdNxtiwPq2mXgLJ2tWDHPi
         mYL6HzuEwCZIM28UnoIMC/xoBOxYQdcinjd9FsBOeNw+CQx9UCLSCvdP6p/8aXkN2Q
         EoSltE1B/Gxo7UqSau6/1dLdbaEAHOO/Kb2iFuwWTZE1wH+W8gETB1ngeiXVKlnQQM
         L8CG9zs3qmdUg==
Date:   Wed, 11 Oct 2023 19:22:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Saravanan Sekar <saravanan@linumiz.com>
Cc:     sravanhome@gmail.com, lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux@roeck-us.net, jdelvare@suse.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v4 2/4] regulator: dt-bindings: Add mps,mpq2286
 power-management IC
Message-ID: <2cf8bd40-91ac-40a7-b4e2-81c6ed3bda03@sirena.org.uk>
References: <20231011164754.449399-1-saravanan@linumiz.com>
 <20231011164754.449399-3-saravanan@linumiz.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5YXomjJOCPp4DvV7"
Content-Disposition: inline
In-Reply-To: <20231011164754.449399-3-saravanan@linumiz.com>
X-Cookie: What an artist dies with me!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5YXomjJOCPp4DvV7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 11, 2023 at 10:17:52PM +0530, Saravanan Sekar wrote:
> Document mpq2286 power-management IC.

Acked-by: Mark Brown <broonie@kernel.org>

--5YXomjJOCPp4DvV7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUm5/EACgkQJNaLcl1U
h9DVPgf5AWf+DSAKpx7Awx6Eh/ID8ihQMrz4iLKlNghPofKGNGFiufvP1GLwXyJu
4t8VK/uK8UYqnR/o1/zbJN/5jTmWCJFJug6VRgSO/pxb3OEPJs7UdBL4nxt/5YWx
fAtEpAAoryXLBc19PiAg3srLX+R+/Jc9YqNc9z3DrheE/mAoJgyctnJHrzQNVDdZ
MnkbNI0+7Pnab8JVJ0IS5SwI23ymBjiP6NwP7TLIKp73CxcIZl2WLXYt7kDFzj60
Ek0LBkZ0rX9zbXcZv9sLuMtK84ZM2B69eSprho6cnUKTKy79kd7e3Gr0Gjom19y2
CbD9qY4KeYB1Ok4NmYCnataTI/AzVA==
=+K6h
-----END PGP SIGNATURE-----

--5YXomjJOCPp4DvV7--
