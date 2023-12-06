Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D148072F6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379078AbjLFOr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379054AbjLFOr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:47:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D93D47
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 06:48:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF77C433C8;
        Wed,  6 Dec 2023 14:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701874083;
        bh=e2mBg63B3Rxem2QPpMvPu2MtbeR1WTob4G8+Mhk2ajk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KbJE358GgB3e/NSmbwLLfs6klqfMdvQzaJXn4Emk5D1LaL6n55uhmCETJrGmKaF4e
         FT/tMQDmlqC/CWd/+d4q/TOErmAcYHuZPHjhK0ijkRkXOAXoflXfGC3rVMY2X/M3Hj
         VVL4DrjOXskVahnhwbgZmJoobTQT4RQlQcXdk8jpkBvDgk2dhoaN8NVg8mPxLl45cd
         oKNQrCBal0krZY+c+dmeqR36g/MrXwYtRJ+afpQYpp08Y7eUoUhlsvzq59RyRQoOAe
         Dy+1H6Y9uB2n1tHvGUbeh8jVMv0uItuFfv+R6bLWOVAc1YFU4ocei0G9Q5K2pSQb8e
         neiCbZhSHEK8w==
Date:   Wed, 6 Dec 2023 14:47:59 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Gregor Herburger <gregor.herburger@ew.tq-group.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: Add TQ-Systems LX2160A based
 boards
Message-ID: <20231206-turban-comma-97e617bcc46c@spud>
References: <20231206-for-ml-tqmlx2160a-v1-0-622e41ae4d8e@ew.tq-group.com>
 <20231206-for-ml-tqmlx2160a-v1-1-622e41ae4d8e@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TNFO97P/ZqDKZ/Nb"
Content-Disposition: inline
In-Reply-To: <20231206-for-ml-tqmlx2160a-v1-1-622e41ae4d8e@ew.tq-group.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TNFO97P/ZqDKZ/Nb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2023 at 03:01:01PM +0100, Gregor Herburger wrote:
> TQMLX2160A is a TQ-Systems GmbH SoM using the LX2160A SoC.
> MBLX2160a is the starterkit baseboard for TQMLX2160A.
>=20
> Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--TNFO97P/ZqDKZ/Nb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXCJnwAKCRB4tDGHoIJi
0hQcAQDQTtIi80WGv2x4EXEfDjGZOrhV0juu0qqOLZD/ivV2UgEAwyO1Q8MlwP0e
bCEnZL7KcywQ/7flWblpTb/z5rvZ3A8=
=fgya
-----END PGP SIGNATURE-----

--TNFO97P/ZqDKZ/Nb--
