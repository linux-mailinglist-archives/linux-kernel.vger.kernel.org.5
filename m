Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A747704F7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjHDPjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjHDPjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:39:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA1B171D;
        Fri,  4 Aug 2023 08:39:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 233F262087;
        Fri,  4 Aug 2023 15:39:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39C3C433C7;
        Fri,  4 Aug 2023 15:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691163546;
        bh=KE9Fk47oveA0djJFVx/cOVl22ZMQyfogGLlgQ79S364=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wq9pU6FZlamZ/ksPoGwWKP5FlT2QWM1cMCqJ0wN6e+A6vIHZaG03FopIO56Y7pC8V
         FfmHGfk6v81hzG9+YsyPk4bsCQdONfYryfrqUyFBmRt/SpHsiDzD4K/r7zkk9S1/J6
         6Qc1W+s6fenFnEQmj1O8WdOC/uvxBr2kz2+HgOEScRGrQoa/kqeWl4k/eWwy8FDu5k
         9BYk+9EC8DC8uYx1sSPOZU0IO8K+6hvkNOqB6ZRh7Q0l08Nwn0LIIZtTG0TpncHAE3
         vjIXqJVtirmkKUbGzmhtx8VQinVG+YQHLLOY3NTd2rkT8KVrdQrjds6F1J7qQ1zjA0
         SxW8H+F0Lw/aw==
Date:   Fri, 4 Aug 2023 16:39:02 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mazziesaccount@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH] dt-bindings: mfd: bd71847-pmic: Remove unneeded LED
 header
Message-ID: <20230804-twice-send-b8f76c8b032d@spud>
References: <20230804021657.190700-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EJaEd7eet5Hh/12h"
Content-Disposition: inline
In-Reply-To: <20230804021657.190700-1-festevam@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EJaEd7eet5Hh/12h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2023 at 11:16:57PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
>=20
> There is nothing from <dt-bindings/leds/common.h> that is needed by
> the binding example.
>=20
> Remove the unneeded inclusion.
>=20
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--EJaEd7eet5Hh/12h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZM0blgAKCRB4tDGHoIJi
0i2PAPwPYYkOqfma8OWGMV013+7MNVnuTYBwGIUN+uSi6q8smgEA5hoLswpbJ207
Uh2H4FzjJA8KgDHetzZYL8sGFUv5OgU=
=6vDD
-----END PGP SIGNATURE-----

--EJaEd7eet5Hh/12h--
