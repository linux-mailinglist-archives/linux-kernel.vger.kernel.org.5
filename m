Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC087E6FF6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344345AbjKIRPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344475AbjKIRPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:15:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDED830D0
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 09:15:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37E3C433CA;
        Thu,  9 Nov 2023 17:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699550114;
        bh=VrmtHvFIFAf4vhLknqzGY4CAC0ddBJN+OXw9FKzqRB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qe0bB+AtLMXEM85wddl2mDF6P2tPMcQptGsAbroFpDiBoVeaIErEExxtxEXZuxjT+
         A0gx9bKZDMfrUgsvZAiPVXpVrlIp6pgzuVovXV7sJs1HG1rShXjZMJ9qhdj7UHyIXq
         +8IP5ArYXANUZjyciVG/N0L2IlQwGe2bKrJfIaGFjhQ8Eu8uJ1atocQ7A3O0a9VJVI
         gfCiVtJ37OqASUEhhmB5+sOtz+csR/Hkj8+W4KfzJGTnPIl7Rbc043+F1jHstN1Eun
         zIDFuEpYHUYQQWsZnrbDjgb97Zoi+jiXpoJvcVNukd2Z5NXwkBnttMzDkGf+Bjlpmh
         wSnul6nNo9jrA==
Date:   Thu, 9 Nov 2023 17:15:09 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Michal Simek <michal.simek@amd.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: riscv: cpus: Add AMD MicroBlaze V compatible
Message-ID: <20231109-hardcore-empathic-dd95ccb2c878@spud>
References: <d442d916204d26f82c1c3a924a4cdfb117960e1b.1699270661.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7xwT4XJ225knA3hD"
Content-Disposition: inline
In-Reply-To: <d442d916204d26f82c1c3a924a4cdfb117960e1b.1699270661.git.michal.simek@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7xwT4XJ225knA3hD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2023 at 12:37:47PM +0100, Michal Simek wrote:
> MicroBlaze V is new AMD/Xilinx soft-core 32bit RISC-V processor IP.
> It is hardware compatible with classic MicroBlaze processor.
>=20
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
I thought I had already done so, but must have forgot to actually send
the email.

Cheers,
Conor.

> ---
>=20
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Document=
ation/devicetree/bindings/riscv/cpus.yaml
> index 97e8441eda1c..7b077af62b27 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -32,6 +32,7 @@ properties:
>      oneOf:
>        - items:
>            - enum:
> +              - amd,mbv32
>                - andestech,ax45mp
>                - canaan,k210
>                - sifive,bullet0
> --=20
> 2.36.1
>=20

--7xwT4XJ225knA3hD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZU0TnQAKCRB4tDGHoIJi
0tgeAQCQdC+QAWJRhWvWwoAoN/Msq0G/jpWZOlReGX4cEyxHXwEA9pkjRVCwq0ZR
BsGc3oeMsnsa+gsJ7GuY0Ecjh3T7qgM=
=TmUg
-----END PGP SIGNATURE-----

--7xwT4XJ225knA3hD--
