Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889DA7FC1D5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344467AbjK1QhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbjK1QhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:37:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339B5D51
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:37:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B11C433C9;
        Tue, 28 Nov 2023 16:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701189441;
        bh=Rkd2WObdqH5uyXpuMYX4mfs7gUlcc9XyM6odEGDd6zk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lKD719tJUPV7x06fQ4wUQOdLYKRHwTYW8djLX2ZVzUjYTFhF4K8srnifyC+ebImgl
         sPCxll/LdF/rbFKQuAjq6TsZq39WxvF4Dt8d+QtdXqj+IPJ4YRXrZVbMwdcRcRb2Fr
         q+FZNB6R6UsaWyVG3vCbr0mtede+P5GAVA19+QF+5IztWPIVy1HXASNzumQRtyqIyN
         zGGOKa4PwNeFL/FSf7rBN+iJRYkyNHZBJ50BYlU7qiAAueOWamhyzjIjhrsH1E5VsF
         10vaONG+jJasv8oR1UL4lOdtDfR41xUWoD4KwF3SOLmigDMwE9US3XND4NrQzjmptj
         mV8BQfdM55WkA==
Date:   Tue, 28 Nov 2023 16:37:15 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Thomas Richard <thomas.richard@bootlin.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        theo.lebrun@bootlin.com, u-kumar1@ti.com
Subject: Re: [PATCH 1/3] dt-bindings: pinctrl: pinctrl-single: add
 ti,j7200-padconf compatible
Message-ID: <20231128-obsessive-vessel-9dde08c823e1@spud>
References: <20231128-j7200-pinctrl-s2r-v1-0-704e7dc24460@bootlin.com>
 <20231128-j7200-pinctrl-s2r-v1-1-704e7dc24460@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1WiGEFq1eieLw4sy"
Content-Disposition: inline
In-Reply-To: <20231128-j7200-pinctrl-s2r-v1-1-704e7dc24460@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1WiGEFq1eieLw4sy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 04:34:59PM +0100, Thomas Richard wrote:
> Add the "ti,j7200-padconf" compatible to support suspend to ram on
> j7200.
>=20
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--1WiGEFq1eieLw4sy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWYXOwAKCRB4tDGHoIJi
0lZYAP0VgA4r/SbyFNFipdXQIjedIczLudV1H+qbE9BZCRhYaAD/fOCazM+LUpxl
yiDLCw83aMiMjGVy8VieNXylZrJqXQs=
=AtN7
-----END PGP SIGNATURE-----

--1WiGEFq1eieLw4sy--
