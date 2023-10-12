Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488EA7C6FB3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343952AbjJLNuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347225AbjJLNur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:50:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F130FD8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:50:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113F5C433C9;
        Thu, 12 Oct 2023 13:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697118645;
        bh=MOnTFzPsgaiw5z0OTC72mCTag1CO1+AnxUxm3+li5Hw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RNbCPeD8XJOri94mQkP0BcFH6MgculKCU5LzTb5Yapy9WaAh+MmA1TmjwWKywH0p6
         2d0lA3F3c5UwZOkZ/X8FXHz6d2HoDnWEIfxbuPpqjq5N+4PpfH+I3LNEIMa5cKTkYh
         mTyv0EKQpxwzaJ3fRGZEpgVxstBG2Ns9VgdZ4kS9vHW17eZVW2msRGu6bNIOTM+Rgh
         fVPB8jwJhrDaDLKMHcFa+DXn/GZhXkrrZ87OgM5ocHQLPjUP73kxbJxVFqwGRXREJU
         jAZt83B5o4LD7n+6gpB46RZesYh1ILlc9+M9lxZAwjgpd22OMWbd/iX8fWelhAhJXh
         4i+wsS1N5mLcg==
Date:   Thu, 12 Oct 2023 14:50:40 +0100
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
        Evan Green <evan@rivosinc.com>
Subject: Re: [PATCH v1 10/13] dt-bindings: riscv: add Zihintntl ISA extension
 description
Message-ID: <20231012-ambiguity-angular-d8c69cc01535@spud>
References: <20231011111438.909552-1-cleger@rivosinc.com>
 <20231011111438.909552-11-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ffU11xaBPoUA4wKk"
Content-Disposition: inline
In-Reply-To: <20231011111438.909552-11-cleger@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ffU11xaBPoUA4wKk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2023 at 01:14:35PM +0200, Cl=E9ment L=E9ger wrote:
> Add description for Zihintntl ISA extension[1] which can now be reported
> through hwprobe for userspace usage.
>=20
> [1] https://drive.google.com/file/d/13_wsN8YmRfH8YWysFyTX-DjTkCnBd9hj/view

Ditto. Who is even hosting this google drive anyway? I'd rather see
GitHub links to docs from the releases, but since youre pointing at the
ISA manual I suppose those do not really exist.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.
>=20
> Signed-off-by: Cl=E9ment L=E9ger <cleger@rivosinc.com>
> ---
>  Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index 4c923800d751..70c2b0351357 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -247,6 +247,12 @@ properties:
>              The standard Zihintpause extension for pause hints, as ratif=
ied in
>              commit d8ab5c7 ("Zihintpause is ratified") of the riscv-isa-=
manual.
> =20
> +        - const: zihintntl
> +          description:
> +            The standard Zihintntl extension for non-temporal locality h=
ints, as
> +            ratified in commit 0dc91f5 ("Zihintntl is ratified") of the
> +            riscv-isa-manual.
> +
>          - const: zihpm
>            description:
>              The standard Zihpm extension for hardware performance counte=
rs, as
> --=20
> 2.42.0
>=20

--ffU11xaBPoUA4wKk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSf5sAAKCRB4tDGHoIJi
0gC2AQD48YxgYkelm7aLEyIMUPGcp0GjgzEJ5HTxkUKhc+hw8QD/bS9XpWTiVQvm
Q+es7WC1l3yctYOGH/AlHpnA4qG/fQA=
=ovFo
-----END PGP SIGNATURE-----

--ffU11xaBPoUA4wKk--
