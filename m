Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCA97B0494
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjI0Mph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjI0Mpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:45:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BC7C0;
        Wed, 27 Sep 2023 05:45:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7078C433C8;
        Wed, 27 Sep 2023 12:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695818734;
        bh=3hrngeipW8QYxZDrT1J17sJTEycYuyG8C4Hf6g4f9mk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hz53PaQiWaKZ/1Zs1EME4EwCfBwffMjO/IjsKksewWqoLHutiYc6XcRIj9MYLYPOJ
         JE46L46NLZjr3fVz3pnh6cB6RzGHdJzrZJJVyUeTKig7geGpJ/2x2pVINuZ+5dNXmA
         zMNSdGYiOLJHin3kXKixuL8pvLjIQExHt9swOF7zRbdolSven+ki/OY4thj3Ne5zl0
         HDrzzPayoA8zjQDIbDX9QSg7wAMsHWT1E734sJ+bBpR1N7eHSMC+6nBFGSjpbKFDaq
         61/7XqBk6zMhSEhC0Ui6U67zSYEUhIIud16gGZcFYmengkt68rRH1ueSYjdErCQZD+
         ioRDU3XLX/6FA==
Date:   Wed, 27 Sep 2023 14:45:31 +0200
From:   Mark Brown <broonie@kernel.org>
To:     Saravanan Sekar <saravanan@linumiz.com>
Cc:     sravanhome@gmail.com, lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux@roeck-us.net, jdelvare@suse.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2 2/3] regulator: dt-bindings: Add mps,mpq2286
 power-management IC
Message-ID: <ZRQj63bNWE5/rPHj@finisterre.sirena.org.uk>
References: <20230927033953.1503440-1-saravanan@linumiz.com>
 <20230927033953.1503440-3-saravanan@linumiz.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T0rU25F2o9sf0/UW"
Content-Disposition: inline
In-Reply-To: <20230927033953.1503440-3-saravanan@linumiz.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T0rU25F2o9sf0/UW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 27, 2023 at 09:09:52AM +0530, Saravanan Sekar wrote:
> Document mpq2286 power-management IC

Acked-by: Mark Brown <broonie@kernel.org>

--T0rU25F2o9sf0/UW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUUI+oACgkQJNaLcl1U
h9DEfwf+JvfaFxh8GiR0Yh5rN8HjOavY+Bhl3rnfzmUzMBYk4XbIQgKzKIMv5KQq
llUScvj8FvQGBT2tKE2Iv/bG/wcD0TIG8qbqFb8e+uaB8ef3bmJpglWCGVtwxXQn
v+SqFAlVKa9IAWZbXqH4N07UBffJEmwu1vK3boVoNPokkPVab8i2rQQcE922v0q9
J6DMYxCUUcmNV+igGkp1r4k6dP93nL3lcvueCnYjsj3CYbOVQdc71hAiBRCLl+sT
ZsdlFdehyQYbuGrFzQ1fYdxDaoEX+29ZWHlJFETtODULMuPmZm8JtpcZWqelsTUe
0V6DwtqFZLm5tG10HhZ979T9yzS3Xw==
=aDqW
-----END PGP SIGNATURE-----

--T0rU25F2o9sf0/UW--
