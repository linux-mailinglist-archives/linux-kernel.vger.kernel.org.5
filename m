Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B863755C94
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjGQHSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjGQHRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:17:51 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C601A10E4;
        Mon, 17 Jul 2023 00:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689578269; x=1721114269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7KVNCKs6gEptnFwi+TK2wmJGN3a7Hiqbrvw+tIvj3fg=;
  b=O4B+btIigG+nVJqlbRKzSdE/AX9ADN0FTopDwWyRM1mDWWRXxnZOHfou
   bxU1zn811ubFsGyh6XiEf50FoWa8GZN7Acwm4X3JfgJ+qtai4kOtjkP7/
   9Aw/9BLVSVN2LpjjeoRJ37GWxJArkjzaYpATbXKnCFP6XfRp+u5QiA+Sg
   jhfPfJqXsv/J111FBr5ABim30TOjXDTA5i/LdX2FfwfHfWEdMFk+LiIhd
   ZoowRFsTCFBaGmVL4JksL9whyffhCEpZBv50i6eBciWYT7Vv3Fr4SGadH
   rnv0Sqkub2Wu/F4nxi8ewDqtmX3L9W2Hi4n9x65cu2arQbcihfaMlnPpJ
   w==;
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="asc'?scan'208";a="235896502"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jul 2023 00:17:48 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 17 Jul 2023 00:17:48 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 17 Jul 2023 00:17:45 -0700
Date:   Mon, 17 Jul 2023 08:17:12 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <huaqian.li@siemens.com>
CC:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <huaqianlee@gmail.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <kristo@kernel.org>,
        <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <jan.kiszka@siemens.com>,
        <baocheng.su@siemens.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: watchdog: ti,rti-wdt: Add support
 for WDIOF_CARDRESET
Message-ID: <20230717-napped-resample-b4891bedd913@wendy>
References: <20230717040723.1306374-1-huaqian.li@siemens.com>
 <20230717040723.1306374-2-huaqian.li@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="obfEl7xNr3y6dFFs"
Content-Disposition: inline
In-Reply-To: <20230717040723.1306374-2-huaqian.li@siemens.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--obfEl7xNr3y6dFFs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2023 at 12:07:21PM +0800, huaqian.li@siemens.com wrote:
> From: Li Hua Qian <huaqian.li@siemens.com>
>=20
> TI RTI (Real Time Interrupt) Watchdog doesn't support to record the
> watchdog cause. Add a reserved memory to know the last reboot was caused
> by the watchdog card. In the reserved memory, some specific info will be
> saved to indicate whether the watchdog reset was triggered in last
> boot.
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

> Reviewed-by: Conor Dooley <conor@kernel.org>

I don't recall actually replying to the earlier revisions of this
patchset, let alone providing a review, but this is not the email
address I would have used, had I done so.

> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>

--obfEl7xNr3y6dFFs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLTq9QAKCRB4tDGHoIJi
0mGoAQCZOYybnsTtnt5Ge05inw85nLLj/dTlEHJVHu0zdfWMgwEAqrESK+Ni6xTM
ov1hKuDJKrofhz/J6kQ8JYW3ZmrplgM=
=OtCo
-----END PGP SIGNATURE-----

--obfEl7xNr3y6dFFs--
