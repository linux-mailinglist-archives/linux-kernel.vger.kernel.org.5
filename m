Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83C275FF2F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 20:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjGXSgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 14:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjGXSge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:36:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E942610F5;
        Mon, 24 Jul 2023 11:36:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7133C61351;
        Mon, 24 Jul 2023 18:36:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC27C433C8;
        Mon, 24 Jul 2023 18:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690223765;
        bh=OgpwfSIR89tdUbNP+SOyTK0/TNQndGehhjYkLRwvoyE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qC5uQtlQkzDyJvQW7hIybV2856mqJQmUIYtKcM0d7vcRtjm3VnAbi4AeIAZNOic9L
         DbD9WwH8t8hDXX9iFuh1aVhduNhlHjUg4PT9ew1GZxilMR4HVt4sPRCzK8xG8TUVuB
         vEVtbJ7z4yPwgZqz4ai/vIuIrcNY6NrNvG/Kn/dxB4n7SP9/3Eaj9gazGCzOeorZ40
         kvi19t7srx/lktauPEzFKN702/0ZtcMV+YkCH58D/gnm7uL//Az/Qc0LvbpznoG0Q+
         gE89qzPEbGNJUbKEE1XI4BlJbHve3EOarworLDB1TH3W14bT5YoORU64+WMNy5TxWZ
         MM5xQolCviI7w==
Date:   Mon, 24 Jul 2023 19:36:01 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: ti: Add compatible for
 AM642-based TQMaX4XxL SOM family and carrier board
Message-ID: <20230724-ferris-afflicted-45f8c8ad6caa@spud>
References: <867f55a4ac865b979fa58a8828e0d0cade619843.1690195151.git.matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z5OOODaP62W9WXbT"
Content-Disposition: inline
In-Reply-To: <867f55a4ac865b979fa58a8828e0d0cade619843.1690195151.git.matthias.schiffer@ew.tq-group.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z5OOODaP62W9WXbT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2023 at 12:40:48PM +0200, Matthias Schiffer wrote:
> For now only the MBaX4Xx carrier board is defined.
>=20
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--z5OOODaP62W9WXbT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZL7EkQAKCRB4tDGHoIJi
0vfBAQCVbq6Fho6vkWlWdMUJlDY6R3r3xhUTt6K3TNxAd7WhZQEAtzHEIziVhyqp
j/zkzeDRQKlnTMMRYsGdPZ/JBJI/LAw=
=RF78
-----END PGP SIGNATURE-----

--z5OOODaP62W9WXbT--
