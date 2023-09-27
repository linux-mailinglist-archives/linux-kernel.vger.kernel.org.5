Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FCD7B07CE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjI0PL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjI0PL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:11:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C011912A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 08:11:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3A5C433C7;
        Wed, 27 Sep 2023 15:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695827516;
        bh=G606I1kZ1AHBVrCZFavAu4e2HWTmXZXEIS63VWTx2Tc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lJJ83QwunOB4di5rQ/a7cD8ug3+iKjYHy4JuQC0Umtgk/2m08BIbRsmVOoJ5NJ5+y
         lA/xaL/LiaY+pbAnkKHQyGNtENAAzMUBsk5apuw1PEiFCDCyWQb1XfPqJO2xm0IcYN
         JJAE7Lt9VpntXDll//UNwkr1HNyOdWuwWIoPa2xQ2cpjIqGa7A+Fc5Pdmt6ciYBLXD
         I/6NllSp1DdAJFnHrVlH9s2DXFRtLEGgXb/OHnbA2Lnb/XIuV45fv1GSs4wxF8X7VZ
         jA+ZOgeaNwYunq0k4OM8yKuDTPbQu/UcuC/3EFRec5EposXrpnYhn7wrYunsy5qG8F
         K8DRNGXB6Su8Q==
Date:   Wed, 27 Sep 2023 16:11:52 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: nvmem: u-boot,env: Add missing
 additionalProperties on child node schemas
Message-ID: <20230927-junkie-custodian-04fddfb252ce@spud>
References: <20230926164529.102427-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="APJsmRLFDDhA8HqH"
Content-Disposition: inline
In-Reply-To: <20230926164529.102427-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--APJsmRLFDDhA8HqH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 11:45:25AM -0500, Rob Herring wrote:
> Just as unevaluatedProperties or additionalProperties are required at
> the top level of schemas, they should (and will) also be required for
> child node schemas. That ensures only documented properties are
> present for any node.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>



Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--APJsmRLFDDhA8HqH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRRGOAAKCRB4tDGHoIJi
0hlJAQD+0BuNHiymSKAtlRbK1Is6k2KoM8IDxYLmBkoH04ajVAEA2Nx86fg+IoA6
+7rYdyEkrFJEnG8y8DuFNoG2IJ9MmwA=
=klf7
-----END PGP SIGNATURE-----

--APJsmRLFDDhA8HqH--
