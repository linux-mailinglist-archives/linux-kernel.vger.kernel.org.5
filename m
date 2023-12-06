Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9F2807316
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378988AbjLFOxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378996AbjLFOx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:53:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E08BD5B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 06:53:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02380C433C7;
        Wed,  6 Dec 2023 14:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701874414;
        bh=BfmDvJ8RDuCVQ+mXdoNuZyTFuN44YPuJHi24jXGbAHc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m87zyRsOCTOxBF+aKu/NHagCRxmyDv+Asnc8Pkf2E+AAD7YXbZYTb2GGZMvLfzeWX
         VZ5pkGgYk3j0VYIYveNb3P31U1FAy8X5FqnWZq6yfWW9DlHik457j/oyJf7KHYvh8s
         ELfU7SepC17kVpuBOPHGjq5K9C3XqOj161s2rCi8dv106SlsrOPR+zELd1+0pCGXJF
         VpVYP9hqoBCjvmv50D11jVZDv9XuPt2gfBQaYpO4OBASeSaSHXhtwvQOyMuyUtjfSi
         dJCG6dePOCByyQogNNPzTyfwW5PCWgb9TqfiFFsCroboK7yan46DXg/4R5ojFmsc09
         LZOgRB4roLxqA==
Date:   Wed, 6 Dec 2023 14:53:29 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Li peiyu <579lpy@gmail.com>
Cc:     jic23@kernel.org, javier.carrasco.cruz@gmail.com, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] iio: humidity: Add TI HDC302x support
Message-ID: <20231206-quarrel-dill-27b94d881ec0@spud>
References: <20231206134655.559474-1-579lpy@gmail.com>
 <20231206135148.559564-1-579lpy@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QXd7A5Rf7VK5v4Il"
Content-Disposition: inline
In-Reply-To: <20231206135148.559564-1-579lpy@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QXd7A5Rf7VK5v4Il
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2023 at 09:51:48PM +0800, Li peiyu wrote:
> Add device tree bindings for HDC3020/HDC3021/HDC3022 humidity and
> temperature sensors.
>=20
> Signed-off-by: Li peiyu <579lpy@gmail.com>

If there is a resubmission, please prepend "dt-bindings: " to your
commit $subject. Otherwise, I am only with this.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--QXd7A5Rf7VK5v4Il
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXCK6QAKCRB4tDGHoIJi
0qgdAQC2K/aw8tdHJ+rVh82hTYCgzPkrJT1gzpW/7/zq0F+giAD/U2P64GnkIVeo
Opn8r6Hjo4FpMoZKTGwUaQQMKQJ/0g4=
=+UPl
-----END PGP SIGNATURE-----

--QXd7A5Rf7VK5v4Il--
