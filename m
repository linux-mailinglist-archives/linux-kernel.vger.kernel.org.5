Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1307B52E0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236999AbjJBMWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236904AbjJBMWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:22:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E37B0
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 05:22:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F28C433C9;
        Mon,  2 Oct 2023 12:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696249328;
        bh=9JTxOS4Ez5ORtaTea5hqlBqSPR3EmYOiqEikAVo0TJc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YVAMnLqlATfqsZoU4xC+VSc696gPnBhDzh+6lCcGUTLWPOZcc9NkVoFkULvKW0ju9
         CBYXtRW7/U1chaU1zBEs7VdXxqqy48g2GGnIAQ3WOHn8RJCMRLkwFprgvfS27ZZz2r
         wY/HBEu09y7WvyjS5BIsYJdAuw2tMEeco8Ffexm2ILLuWlaEFKAcFk9b6LKWGTlOID
         gDp3doFvolTvfUVvqt4U9hLdBPZtD+2N/sKwYSSLCIKJFLtHM4HmCu43N/osd4/Pwo
         nLMfa83Hk1HT6x0e7QG9n2lzASKpnZJNi4XAFF1lScaFD5nR3seURCsrDYICj+m+o9
         7qUA38wrlwUWA==
Date:   Mon, 2 Oct 2023 13:22:02 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Inochi Amaoto <inochiama@outlook.com>, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com
Subject: Re: [PATCH 0/5] Add Milk-V Duo board support
Message-ID: <20231002-slurp-anime-a2308245174e@spud>
References: <20230930123937.1551-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7PRu9BiGWpbVBTj7"
Content-Disposition: inline
In-Reply-To: <20230930123937.1551-1-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7PRu9BiGWpbVBTj7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Sat, Sep 30, 2023 at 08:39:32PM +0800, Jisheng Zhang wrote:
> Milk-V Duo[1] board is an embedded development platform based on the
> CV1800B[2] chip. Add minimal device tree files for the development board.
> Currently, now it's supported to boot to a basic shell.
>=20
> NOTE: this series is based on the SG2042 upstream series for the vendor
> prefix and ARCH_SOPHGO option.
>=20
> Link: https://milkv.io/duo [1]
> Link: https://en.sophgo.com/product/introduce/cv180xB.html [2]
> Link: https://lore.kernel.org/linux-riscv/cover.1695804418.git.unicornxw@=
gmail.com/ [3]

Other than the comment I left, this seems fine to me. I'd be happy
enough to pick up the pre-reqs from the other series & this one if one
of the Sophgo maintainers acked these patches.

Thanks,
Conor.

--7PRu9BiGWpbVBTj7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRq16gAKCRB4tDGHoIJi
0hPiAQDbufi/xai4dSO3amSl9rZppK2+0zKPHMA4SBi3nyrj2gEA2gOHga+VuE+6
cQyX0Y96P/ro+L1m7PljdpadXG5/swQ=
=G7RO
-----END PGP SIGNATURE-----

--7PRu9BiGWpbVBTj7--
