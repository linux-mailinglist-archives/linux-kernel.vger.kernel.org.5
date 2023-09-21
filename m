Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7687AA0AF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjIUUqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjIUUqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:46:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209F585D34;
        Thu, 21 Sep 2023 10:37:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347C2C4E680;
        Thu, 21 Sep 2023 13:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695301481;
        bh=sF9o/NyGOVf1W8ekbso4gsf86PdFO99KgIVvRixT3wk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vMkjlRhs4NLnMmHDMpQ89vcCo9fQVWoEWCpJUt38hUyeaeEUzewua8ILzpOQOaBtM
         Jibt3UNIIkzQbmDz2WoG9PTcLbeCXBhKI3tfcXX0tbm2uNuX1jq9cCU3hXV8x0PU4y
         cmMzKo/aWG+axhC1O68g2pNydDJhCIYVty0jMGrgogRB3Uf2SNe+PzN0Ejz1RmPv6o
         ASuNu2YMIIvZsZsjSznrbvpHeQYjWuCtXpiSjArfYfGOW8OfNSmNiRpLEADde9rOJo
         mkxR5rIWKDBxixxDcx4tqhwAjjakunZk3rmgj72aiwfHiz5AQmldH/pGMa9L/Wtu1k
         8HKKgdbT9o0Gw==
Date:   Thu, 21 Sep 2023 14:04:35 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 000/219] 6.1.54-rc1 review
Message-ID: <20230921-slinging-sudoku-e19ec7c43607@spud>
References: <20230917191040.964416434@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9D8MFrlllA4ootk5"
Content-Disposition: inline
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9D8MFrlllA4ootk5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 17, 2023 at 09:12:07PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.54 release.
> There are 219 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--9D8MFrlllA4ootk5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQw/XwAKCRB4tDGHoIJi
0uzfAQCFmfBn9x8aEMJxdtm1ZV/Y7rk00WPIWNdEP57X/9k/JgEAiThMIQ829IjL
4CxjO0hUgdGFd+yk5ks9AzmrezYlqwk=
=SMjH
-----END PGP SIGNATURE-----

--9D8MFrlllA4ootk5--
