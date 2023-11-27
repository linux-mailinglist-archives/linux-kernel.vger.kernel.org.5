Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF0A7F9CBF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 10:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbjK0Jgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 04:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbjK0Jgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 04:36:38 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CC1DE;
        Mon, 27 Nov 2023 01:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1701077804; x=1732613804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wbYc5Mi0mkxvIgJBVWC8WKPY+n3fl5ePEg7lSS5YolQ=;
  b=aqpm3BQVe5fUfHqKZ+HwnMucgXsCRqQFw/xNylxk17Kt1Gfq2IOoP3Vz
   gxGyndoYKisSv/k2DD1YuM8jwD+rPd7v9sEP47rgP6aZwofX1CC3fARta
   cPqk/6Itf1AxRokXFSWINK+WpXGTxkhRIJKF8iO/AIDdc/LfUS21H4adj
   IxOkNN28hCjOBLfxV3y/CKYZZxvrgw8VsL1yZxYshEmY/rllnEit6Ajnh
   b9MmJM+OjNzFAeykh4AGg2yqrPWteLkH2An1qFYsjk8ueLtsc5ohuwCDb
   7dH643Do6/aR3q6Casy/QDj87+oympJVs5qEoJk6W1TI1PQaYXv4uzrUo
   g==;
X-CSE-ConnectionGUID: jcaihvjJQZmUBLk5lTFEhQ==
X-CSE-MsgGUID: XSNrlY2nTJy6E+xCTC4UsA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="asc'?scan'208";a="12595217"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Nov 2023 02:36:43 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Nov 2023 02:36:12 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 27 Nov 2023 02:36:08 -0700
Date:   Mon, 27 Nov 2023 09:35:39 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Frank Li <Frank.li@nxp.com>, <alexander.stein@ew.tq-group.com>,
        <alexandre.belloni@bootlin.com>, <conor+dt@kernel.org>,
        <conor.culhane@silvaco.com>, <conor@kernel.org>,
        <devicetree@vger.kernel.org>, <festevam@gmail.com>,
        <haibo.chen@nxp.com>, <imx@lists.linux.dev>, <joe@perches.com>,
        <kernel@pengutronix.de>, <krzysztof.kozlowski+dt@linaro.org>,
        <krzysztof.kozlowski@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-i3c@lists.infradead.org>, <linux-imx@nxp.com>,
        <linux-kernel@vger.kernel.org>, <peng.fan@nxp.com>,
        <ping.bai@nxp.com>, <robh+dt@kernel.org>, <s.hauer@pengutronix.de>,
        <sherry.sun@nxp.com>, <xiaoning.wang@nxp.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: freescale: imx93: add i3c1 and i3c2
Message-ID: <20231127-cherisher-falsify-8193656e8872@wendy>
References: <20231017194657.3199749-1-Frank.Li@nxp.com>
 <20231017194657.3199749-2-Frank.Li@nxp.com>
 <ZUz/8fBWtnwdSW9w@lizhi-Precision-Tower-5810>
 <20231127022140.GJ87953@dragon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RBuY3wpHZRfr7ruc"
Content-Disposition: inline
In-Reply-To: <20231127022140.GJ87953@dragon>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URI_DOTEDU autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--RBuY3wpHZRfr7ruc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 10:21:40AM +0800, Shawn Guo wrote:
> On Thu, Nov 09, 2023 at 10:51:13AM -0500, Frank Li wrote:
> > On Tue, Oct 17, 2023 at 03:46:57PM -0400, Frank Li wrote:
> > > Add I3C1 and I3C2.
> > >=20
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> >=20
> > @Guo Shawn:
> >=20
> > Driver part already merged.=20
> >=20
> > Please pick up dts part
>=20
> Rob had a comment [1] about SoC specific compatible.  That's not what we
> want?
>=20
> Shawn
>=20
> [1] https://lkml.iu.edu/hypermail/linux/kernel/2310.2/03035.html

Yeah, Rob's request here looks valid to me. Should just be a bindings
change Frank & fall back to the "silvaco,i3c-master-v1" compatible.

Cheers,
Conor.

--RBuY3wpHZRfr7ruc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWRi6wAKCRB4tDGHoIJi
0nspAP9lVMYJ86MSdG5h+V1vbfIvJIfnVFsNNAu0e5dCZZ8xXQD8CpX4tfnJEZWp
2021AvHbHZl6OuVBbSpSQ5Kdq+dTjQY=
=yohp
-----END PGP SIGNATURE-----

--RBuY3wpHZRfr7ruc--
