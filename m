Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90587811647
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442629AbjLMPYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442549AbjLMPYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:24:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D137BAF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:24:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C5EC433C7;
        Wed, 13 Dec 2023 15:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702481076;
        bh=34+Ib4YFyZmhdk4OinGdvnrlMwYrXexKV9Hm36OaH5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lbVMXI1QdImCKCnxDnc0Lcmg1UQx/Ebc/1WfRY7aP22xJ9CQqvAU/p0vLVIK2oazI
         +Nvx5UUNTQD/u6Zc39LWmbWeVeXI0lbNrM9gaZNiDVspkktzrpm6r7V+E1P4gxNRKA
         QCbOKlO7o0cCJz5GJ2rR+piofMGHy/U09GjH9T+teywtW6IBF4MPfXo2k4LaDZyXLK
         sBxeEi0kwaEDgtMLm9nIyEn8y86cV9cokmRcAilGQ4Psin99aXIKfphklULADpIHl8
         Id2KzVq14cQH60JxHyXVIveRWNY58GVraISLyvPkVHhgDCEp9dvoygNJD8ej29I1UK
         RO+1ozDPDjj9A==
Date:   Wed, 13 Dec 2023 15:24:25 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Yu Chien Peter Lin <peterlin@andestech.com>
Cc:     acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com,
        alexander.shishkin@linux.intel.com, andre.przywara@arm.com,
        anup@brainfault.org, aou@eecs.berkeley.edu, atishp@atishpatra.org,
        conor+dt@kernel.org, conor.dooley@microchip.com,
        devicetree@vger.kernel.org, dminus@andestech.com,
        evan@rivosinc.com, geert+renesas@glider.be, guoren@kernel.org,
        heiko@sntech.de, irogers@google.com, jernej.skrabec@gmail.com,
        jolsa@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sunxi@lists.linux.dev, locus84@andestech.com,
        magnus.damm@gmail.com, mark.rutland@arm.com, mingo@redhat.com,
        n.shubin@yadro.com, namhyung@kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, peterz@infradead.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, sunilvl@ventanamicro.com,
        tglx@linutronix.de, tim609@andestech.com, uwu@icenowy.me,
        wens@csie.org, will@kernel.org, ycliang@andestech.com,
        inochiama@outlook.com
Subject: Re: [PATCH v5 13/16] riscv: dts: sophgo: Add T-Head PMU extension
 for sg2042
Message-ID: <20231213-maturely-freezing-07edd52717d9@spud>
References: <20231213070301.1684751-1-peterlin@andestech.com>
 <20231213070301.1684751-14-peterlin@andestech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0Rcnxco1nl347ZKK"
Content-Disposition: inline
In-Reply-To: <20231213070301.1684751-14-peterlin@andestech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0Rcnxco1nl347ZKK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 03:02:58PM +0800, Yu Chien Peter Lin wrote:
> xtheadpmu stands for T-Head Performance Monitor Unit extension.
> Based on the added T-Head PMU ISA string, the SBI PMU driver
> will make use of the non-standard irq source.
>=20
> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.


--0Rcnxco1nl347ZKK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXnMqAAKCRB4tDGHoIJi
0qyQAP9X4Da6uFGwYd7MFmvCTiSfe1B6LzKyCFwLDqOUywJ6EQEAp9f/B1dFBqB1
ueKxuTYAXyXZJ6C9gMiRZQAQv5ecrwY=
=EGtr
-----END PGP SIGNATURE-----

--0Rcnxco1nl347ZKK--
