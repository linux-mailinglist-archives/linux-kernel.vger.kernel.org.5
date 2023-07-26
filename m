Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB10A763231
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjGZJbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbjGZJbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:31:34 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4798F2D43;
        Wed, 26 Jul 2023 02:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690363808; x=1721899808;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VW/0RWz6OcJOAZAaREALwLaePcsp+WLwKLmTB+u9ah0=;
  b=OMM1IKZ7w4vxeV6K1n0rO4Jkl4IdV9U6kaaBEZgs0GYq+A30GoyS1FGJ
   TXmRvc9wT1wtKz4E8Lta5Xfbq7/rK8TriG8m2T6umUeOmmFJTl4k32QHY
   b//GaGibOY1hlQeybMO+d4K8hpVDYRdFPndbhCYy95YqWurj/hvjQyXVZ
   RXV7rhcE97k9J1MYTnxnu3YOhD7pl2c6950mrwa14aAJI4PVEzixxUe18
   1G639Hlytg5OoVH4SMMd8hfmfhfcUWhtJAuaL/A/g2bUVsIvbUw5Y+bqy
   vYM0Abyp8HC6ou3ZRoWBlaElHiulXSwotz7Tfy+ExRV3/Y8DJxbsOPBt6
   w==;
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="asc'?scan'208";a="222289979"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jul 2023 02:30:05 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 26 Jul 2023 02:30:04 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 26 Jul 2023 02:30:01 -0700
Date:   Wed, 26 Jul 2023 10:29:27 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <stable@vger.kernel.org>, <patches@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
        <akpm@linux-foundation.org>, <linux@roeck-us.net>,
        <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <conor@kernel.org>
Subject: Re: [PATCH 6.4 000/227] 6.4.7-rc1 review
Message-ID: <20230726-preheated-carried-ac1a34bd7a4d@wendy>
References: <20230725104514.821564989@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="abJNtELWpQ4Opme6"
Content-Disposition: inline
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--abJNtELWpQ4Opme6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 25, 2023 at 12:42:47PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.7 release.
> There are 227 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--abJNtELWpQ4Opme6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMDndwAKCRB4tDGHoIJi
0g9/AP0SMHkzqogQdYkeeBflvBCt2FWwRe8w/lFrXn/a38pq0AEAj7dkaHrDxhAN
FIThd1J2wavJkGHq3MEHsN6LzE6V7QM=
=+gnl
-----END PGP SIGNATURE-----

--abJNtELWpQ4Opme6--
