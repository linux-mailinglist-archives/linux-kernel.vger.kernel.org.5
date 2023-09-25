Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A539D7AD5B7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjIYKVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjIYKVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:21:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BB48E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 03:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695637264; x=1727173264;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OYdjOlD1VTnveMwZiWaqVgJ+r23UlkzqDe6dKTfCN4s=;
  b=ThC36gxbVjEJqA6YgjTpnhyuU7Ro5JveG8qOZNHXyAQ8fcSoh6hjx6rc
   LTNxkbJtqdvLtkZZ1eRytfoHWxoObysXcHAqyHz9o8fVz66WV6dkgEDC3
   c61/LackKjxbo1gvU3NpX39WsHjPsROM7OyyjVfr4oCpOr3QsSjOVvQKk
   6cp7FKNdzLTWmSFaQxJw6aePrJdWxVU8coaLB3Ei1VRucUGYXOM+4TPj2
   wa+RgIxim/Cy6G5vVnh/ExovWLwP14KtzhOKkN9D89zAqwm9A/D/DLoXb
   iSsLSjmHIj+I5/AGXF6iopV6tf67QsTYrk2YnduRktazpp3UC/fOG1DrX
   g==;
X-CSE-ConnectionGUID: Qh4ak2qkR92n/PqzHNXvzQ==
X-CSE-MsgGUID: rjHIZEEwQjGvRo9ERwmgEw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="asc'?scan'208";a="6420900"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2023 03:21:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 25 Sep 2023 03:20:58 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 25 Sep 2023 03:20:57 -0700
Date:   Mon, 25 Sep 2023 11:20:39 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel@pengutronix.de>
Subject: Re: [PATCH 16/40] soc/microchip: mpfs-sys-controller: Convert to
 platform remove callback returning void
Message-ID: <20230925-confined-tibia-9982d3267806@wendy>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
 <20230925095532.1984344-17-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fhIKodJZR77/42JG"
Content-Disposition: inline
In-Reply-To: <20230925095532.1984344-17-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--fhIKodJZR77/42JG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2023 at 11:55:07AM +0200, Uwe Kleine-K=F6nig wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new() which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>=20
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Applied with some cosmetic changes to the commit message, thanks!

--fhIKodJZR77/42JG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRFe9wAKCRB4tDGHoIJi
0sRnAPd/gyGabk4lGCe4J7YKWSTYZfskMdTlLKF9+WtCvbAGAP0QkTt5FibnWb20
vR0++rV3JV25XYlsoixT5xWl+2wOAQ==
=IruO
-----END PGP SIGNATURE-----

--fhIKodJZR77/42JG--
