Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C354D790011
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 17:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239246AbjIAPnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 11:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbjIAPm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:42:59 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A6CAC;
        Fri,  1 Sep 2023 08:42:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E0A71CE201A;
        Fri,  1 Sep 2023 15:42:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C978C433C8;
        Fri,  1 Sep 2023 15:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693582973;
        bh=Aec0t6krFCEGf5U3ptUC6kwjD2IAlaWgVN7rht2AvZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nsT62ZoHWt5x0aCRPsHutsG+4ryQ4Ewb1L7t+icTEW4pIECRDYYxVH9UhxS4Wwq+h
         9+HQLKh5uU1TC8U/o3WUj242ae6d98D2XnM34kAHfW+nTzpLF57X/err1iGrD5GNzE
         7KgMGe69qoCTqNQkFb9KA3LvwnHQVz6YrOXxRrMSzMGScusjrstm3e6NwUpFF9Q8Ks
         8mL5GNM7hzTGF/fimd9nsjhpw3OsqmPAnHT0kWjnVnPsPZo9GGHwM5G2znW4e9FQ25
         VZZ0aeTCaIyxuB6zpFes93NsCjKT/v6WUdQEPhABP8iCmQ7XIYoyvPoJL6IBdgHQQK
         /Qm4eVkrBSSyg==
Date:   Fri, 1 Sep 2023 16:42:47 +0100
From:   Conor Dooley <conor@kernel.org>
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-mmc@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v1 1/3] dt-bindings: mmc: Drop unused properties
Message-ID: <20230901-remold-sublease-a1ddb1fc6348@spud>
References: <20230830031846.127957-1-william.qiu@starfivetech.com>
 <20230830031846.127957-2-william.qiu@starfivetech.com>
 <20230830-commence-trickery-40eaa193cb15@wendy>
 <b375b88c-0d9c-30a9-21f6-283083cf3880@linaro.org>
 <20230830-procedure-frostbite-56c751f7c276@wendy>
 <efab6f52-4d7f-ea3c-0fc3-4e3ad03c14c7@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pLuG68yt4VHhXP8C"
Content-Disposition: inline
In-Reply-To: <efab6f52-4d7f-ea3c-0fc3-4e3ad03c14c7@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pLuG68yt4VHhXP8C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 01, 2023 at 10:33:13AM +0800, William Qiu wrote:
>=20
>=20
> On 2023/8/30 16:34, Conor Dooley wrote:
> > On Wed, Aug 30, 2023 at 09:29:20AM +0200, Krzysztof Kozlowski wrote:
> >> On 30/08/2023 08:50, Conor Dooley wrote:
> >> > On Wed, Aug 30, 2023 at 11:18:44AM +0800, William Qiu wrote:
> >> >> Due to the change of tuning implementation, it's no longer necessar=
y to
> >> >> use the "starfive,sysreg" property in dts, so drop the relevant
> >> >> description in dt-bindings here.
> >> >=20
> >> > How does changing your software implantation invalidate a descriptio=
n of
> >> > the hardware?
> >> >=20
> >>=20
> >> Which is kind of proof that this syscon was just to substitute
> >> incomplete hardware description (e.g. missing clocks and phys). We
> >> should have rejected it. Just like we should reject them in the future.
> >=20
> > :s I dunno what to do with this... I'm inclined to say not to remove it
> > from the binding or dts at all & only change the software.
> >=20
> >> There are just few cases where syscon is reasonable. All others is just
> >> laziness. It's not only starfivetech, of course. Several other
> >> contributors do the same.
> >=20
> > I'm not sure if laziness is fair, lack of understanding is usually more
> > likely.
>=20
> For this, I tend to keep it in binding, but remove it from required. Beca=
use
> we only modify the tuning implementation, it doesn't mean that this prope=
rty
> need to be removed, it's just no longer be the required one.

Please only remove it from required if the current driver doesn't break
if the regmap is removed.

--pLuG68yt4VHhXP8C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZPIGdwAKCRB4tDGHoIJi
0s3uAQCCUsv/FqKDOGNlzYbIkcuD89HVaHQ7QYCJNSwvBPh3/gD9Gmy1suT2VgbM
R6+a6rUuyrNXFDz0Y9tRIQt3NPZZ9w4=
=dgfB
-----END PGP SIGNATURE-----

--pLuG68yt4VHhXP8C--
