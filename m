Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84817E25D1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 14:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjKFNkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 08:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjKFNkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 08:40:01 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A30D8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 05:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1699277998; x=1730813998;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XlOH7nrQpahPz4MrL+YG14GWdtL7jxJNxbr9KkHQenY=;
  b=Duf5+KSxmZnDMr6c3yUEokQBgO3M2OgAeGeUYJIHP7TvSzus3D2McL28
   TiBUbraajbBQxphi5jSQ2qvs/D9AF+rd8LY1JGJHIQYPS04ImPuVApNA9
   LZiUWrvdqi2XutDmoulqRBe/5Lndmn0cjNyHX+jHjbIW76Dwo+rLErbZW
   rD7N3GB3iArFDwlNmvFNeIwGYDV1OT5x9uk1fZuDDNNDoPsWaXBo6hOrz
   lvgQPa99B/aQ0xVvZS10VYjqkskIWitxo65wWcjZ5UnjdR1ivBwAHfsGK
   tq3dvXWjiTioZCWVaiaH76y8Rv0XGv8Ii3TOEYVJnmzOKVYeMlPaEJog6
   A==;
X-CSE-ConnectionGUID: Thi5Qt48TrKje16MjuTEoQ==
X-CSE-MsgGUID: OPhiwGE6Tqa99Y38hYR40Q==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="asc'?scan'208";a="11840393"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Nov 2023 06:39:57 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Nov 2023 06:39:37 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 6 Nov 2023 06:39:36 -0700
Date:   Mon, 6 Nov 2023 13:39:11 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     David Revoy <davidrevoy@protonmail.com>
CC:     <linux-kernel@vger.kernel.org>, <konstantin@linuxfoundation.org>
Subject: Re: Requesting your attention and expertise regarding a
 Tablet/Kernel issue
Message-ID: <20231106-dealer-deceased-64ad5b4895c5@wendy>
References: <nycvar.YFH.7.76.2311012033290.29220@cbobk.fhfr.pm>
 <20231103200524.53930-1-ostapyshyn@sra.uni-hannover.de>
 <bokQB3BK040-4fGy8tNfZrdM2mNmWxZud9O-KMmYqOkfa1JTC1ocUjoAzCEpPsbsAvY5qb5TcSP6XsQLaja2XO0gapOcsZyeVdCvq6T31qA=@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eMwurKpH7rWdwnOj"
Content-Disposition: inline
In-Reply-To: <bokQB3BK040-4fGy8tNfZrdM2mNmWxZud9O-KMmYqOkfa1JTC1ocUjoAzCEpPsbsAvY5qb5TcSP6XsQLaja2XO0gapOcsZyeVdCvq6T31qA=@protonmail.com>
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

--eMwurKpH7rWdwnOj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Dropped most of the CCs]

On Mon, Nov 06, 2023 at 01:17:55PM +0000, David Revoy wrote:

> I apologise in advance to Bagas and you all for not being able to properly
> configure my email client to follow the correct etiquette (Protonmail,
> unsuitable for kernel development, but we've made some progress with them
> on Mastodon on the encryption issue [1]).
>=20
> [1]: https://mastodon.social/@protonmail/111346195283677411

Ohh sick, I'm glad you had more luck with them than I (or others) did!
I'll happily remove that from the docs if it gets removed.

Thanks,
Conor.

--eMwurKpH7rWdwnOj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUjsfwAKCRB4tDGHoIJi
0gW7AP9V9kMRa67YYh28p+xEKY/HFL7WqeMAWO0mImcPpw4WcAD/ZHhB+LrWQ6h2
EurYKPwmtwmJ5jtcZ/H8FLPulIX/7QA=
=S4MC
-----END PGP SIGNATURE-----

--eMwurKpH7rWdwnOj--
