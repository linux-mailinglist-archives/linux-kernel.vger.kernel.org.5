Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3FF57E8C44
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 20:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjKKTGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 14:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjKKTGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 14:06:39 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E173A82;
        Sat, 11 Nov 2023 11:06:37 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id D3E011C0050; Sat, 11 Nov 2023 20:06:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1699729595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0SATLdu8O+1FoZkoCkQe4rgD4RsmkXxDReVEpknUfPk=;
        b=JR1tpjfLrS8oxSDv23LG/WW/B16maQKaOMzsxu/IFmt0G707mUrSFF98ya5Pr6/E3tu4rF
        tbwJIQPTdpccTesxLdF9mP/UCo7w+DWQ6JAlB8mOJJDwOqBcRlig1Kq71G0H8gH01qCFMH
        DJFRYiyTxc5gKg5GFzsM9s5UtuUyQ38=
Date:   Sat, 11 Nov 2023 20:06:36 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Alain Volmat <alain.volmat@foss.st.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: vendor-prefixes: Add prefix for
 GalaxyCore Inc.
Message-ID: <ZU/QvFaDzkLhSAyE@duo.ucw.cz>
References: <20231107081345.3172392-1-alain.volmat@foss.st.com>
 <20231107081345.3172392-2-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HnEnkRRhYmP1yPek"
Content-Disposition: inline
In-Reply-To: <20231107081345.3172392-2-alain.volmat@foss.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HnEnkRRhYmP1yPek
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Pavel Machek <pavel@ucw.cz>

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--HnEnkRRhYmP1yPek
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZU/QvAAKCRAw5/Bqldv6
8nr/AJ9ZFA6+cDREeD54mI2ioyRe1lSc+gCcCakQIkLS3dqubrmI7H7OnML1zbo=
=716D
-----END PGP SIGNATURE-----

--HnEnkRRhYmP1yPek--
