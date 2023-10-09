Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20EF7BDAA9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346453AbjJIMFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346445AbjJIMFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:05:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB403A6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 05:05:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B12C433C8;
        Mon,  9 Oct 2023 12:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696853151;
        bh=lm6HOp0bcp8j4kmmGSSU2qqzsmIalB+XEyaDQUMgqHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EQdUHr9akUjnWLxtC4wI5TsVA4I1dZfATVsF8WdYpzdH+n0BaF7wrbfk3eLTE1DQh
         FgWnd1pZPZtpHLPFT0xAHD+0HmwFb4MSmTlX4MR6WMH5A6sZ7Ta8x0HwX8vEzC06U1
         eB2k6YXaJnukR9yQF/dDqYxpeO3kjXVkpOQE1E5OdRwnugaQxGL/qVKjiEbFJ+P6nn
         1pmzHnUEe5XCIokUjUZ/impnxMpj16l+SoZlvvfvZoGWkKJA/xOpobCxR/EXcC0OMt
         TUmzMkOAD+E8H78sFNlVJMIz/iofu5rlVK2T8XJWPMWr94AsjQjrjSvn+Qow5blj1d
         ul0PcSH8jQp+A==
Date:   Mon, 9 Oct 2023 13:05:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: ti: ams-delta: Fix cx81801_receive() argument types
Message-ID: <eb1a215f-6061-4a92-aa17-4f163610c6aa@sirena.org.uk>
References: <20231007213820.376360-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t/8IS+UkRldiLwR4"
Content-Disposition: inline
In-Reply-To: <20231007213820.376360-1-jmkrzyszt@gmail.com>
X-Cookie: What is the sound of one hand clapping?
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t/8IS+UkRldiLwR4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 07, 2023 at 11:38:18PM +0200, Janusz Krzysztofik wrote:
> Since types of arguments accepted by tty_ldis_ops::receive_buf() have
> changed, the driver no longer builds.

Acked-by: Mark Brown <broonie@kernel.org>

--t/8IS+UkRldiLwR4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUj7JkACgkQJNaLcl1U
h9BSGwf+P0HdiRyyeltm0lbcQLuLddOVzbKwsiVaVR8sTCX/3GbtGLDEJZLRMNpe
sKOqdGTYsaeKdOkgzR2XVXc7wVviqBic+yjmdZP0E8lXuPAJkCzhOtqPWVxTfGKa
cuHfa4GGXWSfFXsNq1MG/UnpOGQ0bSPTQ1KzuFMqnxp7uWsZJA1Bq80HLzMMzTKh
jYKn063428GnTW/XJUswhv0b4/PLHndd0a34zROzGepdtTcD7s4ZWJpeGhhlvVip
0dR02qBRWd3AVd1rMQmASdEMh8UV7vO1SP2AWdMwpvCgZQy+XSUxaqyd08QYeCgt
ovYXzNtvIrRcgGkGYIJaWTCVZpMd4A==
=W6ad
-----END PGP SIGNATURE-----

--t/8IS+UkRldiLwR4--
