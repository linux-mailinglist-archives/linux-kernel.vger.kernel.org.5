Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C8D7AB2A7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 15:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbjIVN04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 09:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjIVN0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 09:26:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E238ECE;
        Fri, 22 Sep 2023 06:26:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691EDC433C7;
        Fri, 22 Sep 2023 13:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695389207;
        bh=vGEkHQJf4PQtH0a/9x8WR749VplOJZh/zXauzgVGprU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NW/rvdtcY7VTLsJ3LS5gE6TIJrskV5Sgjh8X4Ib5swCpH/eNakUvRl/lV/CppVoIO
         mLv+nky1RFBek3G4VCd+Vi0l27cGZQKOIaYCqzU1aN4BwApCmDg0Q7HIGYG+P81KUh
         oLavnFpmABpZIGle732Pc9amyYwZ5yp/plWZEl+a+G5QBZ9y0/anHAeksdPchUNXhr
         YzWx59bWLrXv3KghOpvvpzL7lvqcRSSDoQt+HAs1LD3f9JfI6T3WPO9pRbUgliSGHy
         1DAwYnleBBPk8InWy/SNEIlMuISAdonG6iQJKUB3jZnmPMHWgyHNf6LTsL/0LSNIiH
         I+h4+E3pzCj4Q==
Date:   Fri, 22 Sep 2023 14:26:42 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 000/139] 6.1.55-rc1 review
Message-ID: <20230922-revenue-reclusive-a97674107190@spud>
References: <20230920112835.549467415@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6/KWIef/Zne+zNVk"
Content-Disposition: inline
In-Reply-To: <20230920112835.549467415@linuxfoundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6/KWIef/Zne+zNVk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 20, 2023 at 01:28:54PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.55 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

cheers, conor

--6/KWIef/Zne+zNVk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQ2WEQAKCRB4tDGHoIJi
0tvHAP0aunAm+76sw6PMW5bGiB1F7PL3G98sCKx8w8w/S04V/wEA9bE3mqN0zKcj
STYDeJgXkSE7ia7H4gYh+k56PCFQbQQ=
=R9i9
-----END PGP SIGNATURE-----

--6/KWIef/Zne+zNVk--
