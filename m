Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A445803A23
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344667AbjLDQZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbjLDQZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:25:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7D2A4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:25:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DE4C433C7;
        Mon,  4 Dec 2023 16:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701707138;
        bh=22m4bPVF4Ye6gvOYaIJnR7Fk6Wljx9n9u9W9CAkPDWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q+nkeW5SJMT0DXnux7lrwLAzeenRDdPDAHT7JIMJKB++yD3y/qq7ZSu57OhvXkx6i
         yG/Gg/OSFoHpAyvwm1kpI9M09FsMjPHfAzeg5xlyYwf8Pb98M4EWSPrhl6VQYMCXr8
         YKTAHFfFj7en6OZGEhPcDsvcW0N0ZWSqInQAlvinczmAgRMdTm/uNF4s+/coClQQVb
         uqIpNldcd6D5s5w0ILb4gY6t89lfeOivIhJxWAVzUTLJGrZDMUx54/bWR7jNnX5gHE
         ah2jnG+uZpO5xtdhOnIxtVNorQjWii1fYb8f4086L6+jpAZIbM2MfQo+OPiE0OCIyQ
         9rRTa0p7Ch83w==
Date:   Mon, 4 Dec 2023 16:25:34 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] dt-bindings: iio/adc: qcom,spmi: fix up examples
Message-ID: <20231204-exclude-tapioca-0db6d01640aa@spud>
References: <20231130171628.12257-1-johan+linaro@kernel.org>
 <20231204132624.03733d50@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QAlgK3xkgS7NPjoc"
Content-Disposition: inline
In-Reply-To: <20231204132624.03733d50@jic23-huawei>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QAlgK3xkgS7NPjoc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2023 at 01:26:24PM +0000, Jonathan Cameron wrote:
> On Thu, 30 Nov 2023 18:16:22 +0100
> Johan Hovold <johan+linaro@kernel.org> wrote:
>=20
> > When reviewing the various SPMI PMIC bindings, I noticed that several
> > examples were incorrect and misleading and could also use some cleanup.
> >=20
> > This series addresses the iio/adc ones.
>=20
> All look fine to me.  Just waiting for the DT folk to have time to take a=
 look.

Yah, they all look grand to me.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--QAlgK3xkgS7NPjoc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZW39fgAKCRB4tDGHoIJi
0umlAP41S5c3TE7AyMWFkxiVYj3Wtq1YF0jUGFVVePxnMN6UrwEAyEmXc/dKoaEH
tLiY8u7F9STaiyxQX1C5a1AURXuXqA8=
=rPc4
-----END PGP SIGNATURE-----

--QAlgK3xkgS7NPjoc--
