Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C877A75B3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 10:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjITIVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 04:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjITIVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:21:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A3092;
        Wed, 20 Sep 2023 01:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695198087; x=1726734087;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KE0nQg/amugrY0hU6X8yP1M4clGfXyQXmS4LTPcsBBU=;
  b=L0cxBYUztq/3GlSMhhJ1+qkpnThfqD6BWVAbQyqyflBP7OoPJq9tYyYR
   DeKpRH10HVCrPyCGjWX5kD9h0CI/lGbffcoGAqxqScXD/g7e5M1IZ4buQ
   HB0kjrU6hy+yj25RIEf982Cih+ONCBx836r6ociXgfdaZ7U+0HIxTQWef
   9Go1ROzAHXjOABtkIzHEED3UrzOoCVOaUVaOigoBLHkVHCX8egjYcztsW
   5R2tGuDRHF3QRiMTrsf2UPMjB8a5Eo4Hh22mv4nGYHb4tA8YBjc7qWqHB
   mONUZda1yv7xGIZGxJgm5pIqE2j2GtvJ3gvIkpkZl+NGEpgBqdk/WHWcb
   A==;
X-CSE-ConnectionGUID: WxPtBgV6QO2kh+eUWKaMkQ==
X-CSE-MsgGUID: xay10pjUQbOVRdsaCZWxXA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="asc'?scan'208";a="5608330"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2023 01:21:26 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 20 Sep 2023 01:21:26 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 20 Sep 2023 01:21:23 -0700
Date:   Wed, 20 Sep 2023 09:21:06 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Chen Wang <unicornxw@gmail.com>
CC:     <aou@eecs.berkeley.edu>, <chao.wei@sophgo.com>, <conor@kernel.org>,
        <devicetree@vger.kernel.org>, <emil.renner.berthing@canonical.com>,
        <guoren@kernel.org>, <jszhang@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <robh+dt@kernel.org>, <xiaoguang.xing@sophgo.com>,
        Chen Wang <wangchen20@iscas.ac.cn>
Subject: Re: [PATCH v2 01/11] riscv: Add SOPHGO SOC family Kconfig support
Message-ID: <20230920-flashily-ibuprofen-bceba1e6e8a2@wendy>
References: <cover.1695189879.git.wangchen20@iscas.ac.cn>
 <2c6db3d2db0d27d4b2b8364e0c03be3da292101e.1695189879.git.wangchen20@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xGlxnrW2N4qY4U7g"
Content-Disposition: inline
In-Reply-To: <2c6db3d2db0d27d4b2b8364e0c03be3da292101e.1695189879.git.wangchen20@iscas.ac.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--xGlxnrW2N4qY4U7g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>


--xGlxnrW2N4qY4U7g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQqrcQAKCRB4tDGHoIJi
0jESAP9r4e9cXEo8FMKa8sqvXhsg+g1Gkbdl1d/rDCx9LELHLAEA3hby1qa9SSEB
uVRcU35a6phce/xbF5nvjV1B9LxDxAk=
=Bija
-----END PGP SIGNATURE-----

--xGlxnrW2N4qY4U7g--
