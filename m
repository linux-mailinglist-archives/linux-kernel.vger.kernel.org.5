Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322537CF72E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345407AbjJSLlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345371AbjJSLlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:41:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF111BE
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:41:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8D4C433CC;
        Thu, 19 Oct 2023 11:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697715662;
        bh=zFJ31eXbJDMkRLWAUkyjKDUm5+ZrWpDws7et1zq/7TY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VDBcDBIifXtJCjbhtUZXa8vevpQJOxLdxlQcbNDujxz6ywYlRYDu+4Iiqy7inYDhV
         vayn8Vg9VvABvpM7tX6Z+MBQRza9BytY9ghKdLfRAV/MruEbvUYkSm4IVvWcdhMBW5
         QgZCDJYhVqJGZ/3Km45vyDSUV6nBy1sS6tC8NOroGvanL8InJyRBX7/FgQ1xRMZNZe
         JizaRzTbsO2745WJs8uDUMBvXtEDKq4cPUofRV+P/uqS9YGD/4HuA4fQANmx+r12IZ
         tWI4WJQLMARoF0cT5tm1Rlz1gISYxxsFiSuGmhzdidE0OkNSD10S1qp6THqHa0u5tJ
         ofewMRgEk+ulQ==
Date:   Thu, 19 Oct 2023 12:40:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: ti: ams-delta: Allow it to be test compiled
Message-ID: <9bbab4c8-f616-4abc-9eee-022c19c6921d@sirena.org.uk>
References: <20231008135601.542356-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rJpf5KhErWczI+JQ"
Content-Disposition: inline
In-Reply-To: <20231008135601.542356-1-jmkrzyszt@gmail.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rJpf5KhErWczI+JQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 08, 2023 at 03:53:10PM +0200, Janusz Krzysztofik wrote:
> The driver is now built only when MACH_AMS_DELTA is selected, which
> requires a very specific selection of ARCH settings.  As a consequence, it
> gets very little attention from build-bots, if not none.

Acked-by: Mark Brown <broonie@kernel.org>

--rJpf5KhErWczI+JQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUxFckACgkQJNaLcl1U
h9DHpwf/f4imUxP1IUlBS5zbmBYxSlrnJnvcq+nnx74N7CWo6LPYnn2/7hQHNOCu
XUBv1ekL42okvqVQ9iEXE92BtM0qkKmjminn6dsKuARZGJO/Wsqd5888h8cGvVF/
Tto+BTJ8Zvze/lBVhL3W8UACbeLRvZ54a4tVegAT7OqkqUAFs+SnrVujzy/8G4zb
mEb1NtbNnAHNh3fX726JlrCNW/jECc2cKrD5f3z//K+ixjxYfh5ldVajk7AV0kxD
iUOhqWmxTltKZzh9g/AXpWnS2x0W9enLmx1xhC07kEhWaVeTL5U2hHsOgF3U+DUr
f8K8/lguuC7ta6Svtkm5nc+9L+9Tdg==
=eB4A
-----END PGP SIGNATURE-----

--rJpf5KhErWczI+JQ--
