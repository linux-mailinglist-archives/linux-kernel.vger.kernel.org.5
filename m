Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC1D77E4A5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343964AbjHPPGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344036AbjHPPFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:05:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087DB10FF;
        Wed, 16 Aug 2023 08:05:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75829664A4;
        Wed, 16 Aug 2023 15:05:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71619C433C7;
        Wed, 16 Aug 2023 15:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692198352;
        bh=AjWT+sNG9u9IpZ0wytCcsb0hQfFRKcYdNMO0VCFlHNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gOynqFoDcbH89en434cc1O/FQA8SgB3CzReLAHlESh1a1Kxt/Lh6FqPEE6t0hKh2C
         zlT453+4QkVQoSxkSQjWgngrOmrPJYQi2/YuanG7Itk3R1W9YUGucajbrGvTv6l/HD
         I0uIABWjbP1KIXGJmuzcWPfal3lFaTY+N7vgp3LXhZZDvhCctZnH0UxIoMXzXa7T7M
         9+X6kAbkRX724pfFqBbHyIsRLREcSlaXwMF4bjVZ/rTyQ3RDfagMeGUpIwynoXlhcl
         VWJopyP2ZT49cfvBXHSugio57gu828V/gL6XPqZOTySfjoLmazdSd66LBU+aZ88JC/
         Q1r/g6GSvRz5g==
Date:   Wed, 16 Aug 2023 16:05:48 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        michal.simek@amd.com, sebastian.reichel@collabora.com,
        jassisinghbrar@gmail.com, dlemoal@kernel.org,
        nava.kishore.manne@amd.com, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: power: xilinx: merge zynqmp-genpd.txt with
 firmware binding
Message-ID: <20230816-humble-boxer-b9ba32d32643@spud>
References: <20230816130309.1338446-1-naman.trivedimanojbhai@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4ax5sp0jD06qR0HG"
Content-Disposition: inline
In-Reply-To: <20230816130309.1338446-1-naman.trivedimanojbhai@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4ax5sp0jD06qR0HG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2023 at 06:03:09AM -0700, Naman Trivedi Manojbhai wrote:
> Remove the zynqmp-genpd.txt binding. Add the power-domain-cells
> property from the zynqmp-genpd.txt binding to firmware binding.
>=20
> Signed-off-by: Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--4ax5sp0jD06qR0HG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNzlzAAKCRB4tDGHoIJi
0glNAP9rcz4lPRMCnsrrTIHPSMSLz4csIqqp0O+UjHZL0FgEGQEA7mNuL0XGB7i8
IUBrLjIpwbdoNJYgzH41Y6jqpEHlLAQ=
=GL81
-----END PGP SIGNATURE-----

--4ax5sp0jD06qR0HG--
