Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E9C75E176
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 12:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjGWKl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 06:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjGWKly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 06:41:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06CEE50;
        Sun, 23 Jul 2023 03:41:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5569D60C77;
        Sun, 23 Jul 2023 10:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB07C433C8;
        Sun, 23 Jul 2023 10:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690108912;
        bh=6pfhjlPTOh6AOzRsJbAp4eRsQEhZQt7xA0hkoqbQ1Kg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BEa+xR13lmIu8EJRQUQjKqCDCGJv3scr1Mo85p1UgRRd0j0mOuMgZE7II8qVsLiM8
         MMYN/bQZCKmAoWNyr9n36EaHRjBjlwPh+UKufXwkqA5zg4mevkT+ay5K7erd3zWdBX
         xVMH2BOO6h9g+bO21+TFIyckaqp7QMgtryL6AwtrgkJmOA2FjHxp2I9v+AlsLmk4ys
         Ffu17WQXZ8KqXFiUy/l6ZrHbMsHJjvJnKW/Rp/rgkJZRrteAtjMwBZTrIVpI4F8ePi
         2ud+seIAlKqG9Yu0gCgllpFpLB3fl/NgQvLpYD55W93ivF4rrG3cle/oHZ6aES90DD
         RzaSg8/Jy3xsg==
Date:   Sun, 23 Jul 2023 11:41:47 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.4 000/292] 6.4.5-rc1 review
Message-ID: <20230723-antics-disliking-e51f5f376820@spud>
References: <20230721160528.800311148@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Y23Encm58GYXonbN"
Content-Disposition: inline
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Y23Encm58GYXonbN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 21, 2023 at 06:01:49PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.5 release.
> There are 292 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--Y23Encm58GYXonbN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZL0D6wAKCRB4tDGHoIJi
0nVYAQDmgO+AR8ya6jXYh0BedeWoIedGUWJHT3jqLbDuAiz1DQEAyP6dqAllOe8G
tJ4PLfA7lJHSEZesgf0NmvY8o75i+wY=
=AP5S
-----END PGP SIGNATURE-----

--Y23Encm58GYXonbN--
