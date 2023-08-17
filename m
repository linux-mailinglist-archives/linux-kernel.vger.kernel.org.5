Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB0677F27D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349132AbjHQIxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349165AbjHQIxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:53:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B60C2724;
        Thu, 17 Aug 2023 01:53:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B90CA618D8;
        Thu, 17 Aug 2023 08:53:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D813C433C9;
        Thu, 17 Aug 2023 08:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692262392;
        bh=kEXsWw+/VJM6IN0aDrK9PQ5r8Y/Ps1Rs0C5CdwEVDUc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hYCaopFbJeZhNGKhUObKp9EccLUIE3fL0oxAuBbW1/veBA+AZGeHi0oJtBjgzn4fl
         wjBU2+XXL0fHspvSDvQsFOgYbCsjp07/svOcbGTXpYvPznrNA19akUM24BF4dELCN0
         emB5QxFhiTRz6WHYqe7HfOlSIw2qLkNHGV8kLbtjzXK/ubY/f5UHSpd3uIpkSEzeW0
         u6qxlWefSXRnoUu0DazxqXLBbGU4519Iuz15gcDTboXVvlbQtLNN/JkNnGCPll6Bba
         v1DARtt40Cg21MwpFcLyeR/o7ZVDYX6QLCp137Y0cXze1fh/gwLwqZ5val/IqbP9Tg
         RLy3QWjZP0wNw==
Date:   Thu, 17 Aug 2023 09:53:06 +0100
From:   Conor Dooley <conor@kernel.org>
To:     nick.hawkins@hpe.com
Cc:     christophe.jaillet@wanadoo.fr, simon.horman@corigine.com,
        andrew@lunn.ch, verdun@hpe.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] dt-bindings: net: Add HPE GXP UMAC
Message-ID: <20230817-wrecking-rely-5c760b7090f9@spud>
References: <20230816215220.114118-1-nick.hawkins@hpe.com>
 <20230816215220.114118-4-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JM/EsoxX1wDbny1U"
Content-Disposition: inline
In-Reply-To: <20230816215220.114118-4-nick.hawkins@hpe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JM/EsoxX1wDbny1U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2023 at 04:52:18PM -0500, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
>=20
> Provide access to the register regions and interrupt for Universal
> MAC(UMAC). The driver under the hpe,gxp-umac binding will provide an
> interface for sending and receiving networking data from both of the
> UMACs on the system.
>=20
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
>=20
> ---
>=20
> v3:
>  *Remove MDIO references
>  *Modify description for use-ncsi

Thanks for the description update. This seems good to me, thanks.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>


--JM/EsoxX1wDbny1U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZN3f8gAKCRB4tDGHoIJi
0kJ+AQDIO38WjzyeoxuE3G1jBNGxfmTLEYg5UNnGFaKfo/3NhwEAl3eF5cI/YmvA
SfNmlmI6AKvpiW4MTLKbwTdm02Uxwg4=
=Pm9W
-----END PGP SIGNATURE-----

--JM/EsoxX1wDbny1U--
