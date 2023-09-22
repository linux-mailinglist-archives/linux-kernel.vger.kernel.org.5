Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31FC7AADDC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjIVJ2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbjIVJ2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:28:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3858A19B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 02:28:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BAE9C433C7;
        Fri, 22 Sep 2023 09:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695374889;
        bh=4Xc/L95oSWqxAlP8k0CojZn1YClK1+4Xtrm9064KLD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JZdsJUlBIhFmLL6CT2bsTEMM9QhzQRRobvoPAJvTiSh0mqYAsQqbY+pLWNQ6aaeMG
         nzHO1ENvS8ph7z7oGRlvpqL9MmAQyiVQhWcEodLMof3nXNE6oXvl0q29CC+kF5awEo
         7Wsjnpj6ikhpQaClTK6MNTr3+6mDqBv/elDMEK2bkcG1WhIwf0JNHoYGOCy8wy3EeS
         F/kWWTM3jwYbLwCr3oNoZrQJ09T71j+HJqHbDwUWgmy175mhI2vn/4CQSqwqbONEzc
         n0qlfWYCHYVzb1xfv1FtrCqz+wDdzK8SupkpIe9b0TTkZEw9gn//HlVdeYD4XqbkTi
         rzjhWxhoVSGtg==
Date:   Fri, 22 Sep 2023 10:28:04 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc:     linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org,
        greentime.hu@sifive.com, vincent.chen@sifive.com, tjytimi@163.com,
        alex@ghiti.fr, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: riscv: Add Svadu Entry
Message-ID: <20230922-bagel-hyphen-aae5b1b88b21@spud>
References: <20230922085701.3164-1-yongxuan.wang@sifive.com>
 <20230922085701.3164-3-yongxuan.wang@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZaTkWSVN9S5z8516"
Content-Disposition: inline
In-Reply-To: <20230922085701.3164-3-yongxuan.wang@sifive.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZaTkWSVN9S5z8516
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2023 at 08:56:48AM +0000, Yong-Xuan Wang wrote:
> Add an entry for the Svadu extension to the riscv,isa-extensions property.
>=20
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index cc1f546fdbdc..b5a0aed0165b 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -147,6 +147,12 @@ properties:
>              ratified at commit 3f9ed34 ("Add ability to manually trigger
>              workflow. (#2)") of riscv-time-compare.
> =20
> +        - const: svadu
> +          description: |
> +            The standard Svadu supervisor-level extension for hardware u=
pdating
> +            of PTE A/D bits as frozen at commit b65e07c ("move to Frozen
> +            state") of riscv-svadu.
> +
>          - const: svinval
>            description:
>              The standard Svinval supervisor-level extension for fine-gra=
ined
> --=20
> 2.17.1
>=20

--ZaTkWSVN9S5z8516
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQ1eJAAKCRB4tDGHoIJi
0v9nAQC9vIjrDSNPVsV/sDmKkSEokU2Zz1TPhfzrs9q0VzCcOQEAiiM8m3v8Pxeb
IgSWyoBmHUYpi7kujuA7TfByYIw6Pw4=
=JRlx
-----END PGP SIGNATURE-----

--ZaTkWSVN9S5z8516--
