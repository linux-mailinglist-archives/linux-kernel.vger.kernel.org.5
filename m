Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF22E7A6CB1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 23:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbjISVFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 17:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjISVFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 17:05:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59739B3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 14:04:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35FCDC433C7;
        Tue, 19 Sep 2023 21:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695157497;
        bh=ZBNmlJfPU0ZzG/XbnBXap4CcKHmXF186hxS/a/0HOA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hFEL1rL7PwzYmpz7Bcf4B65KtW2RtIIqaw084dpL+sHHgb3+iC2R7EBtp44Y9ZHGv
         Xtcfh1STSbtNq5DK8BeJQ1f1J+hga57OPKsn2lyMdYIuXfUvX9KJsYIRJ6GCyaNlQY
         9a0cNQCfc9Fb+2IxJVa3vWjKmRwqau2YaAFAHRAoiHllK5xJuSgojdFWE7SvXbyTMH
         bGM0hxC9xSUPdubdq7AgKBe0bszcwY03Yb8a8QhgEAAxkh/ywqdSpYSbRfxrdVwJpa
         vwkXnPbbv3FYv3mTY2JTenEcSKk6eIIpW/GPKJwfVAf7Xd+D/e/wJMw+VQ4JIOiAzb
         yIcr9FXQC3fXg==
Date:   Tue, 19 Sep 2023 22:04:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Gokhan Celik <gokhan.celik@analog.com>
Cc:     outreachy@lists.linux.dev, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] regulator: max77503: Add ADI MAX77503 support
Message-ID: <ef0ec241-6cfe-4748-b6f1-83252ed75580@sirena.org.uk>
References: <cover.1695155379.git.gokhan.celik@analog.com>
 <5ee2ac417829b4be0a5eeb8b0593325fd1b1d1e6.1695155379.git.gokhan.celik@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xVK5PIFPVcjFlKlr"
Content-Disposition: inline
In-Reply-To: <5ee2ac417829b4be0a5eeb8b0593325fd1b1d1e6.1695155379.git.gokhan.celik@analog.com>
X-Cookie: You buttered your bread, now lie in it.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xVK5PIFPVcjFlKlr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2023 at 11:45:21PM +0300, Gokhan Celik wrote:
> Add ADI MAX77503 buck converter driver support.
>=20
> Signed-off-by: Gokhan Celik <gokhan.celik@analog.com>

The driver code itself looks good.

--xVK5PIFPVcjFlKlr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUKDPMACgkQJNaLcl1U
h9B+9gf/WLiClu05Mejspfrb0rckc78G5Zn/1ihHKa/mgeh3WSpbF+noKuVkRynn
uIOGG1bGKXK3pEuKj/9TfGYDsLkdeya5rbNUsHM+QB1a4g3IN4H/jDR9TrQIZ4JT
28Lv6xH9QgQyJcBe3Ctcd7ueU6so1NqvkRJYu/njbG6orA5BcDJ8Hj2PV8TPAhuB
0MN/0Glk33AzAyc5ni+wRNF+4DkCM6Smy6fqBAR9Ri2VUCW9I9uSH+PDjlHZPyi8
VrSjOdxXfmP5uehqEmc5B5rg+QdRMdvRKUEzFsUjinkE4Ywr9NkaIjZgd97tXypn
QX699nG3vUrJuDvfkQj8Sr/Itwsh8w==
=gwzq
-----END PGP SIGNATURE-----

--xVK5PIFPVcjFlKlr--
