Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D010C807C80
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 00:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379687AbjLFXkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 18:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjLFXj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 18:39:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4EE181
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 15:40:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B5FC433C8;
        Wed,  6 Dec 2023 23:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701906005;
        bh=JQp1oL5A45HzXA8sxH/IkXyf7ozKJRmzRu5UbEsDfYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nkV2jMFPNNdIlnzVH790fgYfLVgoN9J7v54BsbqXY6MbBQLIdO7nY3RWZvlB5jMsC
         0M4LVJmKLyKVQJq5IJQ510dctIrVO8SR2HmEBrHiUCrgSim/l6rf5BWbyPjJK8LX+n
         bzMHIaVqCj5LwQ5SAo/tr+WS6uvRqdN+EMl3MHrOlVSSKkfog8YU2XLe7eJGrZG3JA
         xuAGQZZSUyNv2IFiRHEeV1wrHG0EfmJtaUE8s7j9cROwxrFIeb6WlXpweZfjMKtQ2J
         xiU3LcsAyO709V1BTQ1Tyi9/3TpLaJcCLk712zEhMkqQJTaBeWq/sST3mOWQldX8yu
         3vHBaqLyd8jtA==
Date:   Wed, 6 Dec 2023 23:39:59 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 000/105] 6.1.66-rc2 review
Message-ID: <20231206-deviancy-trickery-f90d0374db1b@spud>
References: <20231205183248.388576393@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ot5A10vgoOVtOqYU"
Content-Disposition: inline
In-Reply-To: <20231205183248.388576393@linuxfoundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ot5A10vgoOVtOqYU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 06, 2023 at 04:22:38AM +0900, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.66 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

rc2 looks good, thanks.
Tested-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--ot5A10vgoOVtOqYU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXEGTAAKCRB4tDGHoIJi
0pbzAQCCr810gUItXA5O8wXYoS1ZUXprnRzcHCSkq9OqD2Ru+AEA0TGHzt/paPAM
zQwzFCVl37LzZBIEbeRMWbQ5xsM03QY=
=Z4HV
-----END PGP SIGNATURE-----

--ot5A10vgoOVtOqYU--
