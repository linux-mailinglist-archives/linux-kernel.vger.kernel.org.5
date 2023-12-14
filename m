Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F958132AE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjLNOMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjLNOMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:12:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E4011A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:12:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94130C433C7;
        Thu, 14 Dec 2023 14:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702563140;
        bh=kURWfUajABccOzK2w+kJIDkLS9dQkFuhmyqOgcPhtJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hvw/RmvahaG+vJo5uCzSEKnmWfsd+/U85LYZrRyvzhp6UKXlQ1yeeAuNFUnNwVRX4
         faMVtWMdLfoiMbxF2UrVXJY9j5g7EGRj7vjWzPlvOd2/qJfcweIVDO/Zav9+pTLVT5
         KD9paXFbuWHEl+qO3p45SWuYLD4ikogILu6GXApdBVB3b7LGz3QfULj3y0C6minr8W
         TEqF32ejdsEb5MVuzWSx5I/PQQWzAxr3yu4zHXFIhLcpf/SiRDrb0ZZDGOXDtxCVWO
         7tHe8IfSwKq/MQZZJt9moqTupXXNYjs5Iy82kL20rZlpRIwJ1lfr3BYJduNqMklMU+
         u0vlaMrAMT8rg==
Date:   Thu, 14 Dec 2023 14:12:15 +0000
From:   Conor Dooley <conor@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc:     linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robbin Ehn <rehn@rivosinc.com>
Subject: Re: [PATCH 6/9] dt-bindings: riscv: add Zacas ISA extension
 description
Message-ID: <20231214-plywood-little-4fc5f6866938@spud>
References: <20231213113308.133176-1-cleger@rivosinc.com>
 <20231213113308.133176-7-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WsH5yL1is2A3wdVm"
Content-Disposition: inline
In-Reply-To: <20231213113308.133176-7-cleger@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WsH5yL1is2A3wdVm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 12:33:02PM +0100, Cl=E9ment L=E9ger wrote:
> Add description for the Zacas ISA extension which was ratified recently.
>=20
> Signed-off-by: Cl=E9ment L=E9ger <cleger@rivosinc.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--WsH5yL1is2A3wdVm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXsNPwAKCRB4tDGHoIJi
0l8pAQDb06YZM3zu81dwFpDCL6dk+ww9ScWul2gsUo2Cm8U2NgEAjczxPKOsp6/v
ARmSuUG56RnA+IZRScFD0UD7oxDG8g0=
=SBUH
-----END PGP SIGNATURE-----

--WsH5yL1is2A3wdVm--
