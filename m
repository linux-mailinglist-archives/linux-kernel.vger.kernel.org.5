Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6323375A6E5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 08:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjGTGtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 02:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjGTGtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:49:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A477110A;
        Wed, 19 Jul 2023 23:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689835748; x=1721371748;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GvA2a+7n8IaNZUhAWJDCYoLOe+H+gng2myj8Io9r+08=;
  b=FwOl49Jto24tTo9R5q851F8dBZNEYFzefjRQ0/0nYJj+KMvx8S3U1/mA
   m599QUGkoiXT40jifbb3+AylS/yjGcf53KANOLQcznDB4zgwo5xvgi9s/
   6L3CsFfWGBXefPIOpHPbp9sieGgelCZVg1570qxnvYyy8AOQ1ox/7TbYz
   ELR1xGPLt1LTL3dV9qC5lYK9FwUi3RJ6oAlTFEnGV7h4TSpItwLN9uTIG
   nSBDabVFSGRyQ0suEqVrsjAZ1vDQ2zDxWE3LBl93+vQMM5wbUOQI5yrfy
   EDmuLG/fBuD2A3BhMttWnPF7YTBhBDZZcbVBiDq3f0ios1IG/R9NBeqvB
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="asc'?scan'208";a="221271702"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jul 2023 23:49:07 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 19 Jul 2023 23:49:01 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 19 Jul 2023 23:48:59 -0700
Date:   Thu, 20 Jul 2023 07:48:26 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Changhuang Liang <changhuang.liang@starfivetech.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Walker Chen <walker.chen@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/4] Add JH7110 AON PMU support
Message-ID: <20230720-egging-preheated-02752a588f59@wendy>
References: <20230519060202.15296-1-changhuang.liang@starfivetech.com>
 <7fe9bc9a-2bb1-6c5c-2ed5-1eee85b8f299@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ndB0Wq94O4LSYrXb"
Content-Disposition: inline
In-Reply-To: <7fe9bc9a-2bb1-6c5c-2ed5-1eee85b8f299@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ndB0Wq94O4LSYrXb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2023 at 11:46:27AM +0800, Changhuang Liang wrote:
> On 2023/5/19 14:01, Changhuang Liang wrote:
> > This patchset adds aon power domain driver for the StarFive JH7110 SoC.
> > It is used to turn on/off dphy rx/tx power switch. It also can use sysc=
on
> > operation. The series has been tested on the VisionFive 2 board.
> >=20
> > This patchset should be applied after the patchset [1]:
> > [1] https://lore.kernel.org/all/20230512022036.97987-1-xingyu.wu@starfi=
vetech.com/
=20
> Pll series is accepted, should I need to send a new version about this se=
ries?

I don't think so, there were no changes requested here. Let me check.



--ndB0Wq94O4LSYrXb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLjYugAKCRB4tDGHoIJi
0u2zAPwIPO8ScgeJoGf2C5V8jehHZbn7PWAwnUgwzUy6EtGXpwEAlbSanXyr45PU
iF7FqiENoOWD67I/oCtJ0J0d1JvZAAY=
=8iAf
-----END PGP SIGNATURE-----

--ndB0Wq94O4LSYrXb--
