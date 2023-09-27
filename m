Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936F77AFF4F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjI0JCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjI0JCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:02:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2AF97;
        Wed, 27 Sep 2023 02:02:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661CAC433C7;
        Wed, 27 Sep 2023 09:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695805325;
        bh=NV3CQINOR3lLeasFFHKqaebi0Y2ZJ3Da2K0ghEVndvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U+C5aCr1b1Pf9qpCyCXMWmkBS4e9877ocdcpipFjyK2AlldG6OQvIc5Lh/66hIj1p
         gMrANA0eF5mYhtiaR4lk/afnIWB/8cl0D1lN2ywOFolD6dYkbTDVsGtGfE+go8gkKE
         AuLIJcLoCgcmkXkCnMaIrZ04hBOmteJq/ttIrOeWqb2F8fr+d7a61wmoEUoVVCpQ1w
         g5fGartvWQ7MJ9dkpTrW1R9oHKCVa9MTS7yNoTPfdZ91mBLaWYHpzSQIWZ+L+45st9
         vDu0MSsnm9d80g/khvDnm57KqJNtdrkq/0q4OKnUZlc1u9wv1IlWq/vhLJUsOKOHrh
         4z0/Rf9Ay9SXg==
Date:   Wed, 27 Sep 2023 11:02:02 +0200
From:   Mark Brown <broonie@kernel.org>
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 2/2] spi: rzv2m-csi: Add Slave mode support
Message-ID: <ZRPvikYWgbeDdz4X@finisterre.sirena.org.uk>
References: <20230926210818.197356-1-fabrizio.castro.jz@renesas.com>
 <20230926210818.197356-3-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ndibdbb3gqomR4sh"
Content-Disposition: inline
In-Reply-To: <20230926210818.197356-3-fabrizio.castro.jz@renesas.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ndibdbb3gqomR4sh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 26, 2023 at 10:08:18PM +0100, Fabrizio Castro wrote:

> The CSI IP found inside the Renesas RZ/V2M SoC supports
> both SPI Master and SPI Slave roles.

Prefer controller and device.

--ndibdbb3gqomR4sh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUT74kACgkQJNaLcl1U
h9Adigf/W/m1Rw76Vg/MRALbchpkwHaF1X8IjwY3MiTylXCr9/Vp3+sPNfN35chM
M8XO+EXNl/AjW8MSCR7JsXs6QnVFnmsMbEH6VKrvJZignLmLDrPdnx7vf812A1oV
daIlWmBe7ZpUFgi59NF2VTCRgjQaBd46dde+QZTcvlxa0LHgDSYttgl2/hbjVcPx
mxJiLT+oSmjX+emHsbKiX1n0gRs70v924UlFayu/AjkmljQFNVeNOBdQ9Cl5bcFA
kyB6pJuoy2ZwItuzeeEMzSKz/X/82+53EnTX6ohi2j1LKFrRq3XlwPvsuegtYCzY
ER81kWz7Q3Fb49bfhKaCJRN4m6rWJA==
=c/bL
-----END PGP SIGNATURE-----

--ndibdbb3gqomR4sh--
