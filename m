Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545DA75105D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 20:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjGLSNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 14:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjGLSNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 14:13:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698DA121;
        Wed, 12 Jul 2023 11:13:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7CA7618A8;
        Wed, 12 Jul 2023 18:13:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA5DC433C7;
        Wed, 12 Jul 2023 18:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689185587;
        bh=ZucLRM+SG2KQmz14xWev1E70FP9NzsdW6kTgNIsDmhw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qiR8nSHat+j4uOTJf17/0KZKwcyLRakuRIEiR189smYHBIcJJbZE8k1ihRfVvGiR8
         /56CSxSunwZMx+db7a15WuJvd9oQdyC4f+prO/ms69yV8NTATC8uHEpCQwNu4Jr6Fq
         YrOBrmtvrImYUvtRKsBup5SoZYD438a5j0nuqbs66SQmDBxDo0g17R5nkT0luyM9+P
         qEvXH1Zy9N9MgOLr/prmZgJUqIiQS07RfuZJRdkazN0pFIoZUxlrIaY1PHHNC+zBc8
         z2gOeD/VIJn5mAuvxH36424gExw4T3CPUmqljXaihrPok3o3HAW00FzhLdCciNOHv2
         L5f8Sa3xkmNUA==
Date:   Wed, 12 Jul 2023 19:13:02 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Chris Packham <chris.packham@alliedtelesis.co.nz>, richard@nod.at,
        vigneshr@ti.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregory.clement@bootlin.com, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: mtd: Add AC5 specific binding
Message-ID: <20230712-headway-unlikable-436a4533d540@spud>
References: <20230703035044.2063303-1-chris.packham@alliedtelesis.co.nz>
 <20230703035044.2063303-2-chris.packham@alliedtelesis.co.nz>
 <20230712143220.06a3d6eb@xps-13>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="T+DewEGyjGC/f8R2"
Content-Disposition: inline
In-Reply-To: <20230712143220.06a3d6eb@xps-13>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T+DewEGyjGC/f8R2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2023 at 02:32:20PM +0200, Miquel Raynal wrote:
> Hi Chris,
>=20
> chris.packham@alliedtelesis.co.nz wrote on Mon,  3 Jul 2023 15:50:42
> +1200:
>=20
> > Add binding for AC5 SoC. This SoC only supports NAND SDR timings up to
> > mode 3 so a specific compatible value is needed.
> >=20
> > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> I need DT-binding maintainer's ack to take this patch, but this commit
> did not receive feedback (positive of negative) from them and is no
> longer in their patchwork. Can you please resend the series?

You have one ;)

https://docs.kernel.org/process/maintainers.html?highlight=3Dconor+dooley#o=
pen-firmware-and-flattened-device-tree-bindings

--T+DewEGyjGC/f8R2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZK7tLgAKCRB4tDGHoIJi
0hd0AP0RMbK0KMZS2UGNZaLDxhCWJH42WBPjqgWodDqNASY76wEAxKiJLDakIcvm
6S92pmECkSIqdlzJ1TEfOJYjkVFcAQI=
=eKhw
-----END PGP SIGNATURE-----

--T+DewEGyjGC/f8R2--
