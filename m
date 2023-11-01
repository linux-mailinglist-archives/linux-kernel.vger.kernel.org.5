Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016BC7DE3BA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjKAPPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjKAPPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:15:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B65102
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 08:15:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B34C433C9;
        Wed,  1 Nov 2023 15:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698851743;
        bh=bF/PDFBgCNEyxwW8X8+O+LXv1aXNzxtk1fqmjVSSxIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RwbLrc9k+lhcD+zuA+JUajGEIHE1ZmvRDGzu1U9hxkLbKtleZGYavyCUDhj013ZYv
         +bw3mvaFolfSXUVoy7KuLICIi2wdF1kWm/zAWT6yMv6XGccoex0k11FUU/NvLdBSKB
         LEEAtxwROehdt08c/uUexyzGdxjkaXkx3qL9diBOnxb8M8wGc+lxrAZyuvSYTmHXOF
         +P1ezyaa+scUF4zFhKZn/4FKhWo9quIjXT0oDmbRN0YvTndtaQdCsfZU49/BHT1oSP
         2dpqluBHQI1Cnz8gxZbUvY3jGq81khx7wo0OWYqqHZ4EpvgPBBdjCyVblbobAlR8vg
         w5Ddh/hcNhd5w==
Date:   Wed, 1 Nov 2023 15:15:39 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: vendor-prefixes: add rve
Message-ID: <20231101-detest-respect-e2fcb236697c@spud>
References: <20231101144057.2653271-1-hugo@hugovil.com>
 <20231101-maimed-email-4decd11f1d52@spud>
 <20231101110404.9f4c31d69c67d91e7be46387@hugovil.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WlopFModHXtQCbk9"
Content-Disposition: inline
In-Reply-To: <20231101110404.9f4c31d69c67d91e7be46387@hugovil.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WlopFModHXtQCbk9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 01, 2023 at 11:04:04AM -0400, Hugo Villeneuve wrote:
> On Wed, 1 Nov 2023 14:54:34 +0000
> Conor Dooley <conor@kernel.org> wrote:
>=20
> > On Wed, Nov 01, 2023 at 10:40:57AM -0400, Hugo Villeneuve wrote:
> > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > >=20
> > > Add vendor prefix for Recharge V=E9hicule =C9lectrique (RVE), which
> > > manufactures electric vehicle chargers infrastructure components.
> > >=20
> > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >=20
> >=20
> > Where is the user for this?
>=20
> Hi Conor,
> it is for a new board I submitted a few seconds after this patch:
>=20
>     https://lore.kernel.org/all/20231101144303.2653464-1-hugo@hugovil.com=
/raw

Please send related patches together as a series chief.

--WlopFModHXtQCbk9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUJrmwAKCRB4tDGHoIJi
0sX3AP9jvlH/3APqmjLIKQcl8tABtma9khveW9OtMe/M/PxqFAD8CjKxEAsJoZ5V
n2LtJUS6SQDguE5p8MvwwaztcJuxFA0=
=vJ9n
-----END PGP SIGNATURE-----

--WlopFModHXtQCbk9--
