Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E8D76B8DE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbjHAPlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjHAPlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:41:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09159BF;
        Tue,  1 Aug 2023 08:41:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92B8861616;
        Tue,  1 Aug 2023 15:41:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1EE5C433C7;
        Tue,  1 Aug 2023 15:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690904506;
        bh=hfpt/rn8T3dD1fNDjkJkdSYArWP39LI+Rklom06rePY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I6DSCbFH4skneOdQoeV8cvfcTZMsRITI8VFgVeDcOKpkwSQLJNuBC4W3DJTJ9s0XV
         wA/OZUexfr63rje+so0wXfskzWM29f/YPZdXha5GrtNGxoFoKL5RJSGsieqqMGFmBv
         QgsRAUlK/kInCsfnoTtN19Nv4h4uLRFs4erJXdy3lDRccJuXcw0QaSyQDuK6apnU+g
         8ruC6UsLTKhWlYNXmd8VsoIXaEpe4Z90ygkDRjcGl+cG/kclOXPbs9t1RDc8961JeF
         JRzQ13bfR8pckNLtvzsAhCbZF6j2lMtAwnkA2rxWF/xC9l1lSITs+yJ2NH0jR3NmM/
         xdyHwG8VCM+Xg==
Date:   Tue, 1 Aug 2023 16:41:41 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     sakari.ailus@linux.intel.com, linuxfancy@googlegroups.com,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: dt-bindings: ov5693: fix maintainer email address
Message-ID: <20230801-boundless-energetic-c79120d43883@spud>
References: <20230731215215.3045794-1-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="COL9OepmJl2Nzwv6"
Content-Disposition: inline
In-Reply-To: <20230731215215.3045794-1-tomm.merciai@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--COL9OepmJl2Nzwv6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 31, 2023 at 11:52:15PM +0200, Tommaso Merciai wrote:
> Switch my mail address from a company mail to a personal one.

Sure?
Acked-by: Conor Dooley <conor.dooley@microchip.com>



--COL9OepmJl2Nzwv6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMkntQAKCRB4tDGHoIJi
0mUyAQCWH54QxQoYSomLIBilcB2hGitgmespFMCgDSNkcC09jQD/b6kksCdR8FcD
wBfMW8DCM0kfiEH8dpOK89NwPQohJAg=
=Txvv
-----END PGP SIGNATURE-----

--COL9OepmJl2Nzwv6--
