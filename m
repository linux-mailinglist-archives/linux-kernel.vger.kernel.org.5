Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F287F4C12
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjKVQNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjKVQNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:13:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B695BD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:13:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0371BC433C7;
        Wed, 22 Nov 2023 16:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700669620;
        bh=b2nTl96C3C5sv3UzKTb650wEGPo53mm3yZpl9sYxoS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lG8Qpst2HZvWgqf6mkTFaP5fkgbWBooDCM0ZTYirNIL4XbSPyXfwY6ljuL8tIA5tN
         oQTE+0RV8RgBeRZjD15Mm8Jghm38A0FhbdjMsiPcptC4dgZDSmm8HvANrTCe0+ZAp2
         RC9ygzbxtd57rFqegIFmwfomhENk/d/GH0RhIKZb76I/0bAwSjCOVIW79OxfXu7WLz
         gV3lCOgnLVeZfKOg49NoogyFidRBYzPkKFWcoiHHDk8hdhqU4cD2jd5bbZN7lf0fK1
         hxka9hhTad960OppnDBTusNoe2odAKl6D42Fj/XeWOcHCDp85Nb0cX0lX+2ppZY/bS
         XvsQpYOmOf8FA==
Date:   Wed, 22 Nov 2023 16:13:35 +0000
From:   Conor Dooley <conor@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Jerry Shih <jerry.shih@sifive.com>
Subject: Re: [PATCH v4 05/20] dt-bindings: riscv: add scalar crypto ISA
 extensions description
Message-ID: <20231122-bulginess-rash-08f811f54f0a@spud>
References: <20231114141256.126749-1-cleger@rivosinc.com>
 <20231114141256.126749-6-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MwP0K8Sf91YW7Tpk"
Content-Disposition: inline
In-Reply-To: <20231114141256.126749-6-cleger@rivosinc.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MwP0K8Sf91YW7Tpk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 09:12:41AM -0500, Cl=E9ment L=E9ger wrote:
> Add description for scalar crypto ISA extensions:
>=20
> - Zbkb
> - Zbkc
> - Zbkx
> - Zknd
> - Zkne
> - Zknh
> - Zkr
> - Zksed
> - Zksh
> - Zkt
>=20
> Signed-off-by: Cl=E9ment L=E9ger <cleger@rivosinc.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--MwP0K8Sf91YW7Tpk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZV4orwAKCRB4tDGHoIJi
0t+FAPwJWXny8MqLPpIpmQrQtwO3Qntn+WM4+IITgS5uuTwgDgEAk2BRuEGqBZid
AeYQalnd3+AvWO7eHvWwQPyGs3dTUwY=
=2+fF
-----END PGP SIGNATURE-----

--MwP0K8Sf91YW7Tpk--
