Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D9077B929
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjHNM7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjHNM7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:59:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06025B5;
        Mon, 14 Aug 2023 05:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692017943; x=1723553943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DE9xX4dYWtBq0Su8RLmTH6uQZ23grIVCeSguhcWzu0U=;
  b=2Ld5CSfRh9GA8+V+2gFWMx+YypMTpyGTDg2+qDPSPd65KK9zLCiH5aci
   tHfoOgMed8GLf6qI2l9EEYZVgT2ZGLWXU/fb2B+ElU5fJ2F97GmQVbobT
   N4AvqTPIpRRfIEoNeaXEnxBOiaodKzDi/erRPWKwd0/JNDSYVrjAWaIGv
   lHtZOgj03THH+CuQ+BRIYVwI772hkp1hB+jfG+YaLVus0PQiQZfDgxxdy
   4Qj2atkNoWWUH+SveXgaY0vegCJVS5MaNLbCzWSjLGgPQ4jLDYpxt1vKB
   3r5UL9y2lGUmYhIzTjXOw21ojGkzgU33rdwyoMN7HC+C5YnbBGPtY7FSM
   A==;
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="asc'?scan'208";a="228827133"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Aug 2023 05:59:02 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 14 Aug 2023 05:59:02 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 14 Aug 2023 05:58:59 -0700
Date:   Mon, 14 Aug 2023 13:58:21 +0100
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
Subject: Re: [PATCH 6.1 000/127] 6.1.45-rc1 review
Message-ID: <20230814-tamale-persecute-6878e2892a57@wendy>
References: <20230809103636.615294317@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="T26R+JCjILvdL4AG"
Content-Disposition: inline
In-Reply-To: <20230809103636.615294317@linuxfoundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--T26R+JCjILvdL4AG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 09, 2023 at 12:39:47PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.45 release.
> There are 127 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Nothing looking amiss from here..
Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--T26R+JCjILvdL4AG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNok7QAKCRB4tDGHoIJi
0pJtAP4iI7Upu2x9EmSOWEdkMF8xma+q4BC/Pgcob/zBUzNNmgEA3gjThIDvdrId
3V+WLAx1GiySOqCFi2p1qNuh59FXmQ8=
=nF15
-----END PGP SIGNATURE-----

--T26R+JCjILvdL4AG--
