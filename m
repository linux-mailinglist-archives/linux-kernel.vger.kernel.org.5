Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D8576EE67
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237186AbjHCPnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235111AbjHCPnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:43:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9C810C1;
        Thu,  3 Aug 2023 08:43:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8694E61E01;
        Thu,  3 Aug 2023 15:43:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D21C433C7;
        Thu,  3 Aug 2023 15:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691077390;
        bh=KoLn3PO68BXikhaj4ySE/rO5/HRmPhUyMv3wjtf4qCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=faOS5KxurJgM/9FVHaQtuTARup65VQBeqMbximvgU1vwEIATNEAdueT/mT68H8XsB
         lUB95a0YDTNUUllXBqf7zeRKcz+YVR0rw+Rr8/yUva4y0pM9YS/WwIB3/9p5c+XZLQ
         NPxAdm3z3AWNQv8qMjNZw8honCH5UR7iAp2mT/DCK9Cwfz3uNKVto+cNH6dVHCWX42
         u46cADr/rRE1+UqRCtnTA1zDn2dJqDU6nhx9/TlmSAHKLp/P2oqQBtyrM2ADOos3Xn
         V8dX9+Hy47GMJ9wo+37Qr6AZ8U4Awnd168KJw5a4RH03GJvakr8LgIah3AzaxnzA6o
         QKY7YlF0auc1A==
Date:   Thu, 3 Aug 2023 16:43:06 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Michal Simek <michal.simek@amd.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: spi: spi-cadence: Describe
 power-domains property
Message-ID: <20230803-same-oxidize-75f916f2dbc2@spud>
References: <987430ee905fd299fe962663d94f848b341c87df.1691047461.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PJFBxIscZoVIaMg9"
Content-Disposition: inline
In-Reply-To: <987430ee905fd299fe962663d94f848b341c87df.1691047461.git.michal.simek@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PJFBxIscZoVIaMg9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2023 at 09:24:24AM +0200, Michal Simek wrote:
> ZynqMP Cadence SPI IP core has own power domain that's why describe it as
> optional property.
>=20
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--PJFBxIscZoVIaMg9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMvLCgAKCRB4tDGHoIJi
0kg/AQCIHSQwUFbhQg65ZRhUd32tX3C7IhQVSkhgdemw+LYZrAD/Sntm9kn1AQYq
BDPhyMUA5OnMTphVTBZXJIoBzT25QgY=
=n1Um
-----END PGP SIGNATURE-----

--PJFBxIscZoVIaMg9--
