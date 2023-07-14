Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F22754301
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 21:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236113AbjGNTEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 15:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235481AbjGNTEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 15:04:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C1335AD
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 12:04:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E1F561DD9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 19:04:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77531C433CB;
        Fri, 14 Jul 2023 19:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689361471;
        bh=cOhnAn205vbLzyMoSoIWJHEK2C6QtosuSdtdXfvdigE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FGVA/AON9W3WICBAVpWucSbdvIR4ojjD+ywDmEzCWCp9W7WrQKaeSBirFUCQZN2qJ
         rZo6WzpC6nUou3kO8QsVb0Kbvt8QgNieNAyLfoZkisyPhvK8jl2Gf0dMM6hYF3IVtW
         3iqjsTaI3axdGh5qRVH0NNMGg/bL+z+43P6fKKIQelvyRjCnvasDCnEwNYXvia8KrS
         HcMNMXN3BM8r1bR04J+/k660vjnelOA+UTagFE3k9iEqkWYFe1QU/6OW8nc3k7JQ4i
         gpUUhTeSRfVpFEYFdlTornli6ExX8MZ2tjCvIqPhqgZEDRnHj4dm+ZA8xdlRm1DQac
         8fe8bl3oIhghg==
Date:   Fri, 14 Jul 2023 20:04:28 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com
Subject: Re: [PATCH] MAINTAINERS: update Claudiu Beznea's email address
Message-ID: <20230714-mystified-tamale-47a11cd8845a@spud>
References: <20230714183852.8370-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J/PoLqcUlODJkH6j"
Content-Disposition: inline
In-Reply-To: <20230714183852.8370-1-claudiu.beznea@tuxon.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J/PoLqcUlODJkH6j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2023 at 09:38:52PM +0300, Claudiu Beznea wrote:
> Update MAINTAINERS entries with a valid email address as the Microchip
> one is no longer valid.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> ---
>  MAINTAINERS | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3be1bdfe8ecc..0be71ca1cbb2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2337,7 +2337,7 @@ F:	drivers/phy/mediatek/

>  ARM/MICROCHIP (ARM64) SoC support
>  M:	Conor Dooley <conor@kernel.org>
>  M:	Nicolas Ferre <nicolas.ferre@microchip.com>
> -M:	Claudiu Beznea <claudiu.beznea@microchip.com>
> +M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Supported
>  T:	git https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--J/PoLqcUlODJkH6j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLGcPAAKCRB4tDGHoIJi
0iozAP9Lu3rB8szE8pBqyb4OGALjBhVfz9ln4OcOvxtVanVuqAEAjSxX8Ivj7Yuf
fB3QKnhp5Ceaby4XtnH9lrXSJvNV5AQ=
=nn7n
-----END PGP SIGNATURE-----

--J/PoLqcUlODJkH6j--
