Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF047AEFB4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbjIZP3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbjIZP3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:29:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C601313A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 08:29:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3546C433C9;
        Tue, 26 Sep 2023 15:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695742145;
        bh=u8b2IFsXG6BYbvL2ly6sSXnKfNqvQC9inEX2QHsDbe4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oGaM7mnw0ur3AJG9xiZ1MzLaAEStY0dsB5mNBhvWgaFOz7MthbVWOTieAzsU2ydUc
         k7gzeRnasYmYUZmPTRS8UeHYOD01PDmSU9Ugm9lQzWTmVyi9QTh+hRLqC9ZvTgqPZW
         8GNQ/SjZc/xM0ika5tsqKCaw4KchVjLKu9xYDqf/HBzYahj4fjTAqNkN37puY5DxSf
         wUmWUrb4l6A1uuxeeBg3tP+ZzO5a7FLsycQg00P887JLw/rL7jTqlOJQ6zgbbBkrSs
         5ZZ7ug7siDRpYApC93t74IS0mpojtMD2kYd+LIOn8XXTwBoG4sK1caDWQT1jwmSe6N
         rWR2UjWKv7sqA==
Date:   Tue, 26 Sep 2023 17:29:02 +0200
From:   Mark Brown <broonie@kernel.org>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 07/12] regulator: mt6358: Add supply names for MT6358
 regulators
Message-ID: <ZRL4vmNXFVWOFsjJ@finisterre.sirena.org.uk>
References: <20230919104357.3971512-1-wenst@chromium.org>
 <20230919104357.3971512-8-wenst@chromium.org>
 <ZRF6mbpswWoxdJsl@finisterre.sirena.org.uk>
 <CAGXv+5EeQupoWc880sCSOuGsdc24y6qPBaaypdV749oHi-XjSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bXPyTeiLA27bUpcX"
Content-Disposition: inline
In-Reply-To: <CAGXv+5EeQupoWc880sCSOuGsdc24y6qPBaaypdV749oHi-XjSA@mail.gmail.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bXPyTeiLA27bUpcX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 11:58:43AM +0800, Chen-Yu Tsai wrote:
> On Mon, Sep 25, 2023 at 8:18=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:

> > This doesn't apply against current code, please check and resend (I was
> > using -rc3).

> Which parts were you planning to merge? I believe we're still blocked on
> the DT bindings. And I need to update the patches to fix a warning report=
ed
> by Rob's bot.

IIRC everything except the first and last patches.

--bXPyTeiLA27bUpcX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUS+L0ACgkQJNaLcl1U
h9BPSwf8CR4po77h7L5GG4DOj2NwAPFMRFpOYD+YH2EWI8ru2oAwCB5MgYZmBtKA
YdDRXNrB3uUshBzfRImfQ+oLUcvGZkXlvnuUXldXi/G0rDCyy3oAISwxhcswlzpP
m2hW6XazDuF8D3WVaYhL7hZpUukcoRv6vH3SKx5jQaZF0j+5rE9w9g0/YaOcRaTr
jj79JrzUASzSRk6TXVTNot+4eIKMQcHLZoIaB/MA2hJi8hICmfA/q0KHNNy9twe2
yLi2gCFpfFypJ6TM0MgRq+59HRTZ/W0+/hVQTIkAyZT5eeMhyw/7WrvhY+/Hbe5F
2UxlA8a9PLNpM0EDB+kItuXHoxj9Ag==
=yTkl
-----END PGP SIGNATURE-----

--bXPyTeiLA27bUpcX--
