Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C534877CE02
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237581AbjHOOXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237586AbjHOOXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:23:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D9E10CF;
        Tue, 15 Aug 2023 07:23:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 001586520B;
        Tue, 15 Aug 2023 14:23:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE06C433C7;
        Tue, 15 Aug 2023 14:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692109411;
        bh=G0wLK5bMRBZ3biEchEhetIoIiQUxmKkj//WHJ7fAgPk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ayT/rgQZ9gf6TrxVQT3sc+8xiMemB0kYDYqjjBJ4oZG7/pyrNlqvKMsiJacV7sfuw
         N1hyx9+1O7GWZYe3bMlssVLZsrWObOOFiammzaUsX+qM0eMBK5U62HwAfMjzTwnMm9
         Qs4kjUCb7YLtciKzj80gSQ1/wYb4i4nROV8qB+bpBYWe1oObvjTthdrEFTKppgVe4J
         bKAMp1vYydharH/5fI4ceiiGT+53TK0DBtWLkQOtaF8edOWmrHmwmErF2+MUleGEij
         FRMuREKDjQ+LutI+xUzfvqnZ+lNqHr8wytA4wc9lDJbMlfGDETJlUlFyE2duviPPJv
         uFClPDn9XM4kg==
Date:   Tue, 15 Aug 2023 15:23:25 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rohan G Thomas <rohan.g.thomas@intel.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: net: snps,dwmac: Tx queues
 with coe
Message-ID: <20230815-reconcile-reshoot-1dfc9ab4a60f@spud>
References: <20230814140637.27629-1-rohan.g.thomas@intel.com>
 <20230814140637.27629-2-rohan.g.thomas@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="31EWOSqhpz72Q0+j"
Content-Disposition: inline
In-Reply-To: <20230814140637.27629-2-rohan.g.thomas@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--31EWOSqhpz72Q0+j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 10:06:36PM +0800, Rohan G Thomas wrote:
> Add dt-bindings for the number of tx queues with coe support. Some
> dwmac IPs support tx queues only for a few initial tx queues,
> starting from tx queue 0.
>=20
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Docu=
mentation/devicetree/bindings/net/snps,dwmac.yaml
> index ddf9522a5dc2..0c6431c10cf9 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -313,6 +313,9 @@ properties:
>        snps,tx-queues-to-use:
>          $ref: /schemas/types.yaml#/definitions/uint32
>          description: number of TX queues to be used in the driver
> +      snps,tx-queues-with-coe:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: number of TX queues that support TX checksum offloa=
ding
>        snps,tx-sched-wrr:
>          type: boolean
>          description: Weighted Round Robin
> --=20
> 2.19.0
>=20

--31EWOSqhpz72Q0+j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNuKXQAKCRB4tDGHoIJi
0kNYAQC89tAi2N1i1739qtPj8asdT8XtPs5imJ8IXuR77su/SgEAtdnyhxQ9FezS
87c/00tTpw4Xbqxwe7wmDz5Hf5pSlAM=
=gfdG
-----END PGP SIGNATURE-----

--31EWOSqhpz72Q0+j--
