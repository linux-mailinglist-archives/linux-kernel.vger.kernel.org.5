Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898B980D52F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 19:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344956AbjLKSVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 13:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344963AbjLKSVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 13:21:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795E5D6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 10:21:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD3CC433CA;
        Mon, 11 Dec 2023 18:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702318877;
        bh=yx7x9HZRw2fNrttJxMedeCqy6X82RJq3KdEf+5K1eTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M1Zd+Oo6uaDJ/62he6wzYZJ1pWsfJV3i7CeKrJIC0TwLvyk3HX41TUyhrpOeOjoIa
         7q9KZzHZQCxSkG2FEduM0F0iZA7B3eOKMaodUDUyKOHPvvMIs6mTSggVJKRNfaqLgo
         /DPTGulIAvJhyzdFLh0WMMSmciI6KQJo72yYXQ+IWy3jStBBr3N3KxLxaNQbtOPzkc
         8jd666vX+7C6Ulsv/NmzZ4YQK/5kyQ/HmdOFLCpgsQW4dOUEQ7JP+RhyFOZKVldeyV
         zK1p+NMbo8gjvSke9/3HcEd5Rvz814uLTN20WaagehllWPQY/xMAJJ6HD79Zdsk4kR
         VI0DHtRWyxmnA==
Date:   Mon, 11 Dec 2023 18:21:12 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Li peiyu <579lpy@gmail.com>
Cc:     jic23@kernel.org, javier.carrasco.cruz@gmail.com, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] dt-bindings: iio: humidity: Add TI HDC302x support
Message-ID: <20231211-tackiness-imprecise-685882c9c318@spud>
References: <20231211122201.9598-1-579lpy@gmail.com>
 <20231211123101.9868-1-579lpy@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XvxZv93uMWHkmLEq"
Content-Disposition: inline
In-Reply-To: <20231211123101.9868-1-579lpy@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XvxZv93uMWHkmLEq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 08:31:01PM +0800, Li peiyu wrote:
> Add device tree bindings for HDC3020/HDC3021/HDC3022 humidity and
> temperature sensors.
>=20
> Signed-off-by: Li peiyu <579lpy@gmail.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.


--XvxZv93uMWHkmLEq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXdTGAAKCRB4tDGHoIJi
0mybAP4/anKKpEIWu6vRV5nw3jDFZuvaVLsMfF3wPGeStQQbsQEA7/JiBzEV3Z/N
ZVjWE55zSqdEbI6XQms9Hq4XvLovDwg=
=RvtZ
-----END PGP SIGNATURE-----

--XvxZv93uMWHkmLEq--
