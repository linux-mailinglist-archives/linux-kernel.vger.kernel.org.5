Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015A580F1E6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjLLQIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbjLLQIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:08:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DE18E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:08:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524DBC433C8;
        Tue, 12 Dec 2023 16:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702397306;
        bh=OH0G10DH+BAtW5ufCW11pSaAmGWPMbfRjouSrbJTQuw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kjLqLIs5wRJ/96ttv/ATtpwpcykIqyZ/Oembazzvr6zI+UegpxBctN+p5CLBHujuL
         DnoEVYLXNejR5FZ/JZE2bsHDSPpYI7JjNZKVqtEoXTk6RVaZF/i1Ni6qjjzpjjL8ih
         b+T3+v4ifHyX+jTHtn1OziAPwSsp2N/m35jg2aVWbLjJchME+Yn/Dxc7bBuxZ1OKsJ
         JpMbv9Mxo/pML7Jcvu9xDgtznxY7pLnU1zS6w4JdN9kLnIype0DY1fYolK/1GIRnqg
         iCQjeGTinvsrINqinEcpe2r+aGrwjWbbQrjkgbRie9902S5nvUBivWgY40n9dIVB4p
         kDXs9UcE+KbFQ==
Date:   Tue, 12 Dec 2023 16:08:22 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Swapnil Jakhade <sjakhade@cadence.com>
Cc:     vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mparab@cadence.com, rogerq@kernel.org,
        s-vadapalli@ti.com
Subject: Re: [PATCH v2 4/5] dt-bindings: phy: cadence-torrent: Add a separate
 compatible for TI J7200
Message-ID: <20231212-headphone-dorsal-dcea42263636@spud>
References: <20231212114840.1468903-1-sjakhade@cadence.com>
 <20231212114840.1468903-5-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uVnzDENYDLNx9frF"
Content-Disposition: inline
In-Reply-To: <20231212114840.1468903-5-sjakhade@cadence.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uVnzDENYDLNx9frF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 12:48:39PM +0100, Swapnil Jakhade wrote:
> TI J7200 uses Torrent SD0805 version which is a special version derived
> from Torrent SD0801 with some differences in register configurations.
> Add a separate compatible for TI J7200 platforms.
>=20
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--uVnzDENYDLNx9frF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXiFdQAKCRB4tDGHoIJi
0qFZAP0buWf516DdZnBglwCKgtqcA6Xdl/YA7o4Zq3WV3iMpRAEA+fbxnwYZdAWi
PYoesrgonvFDnfdaKZOcuCW/rzcwRAA=
=BDxH
-----END PGP SIGNATURE-----

--uVnzDENYDLNx9frF--
