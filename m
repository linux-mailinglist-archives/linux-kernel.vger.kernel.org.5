Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1777775CA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbjHJK3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbjHJK3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:29:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F114483;
        Thu, 10 Aug 2023 03:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1691663361; x=1723199361;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KHNhJ8wIRQzxKkGQXQ2id5gPJS7AognrfbDYBi13We4=;
  b=tGEP7IWCTeXjYaWZw4P+ccyYnB5sDQft4sFd6TMcWvIa1gzLlK/9I7DH
   ZrDYyhdAzQ/JqnhdIEdh+9NFheWAlquif/UsVEdxc29IepqM48xG5ODL6
   uRaz2cu1+4o4JMD9mqX6/io4Hm0ngqUYnOUgRkefYkD6Q4vVmPJGgSm83
   T5M3gQiIkN0jhWoFcox9+RXWf2KarButfddnVXjP2c0W2mlGvfxfs/Tn6
   6c4LAgSiPhcROzkWFseHTlvVqAfw1mZe6MnqBfv9lWMO+pckReJAbpnHI
   2VdcQvTMFZBHbelq2h45etEsO2eTb+uf3tl9NvLGmVYEXpQhJiStL5Qez
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="asc'?scan'208";a="165807440"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Aug 2023 03:29:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 10 Aug 2023 03:29:16 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 10 Aug 2023 03:29:13 -0700
Date:   Thu, 10 Aug 2023 11:28:36 +0100
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
Message-ID: <20230810-estrogen-tamale-61beeb1f5f05@wendy>
References: <20230809103636.615294317@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="S4iBG1PC4gJAxsGe"
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

--S4iBG1PC4gJAxsGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 09, 2023 at 12:39:47PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.45 release.
> There are 127 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--S4iBG1PC4gJAxsGe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNS71AAKCRB4tDGHoIJi
0oBoAPsEKD8DhdPcCOEoDAGN8NTZGo33vuALblAp/znrcrLAPgD+Lh3Kh7Pxi97g
NVXyOxxui+KhNtkyvvDua152TFgsZwc=
=ifbY
-----END PGP SIGNATURE-----

--S4iBG1PC4gJAxsGe--
