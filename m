Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B977F0680
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 14:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjKSNmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 08:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjKSNme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 08:42:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645CFC4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 05:42:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1AAC433C8;
        Sun, 19 Nov 2023 13:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700401351;
        bh=ivH/7a0rtuqIcC1N4qUHjlirk04W9i7zLpx25t7awaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D9glATJ0gYLuYUOP72CaUWTQcNh7jgQeDfWy/0PxArKf+yDJa3EDf1zEQ6UBcPRhR
         7o6kwvQS++aXZOm/lYMhhW2fqM7RrGqCazyFCDw+TbZk6tViEVzqIZ2EEzv4TmuL6u
         V0O0B62UOPsCZe4Qamkg9azLa7Ueg+pRTqQI61BMFP+hWXmDPPlt5G9Q2J4GfBnSLb
         fjRHFfk+s5zwuHll7BEfSLIYBIn2tAnZU9t3bzGVQIvH7J3Wp1zz1VAoPPnZH+fXFG
         jJCmPHAQaStwAWPLNh7psTo1OtpcvyrFySgzq1h7VMG3cCZts5PL7jixC2tquF/17g
         Q95KzKua8JX3A==
Date:   Sun, 19 Nov 2023 13:42:26 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/4] dt-bindings: nvmem: add new stm32mp25 compatible for
 stm32-romem
Message-ID: <20231119-tree-improper-b031c2527128@spud>
References: <20231117143338.1173475-1-patrick.delaunay@foss.st.com>
 <20231117153310.1.I1784fc7f33cc928e9007d85354707d6382b48b72@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZoXxyyywsf/pWmKt"
Content-Disposition: inline
In-Reply-To: <20231117153310.1.I1784fc7f33cc928e9007d85354707d6382b48b72@changeid>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZoXxyyywsf/pWmKt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 03:33:34PM +0100, Patrick Delaunay wrote:
> Add a new compatible for stm32mp25 support.
>=20
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>


--ZoXxyyywsf/pWmKt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVoQwgAKCRB4tDGHoIJi
0tbrAQCyo2zim4XR1mSVguxU651KwBRSpJJNI10F0CMpk1jK0QD+PFecoGEbntYE
vyEZHgbChgX0fsQEChjuX5OZQb/CCg8=
=gFZr
-----END PGP SIGNATURE-----

--ZoXxyyywsf/pWmKt--
